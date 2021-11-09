package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.BookReplyVO;

public interface BookReplyDAO {
	// 댓글 하나 얻기 --> 읽기, 수정, 삭제
	BookReplyVO selectByBreplyId(int breply_id);
	// 댓글 저장하기
	int insertBookReply(BookReplyVO bookReplyVO);
	// 특정 댓글 수정하기
	void updateReply(BookReplyVO bookReplyVO);
	// 특정 댓글 삭제하기
	void deleteReply(int breply_id);
	// 전체 댓글 개수 세기
	int selectCount(String isbn);
	// 댓글 리스트 Ajax 사용 X 
	List<BookReplyVO> selectReplyList(HashMap<String, String>map);
	// 특정 도서의 댓글 리스트 전체 읽기 Ajax 
	List<BookReplyVO> getBookReplyList(String isbn);
	// 게시물이 삭제되면 그 게시글의 댓글도 삭제되어야 한다.
	void deleteAllReply(String isbn);
}
