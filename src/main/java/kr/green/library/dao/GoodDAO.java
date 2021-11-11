package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.GoodVO;

public interface GoodDAO {
	void insert(GoodVO goodVO);
	int selectCount(HashMap<String, String>map);
	List<GoodVO>selectList(HashMap<String, String>map);
	void delete(GoodVO goodVO);
	
	int selectByGoodIdTitle(GoodVO goodVO);
	
	GoodVO selectByGoodId(int good_id);
}
