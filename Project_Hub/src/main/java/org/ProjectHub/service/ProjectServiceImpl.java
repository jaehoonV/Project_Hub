package org.ProjectHub.service;

import java.util.List;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeUtility;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.ProjectHub.domain.BoardDTO;
import org.ProjectHub.domain.ProjectDTO;
import org.ProjectHub.domain.ProjectMemberDTO;
import org.ProjectHub.domain.BookmarkDTO;
import org.ProjectHub.mapper.ProjectMapper;
import org.ProjectHub.util.MailHandler;
import org.ProjectHub.util.TempKey;

@Service
public class ProjectServiceImpl implements ProjectService {

	// 이메일
	@Autowired
	private JavaMailSender mailSender;

	@Inject
	ProjectMapper projectMapper;

	// 프로젝트 생성
	@Override
	public void p_register(ProjectDTO projectDTO) throws Exception {
		System.out.println(">>>>>>>>>>>> ProjectServiceImpl!! <<<<<<<<<<<< " + projectDTO);
		// 프로젝트 생성
		projectMapper.p_register(projectDTO);

		// 프로젝트 회원 등록
		projectMapper.memberRegister(projectDTO);
	}

	// 프로젝트 리스트
	@Override
	public List<ProjectMemberDTO> projectList(String email) throws Exception {

		return projectMapper.projectList(email);
	}

	// 프로젝트 멤버 리스트
	@Override
	public List<ProjectMemberDTO> projectMemberList(int pno) throws Exception {

		return projectMapper.projectMemberlist(pno);
	}

	// 회원 프로젝트 정보
	@Override
	public ProjectMemberDTO projectMemberInfo(int pno, String email) throws Exception {
		System.out.println(">>>>>>>>>>>> ProjectServiceImpl - projectMemberInfo <<<<<<<<<<<< " + pno + email);
		return projectMapper.projectMemberInfo(pno, email);
	}

	// 프로젝트 정보
	@Override
	public ProjectDTO projectInfo(int pno) throws Exception {
		return projectMapper.projectInfo(pno);
	}

	// 프로젝트 즐겨찾기O
	@Override
	public void favoriteO(int pno, String email) throws Exception {
		System.out.println(">>>>>>>>>>>> ProjectServiceImpl - favoriteO <<<<<<<<<<<< " + pno + email);
		projectMapper.favoriteO(pno, email);
	}

	// 프로젝트 즐겨찾기X
	@Override
	public void favoriteX(int pno, String email) throws Exception {
		projectMapper.favoriteX(pno, email);
	}

	// 프로젝트 즐겨찾기 유무 확인
	@Override
	public int favoriteCheck(String email) throws Exception {
		return projectMapper.favoriteCheck(email);
	}

	// 프로젝트 컬러 변경
	@Override
	public void projectColorUpdate(int pno, String email, String pmcolor) throws Exception {
		projectMapper.projectColorUpdate(pno, email, pmcolor);
	}

	// 프로젝트 나가기
	@Override
	public void projectExit(int pno, String email) throws Exception {
		projectMapper.projectExit(pno, email);
	}

	// 프로젝트 삭제
	@Override
	public void deleteProject(int pno) throws Exception {
		projectMapper.deleteProject(pno);
	}

	// 프로젝트 수정
	@Override
	public void modifyProject(int pno, String pname, String pdescription) throws Exception {
		projectMapper.modifyProject(pno, pname, pdescription);
	}


	// 프로젝트 초대
	@Override
	public void inviteProject(List<String> emailarr, int pno, String pname, String name, String intitee_email)
			throws Exception {
		System.out.println(">>>>>>>>>>>> ProjectServiceImpl - inviteProject <<<<<<<<<<<< " + pno);
		// 메일 발송
		MailHandler sendMail = new MailHandler(mailSender);
		for (String email : emailarr) {
			sendMail.setSubject(MimeUtility.encodeText("[Project Hub 프로젝트 초대 메일입니다.]", "UTF-8", "B"));
			sendMail.setText(new StringBuffer().append("<h1><strong>").append("우리가 함께 일하는 법, Project Hub</strong></h1>")
					.append("<h2><strong>").append("프로젝트 초대</strong></h2>")
					.append("<td align=\"left\" valign=\"top\" style=\"margin:0;padding:15px 0 25px 0;"
							+ "vertical-align:top;border-top:1px solid #dee0e2;border-bottom:1px solid #dee0e2;\">\r\n")
					.append(name).append(" 님이 프로젝트에 초대합니다.<br>\r\n")
					.append("<p style=\"margin:0;padding:0;font-size:14px;font-weight:normal;"
							+ "line-height:36px;text-align:left\";><strong>\"")
					.append(pname).append("\"</strong><br>아래 버튼을 눌러 프로젝트에 참여할 수 있습니다.</p>")
					.append("<a href='http://localhost:8080/invitation?pno=").append(pno).append("&email=")
					.append(intitee_email)
					.append("'><button style=\"margin:0;padding:0;color: #ffffff;border-radius: 8px;"
							+ "text-decoration: none;background: #5f5ab9;text-align: center;cursor: pointer;"
							+ "width:300px; height:30px;\">프로젝트 참여하기</button></a>")
					.toString());
			sendMail.setFrom("ProjectHub@gmail.com", "ProjectHub");
			sendMail.setTo(email);
			sendMail.send();
		}
		System.out.println(">>>>>>>>>>>> MemberServiceImpl - MailHandler <<<<<<<<<<<< ");
	}

	// 프로젝트-회원 등록
	@Override
	public void project_member_register(String email, int pno) throws Exception {
		projectMapper.project_member_register(email, pno);
	}

	// 프로젝트-회원 등록체크
	@Override
	public int project_member_check(String email, int pno) throws Exception {
		return projectMapper.project_member_check(email, pno);
	}

	// 프로젝트 회원수
	@Override
	public int projectMemberCount(int pno) throws Exception {
		return projectMapper.projectMemberCount(pno);
	}

	// 관리자 체크
	@Override
	public int adminCheck(String email, int pno) throws Exception {
		return projectMapper.adminCheck(email, pno);
	}

	// 관리자 지정
	@Override
	public void adminSet(String email, int pno) throws Exception {
		projectMapper.adminSet(email, pno);
	}

	// 관리자 해제
	@Override
	public void adminCancel(String email, int pno) throws Exception {
		projectMapper.adminCancel(email, pno);
	}

	// 내보내기
	@Override
	public void exportMember(String email, int pno) throws Exception {
		projectMapper.exportMember(email, pno);
	}

	// 참여자 이름 검색
	@Override
	public List<ProjectMemberDTO> searchMember(String name, int pno) throws Exception {
		return projectMapper.searchMember(name, pno);
	}

}
