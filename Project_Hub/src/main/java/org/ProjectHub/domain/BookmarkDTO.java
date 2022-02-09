package org.ProjectHub.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
@Data
public class BookmarkDTO {
	
	private int pno; // 프로젝트 번호
	private String pname; // 프로젝트 제목
	private int bno; // 게시물 번호
	private String email; // 이메일
	private int bidentifier; // 식별번호
	private String bwriter; // 작성자
	private String title; // 게시글 제목
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date day; // 게시글 날짜
	
}
