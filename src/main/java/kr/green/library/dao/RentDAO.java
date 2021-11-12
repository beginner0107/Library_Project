package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.RentVO;

public interface RentDAO {
	//대여
	void insert(RentVO rentVO);
	// <!-- isbn과 아이디로 대여한 도서 찾기(중복된 도서 대여 불가, 확인) -->
	RentVO rentAvailable(HashMap<String, String>map);
	
	List<RentVO> rentListByUserid(HashMap<String, String>map);
	// 반납
	void updateReturnDate(HashMap<String, String>map);
	// 회원의 연체한 도서의 개수
	int selectOverdueBook(String userid);
	
	void updateExtensionCount(RentVO rentVO);
	
	int selectReturnAvailable(HashMap<String, String>map);
	// 연체 도서 목록 보기
	List<RentVO>selectOverdueBookList(HashMap<String, String>map);
	// 연체 도서 목록 개수
	int selectOverdueBookCount(HashMap<String, String>map);
	// 
	int rentListCount(HashMap<String, String>map);
	// 회원이 대여했던 도서들의 목록
	List<RentVO>selectBorrowedList(HashMap<String, String>map);
	int borrowedCount(HashMap<String, String> totalMap);
	
}
