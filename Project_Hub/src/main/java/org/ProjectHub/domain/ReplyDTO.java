package org.ProjectHub.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReplyDTO {
	
	private int reply_no; // 댓글번호
	private String reply_content; // 댓글내용
	private Date reply_date; // 댓글작성일
	private String reply_writer; // 댓글작성자
	private int bno; // 게시물번호
	private List<RfileDTO> rfileList; // 파일 리스트

}
