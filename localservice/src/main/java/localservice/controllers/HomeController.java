package localservice.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import localservice.models.Consts;

@Controller
public class HomeController {
	
	@GetMapping("/")
	public String home(HttpServletRequest request) {
		request.getSession().setAttribute(Consts.CURRENT_MODULE, StringUtils.EMPTY);
		return "index";
	}
	
	@GetMapping("/amenities")
	public String amenities(HttpServletRequest request) {
		String page = "amenities";
		request.getSession().setAttribute(Consts.CURRENT_MODULE, page);
		return page;
	}
	
	@GetMapping("/gallery")
	public String gallery(HttpServletRequest request) {
		String page = "gallery";
		request.getSession().setAttribute(Consts.CURRENT_MODULE, page);
		return page;
	}
	
	@GetMapping("/location")
	public String location(HttpServletRequest request) {
		String page = "location";
		request.getSession().setAttribute(Consts.CURRENT_MODULE, page);
		return page;
	}
	
	@GetMapping("/contact")
	public String contact(HttpServletRequest request) {
		String page = "contact";
		request.getSession().setAttribute(Consts.CURRENT_MODULE, page);
		return page;
	}
	
}
