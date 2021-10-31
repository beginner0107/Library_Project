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
public class BookBoardVO {
	private int book_board_id;
	private String uerid;
	private String book_board_title;
	private String book_board_content;
	private int book_board_view;
	private Date regdate;
}
