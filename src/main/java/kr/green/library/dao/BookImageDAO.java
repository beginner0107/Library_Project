package kr.green.library.dao;

import java.util.List;

import kr.green.library.vo.BookImageVO;

public interface BookImageDAO {
	// --- 관리자 ---
	// 도서 이미지 저장
	void insert(BookImageVO bookImageVO);
	// 특정 도서의 이미지 경로들을 List로 받아서 보여줌
	List<BookImageVO> selectImage(String isbn);
	// 삭제하기 - 수정할 때 이용 
	void deleteBookImage(String isbn);
	// 어제자 날짜 이미지 리스트
	public List<BookImageVO> checkFileList();
}
