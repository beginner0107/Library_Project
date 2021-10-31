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
public class FreeBoardReplyVO {
	private int fboard_reply_id;
	private int free_board_id;
	private String userid;
	private Date fboard_reply_regdate;
	private String fboard_reply_content;
}
