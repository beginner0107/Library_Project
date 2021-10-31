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
public class RequestVO {
	private int request_id;
	private String request_isbn;
	private String request_title;
	private Date request_regdate;
	private String request_link;
}
