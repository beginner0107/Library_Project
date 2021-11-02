package kr.green.library.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.library.dao.NoticeDAO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.NoticeVO;
import kr.green.library.vo.PagingVO;
@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeDAO noticeDAO;
	
	@Override
	public void insert(NoticeVO noticeVO) {
		noticeDAO.insert(noticeVO);
	}

	@Override
	public PagingVO<NoticeVO> selectList(CommVO commVO) {
		PagingVO<NoticeVO> pagingVO = null;
		try {
			// 전체 개수 구하기
			int totalCount = noticeDAO.selectCount();
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount);
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			// 완성된 리스트를 페이징 객체에 넣는다.
			List<NoticeVO>list = noticeDAO.selectList(map);
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pagingVO;
	}

	@Override
	public void delete(NoticeVO noticeVO) {
		noticeDAO.delete(noticeVO.getNotice_id());
	}

}
