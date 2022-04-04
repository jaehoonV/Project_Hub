<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl c태그 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 라이브러리 코드 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>북마크</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/resources/assets/favicon.ico">
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/favicon.ico">
<!-- css -->
<link href="/resources/css/bookmark.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<!-- 부트스트랩 아이콘cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- 폰트어썸 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
<!-- jQuery.validate 플러그인 삽입 -->
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<!-- js -->
<script src="<c:url value="/resources/js/bookmark.js"/>"></script>
</head>
<body>
	<header>
		<nav class="topnav">
			<a class="topnav-brand" href="#" style="color: white">Project Hub</a>
			<ul class="topnav-nav">
				<li>
					<div class="btn-group">
						<button type="button" data-toggle="dropdown" aria-expanded="false" id="profilebutton">
							<div class="profile-default-button"></div>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<div class="user_info">
								<div class="user_profile"></div>
								<div class="user_name">
									<strong>${memberInfo.name }</strong>
								</div>
							</div>
							<button type="button" data-toggle="modal" data-target="#myProfile" class="myProfile">
								<i class="far fa-user"></i> 내 프로필
							</button>
							<button type="button" data-toggle="modal" data-target="#logout" class="logout">
								<i class="fas fa-sign-out-alt"></i> 로그아웃
							</button>
						</div>
					</div>
				</li>
			</ul>
		</nav>
		<nav class="layoutSidenav">
			<div class="sidemenu">
				<table class="sidenav-logo">
					<tr>
						<th>
							<div class="logo-box">
								<a href="/main" id="a_logo"> Project Hub </a>
							</div>
						</th>
					</tr>
				</table>
			</div>
			<div class="sidemenu">
				<table class="sidenav">
					<tr>
						<th>
							<div class="container">
								<!-- Button to Open the Modal -->
								<button type="button" class="makeProjectbtn" data-toggle="modal" data-target="#makeProject">새 프로젝트</button>
							</div>
						</th>
					</tr>
				</table>
			</div>
			<div class="sidemenu">
				<table class="sidenav">
					<tr>
						<th><i class="bi bi-house"></i>
							<h5>
								<a href="/main" style="color: white"> 내 프로젝트 </a>
							</h5></th>
					</tr>
				</table>
			</div>
			<div class="sidemenu">
				<table class="sidenav-menu">
					<tr>
						<th>
							<ul class="leftmenu">
								<li class="leftmenu_li"><a href="/bookmark" id="bookmark_link">북마크</a></li>
								<li class="leftmenu_li">캘린더</li>
								<li class="leftmenu_li">파일함</li>
								<li class="leftmenu_li">내 게시물</li>
							</ul>
						</th>
					</tr>
				</table>
			</div>
			<div class="sidemenu">
				<table class="sidenav">
					<tr>
						<th>
							<h5>고객센터</h5>
						</th>
					</tr>
				</table>
			</div>
		</nav>
	</header>
	<main>
		<div class="apply_modal" style="opacity: 0;">적용되었습니다.</div>
		<div class="name_null_modal" style="opacity: 0;">이름을 입력하세요.</div>
		<div class="modal fade" id="logout">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content logout-modal-content">
					<!-- Modal body -->
					<div class="modal-body logout_modal_body">
						<div class="logout_header">
							<p class="logout_text">로그아웃 하시겠습니까?</p>
						</div>
						<!-- logout-button-->
						<div class="logout-button">
							<button type="button" class="btn modal_cancel" data-dismiss="modal">취소</button>
							<a href="logout">
								<button class="modal_submit" type="submit">확인</button>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="myProfile">
			<div class="modal-dialog modal-dialog-centered myProfile_modal">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header" id="profilemodal-header">
						<div class="profile-header-dimmed-layer"></div>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<div class="name-card">
							<div class="info">
								<p class="info-box">
									<span class="name ellipsis">이름</span>
								</p>
							</div>
						</div>
					</div>
					<!-- Modal body -->
					<div class="modal-body" id="profilemodal-body">
						<div class="contact">
							<ul class="contact-contents profile_ul">
								<li id="profile_li"><span id="profile_li_icon"><i class="far fa-user"></i></span><span id="username">${memberInfo.name }</span></li>
								<li id="profile_li"><span id="profile_li_icon"><i class="far fa-envelope"></i></span><span id="useremail">${memberInfo.email }</span></li>
								<li id="profile_li"><span id="profile_li_icon"><i class="fas fa-mobile-alt"></i></span><span id="userPhone">${memberInfo.phone_num }</span></li>
								<li id="profile_li"><span id="profile_li_icon"><i class="fas fa-phone"></i></span><span id="userCall">${memberInfo.tel_num }</span></li>
							</ul>
						</div>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer" id="profilemodal-footer">
						<!-- Submit Button-->
						<button class="profile-btn profilebtn-chat">채팅</button>
						<button class="profile-btn profilebtn-modify">정보수정</button>
					</div>
					<!-- modal-footer closed-->
				</div>
			</div>
		</div>
		<!-- modal closed-->
		<div class="modal fade" id="mySetting">
			<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable settingmodal">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header" id="settingmodal-header">
						<h6 class="settingmodal-title">
							<b>계정설정</b>
						</h6>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body" id="settingmodal-body"></div>
					<div class="settingArea">
						<ul class="settingUl">
							<li class="adjust"><div class="my-right-list-1">아이디(이메일)</div>
								<div class="my-right-list-2" id="adjust_mail">
									<span id="useremail">${memberInfo.email }</span>
								</div></li>
							<li class="edit-adjust"><div class="my-right-list-1">이름</div>
								<div class="my-right-list-2 defaultview d-block">
									<span id="username">${memberInfo.name }</span> <i class="far fa-edit"></i>
								</div>
								<div class="my-right-list-2 editview" id="change_name_box_div">
									<form id="change_name_box">
										<input id="change_name" type="text" name="change_name" value="${memberInfo.name }" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-confirm-btn" type="submit">확인</button>
									</form>
								</div></li>
							<li class="edit-adjust"><div class="my-right-list-1">회사명</div>
								<div class="my-right-list-2 defaultview d-block">
									<span id="usercompany_name">${memberInfo.company_name }</span> <i class="far fa-edit"></i>
								</div>
								<div class="my-right-list-2 editview">
									<form id="change_cmpname_box">
										<input id="change_company_name" type="text" name="change_company_name" value="${memberInfo.company_name }" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-confirm-btn" type="submit">확인</button>
									</form>
								</div></li>
							<li class="edit-adjust"><div class="my-right-list-1">직급</div>
								<div class="my-right-list-2 defaultview d-block">
									<span id="userjob_position">${memberInfo.job_position }</span> <i class="far fa-edit"></i>
								</div>
								<div class="my-right-list-2 editview">
									<form id="change_jobp_box">
										<input id="change_job_position" type="text" name="change_job_position" value="${memberInfo.job_position }" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-confirm-btn" type="submit">확인</button>
									</form>
								</div></li>
							<li class="edit-adjust"><div class="my-right-list-1">휴대폰번호</div>
								<div class="my-right-list-2 defaultview d-block">
									<span id="userphone_num">${memberInfo.phone_num }</span> <i class="far fa-edit"></i>
								</div>
								<div class="my-right-list-2 editview">
									<form id="change_phonen_box">
										<input id="change_phone_num" type="text" name="change_phone_num" value="${memberInfo.phone_num }" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-confirm-btn" type="submit">확인</button>
									</form>
								</div></li>
							<li class="edit-adjust"><div class="my-right-list-1">전화번호</div>
								<div class="my-right-list-2 defaultview d-block">
									<span id="usertel_num">${memberInfo.tel_num }</span> <i class="far fa-edit"></i>
								</div>
								<div class="my-right-list-2 editview">
									<form id="change_teln_box">
										<input id="change_tel_num" type="text" name="change_tel_num" value="${memberInfo.tel_num }" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-confirm-btn" type="submit">확인</button>
									</form>
								</div></li>
							<li class="edit-adjust" id="passwordArea"><div class="my-right-list-1">비밀번호</div>
								<div class="my-right-list-2 defaultview d-block">
									<Strong>비밀번호 재설정이 가능합니다.</Strong>
									<button class="pw-btn">비밀번호 재설정</button>
								</div>
								<div class="my-right-list-2 editview">
									<form id="change_pw_box">
										<span>비밀번호</span>
										<input id="change_pw" type="password" name="change_pw" />
										<br> <span>비밀번호 확인</span>
										<input id="change_pwChk" type="password" name="change_pwChk" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-pw-confirm-btn" id="change_pw_btn" type="submit">확인</button>
									</form>
								</div></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- modal closed-->
		<div class="modal fade" id="makeProject">
			<div class="modal-dialog modal-dialog-centered makeProject-modal">
				<div class="modal-content makeProject-modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h6 class="makeProject-modal-title">새 프로젝트</h6>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						<form action="/makeProject" method="post" id="makeProjectForm">
							<!-- Project name input-->
							<div class="form-project">
								<input class="projectTitleInput" id="pname" type="text" name="pname" placeholder="제목을 입력하세요" />
							</div>
							<br>
							<!-- Project description  input-->
							<div class="form-project">
								<textarea class="projectContentsInput" id="pdescription" name="pdescription" placeholder="프로젝트에 관한 설명(옵션)"></textarea>
							</div>
							<!-- Submit Button-->
							<button class="project-submit" id="submitButton" type="submit">만들기</button>
						</form>
						<!-- /makeProject closed-->
					</div>
				</div>
			</div>
		</div>
		<!-- modal closed-->
		<div class="main-container">
			<div class="main-header">
				<div class="header_name">
					<strong>북마크</strong>
				</div>
				<div class="bookmark-search">
					<i class="bi bi-search searchBtn"></i>
					<input type="text" class="bookmark-search-input" placeholder="게시물 제목을 입력해주세요">
				</div>
			</div>
			<div class="main-content">
				<div class="search_title_area">
					<span id="search_title">전체 </span><span id="bookmark_count"></span> <span id="search_title_sub"> 글 </span><span id="bookmark_count_text"></span> <span id="search_title_sub"> 업무 </span><span id="bookmark_count_task"></span> <span id="search_title_sub"> 일정 </span><span id="bookmark_count_schedule"></span>
				</div>
				<div class="bookmark_list_area">
					<ul id="bookmark_list_ul">
					</ul>
				</div>
			</div>
		</div>
	</main>
</body>
</html>