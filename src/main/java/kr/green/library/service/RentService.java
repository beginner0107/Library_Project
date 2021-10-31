package kr.green.library.service;

import java.util.List;

import kr.green.library.vo.RentVO;

public interface RentService {
	// 책 대여하기 
	void insert(RentVO rentVO);
	// 	<!-- isbn과 아이디로 대여한 도서 찾기(중복된 도서 대여 불가, 확인) -->
	RentVO rentAvailable(String isbn, String userid);
	
	List<RentVO> rentListByUserid(String userid);
	// 반납하기
	void updateReturnDate(RentVO rentVO);
	
	int selectOverdueBook(String userid);
	// 대여도서 연장 -> 도서 반납 예정일이 변한다. return_due_date에 rentVO.getExtensionDate를 더해준다.
	void updateExtensionCount(RentVO rentVO);
	
	int selectReturnAvailable(RentVO rentVO);
}
