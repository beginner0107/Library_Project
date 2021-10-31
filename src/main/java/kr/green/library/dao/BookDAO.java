package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.BookVO;

public interface BookDAO {
	void insert(BookVO bookVO);
	// 한 페이지 얻기
	List<BookVO> selectList(HashMap<String, String> map);
	// 개수 세기
	int selectCount();
	
	BookVO selectByIsbn(String isbn);
	
	//삭제하기
	void deleteBook(String isbn);
	// isbn과 제목 넘겨서 책이 있나 확인하기
	BookVO selectByIsbnTitle(HashMap<String, String>map);
	// 도서 정보 수정
	void updateBookInfo(HashMap<String, String>map);
	// 도서 대여 -> 수량 -1
	void updateBookCount(String isbn);
	// 도서 반납 -> 수량 +1
	void updateReturnCount(String isbn);
	
	// 한 페이지 얻기
	List<BookVO> selectNewBook(HashMap<String, String> map);
	// 신규 도서 개수 세기
	int selectNewCount();
}
