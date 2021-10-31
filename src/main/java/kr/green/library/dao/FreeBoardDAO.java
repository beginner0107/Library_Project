package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.FreeBoardVO;

public interface FreeBoardDAO {
	// 전체 개수 얻기
	int selectCount();
	// 1개 얻기(free_board_id를 넘기면 freeBoardVO를 채울 수 있가.)
	FreeBoardVO selectByBoardId(int free_board_id);
	// 1페이지 얻기
	// <!-- 3. 1페이지 얻기 -->
	List<FreeBoardVO> selectList(HashMap<String, Integer> map);
	// 저장하기
	void insert(FreeBoardVO freeBoardVO);
	// 게시글의 고유번호 가지고 와서 수정 / 삭제
	void update(FreeBoardVO freeBoardVO);
	void delete(int free_board_id);
	// 현재 저장한 free_board_id값 알아내기
	int selectSeq();
}
