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
public class GoodVO {
	private int good_id;
	private String userid;
	private String isbn;
	private String good_content;
	private Date regdate;
	private String good_title;
}
