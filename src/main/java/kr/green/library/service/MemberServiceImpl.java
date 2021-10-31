package kr.green.library.service;

import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.green.library.dao.MemberAuthDAO;
import kr.green.library.dao.MemberDAO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.MemberAuthVO;
import kr.green.library.vo.MemberVO;
import kr.green.library.vo.PagingVO;
import kr.green.library.vo.RentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	@Autowired
	MemberAuthDAO memberAuthDAO;

	@Autowired
	MailService mailService;

	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;

	@Override
	public void insert(MemberVO memberVO) {
		log.info("{}의 insert호출 : {}", this.getClass().getName(), memberVO);
		String uuid = UUID.randomUUID().toString();
		log.info("{}의 insert UUID : {}", this.getClass().getName(), uuid);
		memberVO.setUuid(uuid);

		String newPassword = bCryptPasswordEncoder.encode(memberVO.getPassword());
		memberVO.setPassword(newPassword);

		memberDAO.insert(memberVO); // 회원정보 저장
		// 권한을 저장해야 한다.
		MemberVO dbVO = memberDAO.selectByUserid(memberVO.getUserid());
		System.out.println("dbVO : " + dbVO.toString());
		MemberAuthVO memberAuthVO = new MemberAuthVO(0, memberVO.getUserid(), "ROLE_USER");
		memberAuthDAO.insert(memberAuthVO);
		// 인증 요청 이메일도 발송해야 한다.
		mailService.sendMail(memberVO);
	}

	@Override
	public MemberVO emailConfirm(MemberVO memberVO) {
		log.info("{}의 emailConfirm 호출 : {}", this.getClass().getName(), memberVO);
		MemberVO memberVO2 = null;
		// 1. DB에서 해당 회원의 정보를 가져온다.
		memberVO2 = memberDAO.selectByUserid(memberVO.getUserid());
		// 2. 해당 아이디에 UUID값이 같다면 인증처리를 한다.
		log.info("{}의 emailConfirm uuid : {}", this.getClass().getName(), memberVO.getUuid());
		log.info("{}의 emailConfirm uuid : {}", this.getClass().getName(), memberVO2.getUuid());
		if (memberVO2 != null && memberVO2.getUuid().equals(memberVO.getUuid())) {
			HashMap<String, String> map = new HashMap<>();
			map.put("userid", memberVO.getUserid());
			map.put("enabled", "1");
			memberDAO.updateEnabled(map);
			memberVO2 = memberDAO.selectByUserid(memberVO.getUserid());
		}
		log.info("{}의 emailConfirm 리턴 : {}", this.getClass().getName(), memberVO2);
		return memberVO2;
	}

	@Override
	public void updatePassword(MemberVO memberVO) {
		String uuid = "";
		// 비번을 암호화 해서  넣는다.
		for (int i = 0; i < 5; i++) {
	        uuid = UUID.randomUUID().toString().replaceAll("-", ""); // -를 제거해 주었다.
	        uuid = uuid.substring(0, 10); //uuid를 앞에서부터 10자리 잘라줌.
	    }
		String bcry = bCryptPasswordEncoder.encode(uuid);
		log.info("bcry : {}", bcry);
		memberVO.setPassword(bcry);
		HashMap<String, String> map = new HashMap<>();
		map.put("userid", memberVO.getUserid());
		map.put("email", memberVO.getEmail());
		map.put("password", memberVO.getPassword());
		memberDAO.updatePassword(map);
		mailService.sendPwMail(uuid, memberVO);
	}

	@Override
	public MemberVO selectByUserid(String userid) {
		log.info("{}의 selectByUserid 호출 : {}", this.getClass().getName(), userid);
		MemberVO memberVO = memberDAO.selectByUserid(userid);
		log.info("{}의 selectByUserid 리턴 : {}", this.getClass().getName(), memberVO);
		return memberVO;
	}

	@Override
	public int idCheck(String userid) {
		log.info("{}의 idCheck 호출 : {}", this.getClass().getName(), userid);
		int count = memberDAO.selectCountByUserid(userid);
		log.info("{}의 idCheck 리턴 : {}", this.getClass().getName(), count);
		return count;
	}

	@Override
	public MemberVO selectByEmailUserid(String userid, String email) {
		log.info("{}의 selectByEmailUserid 호출 : {}", this.getClass().getName(), userid);
		HashMap<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("email", email);
		MemberVO memberVO = memberDAO.selectByEmailUserid(map);
		log.info("{}의 selectByIdx 리턴 : {}", this.getClass().getName(), memberVO);
		return memberVO;
	}
	
	// 이메일로 아이디 찾기
	@Override
	public MemberVO selectByEmail(String email) {
		MemberVO memberVO = memberDAO.selectByEmail(email);
		return memberVO;
	}

	@Override
	public void update(MemberVO memberVO) {
		log.info("{}의 update호출 : {}", this.getClass().getName(), memberVO);
		MemberVO dbVO = memberDAO.selectByUserid(memberVO.getUserid());
		boolean match = bCryptPasswordEncoder.matches(memberVO.getPassword(), dbVO.getPassword());
		System.out.println("match : " + match);
		if(dbVO!=null && bCryptPasswordEncoder.matches(memberVO.getPassword(), dbVO.getPassword())) {
			HashMap<String, String>map = new HashMap<>();
			map.put("email", memberVO.getEmail());
			map.put("phone", memberVO.getPhone());
			map.put("userid", memberVO.getUserid());
			memberDAO.update(map);
		}
	}

	@Override
	public boolean checkPw(String userid, String password) {
		MemberVO dbVO = memberDAO.selectByUserid(userid);
		if(dbVO!=null && bCryptPasswordEncoder.matches(password, dbVO.getPassword())) {
			return true;
		}
		return false;
	}

	@Override
	public PagingVO<MemberVO> selectList(CommVO commVO) {
		log.info("{}의 selectList 호출 : {}", this.getClass().getName(), commVO);
		PagingVO<MemberVO>pagingVO = null;
		try {
			// 전체 개수 구하기
			HashMap<String, String>totalMap = new HashMap<>();
			totalMap.put("keyword", commVO.getKeyword());
			totalMap.put("type", commVO.getType());
			int totalCount = memberDAO.selectCount(totalMap);
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount, commVO.getType(), commVO.getKeyword());
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			map.put("keyword", commVO.getKeyword());
			map.put("type", commVO.getType());
			List<MemberVO> list = memberDAO.selectList(map);
			// 완성된 리스트를 페이징 객체에 넣는다.
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pagingVO;
	}

	@Override
	public PagingVO<MemberVO> selectBlackList(CommVO commVO) {
		log.info("{}의 selectList 호출 : {}", this.getClass().getName(), commVO);
		PagingVO<MemberVO>pagingVO = null;
		try {
			// 전체 개수 구하기
			HashMap<String, String>totalMap = new HashMap<>();
			totalMap.put("keyword", commVO.getKeyword());
			totalMap.put("type", commVO.getType());
			int totalCount = memberDAO.selectBlackCount(totalMap);
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount, commVO.getType(), commVO.getKeyword());
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			map.put("keyword", commVO.getKeyword());
			map.put("type", commVO.getType());
			List<MemberVO> list = memberDAO.selectBlackList(map);
			// 완성된 리스트를 페이징 객체에 넣는다.
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pagingVO;
	}

	@Override
	public void changeRank(String userid, String rank) {
		log.info("{}의 changeRank 호출 : {}", this.getClass().getName(), rank);
		MemberVO memberVO = memberDAO.selectByUserid(userid);
		if(memberVO!=null) {
			HashMap<String, String>map = new HashMap<>();
			map.put("userid", userid);
			map.put("rank", rank);
			memberDAO.changeRank(map);
		}
	}

	@Override
	public void updateRentAvailable(String userid) {
		HashMap<String, String> map = new HashMap<>();
		map.put("userid", userid);
		memberDAO.updateRentAvailable(map);
	}

	@Override
	public void updateIncreaseRent(String userid) {
		HashMap<String, String>map = new HashMap<>();
		map.put("userid", userid);
		memberDAO.updateIncreaseRent(map);
	}

	@Override
	public void updateRankDown(String userid) {
		memberDAO.updateRankDown(userid);
	}

	@Override
	public void updateRankUp(String userid) {
		memberDAO.updateRankUp(userid);
	}
	

}
