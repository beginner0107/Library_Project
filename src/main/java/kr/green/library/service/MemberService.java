package kr.green.library.service;

import kr.green.library.vo.CommVO;
import kr.green.library.vo.MemberVO;
import kr.green.library.vo.PagingVO;
import kr.green.library.vo.RentVO;

public interface MemberService {
	// 회원 가입 
	void insert(MemberVO memberVO);
	// 이메일 인증
	MemberVO emailConfirm(MemberVO memberVO);
	// 아이디 중복 검사
	int idCheck(String userid);
	
	// <!-- 아이디로 찾기 -->
	MemberVO selectByUserid(String userid);
	
	void updatePassword(MemberVO memberVO);
	// 아이디 이메일로 찾기
	MemberVO selectByEmailUserid(String userid, String email);
	// 이메일로 아이디 찾기
	MemberVO selectByEmail(String email);
	// 수정하기
	void update(MemberVO memberVO);
	// 비밀번호 일치하는지 일치하지 않는지 확인
	boolean checkPw(String userid, String password);
	// 정상적으로 반납
	void updateNomalReturn(String userid);
	// 연체
	void updateOverdueReturn(String userid);
	
	
	// 관리자 
	// 목록 보기
	PagingVO<MemberVO> selectList(CommVO commVO);
	
	// 목록 보기
	PagingVO<MemberVO> selectBlackList(CommVO commVO);
	
	void changeRank(String userid, String rank);
	
	void updateRentAvailable(String userid);
	
	void updateIncreaseRent(String userid);
	// 수정하기 : 연체한 도서의 개수가 3이면 회원의 등급 -1 회원이 빌릴 수 있는 도서도 0으로
	void updateRankDown(String userid);
	// 개인정보 수정 -> 정상적으로 반납한 횟수가  10이고 회원의 등급이 -1이 아니면
	void updateRankUp(String userid);
	
	
}
