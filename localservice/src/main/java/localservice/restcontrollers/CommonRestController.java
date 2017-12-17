package localservice.restcontrollers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import localservice.models.Consts;

@RestController
@RequestMapping(value="/api/common")
public class CommonRestController {

	@GetMapping("/get-current-module")
	public String getCurrentModule(HttpServletRequest request) {
		return (String) request.getSession().getAttribute(Consts.CURRENT_MODULE);
	}
}
