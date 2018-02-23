package localservice.services;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import localservice.models.AdditionalCharge;
import localservice.models.ApplicationProperties;
import localservice.models.BookingStatus;
import localservice.models.Consts;
import localservice.models.Reservation;
import localservice.models.Room;
import localservice.repositories.ReservationRepository;
import localservice.restcontrollers.RoomRestController;

@Service
@Transactional
public class ReservationService extends BaseService<Reservation>{
	
	private final Log logger = LogFactory.getLog(getClass());
	
	private ReservationRepository reservationRepository;
	@Autowired
	private ApplicationPropertiesService applicationPropertiesService;
	@Autowired
	private MailService mailService;
	@Autowired
	private RoomRestController roomRestController;

	public ReservationService(ReservationRepository reservationRepository) {
		super(reservationRepository);
		this.reservationRepository = reservationRepository;
	}
	
	public double getDownPaymentAmount(double totalAmount) {
		int dpRate = applicationPropertiesService.findLatestConfig().getDownPaymentPercentage();
		double dpAmount = totalAmount * dpRate / 100.0;
		return dpAmount;
	}
	
	public double getVatAmount(double totalAmount) {
		int vatRate = applicationPropertiesService.findLatestConfig().getVatPercentage();
		double vatAmount = totalAmount * vatRate / 100.0;
		return vatAmount;
	}
	
	public double getSumOfRoomRate(List<Room> selectedRooms) {
		double sumRooms = 0.0;
		for(Room room : selectedRooms) {
			sumRooms += room.getRate();
		}
		return sumRooms;
	}
	
	public int getNumOfNights(Reservation reservation) {
		LocalDate checkInLocal = reservation.getCheckIn().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		LocalDate checkOutLocal = reservation.getCheckOut().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		int nights = (int) ChronoUnit.DAYS.between(checkInLocal, checkOutLocal);
		nights = nights > 0 ? nights : 1;
		return nights;
	}
	
	public double computeRoomsAmount(Reservation reservation) {
		double result = 0.0;
		int nights = getNumOfNights(reservation);
		for(Room room : reservation.getRooms()) {
			result += room.getRate() * nights;
		}		
		return result;
	}
	
	public void recomputeTotalAmountAfterAdd(Reservation reservation, double amount) {
		double originalTotal = reservation.getTotalAmount();
		double newTotal = originalTotal + amount;
		reservation.setVatAmount(this.getVatAmount(newTotal));
		reservation.setTotalAmount(newTotal);
	}
	
	public void recomputeTotalAmountAfterRemove(Reservation reservation, double amount) {
		double originalTotal = reservation.getTotalAmount();
		double newTotal = originalTotal - amount;		
		reservation.setVatAmount(this.getVatAmount(newTotal));
		reservation.setTotalAmount(newTotal);
	}
	
	public double applyOnlineDiscount(double rawAmount) {
		ApplicationProperties config = applicationPropertiesService.findLatestConfig();
		if(config.getOnlineBookingDiscount() > 0) {
			return rawAmount - config.getOnlineBookingDiscount();
		}
		return rawAmount;
	}
	
	public List<Reservation> findAllReservationsToday(){
		Date today = Date.from(LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant());
		return this.reservationRepository.findAllByCheckIn(today);
	}
	
	public List<Reservation> findAllReservationsInBetween(Date checkIn, Date checkOut){
		LocalDate checkInLocal = checkIn.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		LocalDate checkOutLocal = checkOut.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		checkIn = Date.from(checkInLocal.atStartOfDay(ZoneId.systemDefault()).toInstant());
		checkOut = Date.from(checkOutLocal.atStartOfDay(ZoneId.systemDefault()).toInstant());
		return this.reservationRepository.findAllByCheckInAndCheckOut(checkIn, checkOut);
	}
	
	public String generateReferenceId() {
		StringBuilder sb;
		boolean exists = false;
		do {
			sb = new StringBuilder();
			String alphabet= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	        String s = "";
	        Random random = new Random();
	        sb.append(String.valueOf(random.nextInt(9)));
	        int randomLen = 5;
	        for (int i = 0; i < randomLen; i++) {
	            char c = alphabet.charAt(random.nextInt(26));
	            s+=c;
	        } 
	        sb.append(s);
	        sb.append(String.valueOf(random.nextInt(9)));
	        
	        Reservation existingReservation = this.findOneByReferenceId(sb.toString());
	        if(null != existingReservation) {
	        	exists = true;
	        }
		}while(exists);		
		
        return sb.toString();
	}
	
	public Reservation findOneByReferenceId(String referenceId) {
		return this.reservationRepository.findOneByReferenceId(referenceId);
	}
	
	public List<Reservation> findAllByEmail(String email) {
		return this.reservationRepository.findAllByEmail(email);
	}
	
	public double computeBalanceForCheckout(Reservation reservation) {
		return reservation.getTotalAmount() - reservation.getDpAmount();
	}
	
