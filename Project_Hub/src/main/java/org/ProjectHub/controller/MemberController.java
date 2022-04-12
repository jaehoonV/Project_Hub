package org.ProjectHub.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.ProjectHub.domain.MemberDTO;
import org.ProjectHub.service.MemberService;
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
public class MemberController {

	@Autowired
	MemberService memberService;

	// 회원가입 GET 방식
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinPage() {
		return "joinPage";
	}

	// 회원가입 POST
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	// @PostMapping("/join")
	public String postRegister(MemberDTO memberDTO) throws Exception {
		System.out.println("email >>>>> " + memberDTO.getEmail());
		System.out.println("name >>>>> " + memberDTO.getName());
		System.out.println("password >>>>> " + memberDTO.getPassword());
		// DB에 회원가입 member 정보 저장 + authkey생성 + 이메일 발송 = memberService.register(member);
		memberService.register(memberDTO);

		return "index";
	}

	// 이메일 인증 확인하면 나오는 경로
	@RequestMapping(value = "/emailConfirm", method = RequestMethod.GET)
	public String emailConfirm(String email, Model model) throws Exception {
		// login_authstatus 권한 상태 1로 변경
		memberService.updateAuthstatus(email);

		// jsp에서 쓰기위해 model에 담음
		model.addAttribute("email", email);

		return "emailConfirm";
	}

	// 이메일 중복 체크
	@RequestMapping(value = "/userEmailChk", method = RequestMethod.POST)
	@ResponseBody
	public boolean userEmailChk(String email) throws Exception {

		System.out.println("userEmailChk() 진입 / email =" + email);

		// emailCheck 중복 이메일 존재하면 1 반환
		int result = memberService.emailCheck(email);

		System.out.println("emailCheck 결과값 = " + result);

		if (result != 0) {
			return false; // 중복 이메일이 존재
		} else {
			return true; // 중복 이메일 x
		}
	} // userEmailChk() 종료

	// 로그인 GET 방식 (로그인 창)
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String LoginPage() {
		return "loginPage";
	}

	// 로그인 post방식
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String Login() throws Exception {
		System.out.println("MemberController >>>>> login(post)");

		return "redirect:/mainPage";
	}

	// loginCheck - 이메일 비밀번호 체크
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public void loginCheck(HttpServletRequest request, @RequestParam("email") String email,
			@RequestParam("password") String password, HttpServletResponse response) throws Exception {
		System.out.println(" >>>>>>> loginChk <<<<<<<<<");
		System.out.println("email >>>>>>>>>>>>>>>>" + email);
		System.out.println("password >>>>>>>>>>>>>>>>" + password);
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
				// email 세션에 저장
				session.setAttribute("email", email);
			} else {
				response.getWriter().print("noauth");
			}
		} else {
			response.getWriter().print(false);
		}
	}

	// 로그아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest req, HttpServletResponse res) throws Exception {
		System.out.println(">>>>>>>>>> logout <<<<<<<<<<");

		// HttpSession이 존재하면 현재 HttpSession을 반환하고 존재하지 않으면 새로이 생성하지 않고 그냥 null을 반환
		HttpSession session = req.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		return "redirect:/";
	}

	// 비밀번호 찾기 GET 방식
	@RequestMapping(value = "/findPw", method = RequestMethod.GET)
	public String findPasswordPage() {
		return "findPasswordPage";
	}

	// 비밀번호 찾기 POST 방식
	@RequestMapping(value = "/findPw", method = RequestMethod.POST)
	public void findPassword(MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println(">>>>>>>>>> findPassword 메소드 진입 <<<<<<<<<<");
		System.out.println("user name >>>>> " + memberDTO.getName());
		System.out.println("user email >>>>> " + memberDTO.getEmail());

		// 세션 생성
		HttpSession session = request.getSession();

		// 일치하는 회원 정보가 있을시 1이 반환됨
		int result = memberService.findPassword(memberDTO);
		System.out.println("findPassword result >>>>>>>>>> " + result);

		if (result == 1) { // 일치하는 회원 정보가 있는 경우
			System.out.println("response.getWriter().print(true);");
			response.getWriter().print(true);
			memberService.findPwService(memberDTO);
		} else { // 일치하는 회원 정보가 없는 경우
			System.out.println("response.getWriter().print(false);");
			response.getWriter().print(false);
		}

		System.out.println(">>>>>>>>>> findPassword 종료  <<<<<<<<<<");
	}

	// 이메일 인증 거친 뒤 비밀번호 찾기 GET 방식
	@RequestMapping(value = "/passwordConfirm", method = RequestMethod.GET)
	public String PasswordResetPage(String email, Model model) {

		// jsp에서 쓰기위해 model에 담음
		model.addAttribute("email", email);

		return "passwordReset";
	}

	// 이메일 인증 거친 뒤 비밀번호 찾기 POST 방식
	@RequestMapping(value = "/resetPw", method = RequestMethod.POST)
	public String ResetPassword(MemberDTO memberDTO) throws Exception {
		System.out.println(">>>>>>>>>> ResetPassword 메소드 진입 <<<<<<<<<<");
		System.out.println("user email >>>>> " + memberDTO.getEmail());
		System.out.println("user password >>>>> " + memberDTO.getPassword());

		memberService.resetPassword(memberDTO);

		System.out.println(">>>>>>>>>> findPassword 종료, loginPage 반환 실행  <<<<<<<<<<");
		return "loginPage";
	}

	// 회원정보수정
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String Modify(MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("valueId") String valueId, @RequestParam("valueById") String valueById) throws Exception {
		System.out.println(">>>>>>>>>> Modify 메소드 진입 <<<<<<<<<<" + valueId + valueById);
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		memberService.modify(email, valueId, valueById);
		String modifyClass = "";
		switch (valueId) {
		case "change_name":
			modifyClass = "name";
			break;
		case "change_company_name":
			modifyClass = "company_name";
			break;
		case "change_job_position":
			modifyClass = "job_position";
			break;
		case "change_phone_num":
			modifyClass = "phone_num";
			break;
		case "change_tel_num":
			modifyClass = "tel_num";
			break;
		case "change_pw":
			modifyClass = "password";
			break;
		}
		session.setAttribute(modifyClass, valueById);
		return "redirect:/";

	}
}