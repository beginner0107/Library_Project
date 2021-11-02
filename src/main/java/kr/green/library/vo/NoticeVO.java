package kr.green.library.vo;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private int notice_id;
	private String notice_title;
	private Date notice_regdate;
	private String notice_content;
}
