package kr.green.library.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.green.library.service.BookService;
import kr.green.library.service.FreeBoardService;
import kr.green.library.service.GoodService;
import kr.green.library.service.MemberService;
import kr.green.library.service.NoticeService;
import kr.green.library.service.RentService;
import kr.green.library.service.RequestService;
import kr.green.library.vo.BookImageVO;
import kr.green.library.vo.BookVO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.FreeBoardVO;
import kr.green.library.vo.GoodVO;
import kr.green.library.vo.MemberVO;
import kr.green.library.vo.NoticeVO;
import kr.green.library.vo.PagingVO;
import kr.green.library.vo.RentVO;
import kr.green.library.vo.RequestVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BookService bookService;

	@Autowired
	private GoodService goodService;
	
	@Autowired
	private RentService rentService;

	@Autowired
	private RequestService requestService;
	
	@Autowired
	private FreeBoardService freeBoardService;
	
	@Autowired
	private NoticeService noticeService;
	
	
	@RequestMapping(value = "/admin")
	public String postAdmin(Model model) {
		model.addAttribute("msg", "관리자 전용 페이지 입니다.");
		model.addAttribute("user", getPrincipal());
		return "admin/admin";
	}

	@RequestMapping(value = "/member_list")
	public String member_list(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
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
		PagingVO<MemberVO> pv = memberService.selectList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		return "admin/member_list";
	}

	@RequestMapping(value = "/member_hope_list")
	public String member_hope_list(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
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
		PagingVO<RequestVO> pv = requestService.selectRequestList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		return "admin/member_hope_list";
	}

	@RequestMapping(value = "/member_black_list")
	public String member_black_list(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
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
		log.info("commVO 값 : {}", commVO.toString());
		PagingVO<MemberVO> pv = memberService.selectBlackList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		return "admin/member_black_list";
	}

	@RequestMapping(value = "/rankOk", method = RequestMethod.POST)
	public String member_blackOk(Model model, @RequestParam Map<String, String> params, HttpServletRequest request,
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
		String rank = request.getParameter("inputMemberRank");
		String userid = request.getParameter("userid");
		memberService.changeRank(userid, rank);
		PagingVO<MemberVO> pv = memberService.selectBlackList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		return "admin/member_black_list";
	}

	@RequestMapping(value = "/book_add")
	public String book_add(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		PagingVO<BookVO> pv = bookService.selectList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		return "admin/book_add";
	}
	

	@RequestMapping(value = "/bookAddOk", method = RequestMethod.GET)
	public String getBookAddOk() {
		return "admin/book_add";
	}

	@RequestMapping(value = "/bookAddOk", method = RequestMethod.POST)
	public String bookAddOk(@ModelAttribute BookVO bookVO, Model model) {
		log.info("{}의 bookAddOk 호출 : {}", this.getClass().getName(), bookVO);
		bookService.insert(bookVO);
		return "redirect:/admin/book_add";
	}
	
	@RequestMapping(value = "/book_delete")
	public String book_delete(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		PagingVO<BookVO> pv = bookService.selectList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		return "admin/book_delete";
	}
	@RequestMapping(value = "/book_update")
	public String book_update(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		PagingVO<BookVO> pv = bookService.selectList(commVO);
		String isbn = request.getParameter("isbn");
		if(isbn!=null) {
			BookVO bvo = bookService.selectByIsbn(isbn);
			model.addAttribute("bvo", bvo);
		}
		model.addAttribute("user", getPrincipal());
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		return "admin/book_update";
	}
	
	@RequestMapping(value = "/bookUpdateOk", method = RequestMethod.GET)
	public String bookUpdateOk() {
		return "admin/book_update";
	}
	
	@RequestMapping(value = "/bookUpdateOk", method = RequestMethod.POST)
	public String bookUpdateOk(@ModelAttribute BookVO bookVO, Model mode, HttpServletRequest request) {
		log.info("bookUpdateOk 호출 : {} ", bookVO);
		String no_image = request.getParameter("no_image");
		if(no_image!=null) {
			log.info("이미지 없음 : {}", no_image);
			bookService.deleteBookImage(bookVO.getIsbn());
		}
		if(bookVO.getImageList()!=null) {
			bookService.deleteBookImage(bookVO.getIsbn());
			bookVO.getImageList().get(0).setIsbn(bookVO.getIsbn());
			bookService.insertBookImage(bookVO.getImageList().get(0));
			log.info("bookVO.getImageList().get(0) : {}", bookVO.getImageList().get(0));
		}
		bookService.updateBookInfo(bookVO);
		return "redirect:/admin/book_update";
	}
	
	@RequestMapping(value = "/bookDeleteOk", method = RequestMethod.GET)
	public String bookDeleteOk() {
		return "admin/book_delete";
	}
	
	@RequestMapping(value = "/bookDeleteOk", method = RequestMethod.POST)
	public String bookDeleteOk(@RequestParam String isbn,
							   @RequestParam String title, Model model) {
		log.info("bookDeleteOk 호출 : {} {}", isbn, title);
		BookVO vo = bookService.selectByIsbnTitle(isbn, title);
		if(vo!=null) {
			bookService.deleteBookImage(isbn);
			bookService.deleteBook(isbn);
		}
		return "redirect:/admin/book_delete";
	}
	// 사서 추천 도서
	@RequestMapping(value = "/good_add")
	public String good_add(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		PagingVO<BookVO> pv = bookService.selectList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "admin/good_add";
	}
	// 사서 추천 도서
	@RequestMapping(value = "/good_delete")
	public String good_delete(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		PagingVO<GoodVO> pv = goodService.selectList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "admin/good_delete";
	}
	
	@PostMapping("goodDeleteOk")
	public String goodDeleteOk(GoodVO goodVO) {
		int existence = goodService.selectByGoodIdTitle(goodVO);
		if(existence==0) {
			return "redirect:/admin/good_deleteFail";
		}
		goodService.delete(goodVO);
		return "redirect:/admin/good_delete";
	}
	@RequestMapping(value = "/good_deleteFail", produces = "text/html; charset=utf8")
	@ResponseBody
	public String good_deleteFail() {
		String good_deleteFail = "<script>alert('NO와 제목을 잘못 입력하셨습니다.'); location.href='good_delete'</script>";
		return good_deleteFail;
	}
	
	@PostMapping("goodAddOk")
	public String goodAddOk(GoodVO goodVO) {
		
		goodService.insert(goodVO);
		return "redirect:/admin/good_add";
	}
	
	// 연체 도서 리스트
	@RequestMapping(value = "/rent_overdue")
	public String rent_overdue(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		PagingVO<RentVO> pv = rentService.selectOverdueBookList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "admin/rent_overdue";
	}
	
	// 자유게시판 부적절한 게시물 올린 회원 글 비공개 처리
	@RequestMapping(value = "/freeBoard_update")
	public String freeBoard_update(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		PagingVO<FreeBoardVO> pv = freeBoardService.selectAdminList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "admin/freeBoard_update";
	}
	
	@PostMapping("fboard_blackOk")
	public String fboard_blackOk(FreeBoardVO freeBoardVO) {
		log.info("freeBoardVO : {}", freeBoardVO);
		freeBoardService.updateInappropriatePost(freeBoardVO);
		return "redirect:/admin/freeBoard_update";
	}
	
	@RequestMapping(value = "/notice_add")
	public String notice_add(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
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
		return "admin/notice_add";
	}
	
	@PostMapping("noticeAddOk")
	public String noticeAddOk(NoticeVO noticeVO) {
		log.info("noticeVO : {}", noticeVO);
		noticeService.insert(noticeVO);
		return "redirect:/admin/notice_add";
	}
	@RequestMapping(value = "/notice_delete")
	public String notice_delete(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
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
		return "admin/notice_delete";
	}
	@PostMapping("noticeDeleteOk")
	public String noticeDeleteOk(NoticeVO noticeVO) {
		log.info("noticeVO : {}", noticeVO);
		noticeService.delete(noticeVO);
		return "redirect:/admin/notice_delete";
	}
	/* 첨부 파일 업로드 */
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<BookImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {
		log.info("uploadAjaxActionPOST..........");
		
		/* 이미지 파일 체크 */
		for(MultipartFile multipartFile: uploadFile) {
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			try {
				type = Files.probeContentType(checkfile.toPath());
				log.info("MIME TYPE : " + type); 
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(!type.startsWith("image")) {
				List<BookImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			}
		}
		
		String uploadFolder = "C:\\upload";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		String datePath = str.replace("-", File.separator);
		/* 폴더 생성 */
		File uploadPath = new File(uploadFolder, datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		/* 이미저 정보 담는 객체 */
		List<BookImageVO> list = new ArrayList<BookImageVO>();
		
		// 향상된 for
		for (MultipartFile multipartFile : uploadFile) {
			
			/* 이미지 정보 객체 */
			BookImageVO vo = new BookImageVO();
			
			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();			
			vo.setFilename(uploadFileName);
			vo.setUploadpath(datePath);
			
			/* uuid 적용 파일 이름 */
			String uuid = UUID.randomUUID().toString();
			
			vo.setUuid(uuid);
			
			uploadFileName = uuid + "_" + uploadFileName;
			
			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);
			
			/* 파일 저장 */
			try {
				multipartFile.transferTo(saveFile);
				/* 썸네일 생성(Image IO) */
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);	
				
				//BufferedImage bo_image = ImageIO.read(saveFile);
					
					//비율 
					//double ratio = 3;
					//넓이 높이
					int width = 250;
					int height = 400;	
				
				
				Thumbnails.of(saveFile)
		        .size(width, height)
		        .toFile(thumbnailFile);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			list.add(vo);
		}
		ResponseEntity<List<BookImageVO>> result = new ResponseEntity<List<BookImageVO>>(list, HttpStatus.OK);
		return result;
	}
	/* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		
		log.info("deleteFile : {}" , fileName);
		File file = null;
		try {
			/* 썸네일 파일 삭제 */
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");
			
			log.info("originFileName : {}" , originFileName);
			file = new File(URLDecoder.decode(originFileName, "UTF-8"));
			file.delete();
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
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
