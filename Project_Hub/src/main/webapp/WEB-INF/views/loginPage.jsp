<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - Project Hub</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/resources/assets/favicon.ico">
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/favicon.ico">
<!-- css -->
<link href="<c:url value="/resources/css/loginPage.css"/>" rel="stylesheet">
<!-- fonts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
<!-- Spoqa Han Sans Neo -->
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="<c:url value="/resources/css/index.css"/>" rel="stylesheet">
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- jQuery.validate 플러그인 삽입 -->
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		$('#loginCheck').click(function() {
			var email = $('#email').val();
			var password = $('#password').val();

			//이메일이나 비밀번호 미입력시 validation 
			if ($('#email').val() == "" || $('#password').val() == "") {
				$('#loginForm').submit();
			} else {
				$.ajax({
					type : "POST",
					url : '/loginCheck',
					data : {
						email : email,
						password : password
					},
					success : function(data) {
						if (data == "true") {
							$('#loginForm').submit();
						} else if (data == "false") {
							$('#auth_error').css('display', 'none');
							$('#error').css('display', 'block');
						} else if (data == "noauth") {
							$('#error').css('display', 'none');
							$('#auth_error').css('display', 'block');
						}
					}
				});
			}
		});
		$('#loginForm').validate({
			rules : {
				email : {
					required : true
				},
				password : {
					required : true
				}
			},
			messages : {
				email : {
					required : "이메일을 입력해 주세요."
				},
				password : {
					required : "비밀번호를 입력해 주세요."
				}
			},
			submitHandler : function() { //유효성 검사를 통과시 전송
				loginForm.submit();
			},
		});//end validate()
	});
</script>
<!-- form validation 에러시 css -->
<style type="text/css">
input.error {
	border: 1px solid red;
}

label.error {
	position: absolute;
	left: 200px;
	color: red;
}
</style>
</head>
<body class="bg-primary">
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="/">Project Hub</a>
		</div>
	</nav>
	<div class="wrap">
		<div id="layoutAuthentication">
			<div id="layoutAuthentication_content">
				<main>
					<div class="container py-10">
						<div class="row justify-content-center">
							<div class="col-lg-8 col-xl-6 text-center">
								<div class="card shadow-lg border-0 rounded-lg mt-5">
									<div class="card-header">
										<h3 class="text-center font-weight-light my-4">로그인</h3>
									</div>
									<div class="card-body">
										<form action="/login" method="post" id="loginForm">
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
												<button class="btn btn-primary btn-xl" type="button" id="loginCheck">로그인</button>
											</div>
										</form>
									</div>
									<div class="card-footer text-center py-3">
										<a href="/findPw" class="btn btn-primary">비밀번호 찾기</a>
										<a href="/join" class="btn btn-primary">회원가입</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</main>
			</div>
		</div>
		<!-- Footer-->
		<footer class="bg-light py-5">
			<div class="container px-4 px-lg-5">
				<div class="small text-center text-muted">Copyright &copy; 2022 - Project Hub</div>
			</div>
		</footer>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/js/scripts.js"></script>
</body>
</html>