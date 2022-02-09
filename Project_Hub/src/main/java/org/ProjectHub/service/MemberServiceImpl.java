package org.ProjectHub.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import javax.mail.internet.MimeUtility;

import org.ProjectHub.domain.MemberDTO;
import org.ProjectHub.mapper.MemberMapper;
import org.ProjectHub.util.MailHandler;
import org.ProjectHub.util.TempKey;

@Service
public class MemberServiceImpl implements MemberService {

	// 이메일 인증
	@Autowired
	private JavaMailSender mailSender;

	@Inject
	MemberMapper memberMapper;

	// 회원가입
	@Override
	public void register(MemberDTO memberDTO) throws Exception {
		System.out.println(">>>>>>>>>>>> MemberServiceImpl!! <<<<<<<<<<<< " + memberDTO);
		// DB에 회원가입 정보 저장
		memberMapper.register(memberDTO);

		// 인증키 생성
		String key = new TempKey().getKey(10, false);

		System.out.println(">>>>>>>>>>>> MemberServiceImpl - memberMapper <<<<<<<<<<<< ");
		// 인증키 DB에 저장
		memberMapper.createAuthkey(memberDTO.getEmail(), key);

		// 메일 발송
		MailHandler sendMail = new MailHandler(mailSender);

		sendMail.setSubject(MimeUtility.encodeText("[Project Hub 회원가입 서비스 이메일 인증 입니다.]", "UTF-8", "B"));
		sendMail.setText(new StringBuffer().append("<h1>Project Hub 가입 메일인증 입니다</h1>")
				.append("<td align=\"left\" valign=\"top\" style=\"margin:0;padding:15px 0 25px 0;"
						+ "vertical-align:top;border-top:1px solid #dee0e2;border-bottom:1px solid #dee0e2;\">\r\n"
						+ "본 메일은 ‘Project Hub’ 시작 시, 본인 확인을 <br>위해 자동으로 발송되는 메일입니다.<br>\r\n")
				.append("<p style=\"margin:0;padding:0;font-size:14px;font-weight:normal;"
						+ "line-height:36px;text-align:left\";>아래 인증확인을 클릭하세요.</p>")
				.append("<a href='http://localhost:8080/emailConfirm?email=").append(memberDTO.getEmail())
				.append("&key=").append(key).append("'><button>인증 확인</button></a>").toString());
		sendMail.setFrom("ProjectHub@gmail.com", "ProjectHub");
		sendMail.setTo(memberDTO.getEmail());
		sendMail.send();
		System.out.println(">>>>>>>>>>>> MemberServiceImpl - MailHandler <<<<<<<<<<<< ");
	}

	// authstatus 1로 변경
	@Override
	public void updateAuthstatus(String email) throws Exception {
		System.out.println(">>>>>>>>>>>> MemberServiceImpl - updateAuthstatus <<<<<<<<<<<< ");
		memberMapper.updateAuthstatus(email);
	}

	// 이메일 중복 체크
	@Override
	public int emailCheck(String email) throws Exception {
		return memberMapper.emailCheck(email);
	}

	// 로그인
	@Override
	public int login(String email, String password) throws Exception {
		System.out.println(">>>>>>>>>>>> MemberServiceImpl - login <<<<<<<<<<<< ");
		return memberMapper.login(email, password);

	}

	// 로그인 시 이메일 인증 체크
	@Override
	public int loginAuthCheck(String email) throws Exception {
		System.out.println(">>>>>>>>>>>> MemberServiceImpl - loginAuthCheck <<<<<<<<<<<< ");
		return memberMapper.loginAuthCheck(email);
	}

	// 회원 정보
	@Override
	public MemberDTO MemberInfo(String email) throws Exception {
		return memberMapper.MemberInfo(email);
	}

	// 비밀번호 찾기
	@Override
	public int findPassword(MemberDTO memberDTO) throws Exception {
		System.out.println(">>>>>>>>>>>> MemberServiceImpl - findPassword <<<<<<<<<<<< ");
		System.out.println(">>>>>> name : " + memberDTO.getName() + " <<<<<<");
		System.out.println(">>>>>> email : " + memberDTO.getEmail() + " <<<<<<");

		return memberMapper.findPassword(memberDTO);
	}

	// 비밀번호 찾기 메일 서비스
	@Override
	public void findPwService(MemberDTO memberDTO) throws Exception {
		System.out.println(">>>>>>>>>>>> MemberServiceImpl - findPwService <<<<<<<<<<<< ");
		System.out.println(">>>>>>>>>>>> findPW Email : " + memberDTO.getEmail() + "<<<<<<<<<<<< ");

		String key = new TempKey().getKey(10, false);

		memberMapper.createAuthkey(memberDTO.getEmail(), key);

		// 메일 발송
		MailHandler sendMail = new MailHandler(mailSender);

		sendMail.setSubject(MimeUtility.encodeText("[Project Hub 비밀번호 찾기 서비스 이메일 인증 입니다.]", "UTF-8", "B"));
		sendMail.setText(new StringBuffer().append("<h1>Project Hub 비밀번호 찾기 메일입니다.</h1>")
				.append("<td align=\"left\" valign=\"top\" style=\"margin:0;padding:15px 0 25px 0;"
						+ "vertical-align:top;border-top:1px solid #dee0e2;border-bottom:1px solid #dee0e2;\">\r\n"
						+ "본 메일은 ‘Project Hub’ 계정 비밀번호를 잊어버린 경우, <br>사용자임을 인증하고 비밀번호를 재설정하기 위해 <br>자동으로 발송되는 메일입니다.<br>\r\n")
				.append("<p style=\"margin:0;padding:0;font-size:14pxfont-weight:normal;"
						+ "line-height:36px;text-align:left\";>아래 인증 확인을 클릭하시면 비밀번호 재설정이 가능합니다.</p>")
				.append("<a href='http://localhost:8080/passwordConfirm?email=").append(memberDTO.getEmail())
				.append("&key=").append(key).append("'><button>인증 확인</button></a>").toString());
		sendMail.setFrom("ProjectHub@gmail.com", "ProjectHub");
		sendMail.setTo(memberDTO.getEmail());
		sendMail.send();
		System.out.println(">>>>>>>>>>>> MemberServiceImpl - MailHandler <<<<<<<<<<<< ");
		System.out.println(">>>>>>>>>> findPwService 종료  <<<<<<<<<<");
	}

	@Override
	public void resetPassword(MemberDTO memberDTO) throws Exception {
		System.out.println(">>>>>>>>>>>> MemberServiceImpl - resetPassword <<<<<<<<<<<< ");
		memberMapper.ResetPassword(memberDTO);
	}
	
	@Override
	public void modify(String email, String valueId, String valueById) throws Exception {
		System.out.println(">>>>>>>>>>>> MemberServiceImpl - modify <<<<<<<<<<<< ");
		switch (valueId) {
		case "change_name":
			String name = valueById;
			memberMapper.change_name(email, name);
			break;
		case "change_company_name":
			String company_name = valueById;
			memberMapper.change_company_name(email, company_name);
			break;
		case "change_job_position":
			String job_position = valueById;
			memberMapper.change_job_position(email, job_position);
			break;
		case "change_phone_num":
			String phone_num = valueById;
			memberMapper.change_phone_num(email, phone_num);
			break;
		case "change_tel_num":
			String tel_num = valueById;
			memberMapper.change_tel_num(email, tel_num);
			break;
		case "change_pw":
			String password = valueById;
			memberMapper.change_pw(email, password);
			break;
		}
	}

}