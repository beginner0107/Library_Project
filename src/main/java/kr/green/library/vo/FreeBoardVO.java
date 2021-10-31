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
public class FreeBoardVO {
	private int free_board_id;
	private String userid;
	private String free_board_title;
	private String free_board_content;
	private int free_board_view;
	private Date free_board_regdate;
	private List<FreeBoardUploadVO> fileList;
}
