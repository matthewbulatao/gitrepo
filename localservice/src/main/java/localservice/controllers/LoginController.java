package localservice.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import localservice.models.AppUserPrincipal;
import localservice.models.ChangePassword;
import localservice.models.User;
import localservice.services.UserService;

@Controller
public class LoginController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping(value = "/login")
	public String login(String logout, String error, HttpServletRequest request) {
		if(null != logout) {
			return "logout";
		}
		if(null != error) {
			request.setAttribute("loginError", true);
		}
		return "login";
	}
	
	@GetMapping(value = "/logout")
	public String logoutSuccess(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	    }
		return "redirect:logout";
	}
	
	@GetMapping(value = "/change-pwd")
	public String changePwd() {
		return "admin-password";
	}
	
	@PostMapping(value = "/change-pwd")
	public String changePwdSubmit(@ModelAttribute ChangePassword cpForm, BindingResult bindingResult, HttpServletRequest request, Authentication authentication) {
		try {
			AppUserPrincipal currentUser = (AppUserPrincipal) userService.loadUserByUsername(authentication.getName());
			if(!new BCryptPasswordEncoder(11).matches(cpForm.getOldPassword(), currentUser.getPassword())) {
				throw new Exception("Old password does not match the current password");
			}else if(!StringUtils.equals(cpForm.getNewPassword(), cpForm.getRepeatNewPassword())) {
				throw new Exception("New password does not match the repeat new password");
			}else {
				User user = currentUser.getUser();
				user.setPassword(cpForm.getNewPassword());
				user.setChangedPassword(true);
				userService.saveOrUpdate(user);
			}
			request.setAttribute("operationSuccess", true);
		}catch(Exception e) {
			request.setAttribute("errorMessage", e.getMessage());
		}		
		return "admin-password";
	}
}
