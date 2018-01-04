package localservice.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import localservice.models.Consts;
import localservice.models.Reservation;
import localservice.models.Room;
import localservice.services.RoomService;

@Controller
public class BookingController {
	
	@Autowired
	private RoomService roomService;
	
	@GetMapping("/booking-step1")
	public String bookingFromMenu(HttpServletRequest request) {
		request.getSession().setAttribute(Consts.CURRENT_MODULE, "booking");
		request.getSession().setAttribute(Consts.CURRENT_SUBMODULE, "step1");	
		return "booking";
	}

	@PostMapping("/booking-step1")
	public String bookingFromMainPage(@ModelAttribute Reservation reservationDraft, BindingResult bindingResult, HttpServletRequest request) {
		request.getSession().setAttribute(Consts.CURRENT_MODULE, "booking");
		request.getSession().setAttribute(Consts.CURRENT_SUBMODULE, "step1");	
		request.getSession().setAttribute("reservationDraft", reservationDraft);
		loadRoomList(request);
		return "booking";
	}
	
	private void loadRoomList(HttpServletRequest request) {
		//TODO get only available rooms
		List<Room> rooms = roomService.findAll();
		request.setAttribute("availableRooms", rooms);
	}
}
