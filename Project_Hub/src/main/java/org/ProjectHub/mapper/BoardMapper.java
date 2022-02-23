package org.ProjectHub.mapper;

import java.util.List;
import java.util.Map;

import org.ProjectHub.domain.BoardDTO;
import org.ProjectHub.domain.BoardLikeDTO;
import org.ProjectHub.domain.BookmarkDTO;
import org.ProjectHub.domain.ReplyDTO;
import org.ProjectHub.domain.ScheduleDTO;
import org.ProjectHub.domain.TaskDTO;
import org.ProjectHub.domain.TextDTO;
import org.ProjectHub.paging.Pagination;

public interface BoardMapper {

	// 게시물 작성
	public void writeBoard(BoardDTO boardDTO) throws Exception;

	// 글 작성
	public void writeText(TextDTO textDTO) throws Exception;

	// 업무 작성
	public void writeTask(TaskDTO taskDTO) throws Exception;

	// 일정 작성
	public void writeSchedule(ScheduleDTO scheduleDTO) throws Exception;

	// 댓글 작성
	public void writeReply(ReplyDTO replyDTO) throws Exception;

	// 게시물 리스트
	public List<BoardDTO> boardList(Pagination pagination) throws Exception;

	// 게시물 개수
	public int boardListCnt(int pno) throws Exception;

	// 게시물 고정
	public void boardFix(int bno) throws Exception;

	// 글 삭제
	public void deleteText(BoardDTO boardDTO) throws Exception;

	// 업무 삭제
	public void deleteTask(BoardDTO boardDTO) throws Exception;

	// 일정 삭제
	public void deleteSchedule(BoardDTO boardDTO) throws Exception;

	// 게시물 삭제
	public void deleteBoard(BoardDTO boardDTO) throws Exception;

	// 글 제목 수정
	public void modifyTextTitle(TextDTO textDTO) throws Exception;

	// 글 내용 수정
	public void modifyTextContent(TextDTO textDTO) throws Exception;

	// 업무 제목 수정
	public void modifyTaskTitle(TaskDTO taskDTO) throws Exception;

	// 업무 내용 수정
	public void modifyTaskContent(TaskDTO taskDTO) throws Exception;

	// 일정 제목 수정
	public void modifyScheduleTitle(ScheduleDTO scheduleDTO) throws Exception;

	// 일정 내용 수정
	public void modifyScheduleContent(ScheduleDTO scheduleDTO) throws Exception;

	// 게시글 파일 업로드
	public void insertBfile(Map<String, Object> map) throws Exception;

	// 댓글 파일 업로드
	public void insertRfile(Map<String, Object> map) throws Exception;

	// 게시글 파일 다운
	public Map<String, Object> bfileDown(int bfile_no) throws Exception;

	// 댓글 파일 다운
	public Map<String, Object> rfileDown(int rfile_no) throws Exception;

	// 파일 수정/삭제
	public void updateBfile(Map<String, Object> map) throws Exception;

	// 좋아요 체크
	public int likeCheck(BoardLikeDTO boardLikeDTO) throws Exception;

	// 좋아요 더하기
	public void likePlus(BoardLikeDTO boardLikeDTO) throws Exception;

	// 좋아요 빼기
	public void likeMinus(BoardLikeDTO boardLikeDTO) throws Exception;

	// 좋아요 만들기
	public void likeMake(BoardLikeDTO boardLikeDTO) throws Exception;

	// 좋아요 개수
	public int likeCount(BoardLikeDTO boardLikeDTO) throws Exception;

	// 좋아요 이메일 체크
	public int likeEmailCheck(BoardLikeDTO boardLikeDTO) throws Exception;

	// 북마크 검색
	public int searchBookmark(String email, int pno, int bno) throws Exception;

	// 북마크 리스트
	public List<BookmarkDTO> searchBookmark_task(String email, String bname) throws Exception;
	public List<BookmarkDTO> searchBookmark_text(String email, String bname) throws Exception;
	public List<BookmarkDTO> searchBookmark_schedule(String email, String bname) throws Exception;

	// 북마크 취소
	public void cancelBookmark(String email, int pno, int bno) throws Exception;

	// 북마크
	public void doBookmark(String email, int pno, int bno) throws Exception;

	// 게시물 고정 취소
	public void boardFixCancel(int bno) throws Exception;

	// 게시물 고정 카운트
	public int boardFixCount(int pno) throws Exception;

	// 고정 게시물 리스트
	public List<BoardDTO> boardListFixed(int pno) throws Exception;

	// 글 수정 - 글 검색
	public TextDTO modifyText_bno(int bno) throws Exception;

	// 업무 수정 - 업무 검색
	public TaskDTO modifyTask_bno(int bno) throws Exception;

	// 일정 수정 - 일정 검색
	public ScheduleDTO modifySchedule_bno(int bno) throws Exception;

	// 게시물 고정 검색
	public int boardFix_search(int bno) throws Exception;
	
	// 댓글 수정
	public void modifyReply(ReplyDTO replyDTO) throws Exception;
	
	// 업무 게시물 수
	public int taskReport_number(int pno) throws Exception;
}
