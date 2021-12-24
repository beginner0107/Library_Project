package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.BookVO;

public interface BookDAO {
	// --- 관리자 ---
	void insert(BookVO bookVO);
	// 한 페이지 얻기 도서 정보 보기
	List<BookVO> selectList(HashMap<String, String> map);
	// 개수 세기 페이징 하기 위해
	int selectCount(HashMap<String, String>map);
	// 하나 가져 오기 -> 수정, 삭제 
	BookVO selectByIsbn(String isbn);
	// 도서 정보 수정
	void updateBookInfo(HashMap<String, String>map);
	//삭제하기
	void deleteBook(String isbn);
	
	// --- 도서 대여 기능 (회원) ---
	// isbn과 제목 넘겨서 책이 있나 확인하기
	BookVO selectByIsbnTitle(HashMap<String, String>map);
	// 도서 대여 -> 수량 -1
	void updateBookCount(String isbn);
	// 도서 반납 -> 수량 +1
	void updateReturnCount(String isbn);
	
	// --- 신규 도서 게시판 --- 
	// 한 페이지 얻기
	List<BookVO> selectNewBook(HashMap<String, String> map);
	// 신규 도서 개수 세기
	int selectNewCount();
	
	List<BookVO> selectFive();
}
