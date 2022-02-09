package org.ProjectHub.domain;

import java.util.Date;

import lombok.Data;

@Data
public class TextDTO {
	private int text_no; // 글번호
	private String text_title; // 글제목
	private String text_content; // 글내용
	private Date text_day; // 작성일
	private int bno; // 게시물번호
}
