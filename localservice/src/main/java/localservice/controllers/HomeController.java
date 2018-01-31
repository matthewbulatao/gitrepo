package localservice.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import localservice.models.Consts;
import localservice.services.MiscellaneousService;

@Controller
public class HomeController extends BaseController {
	
	@Autowired
	private MiscellaneousService miscellaneousService;
	
	@GetMapping("/")
	public String home(HttpServletRequest request) {
		setModuleInSession(request, StringUtils.EMPTY, null);
		return "index";
	}
	
	@GetMapping("/amenities")
	public String amenities(HttpServletRequest request) {
		String page = "amenities";
		setModuleInSession(request, page, null);
		request.setAttribute("miscellaneousList", miscellaneousService.findAll());
		return page;
	}
	
	@GetMapping("/gallery")
	public String gallery(HttpServletRequest request) {
		String page = "gallery";
		setModuleInSession(request, page, null);
		return page;
	}
	
	@GetMapping("/location")
	public String location(HttpServletRequest request) {
		String page = "location";
		setModuleInSession(request, page, null);
		return page;
	}
	
	@GetMapping("/contact")
	public String contact(HttpServletRequest request) {
		String page = "contact";
		setModuleInSession(request, page, null);
		return page;
	}
	
}
