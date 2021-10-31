package kr.green.library.dao;

import java.util.List;

import kr.green.library.vo.BookImageVO;

public interface BookImageDAO {
	void insert(BookImageVO bookImageVO);
	
	List<BookImageVO> selectImage(String isbn);
	
	//삭제하기
	void deleteBookImage(String isbn);
}
