package kr.green.library.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.library.dao.RentDAO;
import kr.green.library.dao.RequestDAO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.PagingVO;
import kr.green.library.vo.RentVO;
import kr.green.library.vo.RequestVO;
import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class RequestServiceImpl  implements RequestService{
	
	@Autowired
	private RequestDAO requestDAO;
	
	@Override
	public void insert(RequestVO requestVO) {
		requestDAO.insert(requestVO);
	}
	
	@Override
	public PagingVO<RequestVO> selectRequestList(CommVO commVO) {
		log.info("{}의 selectList 호출 : {}", this.getClass().getName(), commVO);
		PagingVO<RequestVO>pagingVO = null;
		try {
			int totalCount = requestDAO.selectRequestCount();
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount, commVO.getType(), commVO.getKeyword());
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			List<RequestVO> list = requestDAO.selectRequestList(map);
			// 완성된 리스트를 페이징 객체에 넣는다.
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pagingVO;
	}

}
