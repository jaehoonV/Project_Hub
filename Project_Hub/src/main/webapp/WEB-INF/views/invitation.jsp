<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl c태그 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 초대</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/resources/assets/favicon.ico">
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/favicon.ico">
<!-- css -->
<link href="/resources/css/invitation.css" rel="stylesheet" />
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- jQuery.validate 플러그인 삽입 -->
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<!-- js -->
<script src="<c:url value="/resources/js/invitation.js"/>"></script>
</head>
<body>
	<div class="project_invite_wrap">
		<div class="invite_logo">
			<img src="/resources/assets/ProjectHub_logo.png">
		</div>
		<div class="invite_text">우리가 함께 일하는 법, Project Hub!</div>
		<div class="invite_section">
			<div class="invite_section_wrap">
				<h3>
					<strong>${projectMemberInfo.pname}</strong>
				</h3>
				${projectMemberInfo.name} 님이 프로젝트에 초대합니다.<br>
			</div>
			<div class="card-body">
				<form action="/mainPage" method="get" id="loginForm">
					<div class="form-floating mb-3">
						<input class="form-control" id="email" type="text" name="email" />
						<label for="email">이메일</label>
					</div>
					<div class="form-floating mb-3">
						<input class="form-control" id="password" type="password" name="password" />
						<label for="password">비밀번호</label>
					</div>
					<div style="height: 35px; text-align: center;">
						<span style="color: red; display: none;" id="error">아이디 또는 비밀번호가 잘못 입력 되었습니다</span> <span style="color: red; display: none;" id="auth_error">이메일 인증후 로그인이 가능합니다.</span>
					</div>
					<div class="d-grid">
						<button class="btn btn-primary" type="button" id="loginCheck">로그인하고 프로젝트 시작하기!</button>
					</div>
				</form>
				<input id="pno" type="hidden" name="pno" value="${projectMemberInfo.pno}" />
				<div class="join_div">
					<a href="/join" class="join">Project Hub 회원가입 하러가기</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>