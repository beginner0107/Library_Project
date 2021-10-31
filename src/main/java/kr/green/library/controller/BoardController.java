package kr.green.library.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.green.library.service.FreeBoardService;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.FreeBoardUploadVO;
import kr.green.library.vo.FreeBoardVO;
import kr.green.library.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private FreeBoardService freeBoardService;

	// 자유 게시판(첨부파일)
	@RequestMapping(value = "/freeBoard")
	public String freeBoard(@RequestParam Map<String, String> params, HttpServletRequest request, Model model,
			@ModelAttribute CommVO commVO) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			params = (Map<String, String>) flashMap.get("map");
			commVO.setP(Integer.parseInt(params.get("p")));
			commVO.setS(Integer.parseInt(params.get("s")));
			commVO.setB(Integer.parseInt(params.get("b")));
		}
		PagingVO<FreeBoardVO> pv = freeBoardService.selectList(commVO);
		model.addAttribute("pv", pv);
		model.addAttribute("cv", commVO);
		model.addAttribute("user", getPrincipal());
		return "board/freeBoard";
	}

	// 자유게시판 InsertForm 글쓰기
	@RequestMapping(value = "/fboard_insertForm")
	public String insertForm(@ModelAttribute CommVO commVO, Model model) {
		model.addAttribute("cv", commVO);
		return "board/fboard_insertForm";
	}

	@RequestMapping(value = "/download")
	public ModelAndView download(@RequestParam HashMap<Object, Object> params, ModelAndView mv) {
		String ofileName = (String) params.get("of"); // 원본이름
		String sfileName = (String) params.get("sf"); // 저장이름
		mv.setViewName("downloadView");
		mv.addObject("ofileName", ofileName);
		mv.addObject("sfileName", sfileName);
		return mv;
	}

	// 자유게시판 글 저장하기
	@RequestMapping(value = "/fboard_insertOk", method = RequestMethod.POST)
	public String insertOkPost(@ModelAttribute CommVO commVO, @ModelAttribute FreeBoardVO freeBoardVO,
			MultipartHttpServletRequest request, Model model, RedirectAttributes redirectAttributes) { // redirect시
																										// POST전송을 위해
																										// RedirectAttributes
																										// 변수 추가
		log.info("{}의 insertOkPost 호출 : {}", this.getClass().getName(), commVO + "\n" + freeBoardVO);
		freeBoardVO.setUserid(getPrincipal());
		// 넘어온 파일 처리를 하자
		List<FreeBoardUploadVO> fileList = new ArrayList<>(); // 파일 정보를 저장할 리스트

		List<MultipartFile> multipartFiles = request.getFiles("upfile"); // 넘어온 파일 리스트
		if (multipartFiles != null && multipartFiles.size() > 0) { // 파일이 있다면
			for (MultipartFile multipartFile : multipartFiles) {
				if (multipartFile != null && multipartFile.getSize() > 0) { // 현재 파일이 존재한다면
					FreeBoardUploadVO freeBoardUploadVO = new FreeBoardUploadVO(); // 객체 생성하고
					// 파일 저장하고
					try {
						// 저장이름
						String realPath = request.getRealPath("upload");
						String saveName = UUID.randomUUID() + "_" + multipartFile.getOriginalFilename();
						// 저장
						File target = new File(realPath, saveName);
						FileCopyUtils.copy(multipartFile.getBytes(), target);
						// vo를 채우고
						freeBoardUploadVO.setOriname(multipartFile.getOriginalFilename());
						freeBoardUploadVO.setSavename(saveName);
						// 리스트에 추가하고
						fileList.add(freeBoardUploadVO);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		freeBoardVO.setFileList(fileList);
		// 서비스를 호출하여 저장을 수행한다.
		freeBoardService.insert(freeBoardVO);

		// redirect시 GET전송 하기
		// return "redirect:/board/list?p=1&s=" + commVO.getPageSize() + "&b=" +
		// commVO.getBlockSize();
		// redirect시 POST전송 하기
		// Redirect시 POST전송 하려면 map에 넣어서 RedirectAttributes에 담아서 전송하면 된다.
		Map<String, String> map = new HashMap<>();
		map.put("p", "1");
		map.put("s", commVO.getPageSize() + "");
		map.put("b", commVO.getBlockSize() + "");
		redirectAttributes.addFlashAttribute("map", map);
		return "redirect:/board/freeBoard";
	}

	// 내용보기 : 글 1개를 읽어서 보여준다
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/fboard_view")
	public String view(@RequestParam Map<String, String> params, HttpServletRequest request,
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

		FreeBoardVO freeBoardVO = freeBoardService.selectByBoardId(commVO.getIdx());
		model.addAttribute("fv", freeBoardVO);
		model.addAttribute("cv", commVO);
		return "board/fboard_view";
	}
	
	@RequestMapping(value = "/fboard_delete",method = RequestMethod.POST)
	public String deleteOKPost(@ModelAttribute CommVO commVO,
			@ModelAttribute FreeBoardVO freeBoardVO, 
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		freeBoardVO.setFree_board_id(commVO.getIdx());
		// 일단 VO로 받고
		log.info("{}의 deleteOKPost 호출 : {}", this.getClass().getName(), commVO + "\n" + freeBoardVO);
		// 실제 경로 구하고
		String realPath = request.getRealPath("upload");
		// 서비스를 호출하여 삭제를 수행하고
		freeBoardService.delete(freeBoardVO, realPath);
		
		// redirect시 GET전송 하기
		// return "redirect:/board/list?p=1&s=" + commVO.getPageSize() + "&b=" + commVO.getBlockSize();
		// redirect시 POST전송 하기
		// Redirect시 POST전송 하려면 map에 넣어서 RedirectAttributes에 담아서 전송하면 된다.
		Map<String, String> map = new HashMap<>();
		map.put("p", commVO.getCurrentPage() + "");
		map.put("s", commVO.getPageSize() + "");
		map.put("b",commVO.getBlockSize() + "");
		redirectAttributes.addFlashAttribute("map", map);
		return "redirect:/board/freeBoard";
	}
	
	@RequestMapping(value = "/fboard_update",method = RequestMethod.POST)
	public String updatePost(@ModelAttribute CommVO commVO,Model model) {
		FreeBoardVO freeBoardVO= freeBoardService.selectByBoardId(commVO.getIdx());
		model.addAttribute("fv", freeBoardVO);
		model.addAttribute("cv", commVO);
		return "board/fboard_update";
	}
	@PostMapping(value = "/imageUpload", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String imageUpload(MultipartHttpServletRequest request, MultipartFile file) {
		log.info("{}의 imageUpload 호출 : {}", this.getClass().getName(), request);
		String filePath = "";
		String realPath = request.getRealPath("contentfile");
		if (file != null && file.getSize() > 0) {
			try {
				String saveName = UUID.randomUUID() + "_" + file.getOriginalFilename();
				File target = new File(realPath, saveName);
				FileCopyUtils.copy(file.getBytes(), target);
				filePath = request.getContextPath() + "\\contentfile\\" + saveName;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		log.info("{}의 imageUpload 호출 : {}", this.getClass().getName(), filePath);
		return filePath;
	}
	@RequestMapping(value = "/updateOK",method = RequestMethod.POST)
	public String updateOKPost(@ModelAttribute CommVO commVO,
			@ModelAttribute FreeBoardVO freeBoardVO, 
			MultipartHttpServletRequest request, Model model,
			RedirectAttributes redirectAttributes) {
		// 일단 VO로 받고
		log.info("{}의 updateOKPost 호출 : {}", this.getClass().getName(), commVO + "\n" + freeBoardVO);
		freeBoardVO.setFree_board_id(commVO.getIdx());
		// 넘어온 파일 처리를 하자
		List<FreeBoardUploadVO> fileList = new ArrayList<>(); // 파일 정보를 저장할 리스트
		
		List<MultipartFile> multipartFiles = request.getFiles("upfile"); // 넘어온 파일 리스트
		if(multipartFiles!=null && multipartFiles.size()>0) {  // 파일이 있다면
			for(MultipartFile multipartFile : multipartFiles) {
				if(multipartFile!=null && multipartFile.getSize()>0 ) { // 현재 파일이 존재한다면
					FreeBoardUploadVO freeBoardUploadVO = new FreeBoardUploadVO(); // 객체 생성하고
					// 파일 저장하고
					try {
						// 저장이름
						String realPath = request.getRealPath("upload");
						String saveName = UUID.randomUUID() + "_" + multipartFile.getOriginalFilename();
						// 저장
						File target = new File(realPath, saveName);
						FileCopyUtils.copy(multipartFile.getBytes(), target);
						// vo를 채우고
						freeBoardUploadVO.setOriname(multipartFile.getOriginalFilename());
						freeBoardUploadVO.setSavename(saveName);
						// 리스트에 추가하고
						fileList.add(freeBoardUploadVO); 
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		freeBoardVO.setFileList(fileList);
		// 삭제할 파일 번호를 받아서 삭제할 파일을 삭제해 주어야 한다.
		String[] delFiles = request.getParameterValues("delfile");
		// 서비스를 호출하여 저장을 수행한다.
		String realPath = request.getRealPath("upload");
		freeBoardService.update(freeBoardVO, delFiles, realPath);
		
		// redirect시 GET전송 하기
		// return "redirect:/board/list?p=1&s=" + commVO.getPageSize() + "&b=" + commVO.getBlockSize();
		// redirect시 POST전송 하기
		// Redirect시 POST전송 하려면 map에 넣어서 RedirectAttributes에 담아서 전송하면 된다.
		Map<String, String> map = new HashMap<>();
		map.put("p", commVO.getCurrentPage() + "");
		map.put("s", commVO.getPageSize() + "");
		map.put("b",commVO.getBlockSize() + "");
		map.put("idx",commVO.getIdx() + "");
		redirectAttributes.addFlashAttribute("map", map);
		return "redirect:/board/fboard_view";
	}
	
	

	// 사서추천도서 게시판
	// 공지사항 게시판
	// 희망도서 게시판
	// 자유 게시판(첨부파일)
	
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
