package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.MemberVO;

public interface MemberDAO {
	// 저장하기 : 회원 가입
	void insert(MemberVO memberVO);
	// <!-- 아이디로 찾기 -->
	MemberVO selectByUserid(String userid);
	// <!-- 비밀번호 변경하기 -->
	void updatePassword(HashMap<String, String> map);
	// <!-- 사용여부 변경하기 -->
	void updateEnabled(HashMap<String, String> map);
	// <!-- 동일한 아이디 개수세기 : 아이디 중복 확인 -->
	int selectCountByUserid(String userid);
	// 아이디, 이메일 넘겨서 찾기
	MemberVO selectByEmailUserid(HashMap<String, String> map);
	// 아이디 넘겨서 찾기
	MemberVO selectByEmail(String email);
	// 수정하기
	void update(HashMap<String, String> map);
	// 한 페이지 얻기
	List<MemberVO> selectList(HashMap<String, String> map);
	// 전체 개수 구하기
	int selectCount(HashMap<String, String>map);
	// 한 페이지 얻기
	List<MemberVO> selectBlackList(HashMap<String, String> map);
	// 전체 개수 구하기
	int selectBlackCount(HashMap<String, String>map);
	// 회원 등급 변경하기
	void changeRank(HashMap<String, String>map);
	// 개인정보 수정 -> 대여 가능 횟수 차감
	void updateRentAvailable(HashMap<String, String>map);
	// 개인정보 수정 -> 대여 가능 횟수 증가
	void updateIncreaseRent(HashMap<String, String>map);
	// 개인정보 수정 -> RentMapper에서 연체된 도서의 개수가 3이 넘으면 실행될
	// updateRankDown 회원의 등급이 감소하고, 회원이 빌릴 수 있는 도서의 개수가 0이 된다. 
	void updateRankDown(String userid);
	// 개인정보 수정 -> 정상적으로 반납한 횟수가  10이고 회원의 등급이 -1이 아니면
	void updateRankUp(String userid);
}
