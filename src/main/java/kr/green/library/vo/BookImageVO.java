package kr.green.library.vo;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@XmlRootElement
@AllArgsConstructor
@NoArgsConstructor
@Data
public class BookImageVO {
	private String uuid;
	private String isbn;
	private String filename;
	private String uploadpath;
}
