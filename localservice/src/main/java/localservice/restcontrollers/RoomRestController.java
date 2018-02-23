package localservice.restcontrollers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import localservice.models.ApplicationProperties;
import localservice.models.Consts;
import localservice.models.Reservation;
import localservice.models.Room;
import localservice.services.ApplicationPropertiesService;
import localservice.services.ReservationService;
import localservice.services.RoomService;

@RestController
@RequestMapping(value="/api/rooms")
public class RoomRestController {
	
	private final Log logger = LogFactory.getLog(getClass());

	@Autowired
	private ReservationService reservationService;
	@Autowired
	private ServletContext servletContext;	
	@Autowired
	private ApplicationPropertiesService applicationPropertiesService;
	
	final ScheduledThreadPoolExecutor executor = new ScheduledThreadPoolExecutor(500);
	
	@PostConstruct
	private void initializeRoomStaging() {
		Map<String, String> roomStaging = new HashMap<>();
		servletContext.setAttribute("roomStaging", roomStaging);
	}
	
	@GetMapping("/is-room-reserved")
	public boolean isRoomAlreadyReserved(String key) throws ParseException {
		String roomId = key.split(Consts.SEPARATOR)[0];
		String checkIn = key.split(Consts.SEPARATOR)[1];
		String checkOut = key.split(Consts.SEPARATOR)[2];
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<Reservation> reservationsInBetween = reservationService.findAllReservationsInBetween(sdf.parse(checkIn), sdf.parse(checkOut));
		if(CollectionUtils.isNotEmpty(reservationsInBetween)) {
			for(Reservation res : reservationsInBetween) {
				for(Room room : res.getRooms()) {
					if(room.getId() == Integer.parseInt(roomId)) {
						return true;
					}
				}
			}
		}
		return false;
	}
	
	@GetMapping("/is-room-temporarily-reserved")
	public synchronized String isRoomTemporarily(String key) throws NumberFormatException, ParseException {
		Object obj = servletContext.getAttribute("roomStaging");
		if(null != obj && obj instanceof Map<?, ?>) {
			Map<String, String> roomStaging = (Map<String, String>) obj;
			for(String keyEntry : roomStaging.keySet()) {
				if(hasConflict(keyEntry, key)) {
					ApplicationProperties config = applicationPropertiesService.findLatestConfig();
					Long tempReserveMins = (long) config.getTempReserveMinutes();					
					String timestampStr = roomStaging.get(keyEntry).split(Consts.SEPARATOR)[1];
					Long origTime = Long.parseLong(timestampStr);
					Long currentTime = new Date().getTime();
					Long timeElapsedMill = currentTime - origTime;
					Long timeLeftMill = (tempReserveMins * 60 * 1000) - timeElapsedMill;				
					int timeLeftMins = (int) (timeLeftMill / 1000L / 60L);
					int timeLeftSec = (int) (timeLeftMill / 1000L);
					int timeLeftSecRemainder = (timeLeftSec >= 60) ? (timeLeftSec % (timeLeftMins * 60)) : timeLeftSec;
					String message = "will be released in "+timeLeftMins+" minute"+(timeLeftMins>1?"s ":" ")+timeLeftSecRemainder+" second"+(timeLeftSecRemainder>1?"s ":" ");		
					return message;
				}				
			}
		}
		return String.valueOf(false);
	}	

	private boolean hasConflict(String savedKey, String keyToTest) throws ParseException {
		String roomId = savedKey.split(Consts.SEPARATOR)[0];
		String checkIn = savedKey.split(Consts.SEPARATOR)[1];
		String checkOut = savedKey.split(Consts.SEPARATOR)[2];
		String roomId2 = keyToTest.split(Consts.SEPARATOR)[0];
		String checkIn2 = keyToTest.split(Consts.SEPARATOR)[1];
		String checkOut2 = keyToTest.split(Consts.SEPARATOR)[2];
		
		String savedKeyWithoutSessionId = roomId + Consts.SEPARATOR + checkIn + Consts.SEPARATOR + checkOut;
		if(StringUtils.equalsIgnoreCase(savedKeyWithoutSessionId, keyToTest)) {
			return true;
		}else if(StringUtils.equalsIgnoreCase(roomId, roomId2)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date checkInDate = sdf.parse(checkIn);
			Date checkOutDate = sdf.parse(checkOut);
			Date checkInDate2 = sdf.parse(checkIn2);
			Date checkOutDate2 = sdf.parse(checkOut2); 
			if(isDateInclusive(checkInDate, checkOutDate, checkInDate2)
					|| isDateInclusive(checkInDate, checkOutDate, checkOutDate2)) {
				return true;
			}
		}
		return false;
	}
	
	private boolean isDateInclusive(Date a, Date b, Date d) {
		return a.compareTo(d) * d.compareTo(b) >= 0;
	}
	
	@GetMapping("/temporarily-reserve-room")
	public synchronized String addRoomTemporarily(String key, HttpServletRequest request) throws NumberFormatException, ParseException {
		String sessionId = request.getSession().getId();
		final String keyWithSessionId = key + Consts.SEPARATOR + sessionId;
		String status = this.isRoomTemporarily(key);
		if(status.equalsIgnoreCase("false") && !isRoomAlreadyReserved(key)) {
			Object obj = servletContext.getAttribute("roomStaging");
			if(null != obj && obj instanceof Map<?, ?>) {
				Map<String, String> roomStaging = (Map<String, String>) obj;
				ApplicationProperties config = applicationPropertiesService.findLatestConfig();
				int tempReserveMins = config.getTempReserveMinutes();
				roomStaging.put(keyWithSessionId, "Temporarily reserved for "+tempReserveMins+" minutes"+Consts.SEPARATOR+String.valueOf(new Date().getTime()));
				
				executor.schedule(() -> {
					logger.info("Executing scheduled task...");
					releaseRoom(keyWithSessionId);
				}, tempReserveMins, TimeUnit.MINUTES);					
				return Consts.RESPONSE_OK;
			}
		}else if(!status.equalsIgnoreCase("false")) {
			return status;
		}else { //already reserved
			return "ALREADY_RESERVED";
		}
		
		return Consts.RESPONSE_KO;
	}	
	
	//CALLED BY EXECUTOR
	private void releaseRoom(String key) {
		Object obj = servletContext.getAttribute("roomStaging");
		if(null != obj && obj instanceof Map<?, ?>) {
			Map<String, String> roomStaging = (Map<String, String>) obj;
			if(roomStaging.containsKey(key)) {
				logger.info("Releasing key: " + key);
				roomStaging.remove(key);				
			}
		}
	}
	
	@GetMapping("/release-temporarily-reserve-room")
	public boolean releaseRoom(String key, HttpServletRequest request) {
		key += Consts.SEPARATOR + request.getSession().getId();
		Object obj = servletContext.getAttribute("roomStaging");
		if(null != obj && obj instanceof Map<?, ?>) {
			Map<String, String> roomStaging = (Map<String, String>) obj;
			if(roomStaging.containsKey(key)) {
				logger.info("Releasing key: " + key);
				roomStaging.remove(key);				
			}
		}
		return true;
	}
	
	public void releaseRoomsWithSessionId(String sessionId) {
		Object obj = servletContext.getAttribute("roomStaging");
		if(null != obj && obj instanceof Map<?, ?>) {
			Map<String, String> roomStaging = (Map<String, String>) obj;
			for(String keyEntry : roomStaging.keySet()) {
				if(StringUtils.endsWith(keyEntry, (Consts.SEPARATOR + sessionId))) {
					roomStaging.remove(keyEntry);
				}
			}
		}
	}
}
