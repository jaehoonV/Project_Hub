package org.ProjectHub.domain;

import lombok.Data;

@Data
public class MemberDTO {

	private String email; // 회원 이메일
	private String password; // 회원 비밀번호
	private String name; // 회원 이름
	private int login_authstatus; // 로그인 권한
	private String authkey; // 인증키
	private String tel_num; // 전화번호
	private String phone_num; // 휴대폰번호
	private String company_name; // 회사명
	private String job_position; // 직급
}
