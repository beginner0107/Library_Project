package kr.green.library.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.library.dao.RentDAO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.PagingVO;
import kr.green.library.vo.RentVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class RentServiceImpl implements RentService{

	@Autowired
	private RentDAO rentDAO;
	// 대여 기능
	@Override
	public void insert(RentVO rentVO) {
		rentDAO.insert(rentVO);
	}
	// 중복 대여 금지
	@Override
	public RentVO rentAvailable(String isbn, String userid) {
		HashMap<String, String>map = new HashMap<>();
		map.put("isbn", isbn);
		map.put("userid", userid);
		RentVO vo = rentDAO.rentAvailable(map);
		return vo;
	}
	@Override
	public PagingVO<RentVO> rentListByUserid(CommVO commVO, String userid) {
		log.info("{}의 selectList 호출 : {}", this.getClass().getName(), commVO);
		PagingVO<RentVO>pagingVO = null;
		try {
			// 전체 개수 구하기
			HashMap<String, String>totalMap = new HashMap<>();
			totalMap.put("keyword", commVO.getKeyword());
			totalMap.put("type", commVO.getType());
			totalMap.put("userid", userid);
			int totalCount = rentDAO.rentListCount(totalMap);
			log.info("totalCount : {}", totalCount);
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount, commVO.getType(), commVO.getKeyword());
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userid", userid);
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			map.put("keyword", pagingVO.getKeyword());
			map.put("type", pagingVO.getType());
			map.put("userid", userid);
			List<RentVO> list = rentDAO.rentListByUserid(map);
			// 완성된 리스트를 페이징 객체에 넣는다.
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pagingVO;
	}
	@Override
	public void updateReturnDate(RentVO rentVO) {
		HashMap<String, String>map = new HashMap<>();
		map.put("isbn", rentVO.getIsbn());
		map.put("userid", rentVO.getUserid());
		rentDAO.updateReturnDate(map);
	}
	@Override
	public int selectOverdueBook(String userid) {
		int overdueBook = 0;
		overdueBook = rentDAO.selectOverdueBook(userid);
		return overdueBook;
	}
	@Override
	public void updateExtensionCount(RentVO rentVO) {
	   rentDAO.updateExtensionCount(rentVO);
	}
	@Override
	public int selectReturnAvailable(RentVO rentVO) {
		HashMap<String, String>map = new HashMap<>();
		map.put("isbn", rentVO.getIsbn());
		map.put("userid", rentVO.getUserid());
		return rentDAO.selectReturnAvailable(map);
	}
	@Override
	public PagingVO<RentVO> selectOverdueBookList(CommVO commVO) {
		log.info("{}의 selectList 호출 : {}", this.getClass().getName(), commVO);
		PagingVO<RentVO>pagingVO = null;
		try {
			HashMap<String, String>totalMap = new HashMap<>();
			totalMap.put("keyword", commVO.getKeyword());
			totalMap.put("type", commVO.getType());
			// 전체 개수 구하기
			int totalCount = rentDAO.selectOverdueBookCount(totalMap);
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount, commVO.getType(), commVO.getKeyword());
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			map.put("type", pagingVO.getType());
			map.put("keyword", pagingVO.getKeyword());
			List<RentVO> list = rentDAO.selectOverdueBookList(map);
			// 완성된 리스트를 페이징 객체에 넣는다.
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pagingVO;
	}
	@Override
	public PagingVO<RentVO> selectBorrowedList(CommVO commVO, String userid) {
		log.info("{}의 selectList 호출 : {}", this.getClass().getName(), commVO);
		PagingVO<RentVO>pagingVO = null;
		try {
			// 전체 개수 구하기
			HashMap<String, String>totalMap = new HashMap<>();
			totalMap.put("keyword", commVO.getKeyword());
			totalMap.put("type", commVO.getType());
			totalMap.put("userid", userid);
			int totalCount = rentDAO.borrowedCount(totalMap);
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount, commVO.getType(), commVO.getKeyword());
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userid", userid);
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			map.put("type", pagingVO.getType());
			map.put("keyword", pagingVO.getKeyword());
			List<RentVO> list = rentDAO.selectBorrowedList(map);
			// 완성된 리스트를 페이징 객체에 넣는다.
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pagingVO;
	}
	@Override
	public RentVO selectOverdueCheck(String isbn, String userid) {
		HashMap<String, String>map = new HashMap<>();
		map.put("isbn", isbn);
		map.put("userid", userid);
		RentVO rentVO = rentDAO.selectOverdueCheck(map);
		return rentVO;
	}
	

}
