package org.ProjectHub.domain;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TaskDTO {
	private int task_no; // 업무번호
	private String task_title; // 업무제목
	private String task_content; // 업무내용
	private String task_status; // 업무상태
	private int task_priority; // 우선순위
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date task_start; // 시작일
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date task_last; // 마감일
	private Date task_day; // 작성일
	private int bno; // 게시물번호
}
