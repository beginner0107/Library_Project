package kr.green.library.service;

import java.util.List;

import kr.green.library.vo.CommVO;
import kr.green.library.vo.FreeBoardReplyVO;
import kr.green.library.vo.FreeBoardVO;
import kr.green.library.vo.PagingVO;

public interface FreeBoardService {
		// 1. 목록보기
		PagingVO<FreeBoardVO> selectList(CommVO commVO);
		// 2. 내용보기 - 글 1개 가져오기
		FreeBoardVO selectByBoardId(int book_board_id);
		// 3. 글쓰기
		void insert(FreeBoardVO freeBoardVO);
		// 4. 글수정
		void update(FreeBoardVO freeBoardVO, String[] delFiles, String realPath);
		// 5. 글삭제
		void delete(FreeBoardVO freeBoardVO, String uploadPath);
		// 1. 목록보기
		PagingVO<FreeBoardVO> selectAdminList(CommVO commVO);
		// 
		void updateInappropriatePost(FreeBoardVO freeBoardVO);
		
		// 댓글
		void insertFboardReply(FreeBoardReplyVO freeBoardReplyVO);
		void updateReply(FreeBoardReplyVO freeBoardReplyVO);
		void deleteReply(int fboard_reply_id);
		FreeBoardReplyVO selectByFreplyId(int fboard_reply_id);
		List<FreeBoardReplyVO>selectReplyList(int free_board_id);
		void deleteAllReply(int free_board_id);
		
}
