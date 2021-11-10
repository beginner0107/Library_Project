package kr.green.library.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import kr.green.library.dao.MemberDAO;
import kr.green.library.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;
// Spring Security에서 제공하는 FormLogin에 성공한뒤, 항상 실행하기를 원하는 로직을 추가하기 위해서는, 
// .formLogin().successHandler()에 LoginSuccessHandler를 추가해주면 됩니다.
@Slf4j
public class MyLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		String userid = authentication.getName();
		log.info("{}의 onAuthenticationSuccess 호출 : {} ", this.getClass().getName(), userid);
		MemberVO memberVO = memberDAO.selectByUserid(userid);
		log.info("{}의 onAuthenticationSuccess 호출 : {} ", this.getClass().getName(), memberVO);
		//String idx = request.getParameter("idx");
		//log.info("{}의 onAuthenticationSuccess 호출 : {}", this.getClass().getName(), idx);
		//String root = (String) request.getSession().getAttribute("redirectURI");
		if(memberVO!=null) {
			session.setAttribute("mvo", memberVO);
		}
		/*
		if(idx!=null) {
			root += "?idx="+idx;
		}
		*/
		//log.info("{}의 onAuthenticationSuccess호출 root : {}", this.getClass().getName(), root);
		
		
		response.sendRedirect(request.getContextPath() + "/");
		//response.sendRedirect(root);
	}

}
