package kr.green.library.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.green.library.service.BookService;
import kr.green.library.service.MemberService;
import kr.green.library.service.RentService;
import kr.green.library.service.RequestService;
import kr.green.library.vo.BookReplyVO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.MemberVO;
import kr.green.library.vo.PagingVO;
import kr.green.library.vo.RentVO;
import kr.green.library.vo.RequestVO;
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

	@Autowired
	RequestService requestService;

	// 회원 정보 변경
	@GetMapping("modify")
	public String modify(Model model, MemberVO memberVO) {

		MemberVO dbVO = memberService.selectByUserid(getPrincipal());
		model.addAttribute("userid", dbVO.getUserid());
		model.addAttribute("email", dbVO.getEmail());
		model.addAttribute("phone", dbVO.getPhone());
		return "member/modify";
	}

	// 비밀번호가 일치하는지 확인하여 회원의 아이디와 비밀번호를 넘겨서 db에 회원의 정보가 있다면(1)return
	@PostMapping("modifyOk")
	public String modifyOk(MemberVO memberVO, Model model) {
		boolean result = memberService.checkPw(memberVO.getUserid(), memberVO.getPassword());
		if (result) { // 회원의 정보가 있다면 1이 리턴
			memberService.update(memberVO); // 회원 정보를 수정한다.
			return "redirect:/";
		} else {
			// 회원 정보가 일치 하지 않으므로 비밀번호가 일치하지 않다는 메세지를 띄운다.
			return "redirect:/member/modifyfail";
		}
	}

	// 회원정보 변경이 실패할 경우
	@ResponseBody
	@GetMapping(value = "modifyfail", produces = "text/html; charset=utf8")
	public String modifyfail() {
		String updatefail = "<script>alert('비밀번호가 틀렸습니다'); location.href='modify'</script>";
		return updatefail;
	}

	// 내 서재 (대여 목록과 대여했던 도서들의 목록을 볼 수 있는 페이지)
	@RequestMapping(value = "mypage")
	public String modify(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		String userid = getPrincipal();
		PagingVO<RentVO> pv = rentService.rentListByUserid(commVO, userid);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		MemberVO mvo = memberService.selectByUserid(getPrincipal());
		model.addAttribute("mvo", mvo);
		return "member/mypage";
	}

	// 대여했던 도서들의 목록을 볼 수 있는 페이지
	@RequestMapping(value = "mypage_borrowedList")
	public String mypage_borrowedList(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		String userid = getPrincipal();
		PagingVO<RentVO> pv = rentService.selectBorrowedList(commVO, userid);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		MemberVO mvo = memberService.selectByUserid(getPrincipal());
		model.addAttribute("mvo", mvo);
		return "member/mypage_borrowedList";
	}

	// 댓글 달기(나중에 Ajax로 바꿀)
	@PostMapping("book_detail_replyOk")
	@ResponseBody
	public BookReplyVO board_detail_replyOk(BookReplyVO bookReplyVO, RedirectAttributes rs) {
		log.info("board_detail_replyOk호출 : {}", bookReplyVO);
		bookReplyVO.setUserid(getPrincipal());
		int insert = bookService.insertBookReply(bookReplyVO);
		BookReplyVO replyVO = bookService.selectByBreplyId(bookReplyVO.getBreply_id());
		log.info("board_detail_replyOk호출 : {}", bookReplyVO);
		System.out.println(insert);
		return replyVO;
	}
	// 댓글 달기(나중에 Ajax로 바꿀)
	@PostMapping("book_detail_updateReplyOk")
	@ResponseBody
	public void book_detail_updateReplyOk(String content, String breply_id) {
		log.info("breply_id 넘어오나 : {}", breply_id);
		log.info("content 넘어오나 : {}", content);
		BookReplyVO bookReplyVO = new BookReplyVO();
		bookReplyVO.setBreply_id(Integer.parseInt(breply_id) );
		bookReplyVO.setContent(content);
		bookService.updateReply(bookReplyVO);
	}
	// 댓글 달기(나중에 Ajax로 바꿀)
	@PostMapping("book_detail_deleteReplyOk")
	@ResponseBody
	public void book_detail_deleteReplyOk(String breply_id) {
		log.info("breply_id 넘어오나 : {}", breply_id);
		bookService.deleteReply(Integer.parseInt(breply_id));
	}


	// 책 대여
	@PostMapping("book_rentOk")
	public String book_rentOk(RedirectAttributes rs, @ModelAttribute RentVO rentVO, Model model) {
		log.info("RentVO : {}", rentVO.toString());
		rs.addAttribute("isbn", rentVO.getIsbn());
		RentVO vo = rentService.rentAvailable(rentVO.getIsbn(), getPrincipal());
		MemberVO memberVO = memberService.selectByUserid(getPrincipal());
		int overdueBook = rentService.selectOverdueBook(getPrincipal());
		if (overdueBook == 3) { // 연체한 도서의 개수가 3이라면 회원의 등급을 -1 감소시키고 대여 가능한 도서의 개수도 0으로 바꿔준다.
			memberService.updateRankDown(getPrincipal()); // 회원의 랭크와 회원의 대여 가능 횟수가 0이므로 대여가 불가능
			return "redirect:/book_detail";
		}
		// 회원의 랭크가 -1이거나 회원의 대여 가능 횟수가 이라면 다시 book_detail 페이지로 리다이렉트
		if (vo != null && vo.getReturn_date() == null || memberVO.getRank() == -1
				|| memberVO.getRent_available() == 0) {
			return "redirect:/book_detail";
		}
		// 조건에 부합한다면
		rentVO.setUserid(getPrincipal()); // 회원의 아이디
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
		String isbn[] = rentVO.getIsbn().split(":");
		rentVO.setIsbn(isbn[0].trim());
		rentVO.setUserid(getPrincipal());
		// nullpointException을 피하기 위해 빌린 도서인 경우 1을 리턴 받고 아닌 경우 0을 리턴 받도록 설정
		int available = rentService.selectReturnAvailable(rentVO);
		if (available == 0) {
			// 빌린적이 없다면 다시 내 서재로 redirect
			return "redirect:/member/mypage";
		} else {
			// 반납 날짜를 입력하고
			rentService.updateReturnDate(rentVO);
			// 책의 수량을 증가시키고
			bookService.updateReturnCount(rentVO.getIsbn());
			// 회원의 대여 가능 횟수를 증가시킨다.
			memberService.updateIncreaseRent(getPrincipal());
			// 회원이 정상적으로 반납한 횟수가 10이고 블랙리스트가 아닌 경우
			MemberVO memberVO = memberService.selectByUserid(getPrincipal());
			if (memberVO.getNomal_return() == 10 && memberVO.getRank() != -1) {
				memberService.updateRankUp(getPrincipal());
			}
			return "redirect:/member/mypage";
		}
	}

	// 도서 대여 기간 연장하기
	@PostMapping("extension_book")
	public String extension_book(RentVO rentVO) {
		log.info("extension_book호출 : {} ", rentVO);
		String isbn[] = rentVO.getIsbn().split(":");
		rentVO.setIsbn(isbn[0].trim());
		rentVO.setUserid(getPrincipal());
		rentService.updateExtensionCount(rentVO);
		return "redirect:/member/mypage";
	}

	// 희망도서 신청하는 페이지
	@RequestMapping(value = "/hopeBook")
	public String hopeBoard(Model model, HttpSession session) {
		if (getPrincipal().equals("anonymousUser")) { // 회원이 아닌 사람이 get방식으로 접속했을 때
			return "redirect:/"; // main page로 redirect
		}
		model.addAttribute("user", getPrincipal());
		return "member/hopeBook";
	}

	// 희망도서 등록하는 메서드
	@PostMapping("requestOk")
	public String requestOk(RequestVO requestVO) {
		log.info("requestOk호출 : {}", requestVO);
		requestService.insert(requestVO);
		return "redirect:/member/requestSuccess";
	}

	// 희망도서 등록이 성공했다는 메세지를 띄우며 hopeBook으로
	@ResponseBody
	@GetMapping(value = "requestSuccess", produces = "text/html; charset=utf8")
	public String requestSuccess() {
		String requestSuccess = "<script>alert('희망 도서 등록되었습니다.'); location.href='hopeBook'</script>";
		return requestSuccess;
	}

	// 인증 정보를 얻어내는 method
	private String getPrincipal() {
		String username = "";
		Object object = SecurityContextHolder.getContext().getAuthentication().getName();
		if (object instanceof UserDetails) {
			username = ((UserDetails) object).getUsername();
		} else {
			username = object.toString();
		}
		return username;
	}
}
