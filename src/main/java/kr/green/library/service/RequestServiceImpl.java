package kr.green.library.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.library.dao.RequestDAO;
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

}
