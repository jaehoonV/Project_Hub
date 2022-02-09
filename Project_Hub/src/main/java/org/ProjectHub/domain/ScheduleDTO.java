package org.ProjectHub.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ScheduleDTO {
	private int schedule_no; // 일정번호
	private String schedule_title; // 일정제목
	private String schedule_content; // 일정내용
	private String schedule_location; // 일정장소
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date schedule_start; // 시작일
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date schedule_last; // 마감일
	private Date schedule_day; // 작성일
	private int bno; // 게시물번호
}
