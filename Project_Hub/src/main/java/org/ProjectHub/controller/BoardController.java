package org.ProjectHub.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.ProjectHub.domain.BoardDTO;
import org.ProjectHub.domain.BoardLikeDTO;
import org.ProjectHub.domain.BookmarkDTO;
import org.ProjectHub.domain.MemberDTO;
import org.ProjectHub.domain.ProjectMemberDTO;
import org.ProjectHub.domain.ScheduleDTO;
import org.ProjectHub.domain.TaskDTO;
import org.ProjectHub.domain.TextDTO;
import org.ProjectHub.domain.ReplyDTO;
import org.ProjectHub.service.BoardService;
import org.ProjectHub.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	MemberService memberService;

	// 글 작성
	@RequestMapping(value = "/writeText", method = RequestMethod.POST)
	public String writeText(BoardDTO boardDTO, TextDTO textDTO, MultipartHttpServletRequest mpRequest)
			throws Exception {
		// System.out.println(">>>>>>>>>>>>>>>writeText<<<<<<<<<<<<");
		System.out.println(boardDTO);
		System.out.println(textDTO);

		// System.out.println(mpRequest);

		// 게시물 작성, 글 작성
		boardService.writeText(boardDTO, textDTO, mpRequest);

		return "redirect:/projectHomePage";
	}

	// 업무 작성
	@RequestMapping(value = "/writeTask", method = RequestMethod.POST)
	public String writeTask(BoardDTO boardDTO, TaskDTO taskDTO, MultipartHttpServletRequest mpRequest)
			throws Exception {
		// System.out.println(">>>>>>>>>>>>>>>writeTask<<<<<<<<<<<<");
		System.out.println(boardDTO);
		System.out.println(taskDTO);

		// 게시물 작성, 업무 작성
		boardService.writeTask(boardDTO, taskDTO, mpRequest);

		return "redirect:/projectHomePage";
	}

	// 일정 작성
	@RequestMapping(value = "/writeSchedule", method = RequestMethod.POST)
	public String writeSchedule(BoardDTO boardDTO, ScheduleDTO scheduleDTO) throws Exception {
		// System.out.println(">>>>>>>>>>>>>>>writeSchedule<<<<<<<<<<<<");
		System.out.println(boardDTO);
		System.out.println(scheduleDTO);

		// 게시물 작성, 일정 작성
		boardService.writeSchedule(boardDTO, scheduleDTO);

		return "redirect:/projectHomePage";
	}

	// 댓글 작성
	@RequestMapping(value = "/writeReply", method = RequestMethod.POST)
	public String writeReply(ReplyDTO replyDTO, MultipartHttpServletRequest mpRequest) throws Exception {
		// System.out.println(">>>>>>>>>>>>>>>writeReply<<<<<<<<<<<<");
		System.out.println(replyDTO);

		// 댓글 작성
		boardService.writeReply(replyDTO, mpRequest);

		return "redirect:/projectHomePage";
	}

	// 게시물 고정/boardFix
	@RequestMapping(value = "/boardFix", method = RequestMethod.POST)
	public void boardFix(@RequestParam("bno") int bno, HttpServletResponse response) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>boardFix<<<<<<<<<<<");
		int result = boardService.boardFix_search(bno); // 게시물 고정 확인
		if (result >= 1) {
			boardService.boardFixCancel(bno); // 게시물 고정 취소
			// response.getWriter().print("cancel");
		} else {
			boardService.boardFix(bno); // 게시물 고정
			// response.getWriter().print("fix");
		}
		response.getWriter().print(true);
	}

	// 게시물 삭제
	@RequestMapping(value = "/deleteBoard", method = RequestMethod.POST)
	public String deleteBoard(BoardDTO boardDTO) throws Exception {
		// System.out.println(">>>>>>>>>>>>>>>deleteBoard<<<<<<<<<<<");

		// 게시물 삭제
		boardService.deleteBoard(boardDTO);

		return "redirect:/projectHomePage";
	}

	// 글 수정
	@RequestMapping(value = "/modifyText", method = RequestMethod.POST)
	public String modifyText(TextDTO textDTO) throws Exception {
		System.out.println(">>>>>>>>>modifyText<<<<<<<<<<");
		System.out.println(textDTO);

		// 글 수정
		boardService.modifyText(textDTO);

		return "redirect:/projectHomePage";
	}

	// 업무 수정
	@RequestMapping(value = "/modifyTask", method = RequestMethod.POST)
	public String modifyTask(TaskDTO taskDTO) throws Exception {
		System.out.println(">>>>>>>>>modifyTask<<<<<<<<<<");
		System.out.println(taskDTO);

		// 글 수정
		boardService.modifyTask(taskDTO);

		return "redirect:/projectHomePage";
	}

	// 일정 수정
	@RequestMapping(value = "/modifySchedule", method = RequestMethod.POST)
	public String modifySchedule(ScheduleDTO scheduleDTO) throws Exception {
		System.out.println(">>>>>>>>>modifySchedule<<<<<<<<<<");
		System.out.println(scheduleDTO);

		// 일정 수정
		boardService.modifySchedule(scheduleDTO);

		return "redirect:/projectHomePage";
	}

	// 게시물 파일 다운
	@RequestMapping(value = "/bfileDown")
	public void bfileDown(@RequestParam("bfile_no") int bfile_no, HttpServletResponse response) throws Exception {
		Map<String, Object> resultMap = boardService.bfileDown(bfile_no);
		String storedFileName = (String) resultMap.get("STORED_BFILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_BFILE_NAME");

		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils
				.readFileToByteArray(new File("C:\\projectHub\\file\\" + storedFileName));

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	// 댓글 파일 다운
	@RequestMapping(value = "/rfileDown")
	public void rfileDown(@RequestParam("rfile_no") int rfile_no, HttpServletResponse response) throws Exception {
		Map<String, Object> resultMap = boardService.rfileDown(rfile_no);
		String storedFileName = (String) resultMap.get("STORED_RFILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_RFILE_NAME");

		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils
				.readFileToByteArray(new File("C:\\projectHub\\file\\" + storedFileName));

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	// 게시물 좋아요
	@RequestMapping(value = "/boardLike")
	public void boardLike(BoardLikeDTO boardLikeDTO, HttpServletResponse response, HttpServletRequest request, int bno)
			throws Exception {
		System.out.println(">>>>>>>>>>>>>>>>>>>>boardLike<<<<<<<<<<<<<<<<");
		// 세션 생성
		HttpSession session = request.getSession();

		String email = (String) session.getAttribute("email");
		boardLikeDTO.setEmail(email);
		boardLikeDTO.setBno(bno);

		// 좋아요 이메일 체크
		int lec = boardService.likeEmailCheck(boardLikeDTO);
		if (lec == 1) { // 좋아요 체크 확인
			int lc = boardService.likeCheck(boardLikeDTO);
			if (lc == 0) { // 좋아요 체크 0일 시 체크 1로
				boardService.likePlus(boardLikeDTO);
			} else if (lc == 1) { // 좋아요 체크 1일 시 체크 0으로
				boardService.likeMinus(boardLikeDTO);
			}
		} else { // 아예 없을 시 좋아요 테이블 만들기
			boardService.likeMake(boardLikeDTO);
		}
		// 좋아요 개수
		int lct = boardService.likeCount(boardLikeDTO);

		response.getWriter().print(lct);
	}

	// 좋아요 체크
	@ResponseBody
	@RequestMapping(value = "/boardLikeCheck", method = RequestMethod.POST)
	public void boardLikeCheck(Model model, BoardLikeDTO boardLikeDTO, HttpServletRequest request,
			@RequestParam("bno") int bno, HttpServletResponse response) throws Exception {
		System.out.println(" >>>>>>> boardLikeCheck - bno : " + bno);
		// 세션 생성
		HttpSession session = request.getSession();
		// email 세션에서 가져옴
		String email = (String) session.getAttribute("email");
		boardLikeDTO.setEmail(email);
		boardLikeDTO.setBno(bno);
		int result = boardService.likeCheck(boardLikeDTO);
		if (result == 1) {
			response.getWriter().print(true);
		} else {
			response.getWriter().print(false);
		}
	}

	// 북마크
	@ResponseBody
	@RequestMapping(value = "/clickBookmarkBtn", method = RequestMethod.POST)
	public void clickBookmarkBtn(Model model, HttpServletRequest request, @RequestParam("bno") int bno,
			HttpServletResponse response) throws Exception {
		System.out.println(" >>>>>>> clickBookmarkBtn - bno : " + bno);
		// 세션 생성
		HttpSession session = request.getSession();
		// email 세션에서 가져옴
		String email = (String) session.getAttribute("email");
		// pno 세션에서 가져옴
		int pno = (int) session.getAttribute("pno");
		System.out.println(" >>>>>>> clickBookmarkBtn-email, pno <<<<<<<<<" + email + ", " + pno);
		int result = boardService.searchBookmark(email, pno, bno);
		if (result >= 1) {
			boardService.cancelBookmark(email, pno, bno);
			response.getWriter().print(false);
		} else {
			boardService.doBookmark(email, pno, bno);
			response.getWriter().print(true);
		}
	}

	// 북마크 체크
	@ResponseBody
	@RequestMapping(value = "/bookmarkCheck", method = RequestMethod.POST)
	public void bookmarkCheck(Model model, HttpServletRequest request, @RequestParam("bno") int bno,
			HttpServletResponse response) throws Exception {
		System.out.println(" >>>>>>> bookmarkCheck <<<<<<<<<");
		System.out.println(" >>>>>>> bookmarkCheck - bno : " + bno);

		// 세션 생성
		HttpSession session = request.getSession();

		// email 세션에서 가져옴
		String email = (String) session.getAttribute("email");
		// pno 세션에서 가져옴
		int pno = (int) session.getAttribute("pno");
		System.out.println(" >>>>>>> bookmarkCheck-email, pno <<<<<<<<<" + email + ", " + pno);

		int result = boardService.searchBookmark(email, pno, bno);

		if (result >= 1) {
			response.getWriter().print(false);
		} else {
			response.getWriter().print(true);
		}
	}

	// 북마크
	@RequestMapping(value = "/bookmark", method = RequestMethod.GET)
	public String bookmark(Model model, HttpServletRequest request, MemberDTO memberDTO) throws Exception {
		System.out.println(">>>>>>>> bookmark <<<<<<<<<");
		// 세션 생성
		HttpSession session = request.getSession();

		// email 세션 가져옴
		String email = (String) session.getAttribute("email");

		// 회원 로그인 정보 가져옴
		memberDTO = memberService.MemberInfo(email);
		// 모델에 회원 정보 set
		model.addAttribute("memberInfo", memberDTO);

		return "bookmark";
	}

	// 북마크 리스트 - 업무
	@ResponseBody
	@RequestMapping(value = "/searchBookmark_task", method = RequestMethod.POST)
	public List<BookmarkDTO> searchBookmark_task(Model model, HttpServletRequest request,
			@RequestParam("bname") String bname) throws Exception {
		System.out.println(" >>>>>>> searchBookmark_task <<<<<<<<< " + bname);
		// 세션 생성
		HttpSession session = request.getSession();

		// email 세션 가져옴
		String email = (String) session.getAttribute("email");
		return boardService.searchBookmark_task(email, bname);
	}

	// 북마크 리스트 - 글
	@ResponseBody
	@RequestMapping(value = "/searchBookmark_text", method = RequestMethod.POST)
	public List<BookmarkDTO> searchBookmark_text(Model model, HttpServletRequest request,
			@RequestParam("bname") String bname) throws Exception {
		System.out.println(" >>>>>>> searchBookmark_text <<<<<<<<< " + bname);
		// 세션 생성
		HttpSession session = request.getSession();

		// email 세션 가져옴
		String email = (String) session.getAttribute("email");
		return boardService.searchBookmark_text(email, bname);
	}

	// 북마크 리스트 - 일정
	@ResponseBody
	@RequestMapping(value = "/searchBookmark_schedule", method = RequestMethod.POST)
	public List<BookmarkDTO> searchBookmark_schedule(Model model, HttpServletRequest request,
			@RequestParam("bname") String bname) throws Exception {
		System.out.println(" >>>>>>> searchBookmark_schedule <<<<<<<<< " + bname);
		// 세션 생성
		HttpSession session = request.getSession();

		// email 세션 가져옴
		String email = (String) session.getAttribute("email");
		return boardService.searchBookmark_schedule(email, bname);
	}

	// 글 수정 - 글 검색
	@ResponseBody
	@RequestMapping(value = "/modifyText_bno", method = RequestMethod.POST)
	public TextDTO modifyText_bno(@RequestParam("bno") int bno) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>modifyText_bno<<<<<<<<<<<");
		// 글 검색
		return boardService.modifyText_bno(bno);
	}

	// 업무 수정 - 업무 검색
	@ResponseBody
	@RequestMapping(value = "/modifyTask_bno", method = RequestMethod.POST)
	public TaskDTO modifyTask_bno(@RequestParam("bno") int bno) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>modifyTask_bno<<<<<<<<<<<");
		// 글 검색
		return boardService.modifyTask_bno(bno);
	}

	// 일정 수정 - 일정 검색
	@ResponseBody
	@RequestMapping(value = "/modifySchedule_bno", method = RequestMethod.POST)
	public ScheduleDTO modifySchedule_bno(@RequestParam("bno") int bno) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>modifySchedule_bno<<<<<<<<<<<");
		// 글 검색
		return boardService.modifySchedule_bno(bno);
	}

	// 댓글 수정
	@RequestMapping(value = "/modifyReply", method = RequestMethod.POST)
	public String modifyReply(ReplyDTO replyDTO, MultipartHttpServletRequest mpRequest) throws Exception {
		System.out.println(">>>>>>>>>modifyReply<<<<<<<<<<");
		System.out.println(replyDTO);

		boardService.modifyReply(replyDTO);

		return "redirect:/projectHomePage";
	}

	// 댓글 삭제
	@RequestMapping(value = "/deleteReply", method = RequestMethod.POST)
	public void deleteReply(ReplyDTO replyDTO, HttpServletResponse response) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>deleteReply<<<<<<<<<<<");
		boardService.deleteReply(replyDTO);
		
		response.getWriter().print(true);
	}
}
