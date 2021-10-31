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
public class BookBoardReplyVO {
	private int bboard_reply_id;
	private int book_board_id;
	private String userid;
	private Date bboard_reply_regdate;
	private String bboard_reply_content;
}
