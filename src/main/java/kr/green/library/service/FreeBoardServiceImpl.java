package kr.green.library.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.library.dao.FreeBoardDAO;
import kr.green.library.dao.FreeBoardUploadDAO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.FreeBoardUploadVO;
import kr.green.library.vo.FreeBoardVO;
import kr.green.library.vo.PagingVO;
@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	
	@Autowired
	private FreeBoardDAO freeBoardDAO;
	@Autowired
	private FreeBoardUploadDAO freeBoardUploadDAO;
	@Override
	public PagingVO<FreeBoardVO> selectList(CommVO commVO) {
		PagingVO<FreeBoardVO> pagingVO = null;
		try {
			// 전체 개수 구하기
			int totalCount = freeBoardDAO.selectCount();
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount);
			// 글을 읽어오기
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("startNo", pagingVO.getStartNo());
			map.put("endNo", pagingVO.getEndNo());
			List<FreeBoardVO> list = freeBoardDAO.selectList(map);
			// 해당글들의 첨부파일 정보를 넣어준다.
			if (list != null && list.size() > 0) {
				for (FreeBoardVO vo : list) {
					List<FreeBoardUploadVO> fileList = freeBoardUploadDAO.selectList(vo.getFree_board_id());
					vo.setFileList(fileList);
				}
			}
			// 완성된 리스트를 페이징 객체에 넣는다.
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pagingVO;
	}
	

	@Override
	public FreeBoardVO selectByBoardId(int free_board_id) {
		FreeBoardVO freeBoardVO = freeBoardDAO.selectByBoardId(free_board_id);
		if(freeBoardVO != null) {
			List<FreeBoardUploadVO>list = freeBoardUploadDAO.selectList(free_board_id);
			freeBoardVO.setFileList(list);
		}
		return freeBoardVO;
	}

	@Override
	public void insert(FreeBoardVO freeBoardVO) {
		if(freeBoardVO != null) {
			freeBoardDAO.insert(freeBoardVO);
			int free_board_id = freeBoardDAO.selectSeq();
			List<FreeBoardUploadVO>list = freeBoardVO.getFileList();
			if(list!=null && list.size()>0) {
				for(FreeBoardUploadVO vo : list) {
					vo.setFree_board_id(free_board_id);
					freeBoardUploadDAO.insert(vo);
				}
			}
		}
	}

	@Override
	public void update(FreeBoardVO freeBoardVO, String[] delFiles, String realPath) {
		if(freeBoardVO != null) {
			freeBoardDAO.update(freeBoardVO);
			List<FreeBoardUploadVO> list = freeBoardVO.getFileList();
			if(list!=null && list.size()>0) {
				for(FreeBoardUploadVO vo : list) {
					vo.setFree_board_id(freeBoardVO.getFree_board_id());
					freeBoardUploadDAO.insert(vo);
				}
			}
			if(delFiles!=null && delFiles.length>0) {
				for(String t : delFiles) {
					int fboard_upload_id = Integer.parseInt(t);
					if(fboard_upload_id>0) {
						FreeBoardUploadVO freeBoardUploadVO = freeBoardUploadDAO.selectByFboardId(fboard_upload_id);
						if(freeBoardUploadVO != null) {
							File file = new File(realPath+ File.separator + freeBoardUploadVO.getSavename());
							file.delete();
							freeBoardUploadDAO.deleteByUploadId(fboard_upload_id);
						}
					}
				}
			}
		}
	}

	@Override
	public void delete(FreeBoardVO freeBoardVO, String uploadPath) {
		// 삭제
		freeBoardDAO.delete(freeBoardVO.getFree_board_id());
		// 첨부파일의 목록을 읽어온다
		List<FreeBoardUploadVO> list = freeBoardUploadDAO.selectList(freeBoardVO.getFree_board_id());
		if (list != null && list.size() > 0) {
			for (FreeBoardUploadVO vo : list) {
				// db 파일 삭제
				freeBoardUploadDAO.deleteByFboardId(vo.getFree_board_id());
				// 실제 파일삭제
				File file = new File(uploadPath + File.separator + vo.getSavename());
				file.delete(); // 실제 파일 삭제
			}
		}
		
	}


	@Override
	public PagingVO<FreeBoardVO> selectAdminList(CommVO commVO) {
		PagingVO<FreeBoardVO> pagingVO = null;
		try {
			// 전체 개수 구하기
			int totalCount = freeBoardDAO.selectAdminCount();
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount);
			// 글을 읽어오기
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("startNo", pagingVO.getStartNo());
			map.put("endNo", pagingVO.getEndNo());
			List<FreeBoardVO> list = freeBoardDAO.selectAdminList(map);
			// 해당글들의 첨부파일 정보를 넣어준다.
			if (list != null && list.size() > 0) {
				for (FreeBoardVO vo : list) {
					List<FreeBoardUploadVO> fileList = freeBoardUploadDAO.selectList(vo.getFree_board_id());
					vo.setFileList(fileList);
				}
			}
			// 완성된 리스트를 페이징 객체에 넣는다.
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pagingVO;
	}


	@Override
	public void updateInappropriatePost(FreeBoardVO freeBoardVO) {
		freeBoardDAO.updateInappropriatePost(freeBoardVO);
	}

}
