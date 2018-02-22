
package localservice.controllers;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import localservice.models.BookingStatus;
import localservice.models.Consts;
import localservice.models.Guest;
import localservice.models.Reservation;
import localservice.models.Room;
import localservice.services.ApplicationPropertiesService;
import localservice.services.GuestService;
import localservice.services.ReservationService;
import localservice.services.RoomService;

@Controller
public class BookingController extends BaseController {
	
	@Autowired
	private RoomService roomService;
	
	@Autowired
	private GuestService guestService;
	
	@Autowired
	private ReservationService reservationService;
	
	@Autowired
	private ApplicationPropertiesService applicationPropertiesService;
	
	//BACK TO SELECT ROOMS
	@GetMapping("/booking-step1")
	public String bookingStep1Back(HttpServletRequest request) {
		setModuleInSession(request, "booking", "step1");
		Object resObj = request.getSession().getAttribute("reservationDraft");
		if(null != resObj) {
			Reservation reservationForm = (Reservation) resObj;
			loadAvailableRoomList(request, reservationForm);
			return "booking";
		}else {
			return "redirect:index";
		}		
	}

	//AFTER SELECT DATES
	@PostMapping("/booking-step1")
	public String bookingStep1(@ModelAttribute Reservation reservationForm, BindingResult bindingResult, HttpServletRequest request) {
		setModuleInSession(request, "booking", "step1");
		request.getSession().setAttribute("reservationDraft", reservationForm);
		loadAvailableRoomList(request, reservationForm);
		return "booking";
	}
	
	//BACK TO PERSONAL INFO
	@GetMapping("/booking-step2")
	public String bookingStep2Back(HttpServletRequest request) {
		setModuleInSession(request, "booking", "step2");
		Object resObj = request.getSession().getAttribute("reservationDraft");
		if(null != resObj) {
			return "booking";
		}else {
			return "redirect:index";
		}		
	}
	
	//AFTER SELECT ROOMS
	@PostMapping("/booking-step2")
	public String bookingStep2(@ModelAttribute Reservation reservationForm, BindingResult bindingResult, HttpServletRequest request) {
		setModuleInSession(request, "booking", "step2");
		Reservation reservationDraft = (Reservation) request.getSession().getAttribute("reservationDraft");
		List<Room> selectedRooms = roomService.findByIds(Arrays.asList(reservationForm.getSelectedRoomIds()).stream().map(Integer::parseInt).collect(Collectors.toList()));
		request.getSession().setAttribute("selectedRoomIds", reservationForm.getSelectedRoomIds());
		reservationDraft.setRooms(selectedRooms);
		double totalAmount = reservationService.computeBooking(reservationDraft);
		reservationDraft.setTotalAmount(totalAmount);
		reservationDraft.setSumOfRoomRate(reservationService.getSumOfRoomRate(selectedRooms));	
		reservationDraft.setNumOfNights(reservationService.getNumOfNights(reservationDraft));
		reservationDraft.setDpAmount(reservationService.getDownPaymentAmount(totalAmount));
		reservationDraft.setVatAmount(reservationService.getVatAmount(totalAmount));
		
		request.getSession().setAttribute("reservationDraft", reservationDraft);
		request.setAttribute("config", applicationPropertiesService.findLatestConfig());
		return "booking";
	}
	
	//AFTER PERSONAL DETAILS
	@PostMapping("/booking-step3")
	public String bookingStep3(@ModelAttribute Reservation reservationForm, BindingResult bindingResult, HttpServletRequest request) {
		setModuleInSession(request, "booking", "step3");		
		Reservation reservationDraft = (Reservation) request.getSession().getAttribute("reservationDraft");		
		request.setAttribute("config", applicationPropertiesService.findLatestConfig());		
		reservationDraft.setMainGuest(extractGuest(reservationForm));
		request.getSession().setAttribute("reservationDraft", reservationDraft);
		request.setAttribute("renderPaypal", true);		
		return "booking";
	}
	
	@PostMapping("/booking-step4")
	public String bookingStep4(@ModelAttribute Reservation reservationForm, BindingResult bindingResult, HttpServletRequest request) {
		setModuleInSession(request, "booking", "step4");		
		Reservation reservationDraft = (Reservation) request.getSession().getAttribute("reservationDraft");
		request.setAttribute("config", applicationPropertiesService.findLatestConfig());		
		reservationDraft.setReferenceId(reservationService.generateReferenceId());
		reservationDraft.setPaymentMethod(reservationForm.getPaymentMethod());
		reservationDraft.setMainGuest(saveGuest(reservationDraft.getMainGuest()));
		if(StringUtils.equalsIgnoreCase(Consts.PAYMENT_METHOD_BANK, reservationForm.getPaymentMethod())) {
			reservationDraft.setStatus(BookingStatus.PENDING.toString());
		}else if(StringUtils.equalsIgnoreCase(Consts.PAYMENT_METHOD_PAYPAL, reservationForm.getPaymentMethod())) {
			reservationDraft.setStatus(BookingStatus.CONFIRMED.toString());
		}		
		Reservation reservationSubmitted = reservationService.saveOrUpdate(reservationDraft);
		reservationService.sendReservationEmail(reservationSubmitted);
		request.setAttribute("reservationSubmitted", reservationSubmitted);
		request.getSession().removeAttribute("reservationDraft");
		request.getSession().removeAttribute("selectedRoomIds");
		return "booking";
	}
	
	private Guest extractGuest(Reservation reservationForm) {
		Guest guest = new Guest();
		guest.setFirstName(reservationForm.getFirstName());
		guest.setLastName(reservationForm.getLastName());
		guest.setContactNumber(reservationForm.getContactNumber());
		guest.setEmail(reservationForm.getEmail());
		return guest;
	}
	
	private Guest saveGuest(Guest guest) {
		guestService.saveOrUpdate(guest);
		return guest;
	}
	
	private void loadAvailableRoomList(HttpServletRequest request, Reservation reservationForm) {
		List<Room> rooms = roomService.findAllActiveOrderByCapacity();	
		List<Reservation> reservationsInBetween = reservationService.findAllReservationsInBetween(reservationForm.getCheckIn(), reservationForm.getCheckOut());
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		for(Room room : rooms) {
			Object selRoomsObj = request.getSession().getAttribute("selectedRoomIds");
			if(null != selRoomsObj) {
				String[] selectedRoomIds = (String[]) selRoomsObj;
				if(ArrayUtils.contains(selectedRoomIds, String.valueOf(room.getId()))) {
					room.setSelected(true);
				}
			}
			for(Reservation reservation : reservationsInBetween) {
				if(reservation.getRooms().contains(room)) {
					if(room.getConflicts() == null) {
						room.setConflicts(new ArrayList<>());
					}
					room.getConflicts().add("Reserved from " + sdf.format(reservation.getCheckIn()) + " to " + sdf.format(reservation.getCheckOut()));
				}
			}
		}
		request.setAttribute("availableRooms", rooms);
	}
	
	
}
