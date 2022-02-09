package org.ProjectHub.mapper;

import org.ProjectHub.domain.MemberDTO;
import org.apache.ibatis.annotations.Param;

public interface MemberMapper {

	// 회원가입
	public void register(MemberDTO memberDTO) throws Exception;

	// member DB에 authkey저장
	public int createAuthkey(String email, String authkey) throws Exception;

	// 이메일 인증 후 login_authstatus 1로 변경
	public void updateAuthstatus(String email) throws Exception;

	// 이메일 중복 체크
	public int emailCheck(String email);

	// 로그인
	public int login(String email, String password) throws Exception;

	// 로그인 시 이메일 인증 체크
	public int loginAuthCheck(String email) throws Exception;

	// 회원 정보
	public MemberDTO MemberInfo(String email) throws Exception;

	// 비밀번호 찾기
	public int findPassword(MemberDTO memberDTO) throws Exception;

	// 비밀번호 변경
	public MemberDTO ResetPassword(MemberDTO memberDTO) throws Exception;

	// 회원 정보 변경
	public void change_name(@Param("email")String email, @Param("name")String name) throws Exception;
	public void change_company_name(@Param("email")String email, @Param("company_name")String company_name) throws Exception;
	public void change_job_position(@Param("email")String email, @Param("job_position")String job_position) throws Exception;
	public void change_phone_num(@Param("email")String email, @Param("phone_num")String phone_num) throws Exception;
	public void change_tel_num(@Param("email")String email, @Param("tel_num")String tel_num) throws Exception;
	public void change_pw(@Param("email")String email, @Param("password")String password) throws Exception;
}