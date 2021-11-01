package kr.green.library.service;

import kr.green.library.vo.CommVO;
import kr.green.library.vo.PagingVO;
import kr.green.library.vo.RequestVO;

public interface RequestService {
	void insert(RequestVO requestVO);
	
	PagingVO<RequestVO> selectRequestList(CommVO commVO);
}
