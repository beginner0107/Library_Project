package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.BookReplyVO;

public interface BookReplyDAO {
	int insertBookReply(BookReplyVO bookReplyVO);
	
	List<BookReplyVO> selectReplyList(HashMap<String, String>map);
	
	int selectCount(String isbn);
	
	void updateReply(BookReplyVO bookReplyVO);
	
	void deleteReply(int breply_id);
	// 댓글 하나 얻기
	BookReplyVO selectByBreplyId(int breply_id);
	// 댓글 리스트 전체 읽기
	List<BookReplyVO> getBookReplyList(String isbn);
}
