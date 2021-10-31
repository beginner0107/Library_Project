package kr.green.library.vo;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*

 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@XmlRootElement
public class MemberVO {
	private String userid;
	private String username;
	private String password;
	private String email;
	private String phone;
	private String uuid;
	private int enabled;
	private Date regdate;
	private int rank;
	private int nomal_return;
	private int rent_available;
}
