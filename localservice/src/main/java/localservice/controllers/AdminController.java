package localservice.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import localservice.models.Room;
import localservice.services.RoomService;

@Controller
public class AdminController extends BaseController {
	
	@Autowired
	private RoomService roomService;

	@GetMapping("/admin")
	public String adminHome() {
		return "admin";
	}
	
	@GetMapping("/admin-rooms")
	public String adminRooms(HttpServletRequest request) {
		request.setAttribute("roomList", roomService.findAll());
		setModuleInSession(request, "admin_rooms", null);
		return "admin-rooms";
	}
	
	@GetMapping("/admin-rooms-edit")
	public String editRoom(@RequestParam String code, HttpServletRequest request) {
		Room room = roomService.findByCode(code);
		request.setAttribute("room", room);
		request.setAttribute("roomList", roomService.findAll());
		return "admin-rooms";
	}
	
	@PostMapping("/admin-rooms-save")
	public String saveRoom(@ModelAttribute Room roomForm, BindingResult bindingResult, HttpServletRequest request) {
		roomService.saveOrUpdate(roomForm);
		request.setAttribute("roomList", roomService.findAll());
		return "redirect:admin-rooms";
	}
	
	@PostMapping("/admin-rooms-delete")
	public String deleteRoom(@ModelAttribute Room roomForm, BindingResult bindingResult, HttpServletRequest request) {
		Room room = roomService.findByCode(roomForm.getCode());
		roomService.delete(room);
		request.setAttribute("roomList", roomService.findAll());
		return "redirect:admin-rooms";
	}	
	
}
