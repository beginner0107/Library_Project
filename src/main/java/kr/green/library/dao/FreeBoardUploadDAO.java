package kr.green.library.dao;

import java.util.List;

import kr.green.library.vo.FreeBoardUploadVO;

public interface FreeBoardUploadDAO {
	// <!-- 1. 첨부파일 저장 -->
	void insert(FreeBoardUploadVO vo);
	// <!-- 2. 수정시 첨부파일 저장 : 이때는 원본글의 ref가 별도로 존재한다. -->
	void updateInsert(FreeBoardUploadVO vo);
	// <!-- 3. 첨부파일 삭제 -->
	void deleteByUploadId(int fboard_upload_id);
	// <!-- 4. 원본글의 첨부파일 모두 읽기 -->
	List<FreeBoardUploadVO> selectList(int free_board_id);
	// <!-- 5. 원본글의 첨부파일 모두 삭제하기 -->
	void deleteByFboardId(int free_board_id);
	// <!-- 6. 글 1개 가져오기 -->
	FreeBoardUploadVO selectByFboardId(int fboard_upload_id);
}
