package kr.green.library.vo;

import java.util.Date;
import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@XmlRootElement
@AllArgsConstructor
@NoArgsConstructor
@Data
public class BookVO {
	private String isbn;
	private String title;
	private String author;
	private String publisher;
	private String genre;
	private String content;
	private int count;
	private Date regdate;
	private Date modified_date;
	private List<BookImageVO> imageList;
	private List<BookReplyVO> replyList;
}
