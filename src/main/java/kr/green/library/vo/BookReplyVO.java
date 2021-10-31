package kr.green.library.vo;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@XmlRootElement
@AllArgsConstructor
@NoArgsConstructor
@Data
public class BookReplyVO {
	private int breply_id;
	private String isbn;
	private String userid;
	private Date regdate;
	private String content;
	private String modified_date;
}
