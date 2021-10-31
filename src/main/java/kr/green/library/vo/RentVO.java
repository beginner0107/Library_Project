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
public class RentVO {
	private int rent_id;
	private String isbn;
	private String userid;
	private String title;
	private Date rent_date;
	private Date return_due_date;
	private int extension_count;
	private Date return_date;
}
