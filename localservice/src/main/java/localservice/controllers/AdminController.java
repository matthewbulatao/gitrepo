package localservice.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import localservice.models.Room;
import localservice.services.RoomService;

@Controller
public class AdminController {
	
	@Autowired
	private RoomService roomService;

	@GetMapping("/admin")
	public String adminHome() {
		return "admin";
	}
	
	@GetMapping("/admin/rooms")
	public String adminRooms(HttpServletRequest request) {
		request.setAttribute("roomList", roomService.findAll());
		return "admin-rooms";
	}
	
	@PostMapping("/admin/rooms/save")
	public String bookingStep1(@ModelAttribute Room roomForm, BindingResult bindingResult, HttpServletRequest request) {
		roomService.saveOrUpdate(roomForm);
		request.setAttribute("roomList", roomService.findAll());
		request.setAttribute("room", new Room());
		return "admin-rooms";
	}
}
