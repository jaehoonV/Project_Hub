package org.ProjectHub.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.ProjectHub.domain.BoardDTO;
import org.ProjectHub.domain.BoardLikeDTO;
import org.ProjectHub.domain.BookmarkDTO;
import org.ProjectHub.domain.ReplyDTO;
import org.ProjectHub.domain.ScheduleDTO;
import org.ProjectHub.domain.TaskDTO;
import org.ProjectHub.domain.TextDTO;
import org.ProjectHub.mapper.BoardMapper;
import org.ProjectHub.paging.Pagination;
import org.ProjectHub.util.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class BoardServiceImpl implements BoardService {

	@Resource(name = "fileUtils")
	FileUtils fileUtils;

	@Inject
	BoardMapper boardMapper;

	// 게시물 작성, 글 작성
	@Override
	public void writeText(BoardDTO boardDTO, TextDTO textDTO, MultipartHttpServletRequest mpRequest) throws Exception {
		// 게시물 작성
		boardMapper.writeBoard(boardDTO);
		// mybatis에서 selectKey로 가져온 bno값 textDTO에 set
		textDTO.setBno(boardDTO.getBno());
		// 글 작성
		boardMapper.writeText(textDTO);
		// 파일 업로드
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(boardDTO, mpRequest);
		int size = list.size();
		for (int i = 0; i < size; i++) {
			boardMapper.insertBfile(list.get(i));
		}
	}

	// 게시물 작성, 업무 작성
	@Override
	public void writeTask(BoardDTO boardDTO, TaskDTO taskDTO, MultipartHttpServletRequest mpRequest) throws Exception {
		// 게시물 작성
		boardMapper.writeBoard(boardDTO);
		// mybatis에서 selectKey로 가져온 bno값 taskDTO에 set
		taskDTO.setBno(boardDTO.getBno());
		// 업무 작성
		boardMapper.writeTask(taskDTO);
		// 파일 업로드
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(boardDTO, mpRequest);
		int size = list.size();
		for (int i = 0; i < size; i++) {
			boardMapper.insertBfile(list.get(i));
		}
	}

	// 게시물 작성, 일정 작성
	@Override
	public void writeSchedule(BoardDTO boardDTO, ScheduleDTO scheduleDTO) throws Exception {
		// 게시물 작성
		boardMapper.writeBoard(boardDTO);
		// mybatis에서 selectKey로 가져온 bno값 scheduleDTO에 set
		scheduleDTO.setBno(boardDTO.getBno());
		// 일정 작성
		boardMapper.writeSchedule(scheduleDTO);
	}

	// 댓글 작성
	@Override
	public void writeReply(ReplyDTO replyDTO, MultipartHttpServletRequest mpRequest) throws Exception {
		// 댓글 작성
		boardMapper.writeReply(replyDTO);
		// 파일 업로드
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(replyDTO, mpRequest);
		int size = list.size();
		for (int i = 0; i < size; i++) {
			boardMapper.insertRfile(list.get(i));
		}
	}

	// 게시물 리스트
	@Override
	public List<BoardDTO> boardList(Pagination pagination) throws Exception {
		// 게시물 리스트
		return boardMapper.boardList(pagination);
	}

	// 게시물 개수
	@Override
	public int boardListCnt(int pno) throws Exception {
		return boardMapper.boardListCnt(pno);
	}

	// 게시물 삭제
	@Override
	public void deleteBoard(BoardDTO boardDTO) throws Exception {
		// 글 삭제
		boardMapper.deleteText(boardDTO);
		// 업무 삭제
		boardMapper.deleteTask(boardDTO);
		// 일정 삭제
		boardMapper.deleteSchedule(boardDTO);
		// 게시물 삭제
		boardMapper.deleteBoard(boardDTO);
	}

	// 게시물 수정
	@Override
	public void modifyText(TextDTO textDTO) throws Exception {
		boardMapper.modifyTextTitle(textDTO);
		boardMapper.modifyTextContent(textDTO);
	}

	// 업무 수정
	@Override
	public void modifyTask(TaskDTO taskDTO) throws Exception {
		boardMapper.modifyTaskTitle(taskDTO);
		boardMapper.modifyTaskContent(taskDTO);
	}

	// 일정 수정
	@Override
	public void modifySchedule(ScheduleDTO scheduleDTO) throws Exception {
		boardMapper.modifyScheduleTitle(scheduleDTO);
		boardMapper.modifyScheduleContent(scheduleDTO);
	}

	// 게시글 파일 다운
	@Override
	public Map<String, Object> bfileDown(int bfile_no) throws Exception {
		return boardMapper.bfileDown(bfile_no);
	}

	// 댓글 파일 다운
	@Override
	public Map<String, Object> rfileDown(int rfile_no) throws Exception {
		return boardMapper.rfileDown(rfile_no);
	}

	// 파일 수정/삭제
	@Override
	public void updateBfile(BoardDTO boardDTO, String[] files, String[] fileNames,
			MultipartHttpServletRequest mpRequest) throws Exception {
		// boardMapper.updateBoard(boardDTO);
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(boardDTO, files, fileNames, mpRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for (int i = 0; i < size; i++) {
			tempMap = list.get(i);
			if (tempMap.get("is_new").equals("Y")) {
				boardMapper.insertBfile(tempMap);
			} else {
				boardMapper.updateBfile(tempMap);
			}
		}
	}

	// 좋아요 체크
	@Override
	public int likeCheck(BoardLikeDTO boardLikeDTO) throws Exception {

		return boardMapper.likeCheck(boardLikeDTO);
	}

	// 좋아요 더하기
	@Override
	public void likePlus(BoardLikeDTO boardLikeDTO) throws Exception {

		boardMapper.likePlus(boardLikeDTO);
	}

	// 좋아요 빼기
	@Override
	public void likeMinus(BoardLikeDTO boardLikeDTO) throws Exception {

		boardMapper.likeMinus(boardLikeDTO);
	}

	// 좋아요 만들기
	@Override
	public void likeMake(BoardLikeDTO boardLikeDTO) throws Exception {

		boardMapper.likeMake(boardLikeDTO);
	}

	// 좋아요 개수
	@Override
	public int likeCount(BoardLikeDTO boardLikeDTO) throws Exception {

		return boardMapper.likeCount(boardLikeDTO);
	}

	// 좋아요 이메일 체크
	@Override
	public int likeEmailCheck(BoardLikeDTO boardLikeDTO) throws Exception {
		return boardMapper.likeEmailCheck(boardLikeDTO);
	}

	// 북마크 검색
	@Override
	public int searchBookmark(String email, int pno, int bno) throws Exception {
		return boardMapper.searchBookmark(email, pno, bno);
	}

	// 북마크 리스트
	@Override
	public List<BookmarkDTO> searchBookmark_task(String email, String bname) throws Exception {
		return boardMapper.searchBookmark_task(email, bname);
	}

	@Override
	public List<BookmarkDTO> searchBookmark_text(String email, String bname) throws Exception {
		return boardMapper.searchBookmark_text(email, bname);
	}

	@Override
	public List<BookmarkDTO> searchBookmark_schedule(String email, String bname) throws Exception {
		return boardMapper.searchBookmark_schedule(email, bname);
	}

	// 북마크 취소
	@Override
	public void cancelBookmark(String email, int pno, int bno) throws Exception {
		boardMapper.cancelBookmark(email, pno, bno);
	}

	// 북마크
	@Override
	public void doBookmark(String email, int pno, int bno) throws Exception {
		boardMapper.doBookmark(email, pno, bno);
	}

	// 게시물 고정
	@Override
	public void boardFix(int bno) throws Exception {
		boardMapper.boardFix(bno);
	}

	// 게시물 고정 취소
	@Override
	public void boardFixCancel(int bno) throws Exception {
		boardMapper.boardFixCancel(bno);
	}

	// 게시물 고정 카운트
	@Override
	public int boardFixCount(int pno) throws Exception {
		return boardMapper.boardFixCount(pno);
	}

	// 고정 게시물 리스트
	@Override
	public List<BoardDTO> boardListFixed(int pno) throws Exception {
		return boardMapper.boardListFixed(pno);
	}

	// 글 수정 - 글 검색
	@Override
	public TextDTO modifyText_bno(int bno) throws Exception {
		return boardMapper.modifyText_bno(bno);
	}

	// 업무 수정 - 업무 검색
	@Override
	public TaskDTO modifyTask_bno(int bno) throws Exception {
		return boardMapper.modifyTask_bno(bno);
	}

	// 일정 수정 - 일정 검색
	@Override
	public ScheduleDTO modifySchedule_bno(int bno) throws Exception {
		return boardMapper.modifySchedule_bno(bno);
	}

	// 게시물 고정 검색
	@Override
	public int boardFix_search(int bno) throws Exception {
		return boardMapper.boardFix_search(bno);
	}

	// 댓글 수정
	@Override
	public void modifyReply(ReplyDTO replyDTO) throws Exception {
		boardMapper.modifyReply(replyDTO);
	}

	// 업무 게시물 수
	@Override
	public List<Integer> taskReport_number(int pno) throws Exception {
		List<Integer> taskReport_number_list = new ArrayList<>();
		int all = boardMapper.taskReport_number_all(pno);
		int request = boardMapper.taskReport_number_request(pno);
		int progress = boardMapper.taskReport_number_progress(pno);
		int complete = boardMapper.taskReport_number_complete(pno);
		int hold = boardMapper.taskReport_number_hold(pno);

		taskReport_number_list.add(all);
		taskReport_number_list.add(request);
		taskReport_number_list.add(progress);
		taskReport_number_list.add(complete);
		taskReport_number_list.add(hold);

		return taskReport_number_list;
	}

	@Override
	public void deleteReply(ReplyDTO replyDTO) throws Exception {
		boardMapper.deleteReply(replyDTO);
	}
}
