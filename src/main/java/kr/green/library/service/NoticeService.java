package kr.green.library.service;

import kr.green.library.vo.CommVO;
import kr.green.library.vo.NoticeVO;
import kr.green.library.vo.PagingVO;

public interface NoticeService {
	void insert(NoticeVO noticeVO);
	
	PagingVO<NoticeVO>selectList(CommVO commVO);
	
	void delete(NoticeVO noticeVO);
}
