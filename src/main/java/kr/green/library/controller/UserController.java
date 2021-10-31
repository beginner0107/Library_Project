package kr.green.library.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.green.library.service.MemberService;
import kr.green.library.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	MemberService memberService;
	
	
	// 회원가입 페이지
	@RequestMapping(value = "/join")
	public String join() {
		return "user/join";
	}

	// 아이디 중복확인
	@GetMapping(value = "/idCheck", produces = "text/plain;charset=UTF-8" )
	@ResponseBody
	public String idCheck(@RequestParam String userid) {
		log.info("{}의 idCheck 호출 : {}", this.getClass().getName(), userid);
		int count = memberService.idCheck(userid);
		log.info("{}의 idCheck 리턴 : {}", this.getClass().getName(), count);
		return count+"";
	}
	
	// 로그인
	@RequestMapping(value = "/login")
	public String login(
			@RequestParam Map<String, String> param, // 모든 넘어오는정보를 맵으로 받기
			@RequestParam(value = "error", required = false) String error,
			Model model) {
		log.info("param : {}, error : {}", param, error);
		if (error!=null) {
			model.addAttribute("error","아이디 또는 비밀번호가 틀렸습니다.");
		}
		return "user/login";
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		// 시큐리티를 이용하여 정보를 얻어 인증 정보를 얻어낸다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(authentication!=null) { // 인증 정보가 있으면
			new SecurityContextLogoutHandler().logout(request, response, authentication); // 로그아웃을 시킨다.
		}
		return "redirect:/";
	}
	
	@RequestMapping(value = "/forgotPwd")
	public String forgotPwd() {
		return "user/forgotPwd";
	}
	@RequestMapping(value = "/forgotId")
	public String forgotId() {
		return "user/forgotId";
	}
	
	// 접근 권한이 없는 페이지에 접근하면 보여줄 페이지
	@RequestMapping(value = "/403")
	public String page403(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			System.out.println(userDetails);
			model.addAttribute("username", userDetails.getUsername());
		}
		return "user/403";
	}
	// Get 방식으로 들어온 요청은 메인 페이지로 redirect
	@RequestMapping(value = "/joinOk", method=RequestMethod.GET)
	public String joinOkGet(Model model) {
		log.info("{}의 joinOkGet 호출 : {}", this.getClass().getName(), null );
		return "redirect:/";
	}
	
	@RequestMapping(value = "/joinOk", method=RequestMethod.POST)
	public String joinOkPost(@ModelAttribute MemberVO memberVO,Model model, HttpServletRequest request, RedirectAttributes ra) {
		log.info("{}의 joinOkPost 호출 : {}", this.getClass().getName(), memberVO);
		// 서비스를 호출하여 DB에 저장한다.
			memberService.insert(memberVO);
			return "redirect:/user/joinSuccess";
	}
	@ResponseBody
	@RequestMapping(value = "/joinSuccess", method=RequestMethod.GET, produces = "text/html; charset=utf8")
	public String joinSuccess(@ModelAttribute MemberVO memberVO, Model model) {
		log.info("{}의 joinSuccess 호출 : {}", this.getClass().getName(), memberVO);
		String success = "<script>alert('회원가입 성공하셨습니다. 가입한 "  + "이메일로 인증문자가 발송되었습니다.'); location.href='/library/'</script>";
		return success;
	}
	
	// 이메일 인증처리
	@RequestMapping(value = "/authOk")
	public String authOk(@ModelAttribute MemberVO memberVO, Model model) {
		log.info("{}의 authOk 호출 : {}", this.getClass().getName(), memberVO );
		// 서비스를 호출하여 이메일 인증처리를 한다.
		MemberVO memberVO2 = memberService.emailConfirm(memberVO);
		model.addAttribute("vo", memberVO2);
		return "user/authOk";
	}
	// 아이디 찾기
	@RequestMapping(value = "/forgotIdOk", method = RequestMethod.POST)
	public String forgotIdOk(@ModelAttribute MemberVO memberVO, Model model) {
		log.info("dbVO : {}", memberVO.toString());
		MemberVO dbVO = memberService.selectByEmail(memberVO.getEmail());
		if(dbVO!=null) {
			model.addAttribute("userid", dbVO.getUserid());
			return "user/found";
		}else {
			return "redirect:/user/forgotPwd";
		}
	}
	// 비밀번호 발급
	@RequestMapping(value = "/forgotPwdOk", method = RequestMethod.POST)
	public String forgotPwdOk(@ModelAttribute MemberVO memberVO, Model model) {
		log.info("dbVO : {}", memberVO.toString());
		MemberVO dbVO = memberService.selectByEmailUserid(memberVO.getUserid(), memberVO.getEmail());
		if(dbVO!=null) {
			memberService.updatePassword(dbVO);
			model.addAttribute("email", dbVO.getEmail());
			return "user/found";
		}else {
			return "redirect:/user/forgotPwd";
		}
	}
	

	
	// 인증 정보를 얻어내는 method
		private String getPrincipal() {
			String username = "";
			Object object = SecurityContextHolder.getContext().getAuthentication().getName();
			if(object instanceof UserDetails) {
				username = ((UserDetails) object).getUsername();
			}else {
				username = object.toString();
			}
			return username;
		}
}
