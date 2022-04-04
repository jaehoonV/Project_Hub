<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl c태그 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 라이브러리 코드 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	pageContext.setAttribute("replaceChar", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project HomePage</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/resources/assets/favicon.ico">
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/favicon.ico">
<!-- css -->
<link href="/resources/css/projectHomePage.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<!-- 부트스트랩 아이콘cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- 주소록 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 지도 api -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3fea17d9b713a1da00c584f2f93c5426&libraries=services"></script>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/f1b7ad5b17.js" crossorigin="anonymous"></script>
<!-- jQuery.validate 플러그인 삽입 -->
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<!-- chart.js cdn -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- js -->
<script src="<c:url value="/resources/js/projectHomePage.js"/>"></script>

<script type="text/javascript">



</script>
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
		<div class="invite_apply_modal" style="opacity: 0;">초대 메일 발송을 완료했습니다.</div>
		<div class="reply_null_error" style="opacity: 0;">댓글 내용을 입력하세요.</div>
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
		<div class="modal" id="pmcolorUpdate">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h6 class="modal-title">프로젝트 색상</h6>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						<form action="/pmcolorUpdate" method="post" id="pmcolorUpdateForm">
							<ul id="selectColorTypes">
								<li id="color-type-emerald" value="emerald"><span>emerald</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-green" value="green"><span>green</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-yellow" value="yellow"><span>yellow</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-orange" value="orange"><span>orange</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-red" value="red"><span>red</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-pink" value="pink"><span>pink</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-skyblue" value="skyblue"><span>skyblue</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-blue" value="blue"><span>blue</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-purple" value="purple"><span>purple</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-darkgrey" value="darkgrey"><span>darkgrey</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-black" value="black"><span>black</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
								<li id="color-type-lightgrey" value="lightgrey"><span>lightgrey</span>
								<div class="checkIcon">
										<strong>✓</strong>
									</div></li>
							</ul>
							<!-- Submit Button-->
							<div class="make-button">
								<button type="button" class="modal_cancel" data-dismiss="modal">취소</button>
								<input type="hidden" name="selectedpmcolor" id="selectedpmcolor" value="" />
								<button type="submit" value="" class="modal_submit">확인</button>
							</div>
						</form>
						<!-- /makeProject closed-->
					</div>
					<!-- modal-body closed -->
				</div>
			</div>
		</div>
		<!-- modal closed-->
		<div class="modal" id="project_invite">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content invite_modal">
					<!-- Modal Header -->
					<div class="modal-header" style="align-items: center;">
						<div id="modal_projectColor" class="project_invite_modal_pmcolor"></div>
						<h6 class="project_invite_title">${projectInfo.pname} 초대하기</h6>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body input_modal_body">
						<div class="input_email_list">
							<div class="project_invite_title">이메일 초대장 발송</div>
							<div class="input_email">
								<input type="text" class="emailItemInput" id="inputEmail1" placeholder="example@projectHub.com" data-valid="email" maxlength="50">
							</div>
							<div class="input_email">
								<input type="text" class="emailItemInput" id="inputEmail2" placeholder="example@projectHub.com" data-valid="email" maxlength="50">
							</div>
							<div class="input_email">
								<input type="text" class="emailItemInput" id="inputEmail3" placeholder="example@projectHub.com" data-valid="email" maxlength="50">
							</div>
							<div class="input_email">
								<input type="text" class="emailItemInput" id="inputEmail4" placeholder="example@projectHub.com" data-valid="email" maxlength="50">
							</div>
							<div class="input_email">
								<input type="text" class="emailItemInput" id="inputEmail5" placeholder="example@projectHub.com" data-valid="email" maxlength="50">
							</div>
						</div>
						<button type="button" class="append_input_email">+이메일 추가</button>
					</div>
					<!-- modal-body closed -->
					<!-- Modal footer -->
					<div class="modal-footer project_invite_footer">
						<div class="project_invite_button">
							<button type="button" class="modal_cancel" data-dismiss="modal">취소</button>
							<input type="hidden" id="invite_pno" value="${projectInfo.pno}" />
							<input type="hidden" id="invite_pname" value="${projectInfo.pname}" />
							<input type="hidden" id="invite_name" value="${memberInfo.name}" />
							<button type="submit" class="modal_submit invitebtn">초대</button>
						</div>
					</div>
					<!-- modal-footer closed-->
				</div>
			</div>
		</div>
		<!-- modal closed-->
		<div class="main-container">
			<div class="main-header">
				<div class="row">
					<div class="wrapper col-10">
						<div class="item">
							<button type="button" data-toggle="modal" data-target="#pmcolorUpdate" id="projectColor" value="${projectMemberInfo.pmcolor}">
								<div id="projectColorDiv"></div>
							</button>
						</div>
						<div class="pmfavorite">
							<c:choose>
								<c:when test="${projectMemberInfo.pmfavorite eq 0}">
									<!-- pmfavorite이 0일 때 -->
									<div onclick="favoriteButton(${projectMemberInfo.pno})" id="favoriteButton">
										<img src="/resources/assets/img/empty_star.png" style="margin-bottom: 5px; width: 27px; height: 27px;" alt="empty_star" id="star" /> <img src="/resources/assets/img/empty_star_hover.png" style="margin-bottom: 5px; width: 27px; height: 27px;" alt="empty_star_hover" id="empty_star_hover" />
									</div>
								</c:when>
								<c:otherwise>
									<!-- pmfavorite이 1일 때(default값) -->
									<div onclick="favoriteButton(${projectMemberInfo.pno})" id="favoriteButton1">
										<img src="/resources/assets/img/star.png" style="margin-bottom: 5px; width: 27px; height: 27px;" alt="star" id="star" />
									</div>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="item">
							<div class="dropdown">
								<a role="button" id="projectMenu" data-toggle="dropdown" aria-expanded="false">
									<i class="fas fa-ellipsis-v" id="projectSet"></i>
								</a>
								<div class="dropdown-menu dropdown_projectMenu" aria-labelledby="projectMenu">
									<div class="projectMenu_header">
										<span>프로젝트 번호</span>
										<div class="project_number">${projectInfo.pno }</div>
									</div>
									<button type="button" data-toggle="modal" data-target="#pmcolorUpdate" id="dropdown_projectColor" value="${projectMemberInfo.pmcolor}">
										<div class="projectColor_dropdownbtn">
											<i class="fas fa-palette"></i> 색상 설정
										</div>
									</button>
									<a class="dropdown_projectMenu_a" href="projectExit">
										<i class="fas fa-sign-out-alt"></i> 프로젝트 나가기
									</a>
									<c:if test="${projectMemberInfo.pmadmin_num eq 1}">
										<a class="dropdown_projectMenu_a" href="#" data-toggle="modal" data-target="#modifyProject">
											<i class="fas fa-pencil-alt"></i> 프로젝트 수정
										</a>
										<a class="dropdown_projectMenu_a" href="deleteProject">
											<i class="far fa-trash-alt"></i> 프로젝트 삭제
										</a>
									</c:if>
								</div>
							</div>
						</div>
						<div class="item" id="projectName">${projectInfo.pname }</div>
						<div class="item" id="projectDescription">${projectInfo.pdescription }</div>
					</div>
					<div class="invite_div">
						<c:if test="${projectMemberInfo.pmadmin_num eq 1}">
							<button type="button" data-toggle="modal" data-target="#project_invite" id="invite_button" value="${projectInfo.pno}">초대하기</button>
						</c:if>
					</div>
				</div>
				<nav class="nav">
					<a class="nav-link active" href="#">홈</a>
					<a class="nav-link" href="#">업무</a>
					<a class="nav-link" href="#">캘린더</a>
					<a class="nav-link" href="#">파일</a>
				</nav>
			</div>
			<div class="main-content">
				<div class="main-content-area-wrap">
					<div id="mainBox">
						<div id="taskReportArea">
							<div id="taskReport-section">
								<div class="taskReport_title">
									<span id="taskReport_title_span">업무리포트</span> <span id="taskReport_number">${taskReport_number[0]}</span>
									<button id="taskReport_toggle">
										<i class="fa-solid fa-angle-up"></i>
									</button>
								</div>
								<div class="taskReport_content">
									<div class="task_report">
										<c:if test="${taskReport_number[0] ne '0'}">
											<div class="task_report_doughnut">
												<canvas id="task_report_chart"></canvas>
											</div>
										</c:if>
									</div>
									<div class="task_report_list">
										<ul id="task_report_list_ul">
											<c:if test="${taskReport_number[0] ne '0'}">
												<li style="margin-bottom: 16px;"><span class="task_report_request"> <i class="fa-solid fa-circle fa-xs"></i> <span class="task_report_text">요청 <em class="trn1">${taskReport_number[1]}</em>
													</span> <span class="task_report_request_percent"></span> <span class="request_percent">%</span>
												</span> <span class="task_report_progress"> <i class="fa-solid fa-circle fa-xs"></i> <span class="task_report_text">진행 <em class="trn2">${taskReport_number[2]}</em>
													</span> <span class="task_report_progress_percent"></span> <span class="progress_percent">%</span>
												</span></li>
												<li><span class="task_report_complete"> <i class="fa-solid fa-circle fa-xs"></i> <span class="task_report_text">완료 <em class="trn3">${taskReport_number[3]}</em>
													</span> <span class="task_report_complete_percent"></span> <span class="complete_percent">%</span>
												</span> <span class="task_report_hold"> <i class="fa-solid fa-circle fa-xs"></i> <span class="task_report_text">보류 <em class="trn4">${taskReport_number[4]}</em>
													</span> <span class="task_report_hold_percent"></span> <span class="hold_percent">%</span>
												</span></li>
											</c:if>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div id="writeBox">
							<div class="writeBoxHeader">
								<div class="write" data-toggle="modal" data-target="#writeText">
									<i class="far fa-edit"></i> 글
								</div>
								<div class="write" data-toggle="modal" data-target="#writeTask" id="task_write">
									<i class="fas fa-list-ul"></i> 업무
								</div>
								<div class="write" data-toggle="modal" data-target="#writeSchedule">
									<i class="far fa-calendar-alt"></i> 일정
								</div>
							</div>
							<div class="writeBox-body" data-toggle="modal" data-target="#writeText">내용을 입력하세요.</div>
						</div>
						<div id="fixContainer">
							<div class="section-title">
								<strong>상단 고정</strong> <span id="boardFixCount">${boardFixCount}</span>
							</div>
							<c:forEach items="${boardListFixed}" var="boardListFixed">
								<c:if test="${boardListFixed.bfix eq '1'}">
									<div class="card fixBox">
										<div class="card-body fixBoxMain">
											<div class="fixBoxHeader">
												<div class="fixType">
													<c:if test="${boardListFixed.bidentifier eq 1}">
														<i class="far fa-edit"></i> 글
									</c:if>
													<c:if test="${boardListFixed.bidentifier eq 2}">
														<i class="fas fa-list-ul"></i> 업무
									</c:if>
													<c:if test="${boardListFixed.bidentifier eq 3}">
														<i class="far fa-calendar-alt"></i> 일정
									</c:if>
												</div>
											</div>
											<div class="fixBoxBody">
												<div>
													<div class="d-inline">
														<i class="fas fa-thumbtack fixed_icon" value="${boardListFixed.bno}"></i>
														<c:forEach items="${boardListFixed.textList}" var="textList">
															<c:out value="${textList.text_title}" />
														</c:forEach>
														<c:forEach items="${boardListFixed.taskList}" var="taskList">
															<c:out value="${taskList.task_title}" />
														</c:forEach>
														<c:forEach items="${boardListFixed.scheduleList}" var="scheduleList">
															<c:out value="${scheduleList.schedule_title}" />
														</c:forEach>
													</div>
												</div>
											</div>
											<div class="fixBoxFooter">
												<div class="fixStatus">
													<c:forEach items="${boardListFixed.taskList}" var="taskList">
														<c:choose>
															<c:when test="${taskList.task_status eq 1}">
																<div class="board_stts fixstts">
																	<div class="board_request_div stts_check" stts="1">요청</div>
																</div>
															</c:when>
															<c:when test="${taskList.task_status eq 2}">
																<div class="board_stts fixstts">
																	<div class="board_progress_div stts_check" stts="2">진행</div>
																</div>
															</c:when>
															<c:when test="${taskList.task_status eq 3}">
																<div class="board_stts fixstts">
																	<div class="board_completion_div stts_check" stts="3">완료</div>
																</div>
															</c:when>
															<c:when test="${taskList.task_status eq 4}">
																<div class="board_stts fixstts">
																	<div class="board_hold_div stts_check" stts="4">보류</div>
																</div>
															</c:when>
														</c:choose>
													</c:forEach>
												</div>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<c:if test="${empty boardList}">
		게시물이 없습니다.
		</c:if>
						<c:if test="${not empty boardList}">
							<div id="boardHeader">
								<span style="flex: 1;"> 전체 </span>
								<div id="selectBox">
									<select id="cntSelectBox" name="cntSelectBox" onchange="changeSelectBox(${pagination.currentPage},${pagination.cntPerPage},${pagination.pageSize});" class="form-control" style="width: 100px;">
										<option value="10" <c:if test="${pagination.cntPerPage == '10'}">selected</c:if>>10개</option>
										<option value="20" <c:if test="${pagination.cntPerPage == '20'}">selected</c:if>>20개</option>
										<option value="30" <c:if test="${pagination.cntPerPage == '30'}">selected</c:if>>30개</option>
									</select>
								</div>
							</div>
							<c:forEach items="${boardList}" var="boardList">
								<div class="card boardContainer">
									<div class="card-body boardBox">
										<div class="boardHeader">
											<div class="profile"></div>
											<div class="boardMember">
												<span><c:out value="${boardList.bwriter}" /></span> <span class="writeDate"> <c:forEach items="${boardList.textList}" var="textList">
														<fmt:formatDate pattern="yyyy/MM/dd" value="${textList.text_day}" />
													</c:forEach> <c:forEach items="${boardList.taskList}" var="taskList">
														<fmt:formatDate pattern="yyyy/MM/dd" value="${taskList.task_day}" />
													</c:forEach> <c:forEach items="${boardList.scheduleList}" var="scheduleList">
														<fmt:formatDate pattern="yyyy/MM/dd" value="${scheduleList.schedule_day}" />
													</c:forEach>
												</span>
											</div>
											<div class="boardStatus">
												<div class="boardFix">
													<c:if test="${boardList.bfix eq '0'}">
														<i class="fas fa-thumbtack fixIcon" value="${boardList.bno}"></i>
													</c:if>
													<c:if test="${boardList.bfix eq '1'}">
														<i class="fas fa-thumbtack fixIcon" value="${boardList.bno}" style="color: #6449fc;"></i>
													</c:if>
												</div>
												<c:if test="${boardList.bwriter_email eq memberInfo.email || projectMemberInfo.pmadmin_num eq 1}">
													<div class="dropdown d-inline">
														<a role="button" data-toggle="dropdown" data-bs-display="static" aria-expanded="false">
															<i class="fas fa-ellipsis-v" id="projectSet"></i>
														</a>
														<div class="dropdown-menu dropdown-menu-end dropdown-menu-lg-start modify_menu_box" aria-labelledby="boardMenu">
															<c:if test="${boardList.bwriter_email eq memberInfo.email}">
																<c:forEach items="${boardList.textList}" var="textList">
																	<div onclick="modifyText(${boardList.bno})" class="dropdown-item" data-toggle="modal" data-target="#modifyText" style="cursor: pointer;">
																		<i class="fas fa-pencil-alt modifyText_btn"></i> 게시물 수정
																	</div>
																</c:forEach>
															</c:if>
															<c:if test="${boardList.bwriter_email eq memberInfo.email}">
																<c:forEach items="${boardList.taskList}" var="taskList">
																	<div onclick="modifyTask(${boardList.bno})" class="dropdown-item" data-toggle="modal" data-target="#modifyTask" style="cursor: pointer;">
																		<i class="fas fa-pencil-alt"></i> 게시물 수정
																	</div>
																</c:forEach>
															</c:if>
															<c:if test="${boardList.bwriter_email eq memberInfo.email}">
																<c:forEach items="${boardList.scheduleList}" var="scheduleList">
																	<div onclick="modifySchedule(${boardList.bno})" class="dropdown-item" data-toggle="modal" data-target="#modifySchedule" style="cursor: pointer;">
																		<i class="fas fa-pencil-alt"></i> 게시물 수정
																	</div>
																</c:forEach>
															</c:if>
															<c:choose>
																<c:when test="${boardList.bwriter_email eq memberInfo.email}">
																	<form action="/deleteBoard" method="post">
																		<input type="hidden" name="bno" value="${boardList.bno}">
																		<button class="dropdown-item" type="submit">
																			<i class="far fa-trash-alt"></i> 게시물 삭제
																		</button>
																	</form>
																</c:when>
																<c:when test="${projectMemberInfo.pmadmin_num eq 1}">
																	<form action="/deleteBoard" method="post">
																		<input type="hidden" name="bno" value="${boardList.bno}">
																		<button class="dropdown-item" type="submit">
																			<i class="far fa-trash-alt"></i> 게시물 삭제
																		</button>
																	</form>
																</c:when>
															</c:choose>
														</div>
													</div>
												</c:if>
											</div>
										</div>
										<br>
										<h4>
											<c:forEach items="${boardList.textList}" var="textList">
												<c:out value="${textList.text_title}" />
											</c:forEach>
											<c:forEach items="${boardList.taskList}" var="taskList">
												<c:out value="${taskList.task_title}" />
											</c:forEach>
											<c:forEach items="${boardList.scheduleList}" var="scheduleList">
												<c:out value="${scheduleList.schedule_title}" />
											</c:forEach>
										</h4>
										<hr>
										<div class="boardBody">
											<c:forEach items="${boardList.textList}" var="textList">
												<div class="board_text_content">${fn:replace(textList.text_content, replaceChar,"<br/>")}</div>
												<c:forEach items="${boardList.bfileList}" var="bfileList">
													<div class="card fileBox">
														<div class="card-body fileMain" style="padding: 0;">
															<div class="file"></div>
															<div class="fileInfo">
																<p class="fileName">
																	<c:out value="${bfileList.org_bfile_name}" />
																</p>
																<p class="fileSize">
																	<c:out value="${bfileList.bfile_size}.KB" />
																</p>
															</div>
															<form action="bfileDown" method="post">
																<input type="hidden" value="${bfileList.bfile_no}" name="bfile_no">
																<button type="submit" class="fileDown" style="background-color: white">
																	<i class="fas fa-arrow-down"></i>
																</button>
															</form>
														</div>
													</div>
												</c:forEach>
											</c:forEach>
											<c:forEach items="${boardList.taskList}" var="taskList">
												<div class="board_task_content">${fn:replace(taskList.task_content, replaceChar,"<br/>")}</div>
												<c:choose>
													<c:when test="${taskList.task_status eq 1}">
														<div class="board_stts">
															<div class="board_stts_header">업무상태</div>
															<div class="board_request_div stts_check" stts="1">요청</div>
														</div>
													</c:when>
													<c:when test="${taskList.task_status eq 2}">
														<div class="board_stts">
															<div class="board_stts_header">업무상태</div>
															<div class="board_progress_div stts_check" stts="2">진행</div>
														</div>
													</c:when>
													<c:when test="${taskList.task_status eq 3}">
														<div class="board_stts">
															<div class="board_stts_header">업무상태</div>
															<div class="board_completion_div stts_check" stts="3">완료</div>
														</div>
													</c:when>
													<c:when test="${taskList.task_status eq 4}">
														<div class="board_stts">
															<div class="board_stts_header">업무상태</div>
															<div class="board_hold_div stts_check" stts="4">보류</div>
														</div>
													</c:when>
												</c:choose>
												<c:choose>
													<c:when test="${taskList.task_priority eq 1}">
														<div class="board_prrt">
															<div class="board_prrt_header">우선순위</div>
															<div class="board_l_div prrt_check" prrt="1">낮음</div>
														</div>
													</c:when>
													<c:when test="${taskList.task_priority eq 2}">
														<div class="board_prrt">
															<div class="board_prrt_header">우선순위</div>
															<div class="board_u_div prrt_check" prrt="2">보통</div>
														</div>
													</c:when>
													<c:when test="${taskList.task_priority eq 3}">
														<div class="board_prrt">
															<div class="board_prrt_header">우선순위</div>
															<div class="board_h_div prrt_check" prrt="3">높음</div>
														</div>
													</c:when>
													<c:when test="${taskList.task_priority eq 4}">
														<div class="board_prrt">
															<div class="board_prrt_header">우선순위</div>
															<div class="board_e_div prrt_check" prrt="4">긴급</div>
														</div>
													</c:when>
												</c:choose>
												<div class="start_day">
													<span>시작일</span>
													<fmt:formatDate pattern="yyyy/MM/dd" value="${taskList.task_start}" />
													<span>부터</span>
												</div>
												<div class="deadline_day">
													<span>마감일</span>
													<fmt:formatDate pattern="yyyy/MM/dd" value="${taskList.task_last}" />
													<span>까지</span>
												</div>
												<c:forEach items="${boardList.bfileList}" var="bfileList">
													<div class="card fileBox">
														<div class="card-body fileMain" style="padding: 0;">
															<div class="file"></div>
															<div class="fileInfo">
																<p class="fileName">
																	<c:out value="${bfileList.org_bfile_name}" />
																</p>
																<p class="fileSize">
																	<c:out value="${bfileList.bfile_size}.KB" />
																</p>
															</div>
															<form action="bfileDown" method="post">
																<input type="hidden" value="${bfileList.bfile_no}" name="bfile_no">
																<button type="submit" class="fileDown">
																	<i class="fas fa-arrow-down"></i>
																</button>
															</form>
														</div>
													</div>
												</c:forEach>
											</c:forEach>
											<c:forEach items="${boardList.scheduleList}" var="scheduleList">
												<div class="board_schedule_content">${fn:replace(scheduleList.schedule_content, replaceChar,"<br/>")}</div>
												<c:if test="${! empty scheduleList.schedule_location}">
													<div style="color: #999; font-weight: bold; margin-bottom: 10px;">
														<i class="fas fa-map-marker-alt"></i> <span> <c:out value="${scheduleList.schedule_location}" />
														</span>
													</div>
												</c:if>
												<div class="start_day">
													<span>시작일</span>
													<fmt:formatDate pattern="yyyy/MM/dd" value="${scheduleList.schedule_start}" />
													<span>부터</span>
												</div>
												<div class="deadline_day">
													<span>마감일</span>
													<fmt:formatDate pattern="yyyy/MM/dd" value="${scheduleList.schedule_last}" />
													<span>까지</span>
												</div>
											</c:forEach>
										</div>
										<div class="boardFooter">
											<div class="like_count_div">
												<i class="fas fa-heart" style="color: red;"></i>
												<div id="boardLike${boardList.bno}" style="display: inline-block;">${boardList.blike}</div>
											</div>
											<div class="likeBookmark">
												<button class="boardLikeBtn boardLikeBtn${boardList.bno}" value="${boardList.bno}">
													<i class="fas fa-heart" style="color: red;"></i> 좋아요
												</button>
												<button class="bookmarkBtn" value="${boardList.bno}">
													<i class="far fa-bookmark"></i><span> 북마크</span>
												</button>
											</div>
										</div>
									</div>
									<div class="card-footer replyBox">
										<c:forEach items="${boardList.replyList}" var="replyList" varStatus="status">
											<c:if test="${!empty boardList.replyList}">
												<c:if test="${status.count > 3}">
													<c:if test="${status.last}">
														<p class="prevReply" style="display: inline-block;" data-toggle="modal" data-target="#replyView${boardList.bno}">이전 댓글 더보기</p>
													</c:if>
												</c:if>
												<c:if test="${status.last}">
													<p class="boardReply">댓글 ${status.count}</p>
												</c:if>
											</c:if>
										</c:forEach>
										<br>
										<c:forEach items="${boardList.replyList}" var="replyList" varStatus="status" begin="0" end="2">
											<div class="replyMain">
												<div class="profile"></div>
												<div class="replyBody">
													<p class="replyBody_p">
														<span><c:out value="${replyList.reply_writer}" /></span> <span class="writeDate"><fmt:formatDate pattern="yyyy/MM/dd" value="${replyList.reply_date}" /></span>
														<c:if test="${replyList.rwriter_email eq memberInfo.email}">
															<span class="delete_reply" value="${replyList.reply_no }">삭제</span>
															<span class="modify_reply">수정</span>
															<div class="modify_reply_modal">
																<form action="/modifyReply" class="modifyReplyForm" method="post" enctype="multipart/form-data">
																	<input type="hidden" name="reply_no" value="${replyList.reply_no }">
																	<input type="text" name="reply_content" class="modify_reply_content_input" value="${replyList.reply_content }" placeholder="입력은 Enter 입니다.">
																</form>
															</div>
														</c:if>
													</p>
													<p>
														<c:out value="${replyList.reply_content}" />
													</p>
													<c:forEach items="${replyList.rfileList}" var="rfileList">
														<div class="card fileBox">
															<div class="card-body fileMain" style="padding: 0;">
																<div class="file"></div>
																<div class="fileInfo">
																	<p class="fileName">
																		<c:out value="${rfileList.org_rfile_name}" />
																	</p>
																	<p class="fileSize">
																		<c:out value="${rfileList.rfile_size}.KB" />
																	</p>
																</div>
																<form action="rfileDown" method="post">
																	<input type="hidden" value="${rfileList.rfile_no}" name="rfile_no">
																	<button type="submit" class="fileDown" style="background-color: white">
																		<i class="fas fa-arrow-down"></i>
																	</button>
																</form>
															</div>
														</div>
													</c:forEach>
												</div>
											</div>
											<hr>
										</c:forEach>
										<!-- 댓글 전체 modal -->
										<div class="modal fade" id="replyView${boardList.bno}" tabindex="-1" aria-labelledby="replyView" aria-hidden="true">
											<div class="modal-dialog modal-dialog-centered modal-lg">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="replyView">댓글</h5>
														<button type="button" class="close" data-dismiss="modal" aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>
													<div class="modal-body">
														<div class="form-group">
															<c:forEach items="${boardList.replyList}" var="replyList" varStatus="status" begin="0">
																<div class="replyMain">
																	<div class="profile"></div>
																	<div class="replyBody">
																		<p>
																			<span><c:out value="${replyList.reply_writer}" /></span> <span class="writeDate"><fmt:formatDate pattern="yyyy/MM/dd" value="${replyList.reply_date}" /></span>
																		</p>
																		<p>
																			<c:out value="${replyList.reply_content}" />
																		</p>
																		<c:forEach items="${replyList.rfileList}" var="rfileList">
																			<div class="card fileBox">
																				<div class="card-body fileMain" style="padding: 0;">
																					<div class="file"></div>
																					<div class="fileInfo">
																						<p class="fileName">
																							<c:out value="${rfileList.org_rfile_name}" />
																						</p>
																						<p class="fileSize">
																							<c:out value="${rfileList.rfile_size}.KB" />
																						</p>
																					</div>
																					<form action="rfileDown" method="post">
																						<input type="hidden" value="${rfileList.rfile_no}" name="rfile_no">
																						<button type="submit" class="fileDown" style="background-color: white">
																							<i class="fas fa-arrow-down"></i>
																						</button>
																					</form>
																				</div>
																			</div>
																		</c:forEach>
																	</div>
																</div>
																<hr>
															</c:forEach>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!-- 댓글 전체 modal 끝 -->
										<div class="replyWrite">
											<!-- 댓글 작성 -->
											<div class="profile"></div>
											<div class="card replyWriteBox">
												<div class="card-body replyWriteMain">
													<form action="/writeReply" class="writeReplyForm" method="post" enctype="multipart/form-data">
														<input type="hidden" name="reply_writer" value="${memberInfo.name }">
														<input type="hidden" name="rwriter_email" value="${memberInfo.email }">
														<input type="hidden" name="bno" value="${boardList.bno}">
														<input type="text" name="reply_content" class="reply_content_input" placeholder="입력은 Enter 입니다.">
														<input type="file" name="file" class="reply_input-file" class="upload-hidden">
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
							<!--paginate -->
							<nav id="paginate" aria-label="Page navigation">
								<ul class="pagination">
									<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="movePage(1,${pagination.cntPerPage},${pagination.pageSize});"> &lt;&lt; </a>
									<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasPreviousPage == true}">-1</c:if>,${pagination.cntPerPage},${pagination.pageSize});"> &lt; </a> <c:forEach begin="${pagination.firstPage}" end="${pagination.lastPage}" var="idx">
											<li class="page-item"><a class="page-link" style="color:<c:out value="${pagination.currentPage == idx ? '#cc0000; font-weight:700; margin-bottom: 2px;' : ''}"/> " href="javascript:void(0);" onclick="movePage(${idx},${pagination.cntPerPage},${pagination.pageSize});">
													<c:out value="${idx}" />
												</a>
										</c:forEach>
									<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasNextPage == true}">+1</c:if>,${pagination.cntPerPage},${pagination.pageSize});"> &gt; </a>
									<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="movePage(${pagination.totalRecordCount},${pagination.cntPerPage},${pagination.pageSize});"> &gt;&gt; </a>
								</ul>
							</nav>
							<!-- /paginate -->
						</c:if>
					</div>
					<div class="memberListBox">
						<div class="memberListMain">
							<div class="memberListBox-body">
								<div class="member-section">
									<h4 class="section-title">
										<span><strong>참여자</strong></span> <span id="participantCount">${projectMemberCount}</span>
									</h4>
									<div class="feed-area">
										<button data-toggle="modal" data-target="#allMember" class="all-btn">전체보기</button>
									</div>
								</div>
								<div class="participantArea">
									<div class="participantScrollArea">
										<div class="participants-title">프로젝트 관리자</div>
										<c:forEach items="${projectMemberList}" var="projectMemberList">
											<c:if test="${projectMemberList.pmadmin_num eq 1}">
												<li class="listLi">
													<div class="listLi_div">
														<div style="width: 40px; height: 40px; background: black; display: inline-block;"></div>
														<div class="projectMember_info">
															<div>
																<strong>${projectMemberList.name}</strong>
															</div>
														</div>
													</div>
												</li>
											</c:if>
										</c:forEach>
										<div class="participants-title">참여자</div>
										<c:forEach items="${projectMemberList}" var="projectMemberList">
											<c:if test="${projectMemberList.pmadmin_num eq 0}">
												<li class="listLi">
													<div class="listLi_div">
														<div style="width: 40px; height: 40px; background: black; display: inline-block;"></div>
														<div class="projectMember_info">
															<div>
																<strong>${projectMemberList.name}</strong>
															</div>
														</div>
													</div>
												</li>
											</c:if>
										</c:forEach>
										<input type="hidden" class="pmi_email" value="${projectMemberInfo.email }">
										<input type="hidden" class="pmi_admin_num" value="${projectMemberInfo.pmadmin_num }">
									</div>
									<div class="chatBox">
										<i class="far fa-comment-dots"></i> 채팅
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="cover-bar"></div>
			</div>
			<div id="chatBot">챗봇 api</div>
			<!-- ------------ -->
		</div>
	</main>
	<div class="modal fade" id="allMember">
		<div class="modal-dialog modal-dialog-centered allMember-modal">
			<div class="modal-content makeProject-modal-content">
				<!-- Modal body -->
				<div class="reload_modal">
					<div class="modal-body allMember-modal-body">
						<div class="member-management">
							<span>참여자 관리</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="member-search">
							<i class="bi bi-search searchBtn"></i>
							<input type="text" class="member-search-input" placeholder="참여자명으로 검색">
						</div>
						<div class="allMember-modal-memberList">
							<ul class="memberList-ul">
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- modal closed-->
	<div class="modal fade" id="writeText" tabindex="-1" aria-labelledby="writeTextLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content write_content">
				<div class="modal-header">
					<h5 class="modal-title" id="writeTextLabel">
						<strong>글 작성</strong>
					</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="/writeText" method="post" id="writeTextForm" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="bidentifier" value="1">
						<input type="hidden" name="pno" value="${projectInfo.pno }">
						<input type="hidden" name="bwriter" value="${memberInfo.name }">
						<input type="hidden" name="bwriter_email" value="${memberInfo.email }">
						<div class="form-group">
							<input name="text_title" type="text" id="text_title" placeholder="제목을 입력하세요.">
							<textarea name="text_content" id="text_content" placeholder="내용을 입력하세요."></textarea>
							<div class="file-upload preview-image">
								<input type="text" class="upload-name" value="파일선택" disabled="disabled">
								<label for="input-file" style="margin-bottom: 0;"><i class="fas fa-paperclip"></i></label>
								<input type="file" name="file" id="input-file" class="upload-hidden">
							</div>
						</div>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="modal_submit smallBtn">올리기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="modal fade" id="writeTask" tabindex="-1" aria-labelledby="writeTaskLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content write_content">
				<div class="modal-header">
					<h5 class="modal-title" id="writeTaskLabel">
						<strong>업무 작성</strong>
					</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="/writeTask" method="post" id="writeTaskForm" enctype="multipart/form-data">
						<input type="hidden" name="bidentifier" value="2">
						<input type="hidden" name="pno" value="${projectInfo.pno }">
						<input type="hidden" name="bwriter" value="${memberInfo.name }">
						<input type="hidden" name="bwriter_email" value="${memberInfo.email }">
						<input type="hidden" name="task_status" id="task_status_checked" value="0">
						<input type="hidden" name="task_priority" id="task_priority_checked" value="0">
						<div class="form-group">
							<input name="task_title" type="text" class="form-control" id="task_title" placeholder="제목을 입력하세요.">
							<textarea name="task_content" id="task_content" placeholder="내용을 입력하세요."></textarea>
							<div class="task_file-upload task_preview-image">
								<input type="text" class="task_upload-name" value="파일선택" disabled="disabled">
								<label for="task_input-file" style="margin-bottom: 0;"><i class="fas fa-paperclip"></i></label>
								<input type="file" name="file" id="task_input-file" class="task_upload-hidden">
							</div>
							<hr>
							<div class="radio_div">
								<span class="stts_addBtn">업무상태 추가</span>
								<div class="stts_add">
									<div class="request_div" stts="1">요청</div>
									<div class="progress_div" stts="2">진행</div>
									<div class="completion_div" stts="3">완료</div>
									<div class="hold_div" stts="4">보류</div>
								</div>
							</div>
							<br>
							<div class="radio_div">
								<span class="prrt_addBtn">우선순위 추가</span>
								<div class='prrt_add'>
									<div class="l_div" prrt="1">낮음</div>
									<div class="u_div" prrt="2">보통</div>
									<div class="h_div" prrt="3">높음</div>
									<div class="e_div" prrt="4">긴급</div>
								</div>
							</div>
							<div style="margin-top: 35px;">
								<hr>
								<label for="task_start" class="col-form-label">시작일</label>
								<input name="task_start" type="date" class="form-control" id="task_start"></input>
								<label for="task_last" class="col-form-label">마감일</label>
								<input name="task_last" type="date" class="form-control" id="task_last"></input>
							</div>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="submit" class="modal_submit smallBtn">올리기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="writeSchedule" tabindex="-1" aria-labelledby="writeScheduleLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content write_content">
				<div class="modal-header">
					<h5 class="modal-title" id="writeScheduleLabel">
						<strong>일정 작성</strong>
					</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="/writeSchedule" method="post" id="writeScheduleForm">
						<input type="hidden" name="bidentifier" value="3">
						<input type="hidden" name="pno" value="${projectInfo.pno }">
						<input type="hidden" name="bwriter" value="${memberInfo.name }">
						<input type="hidden" name="bwriter_email" value="${memberInfo.email }">
						<div class="form-group">
							<input name="schedule_title" type="text" class="form-control" id="schedule_title" placeholder="제목을 입력하세요.">
							<textarea name="schedule_content" id="schedule_content" placeholder="내용을 입력하세요."></textarea>
							<hr>
							<input type="hidden" id="postcode" placeholder="우편번호">
							<input type="hidden" id="address" placeholder="주소">
							<input type="hidden" id="detailAddress" placeholder="상세주소">
							<input type="hidden" id="extraAddress" placeholder="참고항목">
							<label for="schedule_location" class="col-form-label">장소</label>
							<input name="schedule_location" type="text" class="form-control" onclick="execDaumPostcode()" id="schedule_location" readonly="readonly" style="background-color: white;"></input>
							<hr>
							<label for="schedule_start" class="col-form-label">시작일</label>
							<input name="schedule_start" type="datetime-local" class="form-control" id=schedule_start></input>
							<label for="schedule_last" class="col-form-label">마감일</label>
							<input name="schedule_last" type="datetime-local" class="form-control" id="schedule_last"></input>
						</div>
						<div class="modal-footer">
							<button type="submit" class="modal_submit smallBtn">올리기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal" id="modifyProject">
		<div class="modal-dialog modal-dialog-centered modifyProject-modal">
			<div class="modal-content modifyProject-modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h6 class="modal-title">프로젝트 수정</h6>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form action="/modifyProject" method="post" id="modifyProjectForm">
						<!-- Project name input-->
						<div class="form-project">
							<input class="projectTitleInput modifyPname" id="pname" type="text" name="pname" value="${projectInfo.pname }" placeholder="제목을 입력하세요" />
						</div>
						<br>
						<!-- Project description  input-->
						<div class="form-project">
							<textarea class="projectContentsInput modifyPdescription" id="pdescription" name="pdescription" placeholder="프로젝트에 관한 설명(옵션)">${projectInfo.pdescription}</textarea>
							<br>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<!-- Submit Button-->
							<div class="make-button">
								<button class="modal_submit smallBtn" type="submit">수정하기</button>
							</div>
						</div>
						<!-- modal-footer closed-->
					</form>
					<!-- /makeProject closed-->
				</div>
			</div>
		</div>
	</div>
	<!-- 글 수정 -->
	<div class="modal fade" id="modifyText" tabindex="-1" aria-labelledby="modifyTextLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modifyTextLabel">게시물 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="/modifyText" method="post" id="modifyTextForm" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" id="modify_text_bno" name="bno">
						<div class="form-group">
							<input name="text_title" type="text" id="modify_text_title" placeholder="제목을 입력하세요.">
							<textarea name="text_content" id="modify_text_content" placeholder="내용을 입력하세요."></textarea>
							<!-- <div class="file-upload preview-image">
                         <input type="text" id ="modify_bfile_name" class="upload-name" value="파일선택">
                           <label for="input-file" style="margin-bottom:0;"><i class="fas fa-paperclip"></i></label> 
                         <input type="file" name="file" id="input-file" class="upload-hidden">
                     </div> -->
						</div>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="modal_submit smallBtn">올리기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 업무 수정 -->
	<!-- 업무 수정 -->
	<div class="modal fade" id="modifyTask" tabindex="-1" aria-labelledby="modifyTaskLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modifyTaskLabel">게시물 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="/modifyTask" method="post" id="modifyTaskForm" enctype="multipart/form-data">
					<div class="modal-body">
						<%-- <input type="hidden" name="bidentifier" value="1">
                  <input type="hidden" name="pno" value="${projectInfo.pno }">
                  <input type="hidden" name="bwriter" value="${memberInfo.name }"> --%>
						<input type="hidden" id="modify_task_bno" name="bno">
						<div class="form-group">
							<input name="task_title" type="text" id="modify_task_title" placeholder="제목을 입력하세요.">
							<textarea name="task_content" id="modify_task_content" placeholder="내용을 입력하세요."></textarea>
							<div class="radio_div">
								<span class="stts_addBtn">업무상태 추가</span>
								<div class="stts_add">
									<div class="request_div" stts="1">요청</div>
									<div class="progress_div" stts="2">진행</div>
									<div class="completion_div" stts="3">완료</div>
									<div class="hold_div" stts="4">보류</div>
								</div>
							</div>
							<br>
							<div class="radio_div">
								<span class="prrt_addBtn">우선순위 추가</span>
								<div class='prrt_add'>
									<div class="l_div" prrt="1">낮음</div>
									<div class="u_div" prrt="2">보통</div>
									<div class="h_div" prrt="3">높음</div>
									<div class="e_div" prrt="4">긴급</div>
								</div>
							</div>
							<div style="margin-top: 35px;">
								<hr>
								<label for="task_start" class="col-form-label">시작일</label>
								<input name="task_start" type="datetime-local" class="form-control" id="modify_task_start"></input>
								<label for="task_last" class="col-form-label">마감일</label>
								<input name="task_last" type="datetime-local" class="form-control" id="modify_task_last"></input>
							</div>
						</div>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="modal_submit smallBtn">올리기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 일정 수정 -->
	<div class="modal fade" id="modifySchedule" tabindex="-1" aria-labelledby="modifySchedule" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modifySchedule">게시물 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="/modifySchedule" method="post" id="modifyScheduleForm" enctype="multipart/form-data">
						<input type="hidden" id="modify_schedule_bno" name="bno">
						<div class="form-group">
							<input name="schedule_title" type="text" class="form-control" id="modify_schedule_title" placeholder="제목을 입력하세요.">
							<textarea name="schedule_content" id="modify_schedule_content" placeholder="내용을 입력하세요."></textarea>
							<hr>
							<input type="hidden" id="postcode" placeholder="우편번호">
							<input type="hidden" id="address" placeholder="주소">
							<input type="hidden" id="detailAddress" placeholder="상세주소">
							<input type="hidden" id="extraAddress" placeholder="참고항목">
							<label for="schedule_location" class="col-form-label">장소</label>
							<input name="schedule_location" type="text" class="form-control" onclick="execDaumPostcode()" id="modify_schedule_location" readonly="readonly" style="background-color: white;"></input>
							<hr>
							<label for="schedule_start" class="col-form-label">시작일</label>
							<input name="schedule_start" type="datetime-local" class="form-control" id=modify_schedule_start></input>
							<label for="schedule_last" class="col-form-label">마감일</label>
							<input name="schedule_last" type="datetime-local" class="form-control" id="modify_schedule_last"></input>
						</div>
						<!-- Modal footer -->
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" class="modal_submit smallBtn">올리기</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
document.getElementById('task_start').value = new Date().toISOString().slice(0, 16);
document.getElementById('task_last').value = new Date().toISOString().slice(0, 16);

document.getElementById('schedule_start').value = new Date().toISOString().slice(0, 16);
document.getElementById('schedule_last').value = new Date().toISOString().slice(0, 16);

//페이지네이션

  //10,20,30개씩 selectBox 클릭 이벤트
  	function changeSelectBox(currentPage, cntPerPage, pageSize){
  	    var selectValue = $("#cntSelectBox").children("option:selected").val();
  	    movePage(currentPage, selectValue, pageSize);
  	    
  	}
  	 
  	//페이지 이동
  	function movePage(currentPage, cntPerPage, pageSize){
  	    var url = "${pageContext.request.contextPath}/projectHomePage";
  	    url = url + "?currentPage="+currentPage;
  	    url = url + "&cntPerPage="+cntPerPage;
  	    url = url + "&pageSize="+pageSize;
  	    
  	    location.href=url;
  	}
  	
</script>
</html>