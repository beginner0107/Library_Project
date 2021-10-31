package kr.green.library.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.green.library.service.FreeBoardService;
import kr.green.library.vo.CommVO;
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
	@RequestMapping(value = "/insertForm")
	public String insertForm(@ModelAttribute CommVO commVO, Model model) {
		model.addAttribute("cv", commVO);
		return "board/insertForm";
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

	// 사서추천도서 게시판
	// 공지사항 게시판
	// 희망도서 게시판
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
