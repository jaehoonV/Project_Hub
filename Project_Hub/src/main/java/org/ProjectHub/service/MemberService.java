package org.ProjectHub.service;

import org.ProjectHub.domain.MemberDTO;

public interface MemberService {

	// 회원가입
	public void register(MemberDTO memberDTO) throws Exception;

	// login_authstatus 1로 변경
	public void updateAuthstatus(String email) throws Exception;

	// 이메일 중복 체크
	public int emailCheck(String email) throws Exception;

	// 로그인
	public int login(String email, String password) throws Exception;

	// 로그인 시 이메일 인증 체크
	public int loginAuthCheck(String email) throws Exception;

	// 회원 정보
	public MemberDTO MemberInfo(String email) throws Exception;

	// 비밀번호 찾기 이메일 전송
	public void findPwService(MemberDTO memberDTO) throws Exception;

	// 비밀번호 찾기
	public int findPassword(MemberDTO memberDTO) throws Exception;

	// 비밀번호 변경
	public void resetPassword(MemberDTO memberDTO) throws Exception;

	// 회원 정보 수정
	public void modify(String email, String valueId, String valueById) throws Exception;
}