<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>우리가 함께 일하는 법, Project Hub</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/resources/assets/favicon.ico">
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/favicon.ico">
<!-- Bootstrap Icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
<!-- SimpleLightbox plugin CSS-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<!-- index.css -->
<link href="<c:url value="/resources/css/index.css"/>" rel="stylesheet">
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- jQuery.validate 플러그인 삽입 -->
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<!-- index.js -->
<script src="<c:url value="/resources/js/index.js"/>"></script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
<!-- SimpleLightbox plugin JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
<!-- <script src="/resources/js/scripts.js"></script> -->
<script src="<c:url value="/resources/js/scripts.js"/>"></script>
</head>
<body id="page-top">
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="/">Project Hub</a>
			<button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ms-auto my-2 my-lg-0">
					<li class="nav-item"><a class="nav-link" href="#about">About</a></li>
					<li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
					<li class="nav-item"><a class="nav-link" href="/join">Join</a></li>
					<li class="nav-item"><a class="nav-link" href="/login">Login</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Masthead-->
	<header class="masthead">
		<div class="container px-4 px-lg-5 h-100">
			<div class="row gx-4 gx-lg-5 h-100 align-items-center justify-content-center text-center">
				<div class="col-lg-8 align-self-end">
					<h1 class="text-white font-weight-bold">
						우리가 함께 일하는 법,<br>Project Hub
					</h1>
					<hr class="divider" />
				</div>
				<div class="col-lg-8 align-self-baseline">
					<p class="text-white-75 mb-5">협업툴 Project Hub를 사용하면 소통이 빨라지고 업무 생산성이 높아집니다.</p>
					<a class="btn btn-primary btn-xl" href="#about">더 알아보기</a>
				</div>
			</div>
		</div>
	</header>
	<!-- About-->
	<section class="page-section bg-primary" id="about">
		<div class="container px-4 px-lg-5">
			<div class="row gx-4 gx-lg-5 justify-content-center">
				<div class="col-lg-8 text-center">
					<h2 class="text-white mt-0">아이디어를 모으고 일을 진행하세요.</h2>
					<hr class="divider divider-light" />
					<p class="text-white-75 mb-4">쉽고 빠른 업무관리 협업툴 Project Hub</p>
					<a class="btn btn-light btn-xl" href="#">가입해서 시작하기</a>
				</div>
			</div>
		</div>
	</section>
	<!-- Portfolio-->
	<div id="portfolio">
		<div class="container-fluid p-0">
			<div class="row g-0">
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="/resources/assets/img/portfolio/fullsize/1.jpg" title="Project Name">
						<img class="img-fluid" src="/resources/assets/img/portfolio/thumbnails/1.jpg" alt="..." />
						<div class="portfolio-box-caption">
							<!-- <div class="project-category text-white-50">Category</div> -->
							<div class="project-name">아이디어를 모으세요</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="/resources/assets/img/portfolio/fullsize/2.jpg" title="Project Name">
						<img class="img-fluid" src="/resources/assets/img/portfolio/thumbnails/2.jpg" alt="..." />
						<div class="portfolio-box-caption">
							<div class="project-name">동료들과 회의하세요</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="/resources/assets/img/portfolio/fullsize/3.jpg" title="Project Name">
						<img class="img-fluid" src="/resources/assets/img/portfolio/thumbnails/3.jpg" alt="..." />
						<div class="portfolio-box-caption">
							<div class="project-name">사람들과 함께하세요</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="/resources/assets/img/portfolio/fullsize/4.jpg" title="Project Name">
						<img class="img-fluid" src="/resources/assets/img/portfolio/thumbnails/4.jpg" alt="..." />
						<div class="portfolio-box-caption">
							<div class="project-name">파일을 수집하고 정리하세요</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="/resources/assets/img/portfolio/fullsize/5.jpg" title="Project Name">
						<img class="img-fluid" src="/resources/assets/img/portfolio/thumbnails/5.jpg" alt="..." />
						<div class="portfolio-box-caption">
							<div class="project-name">꿈을 현실로 만드세요</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box" href="/resources/assets/img/portfolio/fullsize/6.jpg" title="Project Name">
						<img class="img-fluid" src="/resources/assets/img/portfolio/thumbnails/6.jpg" alt="..." />
						<div class="portfolio-box-caption p-3">
							<div class="project-name">물론, 혼자 쓰기에도 좋습니다</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Services-->
	<section class="page-section" id="services">
		<div class="container px-4 px-lg-5">
			<h2 class="text-center mt-0">If you use the project hub</h2>
			<hr class="divider" />
			<div class="row gx-4 gx-lg-5">
				<div class="col-lg-3 col-md-6 text-center">
					<div class="mt-5">
						<div class="mb-2">
							<i class="bi-gem fs-1 text-primary"></i>
						</div>
						<h3 class="h4 mb-2">생산성 향상</h3>
						<p class="text-muted mb-0">Our themes are updated regularly to keep them bug free!</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="mt-5">
						<div class="mb-2">
							<i class="bi-laptop fs-1 text-primary"></i>
						</div>
						<h3 class="h4 mb-2">스마트하게</h3>
						<p class="text-muted mb-0">All dependencies are kept current to keep things fresh.</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="mt-5">
						<div class="mb-2">
							<i class="bi-globe fs-1 text-primary"></i>
						</div>
						<h3 class="h4 mb-2">언제나 어디서나</h3>
						<p class="text-muted mb-0">You can use this design as is, or you can make changes!</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="mt-5">
						<div class="mb-2">
							<i class="bi-heart fs-1 text-primary"></i>
						</div>
						<h3 class="h4 mb-2">사람이 모이는 곳</h3>
						<p class="text-muted mb-0">Is it really open source if it's not made with love?</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Call to action-->
	<section class="page-section bg-dark text-white">
		<div class="container px-4 px-lg-5 text-center">
			<h2 class="mb-4">멀지만 가까이, 함께 일하기</h2>
			<a class="btn btn-light btn-xl" href="#join">가입해서 시작하기</a>
		</div>
	</section>
	<!-- Join-->
	<section class="page-section" id="join">
		<div class="container px-4 px-lg-5">
			<div class="row gx-4 gx-lg-5 justify-content-center">
				<div class="col-lg-8 col-xl-6 text-center">
					<h2 class="mt-0">회원가입</h2>
					<hr class="divider" />
					<p class="text-muted mb-5">사이트를 이용하시려면 회원가입을 해주세요.</p>
				</div>
			</div>
			<div class="row gx-4 gx-lg-5 justify-content-center mb-5">
				<div class="col-lg-6">
					<form action="/join" method="post" id="joinForm">
						<!-- Email address input-->
						<div class="form-floating mb-3">
							<input class="form-control email_input" id="email" type="text" name="email" />
							<label for="email">이메일</label>
						</div>
						<!-- Name input-->
						<div class="form-floating mb-3">
							<input class="form-control" id="name" type="text" name="name" />
							<label for="name">이름</label>
						</div>
						<!-- Password address input-->
						<div class="form-floating mb-3">
							<input class="form-control" id="password" type="password" name="password" />
							<label for="password">비밀번호</label>
						</div>
						<!-- Password address input-->
						<div class="form-floating mb-3">
							<input class="form-control" id="repassword" type="password" name="repassword" />
							<label for="repassword">비밀번호 확인</label>
						</div>
						<!-- Submit Button-->
						<div class="d-grid">
							<button class="btn btn-primary btn-xl" id="submitButton" type="submit">회원가입</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer-->
	<footer class="bg-light py-5">
		<div class="container px-4 px-lg-5">
			<div class="small text-center text-muted">Copyright &copy; 2021 - Project Hub</div>
		</div>
	</footer>
</body>
</html>