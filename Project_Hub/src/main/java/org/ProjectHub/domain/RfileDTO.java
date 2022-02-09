package org.ProjectHub.domain;

import lombok.Data;

@Data
public class RfileDTO {
	
	private int rfile_no; // 파일 번호
	private String org_rfile_name; // 원본 파일명
	private String stored_rfile_name; // 변경된 파일명
	private int rfile_size; // 파일 크기
	private String del_gb; // 삭제구분
	private int reply_no; // 댓글 번호
	
}
