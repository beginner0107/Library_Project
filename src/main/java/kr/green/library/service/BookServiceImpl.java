package kr.green.library.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.green.library.dao.BookDAO;
import kr.green.library.dao.BookImageDAO;
import kr.green.library.dao.BookReplyDAO;
import kr.green.library.vo.BookImageVO;
import kr.green.library.vo.BookReplyVO;
import kr.green.library.vo.BookVO;
import kr.green.library.vo.CommVO;
import kr.green.library.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BookServiceImpl implements BookService {

	@Autowired
	private BookDAO bookDAO;
	@Autowired
	private BookImageDAO bookImageDAO;
	@Autowired
	private BookReplyDAO bookReplyDAO;
	@Transactional
	@Override
	public void insert(BookVO bookVO) {
		log.info("insert 호출 : {}", bookVO);
		bookDAO.insert(bookVO);
		for(BookImageVO list : bookVO.getImageList()){
			list.setIsbn(bookVO.getIsbn());
			log.info("bookimageVO 채워졌는지 : {}", list);
			bookImageDAO.insert(list);
		}
	}
	
	@Override
	public void insertBookImage(BookImageVO bookImageVO) {
		bookImageDAO.insert(bookImageVO);
	}
	
	@Override
	public PagingVO<BookVO> selectList(CommVO commVO) {
		log.info("{}의 selectList 호출 : {}", this.getClass().getName(), commVO);
		PagingVO<BookVO>pagingVO = null;
		try {
			// 전체 개수 구하기
			int totalCount = bookDAO.selectCount();
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount);
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			List<BookVO> list = bookDAO.selectList(map);
			if(list!=null) {
				for(BookVO b : list) {
					b.setImageList(bookImageDAO.selectImage(b.getIsbn()));
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
	public BookVO selectByIsbn(String isbn) {
		BookVO vo = bookDAO.selectByIsbn(isbn);
		log.info("BookVO : {}", vo );
		List<BookImageVO> vo2 = bookImageDAO.selectImage(isbn);
		if(vo!=null) {
			vo.setImageList(vo2);
		}
		log.info("BookVO : {}", vo );
		return vo;	
	}

	@Override
	public BookVO selectByIsbnTitle(String isbn, String title) {
		HashMap<String, String> map = new HashMap<>();
		map.put("isbn", isbn);
		map.put("title", title);
		return bookDAO.selectByIsbnTitle(map);
	}

	@Override
	public void deleteBookImage(String isbn) {
		bookImageDAO.deleteBookImage(isbn);
	}

	@Override
	public void updateBookInfo(BookVO bookVO) {
		HashMap<String, String>map = new HashMap<>();
		map.put("genre", bookVO.getGenre());
		map.put("title", bookVO.getTitle());
		map.put("author", bookVO.getAuthor());
		map.put("publisher", bookVO.getPublisher());
		map.put("count", bookVO.getCount()+"");
		map.put("content", bookVO.getContent());
		map.put("isbn", bookVO.getIsbn());
		
		bookDAO.updateBookInfo(map);
	}

	// 도서 삭제
	@Override
	public void deleteBook(String isbn) {
		bookDAO.deleteBook(isbn);
	}

	// 도서 댓글 추가
	@Override
	public int insertBookReply(BookReplyVO bookReplyVO) {
		int insert = bookReplyDAO.insertBookReply(bookReplyVO);
		return insert;
	}

	@Override
	public PagingVO<BookReplyVO> selectReplyList(CommVO commVO) {
		log.info("{}의 selectList 호출 : {}", this.getClass().getName(), commVO);
		PagingVO<BookReplyVO>pagingVO = null;
		try {
			// 전체 개수 구하기
			int totalCount = bookReplyDAO.selectCount(commVO.getIsbn());
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount, commVO.getIsbn());
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			map.put("isbn", pagingVO.getIsbn());
			log.info("isbn : {}", pagingVO.getIsbn());
			List<BookReplyVO> list = bookReplyDAO.selectReplyList(map);
			pagingVO.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pagingVO;
	}

	@Override
	public void updateBookCount(String isbn) {
		bookDAO.updateBookCount(isbn);
	}

	@Override
	public void updateReturnCount(String isbn) {
		bookDAO.updateReturnCount(isbn);
	}

	@Override
	public PagingVO<BookVO> selectNewBook(CommVO commVO) {
		log.info("{}의 selectList 호출 : {}", this.getClass().getName(), commVO);
		PagingVO<BookVO>pagingVO = null;
		try {
			// 전체 개수 구하기
			int totalCount = bookDAO.selectNewCount();
			// 페이지 계산
			pagingVO = new PagingVO<>(commVO.getCurrentPage(), commVO.getPageSize(), commVO.getBlockSize(), totalCount);
			// 글을 읽어오기
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("startNo", pagingVO.getStartNo()+"");
			map.put("endNo", pagingVO.getEndNo()+"");
			List<BookVO> list = bookDAO.selectList(map);
			if(list!=null) {
				for(BookVO b : list) {
					b.setImageList(bookImageDAO.selectImage(b.getIsbn()));
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
	public void updateReply(BookReplyVO bookReplyVO) {
		bookReplyDAO.updateReply(bookReplyVO);
	}

	@Override
	public void deleteReply(int breply_id) {
		bookReplyDAO.deleteReply(breply_id);
	}

	@Override
	public BookReplyVO selectByBreplyId(int breply_id) {
		return bookReplyDAO.selectByBreplyId(breply_id);
	}

	@Override
	public List<BookReplyVO> getBookReplyList(String isbn) {
		log.info(isbn);
		return bookReplyDAO.getBookReplyList(isbn);
	}

	

	

}
