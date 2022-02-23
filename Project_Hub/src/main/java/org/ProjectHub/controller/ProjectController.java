package org.ProjectHub.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.ProjectHub.domain.BoardDTO;
import org.ProjectHub.domain.MemberDTO;
import org.ProjectHub.domain.ProjectDTO;
import org.ProjectHub.domain.ProjectMemberDTO;
import org.ProjectHub.domain.BookmarkDTO;
import org.ProjectHub.paging.Pagination;
import org.ProjectHub.service.BoardService;
import org.ProjectHub.service.MemberService;
import org.ProjectHub.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class ProjectController {

	@Autowired
	ProjectService projectService;

	@Autowired
	MemberService memberService;

	@Autowired
	BoardService boardService;

	// project 생성
	@RequestMapping(value = "/makeProject", method = RequestMethod.POST)
	public String makeProject(ProjectDTO projectDTO, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {
		System.out.println("pname >>>>> " + projectDTO.getPname());
		System.out.println("pdescription >>>>> " + projectDTO.getPdescription());

		// 세션 생성
		HttpSession session = request.getSession();

		// memberInfo 세션 가져와서 memberDTO에 저장
		String email = (String) session.getAttribute("email");

		// memberDTO에서 이메일 가져오기
		projectDTO.setEmail(email);

		// 프로젝트 생성, 프로젝트 회원 등록
		projectService.p_register(projectDTO);

		rttr.addFlashAttribute("makeProjectResult", "success");

		return "redirect:/mainPage";
	}

	// 프로젝트 리스트
	@RequestMapping(value = "/mainPage", method = RequestMethod.GET)
	public String projectMain(Model model, HttpServletRequest request, MemberDTO memberDTO) throws Exception {
		System.out.println(">>>>>>>> projectMain <<<<<<<<<");
		// 세션 생성
		HttpSession session = request.getSession();

		// email 세션 가져옴
		String email = (String) session.getAttribute("email");

		// 이메일이 들어가 있는 프로젝트의 리스트 projectList에 저장
		model.addAttribute("projectList", projectService.projectList(email));

		// 회원 로그인 정보 가져옴
		memberDTO = memberService.MemberInfo(email);
		// 모델에 회원 정보 set
		model.addAttribute("memberInfo", memberDTO);

		return "mainPage";
	}

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainPage() {
		System.out.println(" >>>>>>> mainPage <<<<<<<<<");

		return "redirect:/mainPage";
	}

	// 프로젝트 홈
	@RequestMapping(value = "/projectHomePage", method = RequestMethod.POST)
	public String projectHomePagePOST(Model model, ProjectMemberDTO projectMemberDTO, ProjectDTO projectDTO,
			HttpServletRequest request, @RequestParam("pno") int pno) throws Exception {
		System.out.println(" >>>>>>> projectHomePagePOST <<<<<<<<<");
		// 세션 생성
		HttpSession session = request.getSession();

		// pno 세션에 저장
		session.setAttribute("pno", pno);

		return "redirect:/projectHomePage";
	}

	// post-redirect-get 패턴
	// projectHomePage
	@RequestMapping(value = "/projectHomePage", method = RequestMethod.GET)
	public String projectHomePage(HttpServletRequest request, Model model, ProjectMemberDTO projectMemberDTO,
			ProjectDTO projectDTO, MemberDTO memberDTO,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "cntPerPage", required = false, defaultValue = "10") int cntPerPage,
			@RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize
//				@RequestParam(required = false, defaultValue = "1") int page,
//				@RequestParam(required = false, defaultValue = "1") int range
	) throws Exception {
		System.out.println(" >>>>>>> projectHomePage <<<<<<<<<");
		// 세션 생성
		HttpSession session = request.getSession();

		// email 세션에서 가져옴
		String email = (String) session.getAttribute("email");
		// pno 세션에서 가져옴
		int pno = (int) session.getAttribute("pno");

		// 회원 로그인 정보 가져옴
		memberDTO = memberService.MemberInfo(email);
		// 모델에 회원 정보 set
		model.addAttribute("memberInfo", memberDTO);

		// 회원 프로젝트 정보 가져옴
		projectMemberDTO = projectService.projectMemberInfo(pno, email);
		// 모델에 회원 프로젝트 정보 set
		model.addAttribute("projectMemberInfo", projectMemberDTO);

		// 프로젝트 정보 가져옴
		projectDTO = projectService.projectInfo(pno);
		// 모델에 프로젝트 정보 set
		model.addAttribute("projectInfo", projectDTO);

		// 모델에 프로젝트 회원 정보 set
		model.addAttribute("projectMemberList", projectService.projectMemberList(pno));

		// 모델에 프로젝트 회원수 정보 set
		model.addAttribute("projectMemberCount", projectService.projectMemberCount(pno));
		
		// 모델에 게시물 고정 카운트 set
		model.addAttribute("boardFixCount", boardService.boardFixCount(pno));
		
		// 모델에 고정 게시물  정보 set
		model.addAttribute("boardListFixed", boardService.boardListFixed(pno));
		
		// 모델에 업무 게시물 수 set
		model.addAttribute("taskReport_number", boardService.taskReport_number(pno));
		
		// 게시물 개수
		int boardListCnt = boardService.boardListCnt(pno);

		// Pagination 객체생성
		Pagination pagination = new Pagination(currentPage, cntPerPage, pageSize);
		pagination.setPno(pno);
		pagination.setTotalRecordCount(boardListCnt);

		// 페이지네이션 모델에 저장
		model.addAttribute("pagination", pagination);
		// 게시물 리스트 모델에 저장
		model.addAttribute("boardList", boardService.boardList(pagination));

		return "projectHomePage";
	}

	// 프로젝트 즐겨찾기 유무 확인
	@ResponseBody
	@RequestMapping(value = "/pListFavorite", method = RequestMethod.GET)
	public int clickFavoritePOST(Model model, HttpServletRequest request, ProjectMemberDTO projectMemberDTO)
			throws Exception {
		System.out.println(" >>>>>>> pListFavorite <<<<<<<<<");
		int result;
		// 세션 생성
		HttpSession session = request.getSession();

		// email 세션에서 가져옴
		String email = (String) session.getAttribute("email");
		System.out.println(" >>>>>>> favoriteCheck-email <<<<<<<<<" + email);
		result = projectService.favoriteCheck(email);
		System.out.println(" >>>>>>> favoriteCheck result <<<<<<<<<" + result);

		return result;
	}

	// 프로젝트 즐겨찾기
	@ResponseBody
	@RequestMapping(value = "/clickFavorite", method = RequestMethod.POST)
	public int clickFavoritePOST(Model model, HttpServletRequest request, ProjectMemberDTO projectMemberDTO,
			@RequestParam("pno") int pno) throws Exception {
		System.out.println(" >>>>>>> clickFavorite <<<<<<<<<");
		int result;
		int pf;
		// 세션 생성
		HttpSession session = request.getSession();

		// email 세션에서 가져옴
		String email = (String) session.getAttribute("email");
		System.out.println(" >>>>>>> clickFavorite-email, pno <<<<<<<<<" + email + pno);
		result = projectService.projectMemberInfo(pno, email).getPmfavorite();
		System.out.println(" >>>>>>> clickFavorite result <<<<<<<<<" + result);

		if (result == 0) {
			System.out.println(" >>>>>>> result == 0 <<<<<<<<<");
			projectService.favoriteO(pno, email); // 프로젝트 즐겨찾기O
			pf = projectService.projectMemberInfo(pno, email).getPmfavorite();
			System.out.println(" >>>>>>> favoriteO <<<<<<<<<" + pf);
		} else {
			System.out.println(" >>>>>>> result != 0 <<<<<<<<<");
			projectService.favoriteX(pno, email); // 프로젝트 즐겨찾기X
			pf = projectService.projectMemberInfo(pno, email).getPmfavorite();
			System.out.println(" >>>>>>> favoriteX <<<<<<<<<" + pf);
		}

		return pf;
	}

	// project 컬러 변경
	@RequestMapping(value = "/pmcolorUpdate", method = RequestMethod.POST)
	public String pmcolorUpdate(ProjectMemberDTO projectMemberDTO, HttpServletRequest request,
			@RequestParam("selectedpmcolor") String pmcolor) throws Exception {
		System.out.println(" >>>>>>> pmcolorUpdate <<<<<<<<<");
		// 세션 생성
		HttpSession session = request.getSession();

		// email 세션에서 가져옴
		String email = (String) session.getAttribute("email");
		// pno 세션에서 가져옴
		int pno = (int) session.getAttribute("pno");
		System.out.println(" >>>>>>> pmcolorUpdate-email, pno, pmcolor <<<<<<<<<" + email + pno + pmcolor);

		// 프로젝트 컬러 변경
		projectService.projectColorUpdate(pno, email, pmcolor);

		return "redirect:/projectHomePage";
	}

	// 프로젝트 나가기
	@RequestMapping(value = "/projectExit", method = RequestMethod.GET)
	public String projectExit(HttpServletRequest request) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>projectExit<<<<<<<<<<<");
		// 세션 생성
		HttpSession session = request.getSession();
		// email 세션에서 가져옴
		String email = (String) session.getAttribute("email");
		// pno 세션에서 가져옴
		int pno = (int) session.getAttribute("pno");

		System.out.println("email >>>>>>>>>>>>>>>>>>>>>>" + email);
		System.out.println("pno >>>>>>>>>>>>>>>>>>>>>>" + pno);

		projectService.projectExit(pno, email);

		return "redirect:/mainPage";
	}

	// 프로젝트 삭제
	@RequestMapping(value = "/deleteProject", method = RequestMethod.GET)
	public String deleteProject(HttpServletRequest request) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>deleteProject<<<<<<<<<<<");
		// 세션 생성
		HttpSession session = request.getSession();
		// pno 세션에서 가져옴
		int pno = (int) session.getAttribute("pno");

		System.out.println("pno >>>>>>>>>>>>>>>>>>>>>>" + pno);

		projectService.deleteProject(pno);

		return "redirect:/mainPage";
	}

	// 프로젝트 수정
	@RequestMapping(value = "/modifyProject", method = RequestMethod.POST)
	public String modifyProject(@RequestParam("prevPname") String prevPname, @RequestParam("pname") String pname,
			@RequestParam("prevPdescription") String prevPdescription,
			@RequestParam("pdescription") String pdescription) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>modifyProject<<<<<<<<<<<");

		// 프로젝트 제목 수정
		projectService.modifyPname(prevPname, pname);

		// 프로젝트 설명 수정
		projectService.modifyPdescription(prevPdescription, pdescription);

		return "redirect:/projectHomePage";
	}

	// 프로젝트 초대
	@ResponseBody
	@RequestMapping(value = "/inviteProject", method = RequestMethod.POST)
	public String inviteProject(@RequestParam("emailarr[]") List<String> emailarr, @RequestParam("pno") int pno,
			@RequestParam("pname") String pname, @RequestParam("name") String name, HttpServletRequest request)
			throws Exception {
		System.out.print("emailarr >>>>> ");
		for (String email : emailarr) {
			System.out.print(email + ", ");
		}
		System.out.println("");
		System.out.println("pname >>>>> " + pname);
		System.out.println("pno >>>>> " + pno);
		System.out.println("name >>>>> " + name);

		// 세션 생성
		HttpSession session = request.getSession();
		// email 세션에서 가져옴
		String invitee_email = (String) session.getAttribute("email");

		// 이메일 발송 = inviteProject(emailarr,pno,pname,name);
		projectService.inviteProject(emailarr, pno, pname, name, invitee_email);

		return "1";
	}

	// 프로젝트 초대 경로(get)
	@RequestMapping(value = "/invitation", method = RequestMethod.GET)
	public String invitation(@RequestParam("email") String email, @RequestParam("pno") int pno, Model model,
			ProjectMemberDTO projectMemberDTO) throws Exception {
		System.out.println("email >>>>> " + email);
		System.out.println("pno >>>>> " + pno);

		// 모델에 회원 프로젝트 정보 set
		model.addAttribute("projectMemberInfo", projectService.projectMemberInfo(pno, email));

		// 이메일이 들어가 있는 프로젝트의 리스트 projectList에 저장
		model.addAttribute("projectList", projectService.projectList(email));

		return "invitation";
	}

	// 프로젝트 초대 경로(post)
	@RequestMapping(value = "/invitation", method = RequestMethod.POST)
	public void start_project(HttpServletRequest request, @RequestParam("email") String email,
			@RequestParam("password") String password, @RequestParam("pno") int pno, HttpServletResponse response)
			throws Exception {
		System.out.println("email >>>>> " + email);
		System.out.println("password >>>>> " + password);
		System.out.println("pno >>>>> " + pno);
		// 세션 생성
		HttpSession session = request.getSession();

		// 입력한 이메일과 비밀번호가 있을 시 1 반환
		int result = memberService.login(email, password);

		// 이메일 비밀번호 있을시
		if (result == 1) {
			// 인증된 이메일 주소일시 1이 반환됨
			int result2 = memberService.loginAuthCheck(email);
			// 결과 출력
			System.out.println("loginAuthCheck >>>>>>>>>>>>>>>>" + result2);

			// 인증된 이메일 주소일시
			if (result2 == 1) {
				response.getWriter().print(true);
				int pmCheck = projectService.project_member_check(email, pno);
				System.out.println("pmCheck >>>>> " + pmCheck);
				if (pmCheck < 1) {
					// DB에 프로젝트 멤버 저장
					projectService.project_member_register(email, pno);
				}
				// email 세션에 저장
				session.setAttribute("email", email);
			} else {
				response.getWriter().print("noauth");
			}
		} else {
			response.getWriter().print(false);
		}
	}

	// 관리자 지정,해제
	@ResponseBody
	@RequestMapping(value = "/adminSettings", method = RequestMethod.POST)
	public int adminSettings(Model model, @RequestParam("email") String email, HttpServletRequest request)
			throws Exception {
		System.out.println(" >>>>>>> adminSettings <<<<<<<<< email ==>" + email);
		// 세션 생성
		HttpSession session = request.getSession();
		// pno 세션에서 가져옴
		int pno = (int) session.getAttribute("pno");
		// 해당 이메일 관리자 체크
		int result = projectService.adminCheck(email, pno);
		System.out.println(" >>>>>>> adminSettings <<<<<<<<< result ==>" + result);

		if (result == 0) { // 관리자 지정
			projectService.adminSet(email, pno);
		} else if (result == 1) { // 관리자 해제
			projectService.adminCancel(email, pno);
		}
		return result;
	}

	// 내보내기
	@ResponseBody
	@RequestMapping(value = "/exportMember", method = RequestMethod.POST)
	public void exportMember(Model model, @RequestParam("email") String email, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println(" >>>>>>> exportMember <<<<<<<<< email ==>" + email);
		// 세션 생성
		HttpSession session = request.getSession();
		// pno 세션에서 가져옴
		int pno = (int) session.getAttribute("pno");

		projectService.exportMember(email, pno);
		response.getWriter().print(true);
	}

	// 참여자 이름 검색
	@ResponseBody
	@RequestMapping(value = "/searchMember", method = RequestMethod.POST)
	public List<ProjectMemberDTO> searchMember(Model model, @RequestParam("name") String name,
			HttpServletRequest request) throws Exception {
		System.out.println(" >>>>>>> searchMember <<<<<<<<< name ==>" + name);
		// 세션 생성
		HttpSession session = request.getSession();
		// pno 세션에서 가져옴
		int pno = (int) session.getAttribute("pno");

		return projectService.searchMember(name, pno);
	}

}