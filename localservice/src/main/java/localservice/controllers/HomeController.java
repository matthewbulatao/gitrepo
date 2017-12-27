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
	
	@GetMapping("/{page}-{subModule}")
	public String navigateToPage(@PathVariable("page") String page, @PathVariable("subModule") String subModule, HttpServletRequest request) {
		request.getSession().setAttribute(Consts.CURRENT_MODULE, page);
		request.getSession().setAttribute(Consts.CURRENT_SUBMODULE, subModule);		
		return page;
	}
	
	
	
}
