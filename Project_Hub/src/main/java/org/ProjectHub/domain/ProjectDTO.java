package org.ProjectHub.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ProjectDTO {

	private int pno; // 프로젝트번호
	private String pname; // 프로젝트제목
	private String pdescription; // 프로젝트설명
	private Date pday; // 프로젝트생성일
	private String email; // 프로젝트 생성자
}