	public void sendReservationEmail(Reservation reservation) {
		ApplicationProperties config = applicationPropertiesService.findLatestConfig();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
			StringBuilder sb = new StringBuilder();
			sb.append("<b>Thank you for booking at CASA ELUM Pavilion & Resort</b><br><br>");
			sb.append("Check-In: " + sdf.format(reservation.getCheckIn()) + "<br>");
			sb.append("Check-Out: " + sdf.format(reservation.getCheckOut()) + "<br>");
			sb.append("Main Guest: " + reservation.getMainGuest().getFullName() + "<br>");
			sb.append("Total Pax: " + reservation.getCountAdult() + " adult(s), "+ reservation.getCountChildren() +" child(ren)<br>");
			sb.append("Rooms: ");
			for (int i = 0; i < reservation.getRooms().size(); i++) {
				Room room = reservation.getRooms().get(i);
				if(i > 0) {
					sb.append(", ");
				}
				sb.append(room.getName());				
			}
			sb.append("<hr>");
			sb.append("Booking Reference: <b>" + reservation.getReferenceId() + "</b><br>");
			sb.append("Status: <b><font color='"
					+(reservation.getStatus().equalsIgnoreCase(BookingStatus.CONFIRMED.toString()) ? "green" : "red") 
					+"'>" + reservation.getStatus() + "</font></b><br>");
			sb.append("Payment Method: " + reservation.getPaymentMethod() + "<br>");
			if(reservation.getOnlineBookingDiscount() > 0) {
				sb.append("Room(s) Amount: &#8369; " + reservation.getTotalAmountRooms() + "<br>");
				sb.append("Online Discount: &#8369; (" + reservation.getOnlineBookingDiscount() + ")<br>");
			}
			sb.append("Total Amount: &#8369; " + reservation.getTotalAmount() + "<br>");
			sb.append("VAT ("+ config.getVatPercentage() +"%) inclusive: &#8369; " + reservation.getVatAmount() + "<br>");
			sb.append("Down payment ("+ config.getDownPaymentPercentage() +"%): <b>&#8369; " + reservation.getDpAmount() + "</b><br><br>");
			
			if(reservation.getStatus().equalsIgnoreCase(BookingStatus.PENDING.toString())) {
				sb.append("<hr>");
				sb.append("Deposit <b>&#8369; "+reservation.getDpAmount()+"</b> within (<b>"+config.getGracePeriodBankDepositHours()+" hours</b>)<br>");
				sb.append("Bank: <b>"+config.getBank()+"</b><br>");
				sb.append("Account Name: <b>"+config.getMerchant()+"</b><br>");
				sb.append("Account Number: <b>"+config.getAccount()+"</b>");
				sb.append("<hr>");
				sb.append("<b>IMPORTANT</b><br>");
				sb.append("Send and attach your <b>DEPOSIT SLIP</b> by email to <b>"+config.getEmailBankDeposit()+"</b> with subject <b>"+reservation.getReferenceId()+"</b>");
			}			
			this.mailService.sendEmail(reservation.getMainGuest().getEmail(), null, "[TEST] Casa Elum Booking ["+ reservation.getReferenceId() +"]", sb.toString());
		} catch (Exception e) {
			logger.error(e);		
		}
	}
	
	public void sendCheckoutEmail(Reservation reservation, List<AdditionalCharge> itemsForDisplay) {
		ApplicationProperties config = applicationPropertiesService.findLatestConfig();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
			StringBuilder sb = new StringBuilder();
			sb.append("<b>Thank you for staying with us at CASA ELUM Pavilion & Resort</b><br><br>");
			sb.append("Check-In: " + sdf.format(reservation.getCheckIn()) + "<br>");
			sb.append("Check-Out: " + sdf.format(reservation.getCheckOut()) + "<br>");
			sb.append("Main Guest: " + reservation.getMainGuest().getFullName() + "<br>");
			sb.append("Total Pax: " + reservation.getCountAdult() + " adult(s), "+ reservation.getCountChildren() +" child(ren)<br>");
			sb.append("Rooms: ");
			for (int i = 0; i < reservation.getRooms().size(); i++) {
				Room room = reservation.getRooms().get(i);
				if(i > 0) {
					sb.append(", ");
				}
				sb.append(room.getName());				
			}
			sb.append("<hr>");
			sb.append("Booking Reference: <b>" + reservation.getReferenceId() + "</b><br>");
			sb.append("Status: " + reservation.getStatus() + "<br>");
			sb.append("<hr>");
			sb.append("<b>Breakdown</b>");
			sb.append("<table>");
			for(AdditionalCharge charge : itemsForDisplay) {
				sb.append("<tr>");
				sb.append("<td>"+charge.getItemDescription()+"</td>");
				sb.append("<td>&#8369; "+charge.getRate()+"</td>");
				sb.append("</tr>");
			}
			sb.append("</table>");
			sb.append("<hr>");
			sb.append("Total Amount: &#8369; " + reservation.getTotalAmount() + "<br>");
			sb.append("VAT ("+ config.getVatPercentage() +"%) inclusive: &#8369; " + reservation.getVatAmount() + "<br>");
			sb.append("(Less) Down payment ("+ config.getDownPaymentPercentage() +"%): &#8369; " + reservation.getDpAmount() + "<br>");
			sb.append("Balance Paid: <b>&#8369; " + reservation.getBalanceUponCheckout()+"</b>");
			this.mailService.sendEmail(reservation.getMainGuest().getEmail(), null, "[TEST] Casa Elum Checkout ["+ reservation.getReferenceId() +"]", sb.toString());
		} catch (Exception e) {
			logger.error(e);		
		}
	}
	
	public void removeRoomsFromStaging(Reservation reservation, HttpServletRequest request) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(Room room : reservation.getRooms()) {
			String key = room.getId() + Consts.SEPARATOR + sdf.format(reservation.getCheckIn()) + Consts.SEPARATOR + sdf.format(reservation.getCheckOut());
			roomRestController.releaseRoom(key, request);
		}
	}
}
