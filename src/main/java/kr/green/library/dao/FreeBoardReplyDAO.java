package kr.green.library.dao;

import java.util.List;

import kr.green.library.vo.FreeBoardReplyVO;

public interface FreeBoardReplyDAO {
	void insertFboardReply(FreeBoardReplyVO freeBoardReplyVO);
	int selectCount (int free_board_id);
	void updateReply(FreeBoardReplyVO freeBoardReplyVO);
	void deleteReply(int fboard_reply_id);
	FreeBoardReplyVO selectByFreplyId(int fboard_reply_id);
	List<FreeBoardReplyVO>selectReplyList(int free_board_id);
	void deleteAllReply(int free_board_id);
}
