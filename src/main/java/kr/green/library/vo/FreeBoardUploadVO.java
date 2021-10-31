package kr.green.library.vo;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@XmlRootElement
@AllArgsConstructor
@NoArgsConstructor
@Data
public class FreeBoardUploadVO {
	private int fboard_upload_id;
	private int free_board_id;
	private String oriname;
	private String savename;
}
