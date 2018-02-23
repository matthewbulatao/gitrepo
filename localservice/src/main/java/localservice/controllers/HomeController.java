	package localservice.controllers;

import java.io.File;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import localservice.models.ContactForm;
import localservice.restcontrollers.RoomRestController;
import localservice.services.ApplicationPropertiesService;
import localservice.services.MailService;
import localservice.services.MiscellaneousService;
import localservice.services.RoomService;

@Controller
public class HomeController extends BaseController {
	
	private final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private MiscellaneousService miscellaneousService;
	@Autowired
	private RoomService roomService;
	@Autowired
	private ApplicationPropertiesService applicationPropertiesService;
	@Autowired
	private MailService mailService;
	@Autowired
	private RoomRestController roomRestController;
	
	private SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	
	@GetMapping("/")
	public String home(HttpServletRequest request) {
		setModuleInSession(request, StringUtils.EMPTY, null);
		request.setAttribute("config", applicationPropertiesService.findLatestConfig());
		request.setAttribute("dateToday", formatter.format(new Date()));	
		
		String userRoleToDisplay = "";
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (null != authentication && !(authentication instanceof AnonymousAuthenticationToken)) {
			List<GrantedAuthority> roles =  (List<GrantedAuthority>) authentication.getAuthorities();
			for(GrantedAuthority role : roles) {
				if(StringUtils.contains(role.getAuthority(), "ADMIN")) {
					userRoleToDisplay = "Admin";
					break;
				}
			}
			if(StringUtils.isEmpty(userRoleToDisplay)) {
				for(GrantedAuthority role : roles) {
					if(StringUtils.contains(role.getAuthority(), "STAFF")) {
						userRoleToDisplay = "Staff";
						break;
					}
				}
			}
		}
		
		request.getSession().setAttribute("userRoleToDisplay", userRoleToDisplay);
		roomRestController.releaseRoomsWithSessionId(request.getSession().getId());
		return "index";
	}
	
	@GetMapping("/rates")
	public String rates(HttpServletRequest request) {
		String page = "rates";
		request.setAttribute("config", applicationPropertiesService.findLatestConfig());
		request.setAttribute("roomList", roomService.findAllActiveOrderByCapacity());
		setModuleInSession(request, page, null);
		return page;
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
		List<String> carouselImages = getFileList("../../images/carousel");
		List<String> galleryImages = getFileList("../../images/gallery");
		request.setAttribute("carouselImages", carouselImages);
		request.setAttribute("galleryImages", galleryImages);
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
	
	@PostMapping("/contact-submit")
	public String contactSubmit(@ModelAttribute ContactForm contactForm, BindingResult bindingResult, HttpServletRequest request) {
		StringBuilder sb = new StringBuilder();
		sb.append("Dear Admin,<br><br>");
		sb.append("Message from: " + contactForm.getFullName()+"<br>");
		sb.append("Contact Number: " + contactForm.getContactNumber() + "<br><br><hr>");
		sb.append(contactForm.getMessage());
		try {
			this.mailService.sendEmail("casaelum.webmailer@gmail.com", null, "[TEST] Casa Elum (Message From: "+ contactForm.getFullName() +")", sb.toString(), contactForm.getEmail());
			request.setAttribute("messageSent", Boolean.TRUE);
		} catch (Exception e) {
			logger.error(e);
		}
		return "contact";
	}
	
	private List<String> getFileList(String directory){
		ClassLoader loader = Thread.currentThread().getContextClassLoader();
		URL url = loader.getResource(directory);
		String path = url.getPath();
		File folder = new File(path);
		File[] files = folder.listFiles();
		List<String> fileName = new ArrayList<>();
		for(File file : files) {
			fileName.add(file.getName());
		}
		return fileName;
	}
	
}
