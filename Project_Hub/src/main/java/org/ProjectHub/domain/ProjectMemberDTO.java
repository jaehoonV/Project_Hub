package org.ProjectHub.domain;

import lombok.Data;

@Data
public class ProjectMemberDTO {
	
	private int pmseq; // 프로젝트 seq
	private int pmadmin_num; // 관리자식별
	private String pmcolor; // 프로젝트색상
	private int pmfavorite; // 즐겨찾기
	private int p_authstatus; // 프로젝트 권한
	private String p_authkey; // 프로젝트 인증키
	private int pno; // 프로젝트 번호
	private String email; // 회원이메일
	private String name; // 회원이름
	private String pname; // 프로젝트 제목
	private int pcount; // 프로젝트 멤버 수
}
