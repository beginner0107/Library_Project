package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.NoticeVO;

public interface NoticeDAO {
	void insert(NoticeVO noticeVO);
	
	int selectCount();
	
	List<NoticeVO>selectList(HashMap<String, String>map);
	
	void delete(int notice_id);
	
	NoticeVO selectByNoticeId(int notice_id);
}
