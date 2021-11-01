package kr.green.library.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.library.dao.GoodDAO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.GoodVO;
import kr.green.library.vo.PagingVO;

@Service
public class GoodServiceImpl implements GoodService {
	
	@Autowired
	private GoodDAO goodDAO;
	
	@Override
	public void insert(GoodVO goodVO) {
		goodDAO.insert(goodVO);
	}

	@Override
	public PagingVO<GoodVO> selectList(CommVO commVO) {
		PagingVO<GoodVO> pagingVO = null;
		try {
			// 전체 개수 구하기
			int totalCount = goodDAO.selectCount();
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount);
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			// 완성된 리스트를 페이징 객체에 넣는다.
			List<GoodVO>list = goodDAO.selectList(map);
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pagingVO;
	}

	@Override
	public void delete(GoodVO goodVO) {
		goodDAO.delete(goodVO);
	}

	@Override
	public int selectByGoodIdTitle(GoodVO goodVO) {
		int existence = goodDAO.selectByGoodIdTitle(goodVO);
		return existence;
	}

}
