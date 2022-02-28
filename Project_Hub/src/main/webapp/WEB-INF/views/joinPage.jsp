<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - Project Hub</title>
<!-- Favicon-->
<!-- <link rel="icon" type="image/x-icon" href="assets/ph_ico.ico" /> -->
<link rel="shortcut icon" href="#">

<!-- <link href="/resources/css/loginPage.css" rel="stylesheet" /> -->
<link href="<c:url value="/resources/css/login_joinPage.css"/>"
	rel="stylesheet">

<!-- fonts -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic"
	rel="stylesheet" type="text/css" />
<!-- Spoqa Han Sans Neo -->
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css'
	rel='stylesheet' type='text/css'>

<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- jQuery.validate 플러그인 삽입 -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		$('#joinForm').validate({
			rules : {
				email : {
					required : true,
					email : true,
					/* remote : 엘리먼트의 검증을 지정된 다른 자원에 ajax 로 요청 */
					remote : {
						url : "/userEmailChk",
						type : "post",
						data : {
							email : function() {
							return $('#email').val();
							}
						}
					}
				},
				name : {
					required : true,
					rangelength : [ 2, 8 ]
				},
				password : {
					required : true,
					rangelength : [ 8, 16 ]
				},
				repassword : {
					required : true,
					equalTo : '#password'
				}
			},
			messages : {
				email : {
					required : "이메일을 입력해 주세요.",
					email : "올바른 이메일을 입력해 주세요.",
					remote : "중복된 아이디입니다."

				},
				name : {
					required : "이름을 입력해 주세요.",
					rangelength : "이름은 {0}자에서 {1}자까지 사용 가능합니다."
				},
				password : {
					required : "비밀번호를 입력해 주세요.",
					rangelength : "비밀번호는 {0}자에서 {1}자까지 사용 가능합니다."
				},
				repassword : {
					required : "비밀번호 확인을 입력해주세요.",
					equalTo : "비밀번호와 동일하게 입력해 주세요."
				}
			},
			submitHandler : function() { //유효성 검사를 통과시 전송
				joinForm.submit();
				console.log("submitHandler >>> function");
				alert("인증 메일을 발송하였습니다. e-mail을 확인해주세요.");
			},
			success : function(e) {
				//
			}
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


</head>

<body class="bg-primary">
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3"
		id="mainNav">
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
										<h3 class="text-center font-weight-light my-4">회원가입</h3>
									</div>
									<div class="card-body">
										<form action="/join" method="post" id="joinForm">
											<div class="form-floating mb-3">
												<input class="form-control" id="email" type="text"
													name="email" /> <label for="email">이메일</label>
											</div>
											<div class="form-floating mb-3">
												<input class="form-control" id="name" type="text"
													name="name" /> <label for="name">이름</label>
											</div>
											<div class="form-floating mb-3">
												<input class="form-control" id="password" type="password"
													name="password" /> <label for="password">비밀번호</label>
											</div>
											<div class="form-floating mb-3">
												<input class="form-control" id="repassword" type="password"
													name="repassword" /> <label for="password">비밀번호 확인</label>
											</div>
											<div class="d-grid">
												<button class="btn btn-primary btn-xl" id="Button"
											type="submit">회원가입</button>
											</div>
										</form>
									</div>
									<div class="card-footer text-center py-3">
									<a href="/login" class="btn btn-primary">이미 회원입니다.</a>
										<a href="/" class="btn btn-primary">뒤로 돌아가기</a>
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
				<div class="small text-center text-muted">Copyright &copy;
					2022 - Project Hub</div>
			</div>
		</footer>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/js/scripts.js"></script>
</body>
</html>