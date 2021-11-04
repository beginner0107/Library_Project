package kr.green.library.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.green.library.service.BookService;
import kr.green.library.vo.BookReplyVO;
import kr.green.library.vo.CommVO;

@Controller
public class RestController {
	
	@Autowired
	BookService bookService;
	
	@ResponseBody
	@PostMapping("/getBookReplyList")
	public List<BookReplyVO> getBookReplyList(CommVO commVO)throws Exception{
		return (List<BookReplyVO>) bookService.selectList(commVO);
	}
	
}
