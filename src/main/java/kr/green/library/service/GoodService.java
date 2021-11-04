package kr.green.library.service;

import kr.green.library.vo.CommVO;
import kr.green.library.vo.GoodVO;
import kr.green.library.vo.PagingVO;

public interface GoodService{
	void insert(GoodVO goodVO);

	PagingVO<GoodVO> selectList(CommVO commVO);
	
	void delete(GoodVO goodVO);
	
	int selectByGoodIdTitle(GoodVO goodVO);
	
	GoodVO selectByGoodId(int good_id);
}
