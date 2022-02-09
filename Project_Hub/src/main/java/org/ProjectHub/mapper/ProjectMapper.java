package org.ProjectHub.mapper;

import java.util.List;

import org.ProjectHub.domain.BoardDTO;
import org.ProjectHub.domain.ProjectDTO;
import org.ProjectHub.domain.ProjectMemberDTO;
import org.ProjectHub.domain.BookmarkDTO;

public interface ProjectMapper {

	// 프로젝트 생성
	public int p_register(ProjectDTO projectDTO) throws Exception;

	// 프로젝트 회원 등록
	public void memberRegister(ProjectDTO projectDTO) throws Exception;

	// 프로젝트 리스트
	public List<ProjectMemberDTO> projectList(String email) throws Exception;

	// 프로젝트 회원 리스트
	public List<ProjectMemberDTO> projectMemberlist(int pno) throws Exception;

	// 회원 프로젝트 정보
	public ProjectMemberDTO projectMemberInfo(int pno, String email) throws Exception;

	// 프로젝트 정보
	public ProjectDTO projectInfo(int pno) throws Exception;

	// 프로젝트 즐겨찾기O
	public void favoriteO(int pno, String email) throws Exception;

	// 프로젝트 즐겨찾기X
	public void favoriteX(int pno, String email) throws Exception;

	// 프로젝트 즐겨찾기 유무 확인
	public int favoriteCheck(String email) throws Exception;

	// 프로젝트 컬러 변경
	public void projectColorUpdate(int pno, String email, String pmcolor) throws Exception;

	// 프로젝트 나가기
	public void projectExit(int pno, String email) throws Exception;

	// 프로젝트 삭제
	public void deleteProject(int pno) throws Exception;

	// 프로젝트 수정
	public void modifyPname(String prevPname, String pname) throws Exception;

	// 프로젝트 수정
	public void modifyPdescription(String prevPdescription, String pdescription) throws Exception;

	// 프로젝트 초대 - project_member DB에 프로젝트 멤버 저장
	public void project_member_register(String email, int pno) throws Exception;

	// 프로젝트 초대 - project_member DB에 해당 회원, 프로젝트가 있는지 체크
	public int project_member_check(String email, int pno) throws Exception;

	// 프로젝트 회원수
	public int projectMemberCount(int pno) throws Exception;

	// 관리자 체크
	public int adminCheck(String email, int pno);

	// 관리자 지정
	public void adminSet(String email, int pno);

	// 관리자 해제
	public void adminCancel(String email, int pno);

	// 내보내기
	public void exportMember(String email, int pno);

	// 참여자 이름 검색
	public List<ProjectMemberDTO> searchMember(String name, int pno);

}
