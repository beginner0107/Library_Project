package kr.green.library.dao;

import java.util.HashMap;
import java.util.List;

import kr.green.library.vo.RequestVO;

public interface RequestDAO {
	void insert(RequestVO requestVO);
	// 회원 희망도서 개수
	int selectRequestCount(HashMap<String, String>map);
	// 회원 희망 도서 1 페이지 얻기
	List<RequestVO>selectRequestList(HashMap<String, String>map);
}
