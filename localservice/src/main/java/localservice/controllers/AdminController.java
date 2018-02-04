package localservice.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import localservice.models.Miscellaneous;
import localservice.models.Room;
import localservice.models.RoomType;
import localservice.services.MiscellaneousService;
import localservice.services.RoomService;
import localservice.services.RoomTypeService;

@Controller
public class AdminController extends BaseController {
	
	@Autowired
	private RoomService roomService;
	@Autowired
	private RoomTypeService roomTypeService;
	@Autowired
	private MiscellaneousService miscellaneousService;
	
	@GetMapping("/admin")
	public String adminHome() {
		return "admin";
	}
	
	@GetMapping("/admin-room-types")
	public String adminRoomTypes(HttpServletRequest request) {
		request.setAttribute("roomTypeList", roomTypeService.findAll());
		return "admin-room-types";
	}
	
	@GetMapping("/admin-room-types-edit")
	public String adminRoomTypeEdit(@RequestParam int id, HttpServletRequest request) {
		request.setAttribute("roomType", roomTypeService.findById(id));
		request.setAttribute("roomTypeList", roomTypeService.findAll());
		return "admin-room-types";
	}
	
	@PostMapping("/admin-room-types-save")
	public String adminRoomTypeSave(@ModelAttribute RoomType roomTypeForm, HttpServletRequest request) {
		roomTypeService.saveOrUpdate(roomTypeForm);
		request.setAttribute("roomTypeList", roomTypeService.findAll());
		return "redirect:admin-room-types";
	}
	
	@PostMapping("/admin-room-types-delete")
	public String adminRoomTypeDelete(@ModelAttribute RoomType roomTypeForm, HttpServletRequest request) {
		RoomType roomType = roomTypeService.findById(roomTypeForm.getId());
		roomTypeService.delete(roomType);
		request.setAttribute("roomTypeList", roomTypeService.findAll());
		return "redirect:admin-room-types";
	}
	
	@GetMapping("/admin-rooms")
	public String adminRooms(HttpServletRequest request) {
		request.setAttribute("roomList", roomService.findAll());
		request.setAttribute("roomTypeList", roomTypeService.findAll());
		setModuleInSession(request, "admin_rooms", null);
		return "admin-rooms";
	}
	
	@GetMapping("/admin-rooms-edit")
	public String editRoom(@RequestParam String code, HttpServletRequest request) {
		Room room = roomService.findByCode(code);
		request.setAttribute("room", room);
		request.setAttribute("roomList", roomService.findAll());
		request.setAttribute("roomTypeList", roomTypeService.findAll());
		return "admin-rooms";
	}
	
	@PostMapping("/admin-rooms-save")
	public String saveRoom(@ModelAttribute Room roomForm, BindingResult bindingResult, HttpServletRequest request) {
		roomService.saveOrUpdate(roomForm);
		request.setAttribute("roomList", roomService.findAll());
		request.setAttribute("roomTypeList", roomTypeService.findAll());
		return "redirect:admin-rooms";
	}
	
	@PostMapping("/admin-rooms-delete")
	public String deleteRoom(@ModelAttribute Room roomForm, BindingResult bindingResult, HttpServletRequest request) {
		Room room = roomService.findByCode(roomForm.getCode());
		roomService.delete(room);
		request.setAttribute("roomList", roomService.findAll());
		request.setAttribute("roomTypeList", roomTypeService.findAll());
		return "redirect:admin-rooms";
	}	
	
	@GetMapping("/admin-amenities")
	public String adminAmenities(HttpServletRequest request) {		
		request.setAttribute("miscellaneousList", miscellaneousService.findAll());
		setModuleInSession(request, "admin_amenities", null);
		return "admin-amenities";
	}
	
	@GetMapping("/admin-amenities-edit")
	public String editAmenities(@RequestParam String code, HttpServletRequest request) {
		Miscellaneous misc = miscellaneousService.findByCode(code);
		request.setAttribute("misc", misc);
		request.setAttribute("miscellaneousList", miscellaneousService.findAll());
		return "admin-amenities";
	}
	
	@PostMapping("/admin-amenities-save")
	public String saveAmenities(@ModelAttribute Miscellaneous miscellaneousForm, BindingResult bindingResult, HttpServletRequest request) {
		miscellaneousService.saveOrUpdate(miscellaneousForm);
		request.setAttribute("miscellaneousList", miscellaneousService.findAll());
		return "redirect:admin-amenities";
	}
	
	@PostMapping("/admin-amenities-delete")
	public String deleteAmenities(@ModelAttribute Miscellaneous miscellaneousForm, BindingResult bindingResult, HttpServletRequest request) {
		Miscellaneous misc = miscellaneousService.findByCode(miscellaneousForm.getCode());
		miscellaneousService.delete(misc);
		request.setAttribute("miscellaneousList", miscellaneousService.findAll());
		return "redirect:admin-amenities";
	}	
	
}
