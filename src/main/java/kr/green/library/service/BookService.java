package kr.green.library.service;

import org.springframework.stereotype.Service;

import kr.green.library.vo.BookImageVO;
import kr.green.library.vo.BookReplyVO;
import kr.green.library.vo.BookVO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.PagingVO;

@Service
public interface BookService {
	void insert(BookVO bookVO);
	
	// 목록 보기
	PagingVO<BookVO> selectList(CommVO commVO);
	
	PagingVO<BookReplyVO> selectReplyList(CommVO commVO);

	BookVO selectByIsbn(String isbn);

	BookVO selectByIsbnTitle(String isbn, String title);
	// 도서 삭제 
	void deleteBook(String isbn);
	// 도서 이미지 삭제 
	void deleteBookImage(String isbn);
	// 도서 정보 수정
	void updateBookInfo(BookVO bookVO);
	// 도서 정보 수정할 때 이미지 삭제하고 다시 추가 할 때에 수행
	void insertBookImage(BookImageVO bookImageVO);
	// 도서 댓글 추가
	void insertBookReply(BookReplyVO bookReplyVO);
	// 도서 대여 -> 수량 -1
	void updateBookCount(String isbn);
	// 도서 반납 -> 수량 +1;
	void updateReturnCount(String isbn);
	// 신규 도서 목록 보기
	PagingVO<BookVO> selectNewBook(CommVO commVO);
	
}
