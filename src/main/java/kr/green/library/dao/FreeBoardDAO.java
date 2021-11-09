package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.FreeBoardVO;

public interface FreeBoardDAO {
	// 게시판 글 한 개 얻기 -> 수정, 삭제를 위해
	FreeBoardVO selectByBoardId(int free_board_id);
	// 게시판 글 쓰기 -> 저장하기
	void insert(FreeBoardVO freeBoardVO);
	// 게시글 수정
	void update(FreeBoardVO freeBoardVO);
	// 게시글 삭제
	void delete(int free_board_id);
	// 현재 저장한 free_board_id값 알아내기
	int selectSeq();
	// 전체 개수 얻기
	int selectCount();
	// 1페이지 얻기 
	List<FreeBoardVO> selectList(HashMap<String, Integer> map);
	int selectAdminCount();
	
	// --- 관리자 --- 
	// 
	List<FreeBoardVO> selectAdminList(HashMap<String, Integer> map);
	void updateInappropriatePost(FreeBoardVO freeBoardVO);
}
