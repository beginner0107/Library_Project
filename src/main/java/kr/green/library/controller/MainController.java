package kr.green.library.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.green.library.service.BookService;
import kr.green.library.service.GoodService;
import kr.green.library.service.MemberService;
import kr.green.library.service.NoticeService;
import kr.green.library.vo.BookImageVO;
import kr.green.library.vo.BookReplyVO;
import kr.green.library.vo.BookVO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.GoodVO;
import kr.green.library.vo.NoticeVO;
import kr.green.library.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainController {
	
	@Autowired
	BookService bookService;
	@Autowired
	MemberService memberService;
	@Autowired
	GoodService goodService;
	@Autowired
	NoticeService noticeService;
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		model.addAttribute("user", getPrincipal());
		model.addAttribute("serverTime", formattedDate );
		return "index";
	}
	
	@RequestMapping(value = "/unified_search")
	public String unified_search(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
			commVO.setKeyword(params.get("keyword").trim());
			commVO.setType(params.get("type").trim());
		}
		PagingVO<BookVO> pv = bookService.selectList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "unified_search";
	}
	@RequestMapping(value = "/book_detail")
	public String book_detail(Model model, HttpServletRequest request
			,@RequestParam Map<String, String> params,
			 @ModelAttribute CommVO commVO) {
		String isbn = request.getParameter("isbn");
		log.info("isbn : {}", isbn);
		BookVO vo = bookService.selectByIsbn(isbn);
		if(vo!=null) {
			model.addAttribute("vo", vo);
		}
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
			commVO.setIsbn(params.get("isbn"));
		}
		PagingVO<BookReplyVO> pv = bookService.selectReplyList(commVO);
		//List<BookReplyVO> pv = bookService.getBookReplyList(isbn);
		log.info("pv : {}", pv);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		log.info("pv : {}", pv.toString());
		return "book_detail";
	}
	@RequestMapping(value = "/bookList")
	@ResponseBody
	public List<BookReplyVO>getBookReplyList(String isbn){
		log.info("getBookReplyList호출 : {}",isbn);
		List<BookReplyVO>pv = bookService.getBookReplyList(isbn);
		return pv;
	}
	
	/* 이미지 정보 반환 */
	@GetMapping(value="/getImageList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<BookImageVO>> getImageList(String isbn){
		
		log.info("getImageList : {}", isbn);
		
		return new ResponseEntity<List<BookImageVO>>(bookService.selectByIsbn(isbn).getImageList(), HttpStatus.OK);
		
	}
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName){
		log.info("getImage : {}", fileName);
		File file = new File("c:\\upload\\" + fileName);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 신간 도서 리스트
	@RequestMapping("/newBook")
	public String newBook(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		model.addAttribute("user", getPrincipal());
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		PagingVO<BookVO> pv = bookService.selectNewBook(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "newBook";
	}
	
	@RequestMapping(value = "/goodBook")
	public String goodBook(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
			commVO.setKeyword(params.get("keyword"));
			commVO.setType(params.get("type"));
		}
		PagingVO<GoodVO> pv = goodService.selectList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "goodBook";
	}
	
	
	@RequestMapping("/library_Introduce")
	public String library_introduece(Model model) {
		model.addAttribute("user", getPrincipal());
		return "library_Introduce";
	}
	@RequestMapping("/notice")
	public String notice(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		PagingVO<NoticeVO> pv = noticeService.selectList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "notice";
	}
	
	@RequestMapping("notice_detail")
	public String notice_detail(@RequestParam Map<String, String> params, HttpServletRequest request,
			@ModelAttribute CommVO commVO, Model model) {
		log.info("{}의 view호출 : {}", this.getClass().getName(), commVO);
		// POST전송된것을 받으려면 RequestContextUtils.getInputFlashMap(request)로 맵이 존재하는지 판단해서
		// 있으면 POST처리를 하고 없으면 GET으로 받아서 처리를 한다.
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
			commVO.setIdx(Integer.parseInt(params.get("idx")));
		}
		NoticeVO noticeVO = noticeService.selectByNoticeId(commVO.getIdx());
		model.addAttribute("nvo",noticeVO);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "notice_detail";
	}
	@RequestMapping("goodBook_detail")
	public String good_detail(@RequestParam Map<String, String> params, HttpServletRequest request,
			@ModelAttribute CommVO commVO, Model model) {
		log.info("{}의 view호출 : {}", this.getClass().getName(), commVO);
		// POST전송된것을 받으려면 RequestContextUtils.getInputFlashMap(request)로 맵이 존재하는지 판단해서
		// 있으면 POST처리를 하고 없으면 GET으로 받아서 처리를 한다.
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
			commVO.setIdx(Integer.parseInt(params.get("idx")));
		}
		GoodVO goodVO = goodService.selectByGoodId(commVO.getIdx());
		model.addAttribute("gvo",goodVO);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "goodBook_detail";
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
