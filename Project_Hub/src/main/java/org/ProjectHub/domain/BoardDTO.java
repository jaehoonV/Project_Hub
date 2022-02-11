package org.ProjectHub.domain;

import java.util.List;

import lombok.Data;

@Data
public class BoardDTO {

	private int bno; // 게시물번호
	private int bidentifier; // 식별번호
	private int pno; // 프로젝트번호
	private String bwriter; // 작성자
	private String bwriter_email; // 작성자이메일
	private int bfix; // 고정
	private int blike; // 게시물 좋아요
	private List<TextDTO> textList; // 글 리스트
	private List<TaskDTO> taskList; // 업무 리스트
	private List<ScheduleDTO> scheduleList; // 일정 리스트
	private List<BfileDTO> bfileList; // 파일 리스트
	private List<ReplyDTO> replyList; // 댓글 리스트
}
