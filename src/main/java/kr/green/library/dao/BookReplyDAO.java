package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.BookReplyVO;

public interface BookReplyDAO {
	void insertBookReply(BookReplyVO bookReplyVO);
	
	List<BookReplyVO> selectReplyList(HashMap<String, String>map);
	
	int selectCount(String isbn);
}
