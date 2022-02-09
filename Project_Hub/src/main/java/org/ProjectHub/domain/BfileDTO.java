package org.ProjectHub.domain;

import lombok.Data;

@Data
public class BfileDTO {
	
	private int bfile_no; // 파일 번호
	private String org_bfile_name; // 원본 파일명
	private String stored_bfile_name; // 변경된 파일명
	private int bfile_size; // 파일 크기
	private String del_gb; // 삭제구분
	private int bno; // 게시물 번호
	
}
