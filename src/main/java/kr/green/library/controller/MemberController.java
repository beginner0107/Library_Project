package kr.green.library.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.green.library.service.BookService;
import kr.green.library.service.MemberService;
import kr.green.library.service.RentService;
import kr.green.library.vo.BookReplyVO;
import kr.green.library.vo.BookVO;
import kr.green.library.vo.MemberVO;
import kr.green.library.vo.RentVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/member")
@Controller
@Slf4j
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BookService bookService;
	
	@Autowired
	RentService rentService;
	
	@GetMapping("modify")
	public String modify(Model model, MemberVO memberVO) {
		
		MemberVO dbVO = memberService.selectByUserid(getPrincipal());
		model.addAttribute("userid", dbVO.getUserid());
		model.addAttribute("email", dbVO.getEmail());
		model.addAttribute("phone", dbVO.getPhone());
		return "member/modify";
	}
	@RequestMapping(value = "mypage")
	public String modify(Model model, HttpServletRequest request) {
		MemberVO mvo = memberService.selectByUserid(getPrincipal());
		BookVO bvo = bookService.selectByIsbn(getPrincipal());
		List<RentVO> rentList = rentService.rentListByUserid(getPrincipal());
		log.info("rentList : {}", rentList );
		model.addAttribute("mvo", mvo);
		model.addAttribute("bvo", bvo);
		model.addAttribute("rlist", rentList);
		model.addAttribute("user", getPrincipal());
		return "member/mypage";
	}
	
	@PostMapping("modifyOk")
	public String modifyOk(MemberVO memberVO, Model model) {
		boolean result = memberService.checkPw(memberVO.getUserid(), memberVO.getPassword());
		System.out.println("result : "+result);
		if(result) {
			memberService.update(memberVO);
			return "redirect:/";
		}else {
			return "redirect:/member/modifyfail";
		}
	}
	
	@ResponseBody
	@GetMapping(value = "modifyfail", produces = "text/html; charset=utf8")
	public String modifyfail() {
		String updatefail = "<script>alert('비밀번호가 틀렸습니다'); location.href='modify'</script>";
		return updatefail;
	}
	
	@PostMapping("book_detail_replyOk")
	public String board_detail_replyOk(BookReplyVO bookReplyVO, RedirectAttributes rs) {
		log.info("board_detail_replyOk호출 : {}",bookReplyVO);
		bookReplyVO.setUserid(getPrincipal());
		bookService.insertBookReply(bookReplyVO);
		rs.addAttribute("isbn", bookReplyVO.getIsbn());
		log.info("board_detail_replyOk호출 : {}",bookReplyVO);
		return "redirect:/book_detail";
	}
	// 책 대여
	@PostMapping("book_rentOk")
	public String book_rentOk(RedirectAttributes rs, @ModelAttribute RentVO rentVO, Model model) {
		log.info("RentVO : {}", rentVO.toString());
		rs.addAttribute("isbn", rentVO.getIsbn());
		RentVO vo = rentService.rentAvailable(rentVO.getIsbn(), getPrincipal());
		MemberVO memberVO = memberService.selectByUserid(getPrincipal());
		int overdueBook = rentService.selectOverdueBook(getPrincipal());
		if(overdueBook == 3) { // 연체한 도서의 개수가 3이라면 회원의 등급을 -1 감소시키고 대여 가능한 도서의 개수도 0으로 바꿔준다.
			memberService.updateRankDown(getPrincipal()); // 회원의 랭크와 회원의 대여 가능 횟수가 0이므로 대여가 불가능
			return "redirect:/book_detail";
		}
		// 회원의 랭크가 -1이거나 회원의 대여 가능 횟수가 이라면 다시 book_detail 페이지로 리다이렉트
		if(vo!=null&&vo.getReturn_date() ==null || memberVO.getRank()==-1 || memberVO.getRent_available()==0) {
			return "redirect:/book_detail";
		}
		// 조건에 부합한다면
		rentVO.setUserid(getPrincipal()); //회원의 아이디
		rentVO.setTitle(rentVO.getTitle()); // 회원이 대여하고자 하는 책의 이름
											// 대여(RentVO)에 담아준다.
		// 책을 빌리고
		rentService.insert(rentVO);
		// 책의 수량을 감소시키고
		bookService.updateBookCount(rentVO.getIsbn());
		// 회원의 대여 가능 횟수를 감소시킨다.
		memberService.updateRentAvailable(rentVO.getUserid());
		
		return "redirect:/book_detail";
	}
	
	// 책을 반납하는/..
	@PostMapping("return_bookOk")
	public String return_bookOk(RentVO rentVO, Model model) throws NullPointerException {
		log.info("return_bookOk호출 : {}", rentVO);
		// 반납 할 때 return_date가 기록되어 있다면 반납이 이루어지면 안된다.
		rentVO.setUserid(getPrincipal());
		// nullpointException을 피하기 위해 빌린 도서인 경우 1을 리턴 받고 아닌 경우 0을 리턴 받도록 설정
		int available = rentService.selectReturnAvailable(rentVO);
		if(available==0) {
			// 빌린적이 없다면 다시 내 서재로 redirect
			return "redirect:/member/mypage";
		}else {
			// 반납 날짜를 입력하고
			rentService.updateReturnDate(rentVO);
			// 책의 수량을 증가시키고
			bookService.updateReturnCount(rentVO.getIsbn());
			// 회원의 대여 가능 횟수를 증가시킨다.
			memberService.updateIncreaseRent(getPrincipal());
			// 회원이 정상적으로 반납한 횟수가 10이고 블랙리스트가 아닌 경우
			MemberVO memberVO = memberService.selectByUserid(getPrincipal());
			if(memberVO.getNomal_return()==10 && memberVO.getRank()!=-1) {
				memberService.updateRankUp(getPrincipal());
			}
			return "redirect:/member/mypage";
		}
	}
	
	@PostMapping("extension_book")
	public String extension_book(RentVO rentVO) {
		log.info("extension_book호출 : {} ", rentVO);
		rentVO.setUserid(getPrincipal());
		rentService.updateExtensionCount(rentVO);
		return "redirect:/member/mypage";
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
