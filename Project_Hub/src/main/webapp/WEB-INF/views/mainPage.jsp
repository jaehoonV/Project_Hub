<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- jstl c태그 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 라이브러리 코드 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MainPage</title>
<link href="/resources/css/mainPage.css" rel="stylesheet" />
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<!-- 부트스트랩 아이콘cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script
   src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery.validate 플러그인 삽입 -->
<script
   src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<script type="text/javascript">

$(function () {
	
	$('#sort_menu_d').click(function(){
		console.log('sort_menu_d click');
		$('#sort_menu_a').removeClass('select_sort_menu');
		$('#sort_menu_d').addClass('select_sort_menu');
	});
	
	$('#sort_menu_a').click(function(){
		console.log('sort_menu_a click');
		$('#sort_menu_d').removeClass('select_sort_menu');
		$('#sort_menu_a').addClass('select_sort_menu');
	});
	
	$('#sort_menu_m').click(function(){
		console.log('sort_menu_m click');
		$('#sort_menu_p').removeClass('select_sort_menu');
		$('#sort_menu_m').addClass('select_sort_menu');
		$('.loadlist').hide();
		$('.loadlist1').hide();
		$('.loadlist2').show();
		$('.loadlist3').show();
		$('.apply_modal').css({opacity:0}).animate({opacity:1},1200);
		$('.apply_modal').css({opacity:1}).animate({opacity:0},700);
		
	});
	
	$('#sort_menu_p').click(function(){
		console.log('sort_menu_p click');
		$('#sort_menu_m').removeClass('select_sort_menu');
		$('#sort_menu_p').addClass('select_sort_menu');
		$('.loadlist2').hide();
		$('.loadlist3').hide();
		$('.loadlist').show();
		$('.loadlist1').show();
		$('.apply_modal').css({opacity:0}).animate({opacity:1},1200);
		$('.apply_modal').css({opacity:1}).animate({opacity:0},700);
	});
});
	
	function favoriteButton(pno) {
		event.stopPropagation();
		console.log(pno);
		
		$('.apply_modal').css({opacity:0}).animate({opacity:1},1200);
		$('.apply_modal').css({opacity:1}).animate({opacity:0},700);
		
		
		$.ajax({
			type: "POST",   
			url: "/clickFavorite",   //데이터를 주고받을 파일 주소
			dataType : "json",
			data: "pno="+pno,
			cache: false,
			async: false,
			success : function(data){   //파일 주고받기가 성공했을 경우. data 변수 안에 값을 담아온다.
				console.log("clickFavorite ajax success data = "+ data);
			
				$('.loadlist').load(window.location.href+' .loadlist');
				$('.loadlist1').load(window.location.href+' .loadlist1');
				$('.loadlist2').load(window.location.href+' .loadlist2');
				$('.loadlist3').load(window.location.href+' .loadlist3');
				
			}
		});
		
		$.ajax({
			type: "GET",   
			url: "/pListFavorite",   //데이터를 주고받을 파일 주소
			dataType: "json",
			async: false,
			success : function(data){   //파일 주고받기가 성공했을 경우. data 변수 안에 값을 담아온다.
				console.log("pListFavorite ajax success data = "+ data);
				if(data == 0){
					$("#pList-header-favorite").hide("slow");
					
				} else{
					$("#pList-header-favorite").show("slow");
				}	
				
			}
		});
	}

	function move(pno){
		
		 var f = document.homePage;

	      // form 태그의 하위 태그 값 매개 변수로 대입
	      f.pno.value = pno;
		  
	      // input태그의 값들을 전송하는 주소
	      f.action = "/projectHomePage"

	      // 전송 방식 : post
	      f.method = "post"
	      f.submit();
	};

   $(document).ready(function() {
	   
	   $('.loadlist2').hide();
	   $('.loadlist3').hide();
	   
	   $.ajax({
			type: "GET",   
			url: "/projectCount",   //데이터를 주고받을 파일 주소
			dataType: "json",
			async: false,
			success : function(data){   //파일 주고받기가 성공했을 경우. data 변수 안에 값을 담아온다.
				console.log("pListFavorite ajax success data = "+ data);
				if(data == 0){
					$("#pList-header-favorite").hide();
					
				} else{
					$("#pList-header-favorite").show();
				}	
				
			}
		});
	   
	   $.ajax({
			type: "GET",   
			url: "/pListFavorite",   //데이터를 주고받을 파일 주소
			dataType: "json",
			async: false,
			success : function(data){   //파일 주고받기가 성공했을 경우. data 변수 안에 값을 담아온다.
				console.log("pListFavorite ajax success data = "+ data);
				if(data == 0){
					$("#pList-header-favorite").hide();
					
				} else{
					$("#pList-header-favorite").show();
				}	
			}
		});

      /* 프로젝트 제목 null 방지 */
      $('#makeProjectForm').validate({
         rules : {
            pname : {
               required : true
            }
         },
         messages : {
            pname : {
               required : "프로젝트 제목을 입력해 주세요."
            }
         },
         submitHandler : function() { //유효성 검사를 통과시 전송
        	 makeProjectForm.submit();
         },
         success : function(e) {
            //
         }
      });//end validate()

      //modal 닫을 때 input 초기화
      $('#makeProject').on('hidden.bs.modal', function() {
         $('input').val(null);
         $('label.error').css('display', 'none');
      });
      
      $('.profilebtn-modify').click(function(){
     	 $("#myProfile").modal("hide");
     	 $('#mySetting').modal("show");
       });
       
      $('.fa-edit, .pw-btn').click(function() {
  		$(this).closest("div").removeClass("d-block")
  		$(this).closest("div").next("div").addClass("d-block")		
  	});
        
        $('.cancel-change').click(function() {
      	$('input').val(null);
       	$(this).closest("div").removeClass("d-block")
    		$(this).closest("div").prev("div").addClass("d-block")
  	});
        
        $('#mySetting').on('hidden.bs.modal', function() {
      	$('input').val(null);
      	console.log('mySetting modal close');
      	$(".defaultview").addClass("d-block")
      	$(".editview").removeClass("d-block")
      });
        
        let valueId='';
        let valueById='';
        
        $('.ch-confirm-btn').click(function() {
            console.log('.ch-confirm-btn clicked')
            valueId = $(this).siblings("input").attr('id');
            console.log('valueId >>>>> ' + valueId);
            valueById = $('#' + valueId).val();
            console.log('valueById >>>>> ' + valueById);
            
           $.validator.addMethod("regex", function(value, element, regexp) {
             let re = new RegExp(regexp);
             let res = re.test(value);
             return res;
          });
            
           switch (valueId) {
    	     case "change_name":
            /* 회원정보 수정 이름 null 방지 */
               $('#change_name_box').validate({
                   rules : { 
                      change_name : {
                         required : true
                      }
                   },
                   messages : {
                      change_name : {
                         required : "이름을 입력하세요.",
                      }
                   },
                   submitHandler : function() { //유효성 검사를 통과시 전송
                       console.log("change_name_box submit >>>>>> "+valueId+valueById);
                   user_modify();             
                    }
                });//end validate()
            break;
         case "change_company_name":
      	   $('#change_cmpname_box').validate({
                 rules : {
              	   change_company_name : {
                       required : false
                    }
                 },
                 messages : {
              	   change_company_name : {
                       required : "회사명을 입력하세요.",
                    }
                 },
                 submitHandler : function() { //유효성 검사를 통과시 전송
                 user_modify();             
                  }
              });//end validate()
            break;
         case "change_job_position":
      	   $('#change_jobp_box').validate({
                 rules : {
              	   change_job_position : {
                       required : false
                    }
                 },
                 messages : {
              	   change_job_position : {
                       required : "직급을 입력하세요.",
                    }
                 },
                 submitHandler : function() { //유효성 검사를 통과시 전송
                 user_modify();             
                  }
              });//end validate()
            break;
         case "change_phone_num":
            $('#change_phonen_box').validate({
                    rules : {
                       change_phone_num : {
                         required : false,
                         regex : "^(010|011)[-\\s]?\\d{3,4}[-\\s]?\\d{4}$"
                       }
                    },
                    messages : {
                       change_phone_num : {
                          regex : "010-0000-0000 형태로 입력하세요.",
                       }
                    },
                    submitHandler : function() { //유효성 검사를 통과시 전송
                       console.log('change_phonen_box validation'+ valueId + valueById);
                       user_modify();             
                     }
                 });//end validate()
            break;
         case "change_tel_num":
             $('#change_teln_box').validate({
                     rules : {
                        change_tel_num : {
                          required : false,
                           regex : "[-\\s]?\\d{2,3}[-\\s]?\\d{3,4}[-\\s]?\\d{4}$"
                        }
                     },
                     messages : {
                        change_tel_num : {
                           regex : "000-000-0000 형태로 입력하세요.",
                        }
                     },
                     submitHandler : function() { //유효성 검사를 통과시 전송
                        user_modify();             
                      }
                  });//end validate()
            break;
         }
             
            function user_modify () {
                 console.log("user_modify >>>>> " + valueId + valueById);
           $.ajax({
                type: "post",
                url : "/modify",
                cache : false,
                async : false,
                data : {
                    valueId : valueId ,
                    valueById : valueById 
                 },
                success : function (data){
                 afterModify(valueId,valueById);
                },
                error: function(error) {
                   console.log('error 전달됨')
                }
           });
          }; //user_modify end
          
     }); //$('.ch-confirm-btn').click(function() end
  		
  	let change_pw='';
  	let change_pwChk='';
  	
     $('#change_pw_btn').click(function() {
  	   console.log('#change_pw_btn clicked');
  	   change_pw = $('#change_pw').val();
  	   change_pwChk = $('#change_pwChk').val();
  	   console.log("change_pw, pwChk >>>> "+change_pw+'/'+change_pwChk);
  	   
  	   $('#change_pw_box').validate({
             rules : {
          	   change_pw : {
                  required : true,
                  rangelength : [ 8, 16 ]
                },
                change_pwChk: {
              	  required : true,
              	  equalTo : '#change_pw'
                },
             },
             messages : {
          	   change_pw : {
          		   required : "비밀번호를 입력하세요.",
          		   rangelength : "비밀번호는 {0}자에서 {1}자까지 사용 가능합니다."
             },
             change_pwChk: {
          	   required : "다시 한 번 입력하세요.",
          	   equalTo : "동일하게 입력하세요."
             },
             },
             submitHandler : function() { //유효성 검사를 통과시 전송
          	   pw_modify();             
              }
          });//end validate()

  	   	
  	   function pw_modify() {
  		   	console.log("pw_modify >>>>>");
  		   	console.log("change_pw >>>>>"+change_pw);
  		    	$.ajax({
  		   		type: "post",
  		           url : "/modify",
  		           cache : false,
  		           async : false,
  		           data : {
  		               valueId : 'change_pw',
  		               valueById : change_pw 
  		            },
  		           success : function (data){
  		            afterModify('change_pw',change_pw);
  		           },
  		           error: function(error) {
  		              console.log('error 전달됨')
  		           }
  		   	});
  		    	
  		   };

     }); //$('#change_pw_btn').click(function() end
           
           function afterModify(valueId, valueById){
              switch (valueId) {
               case "change_name":
                  $(".edit-adjust #username").html(valueById);
                  break;
               case "change_company_name":
                  $("#usercompany_name").html(valueById);
                  break;
               case "change_job_position":
                  $("#userjob_position").html(valueById);
                  break;
               case "change_phone_num":
                  $("#userphone_num").html(valueById);
                  break;
               case "change_tel_num":
                  $("#usertel_num").html(valueById);
                  break;
               };
               $('input').val(null);
              $(".defaultview").addClass("d-block");
              $(".editview").removeClass("d-block");
              $('.apply_modal').css({opacity:0}).animate({opacity:1},1200);
              $('.apply_modal').css({opacity:1}).animate({opacity:0},700);
              
           }; //function afterModify end
           
           $('#mySetting').on('hidden.bs.modal', function() {
             location.reload();
          });
         
});   
</script>
<style>
a {
	color: #212529;
	text-decoration: none;
	outline: none
}

a:hover, a:active, a:link, a:visited {
	text-decoration: none;
	color: #212529;
}
</style>
</head>
<body>
   <header>
      <nav class="topnav">
         <a class="topnav-brand" href="#" style="color:white">Project Hub</a>

         <ul class="topnav-nav">
            <li>
               <div class="btn-group">
                  <button type="button" data-toggle="dropdown" aria-expanded="false" id="profilebutton">
                    	 <div class="profile-default-button"></div></button>
                  <div class="dropdown-menu dropdown-menu-right">
                     <div class="user_info"><div class="user_profile"></div><div class="user_name"><strong>${memberInfo.name }</strong></div>
					 </div>
                     <button type="button" data-toggle="modal" data-target="#myProfile" class="myProfile"><i class="far fa-user"></i> 내 프로필</button> 
                     <button type="button" data-toggle="modal" data-target="#logout" class="logout"><i class="fas fa-sign-out-alt"></i> 로그아웃</button>   
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
                        <a href="/main" id="a_logo"> 
                        Project Hub
                        </a>
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
                        <button type="button" class="makeProjectbtn"
                           data-toggle="modal" data-target="#makeProject">새 프로젝트</button>
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
                        <a href="/main" style="color:white"> 내 프로젝트 </a>
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
							<button type="button" class="btn modal_cancel"
									data-dismiss="modal">취소</button>
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
							<br>
							<li class="edit-adjust"><div class="my-right-list-1">이름</div>
								<div class="my-right-list-2 defaultview d-block">
									<span id="username">${memberInfo.name }</span> <i
										class="far fa-edit"></i>
								</div>
								<div class="my-right-list-2 editview"
									id="change_name_box_div">
									<form id="change_name_box">
										<input id="change_name" type="text" name="change_name"
											value="${memberInfo.name }" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-confirm-btn" type="submit">확인</button>
									</form>
								</div></li>
							<br>
							<li class="edit-adjust"><div class="my-right-list-1">회사명</div>
								<div class="my-right-list-2 defaultview d-block">
									<span id="usercompany_name">${memberInfo.company_name }</span>
									<i class="far fa-edit"></i>
								</div>
								<div class="my-right-list-2 editview">
									<form id="change_cmpname_box">
										<input id="change_company_name" type="text"
											name="change_company_name"
											value="${memberInfo.company_name }" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-confirm-btn" type="submit">확인</button>
									</form>
								</div></li>
							<br>
							<li class="edit-adjust"><div class="my-right-list-1">직급</div>
								<div class="my-right-list-2 defaultview d-block">
									<span id="userjob_position">${memberInfo.job_position }</span>
									<i class="far fa-edit"></i>
								</div>
								<div class="my-right-list-2 editview">
									<form id="change_jobp_box">
										<input id="change_job_position" type="text"
											name="change_job_position"
											value="${memberInfo.job_position }" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-confirm-btn" type="submit">확인</button>
									</form>
								</div></li>
							<br>
							<li class="edit-adjust"><div class="my-right-list-1">휴대폰번호</div>
								<div class="my-right-list-2 defaultview d-block">
									<span id="userphone_num">${memberInfo.phone_num }</span> <i
										class="far fa-edit"></i>
								</div>
								<div class="my-right-list-2 editview">
									<form id="change_phonen_box">
										<input id="change_phone_num" type="text"
											name="change_phone_num" value="${memberInfo.phone_num }" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-confirm-btn" type="submit">확인</button>
									</form>
								</div></li>
							<br>
							<li class="edit-adjust"><div class="my-right-list-1">전화번호</div>
								<div class="my-right-list-2 defaultview d-block">
									<span id="usertel_num">${memberInfo.tel_num }</span> <i
										class="far fa-edit"></i>
								</div>
								<div class="my-right-list-2 editview">
									<form id="change_teln_box">
										<input id="change_tel_num" type="text" name="change_tel_num"
											value="${memberInfo.tel_num }" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-confirm-btn" type="submit">확인</button>
									</form>
								</div></li>
							<br>
							<li class="edit-adjust" id="passwordArea"><div
									class="my-right-list-1">비밀번호</div>
								<div class="my-right-list-2 defaultview d-block">
									<Strong>비밀번호 재설정이 가능합니다.</Strong>
									<button class="pw-btn">비밀번호 재설정</button>
								</div>
								<div class="my-right-list-2 editview">
									<form id="change_pw_box">
										<span>비밀번호</span><input id="change_pw" type="password"
											name="change_pw" /><br> <span>비밀번호 확인</span><input
											id="change_pwChk" type="password" name="change_pwChk" />
										<button class="cancel-change ch-btn" type="button">취소</button>
										<button class="ch-btn ch-pw-confirm-btn" id="change_pw_btn"
											type="submit">확인</button>
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
                        <input class="projectTitleInput" id="pname" type="text" name="pname"
                           placeholder="제목을 입력하세요" />
                     </div>
                     <br>
                     <!-- Project description  input-->
                     <div class="form-project">
                        <textarea class="projectContentsInput" id="pdescription"
                           name="pdescription" placeholder="프로젝트에 관한 설명(옵션)"></textarea>
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
            <div class="header_name"><strong>내 프로젝트</strong></div>
            <div class="right-menu">
            <div class="btn-group">
            	<button type="button" data-toggle="dropdown" aria-expanded="false" id="profilebutton">
                    <div class="sort-menu">
            		<img src="/resources/assets/img/sort.png" width="18px" height="18px" alt="sort"/>
            		</div>
            	</button>
                	<div class="dropdown-menu dropdown-menu-right sort-menu">
                    	<div id="sort_menu_a" class="select_sort_menu">오름차순(ㄱ ~ ㅎ)</div>
                    	<div id="sort_menu_d">내림차순(ㅎ ~ ㄱ)</div>
                    	<hr style="margin-top: 0.5rem; margin-bottom: 0.5rem;">
                    	<div id="sort_menu_p" class="select_sort_menu">내가 참여중인 프로젝트</div>
                    	<div id="sort_menu_m">내가 관리자인 프로젝트</div>
                  	</div>
               </div>
            	
            </div>
         </div>

         <div class="main-content">
            <form name="homePage">
            	<input type="hidden" name="pno"/>
            </form>
            <div class="pList">
            <div class="load-header-favorite"><strong id="pList-header-favorite">즐겨찾기</strong></div>
               <ul class="list">
               	<div class="loadlist1">
                  <c:forEach items="${projectList}" var="projectList">
                  	<c:if test="${projectList.pmfavorite eq 1}">
                	<li class="listLi">
                		<a href="#" onclick="move(${projectList.pno})" id="move-home">
                    	<div id="pmcolor">
                    	<c:choose>
                    			<c:when test="${projectList.pmcolor eq 'blue'}">
                    				<div id="bluediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'skyblue'}">
                    				<div id="skybluediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'emerald'}">
                    				<div id="emeralddiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'green'}">
                    				<div id="greendiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'yellow'}">
                    				<div id="yellowdiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'orange'}">
                    				<div id="orangediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'red'}">
                    				<div id="reddiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'pink'}">
                    				<div id="pinkdiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'purple'}">
                    				<div id="purplediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'darkgrey'}">
                    				<div id="darkgreydiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'lightgrey'}">
                    				<div id="lightgreydiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'black'}">
                    				<div id="blackdiv"></div>
                    			</c:when>
                    			<c:otherwise>
                    				<div>에러</div>
                    			</c:otherwise>
                    		</c:choose>
                    	</div>
                        <div class="pmfavorite">
                           <c:choose>
								<c:when test="${projectList.pmfavorite eq 1}"> <!-- pmfavorite이 1일 때 -->
									<div onclick="favoriteButton(${projectList.pno})" id="favoriteButton1">				
									<img src="/resources/assets/img/star.png" width="20px" height="20px" style="margin-bottom:5px" alt="star" id="star"/>
									</div>		
								</c:when>
							</c:choose>
                           </div>
                           <div class="pname"><strong><c:out value="${projectList.pname}"/></strong></div>
                           <div class="pCount"><i class="bi bi-person"></i><strong><c:out value="${projectList.pcount}"/></strong></div>
                         </a>
                     	</li>
                     	</c:if>
                 	 </c:forEach>
                  </div>
                  <div class="loadlist3">
                  <c:forEach items="${projectList}" var="projectList">
                  	<c:if test="${projectList.pmfavorite eq 1 and projectList.pmadmin_num eq 1}">
                	<li class="listLi">
                		<a href="#" onclick="move(${projectList.pno})" id="move-home">
                    	<div id="pmcolor">
                    	<c:choose>
                    			<c:when test="${projectList.pmcolor eq 'blue'}">
                    				<div id="bluediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'skyblue'}">
                    				<div id="skybluediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'emerald'}">
                    				<div id="emeralddiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'green'}">
                    				<div id="greendiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'yellow'}">
                    				<div id="yellowdiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'orange'}">
                    				<div id="orangediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'red'}">
                    				<div id="reddiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'pink'}">
                    				<div id="pinkdiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'purple'}">
                    				<div id="purplediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'darkgrey'}">
                    				<div id="darkgreydiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'lightgrey'}">
                    				<div id="lightgreydiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'black'}">
                    				<div id="blackdiv"></div>
                    			</c:when>
                    			<c:otherwise>
                    				<div>에러</div>
                    			</c:otherwise>
                    		</c:choose>
                    	</div>
                        <div class="pmfavorite">
                           <c:choose>
								<c:when test="${projectList.pmfavorite eq 1}"> <!-- pmfavorite이 1일 때 -->
									<div onclick="favoriteButton(${projectList.pno})" id="favoriteButton1">				
									<img src="/resources/assets/img/star.png" width="20px" height="20px" style="margin-bottom:5px" alt="star" id="star"/>
									</div>		
								</c:when>
							</c:choose>
                           </div>
                           <div class="pname"><strong><c:out value="${projectList.pname}"/></strong></div>
                           <div class="pCount"><i class="bi bi-person"></i><strong><c:out value="${projectList.pcount}"/></strong></div>
                         </a>
                     	</li>
                     	</c:if>
                 	 </c:forEach>
                  </div>
               </ul>
            <strong id="pList-header">참여중</strong>
               <ul class="list">
               	<div class="loadlist">
                  <c:forEach items="${projectList}" var="projectList">
                  <c:if test="${projectList.pmfavorite eq 0}">
                	<li class="listLi">
                		<a href="#" onclick="move(${projectList.pno})" id="move-home">
                    	<div id="pmcolor">
                    	<c:choose>
                    			<c:when test="${projectList.pmcolor eq 'blue'}">
                    				<div id="bluediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'skyblue'}">
                    				<div id="skybluediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'emerald'}">
                    				<div id="emeralddiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'green'}">
                    				<div id="greendiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'yellow'}">
                    				<div id="yellowdiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'orange'}">
                    				<div id="orangediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'red'}">
                    				<div id="reddiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'pink'}">
                    				<div id="pinkdiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'purple'}">
                    				<div id="purplediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'darkgrey'}">
                    				<div id="darkgreydiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'lightgrey'}">
                    				<div id="lightgreydiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'black'}">
                    				<div id="blackdiv"></div>
                    			</c:when>
                    			<c:otherwise>
                    				<div>에러</div>
                    			</c:otherwise>
                    		</c:choose>
                    	</div>
                        <div class="pmfavorite">
                           <c:choose>
								<c:when test="${projectList.pmfavorite eq 0}"> <!-- pmfavorite이 0일 때 -->
									<div onclick="favoriteButton(${projectList.pno})" id="favoriteButton">			
									<img src="/resources/assets/img/empty_star.png" width="20px" height="20px" style="margin-bottom:5px" alt="empty_star" id="empty_star"/>
									<img src="/resources/assets/img/empty_star_hover.png" width="20px" height="20px" style="margin-bottom:5px" alt="empty_star_hover" id="empty_star_hover"/>
									</div>	
								</c:when>
							</c:choose>
                           </div>
                           <div class="pname"><strong><c:out value="${projectList.pname}"/></strong></div>
                           <div class="pCount"><i class="bi bi-person"></i><strong><c:out value="${projectList.pcount}"/></strong></div>
                         </a>
                     	</li>
                     	</c:if>
                 	 </c:forEach>
                  </div>
                  
                  <div class="loadlist2">
                  <c:forEach items="${projectList}" var="projectList">
                  <c:if test="${projectList.pmfavorite eq 0 and projectList.pmadmin_num eq 1}">
                	<li class="listLi">
                		<a href="#" onclick="move(${projectList.pno})" id="move-home">
                    	<div id="pmcolor">
                    	<c:choose>
                    			<c:when test="${projectList.pmcolor eq 'blue'}">
                    				<div id="bluediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'skyblue'}">
                    				<div id="skybluediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'emerald'}">
                    				<div id="emeralddiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'green'}">
                    				<div id="greendiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'yellow'}">
                    				<div id="yellowdiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'orange'}">
                    				<div id="orangediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'red'}">
                    				<div id="reddiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'pink'}">
                    				<div id="pinkdiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'purple'}">
                    				<div id="purplediv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'darkgrey'}">
                    				<div id="darkgreydiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'lightgrey'}">
                    				<div id="lightgreydiv"></div>
                    			</c:when>
                    			<c:when test="${projectList.pmcolor eq 'black'}">
                    				<div id="blackdiv"></div>
                    			</c:when>
                    			<c:otherwise>
                    				<div>에러</div>
                    			</c:otherwise>
                    		</c:choose>
                    	</div>
                        <div class="pmfavorite">
                           <c:choose>
								<c:when test="${projectList.pmfavorite eq 0}"> <!-- pmfavorite이 0일 때 -->
									<div onclick="favoriteButton(${projectList.pno})" id="favoriteButton">			
									<img src="/resources/assets/img/empty_star.png" width="20px" height="20px" style="margin-bottom:5px" alt="empty_star" id="empty_star"/>
									<img src="/resources/assets/img/empty_star_hover.png" width="20px" height="20px" style="margin-bottom:5px" alt="empty_star_hover" id="empty_star_hover"/>
									</div>	
								</c:when>
							</c:choose>
                           </div>
                           <div class="pname"><strong><c:out value="${projectList.pname}"/></strong></div>
                           <div class="pCount"><i class="bi bi-person"></i><strong><c:out value="${projectList.pcount}"/></strong></div>
                         </a>
                     	</li>
                     	</c:if>
                 	 </c:forEach>
                  </div>
               </ul>
            </div>
         </div>
      </div>
      
   </main>
   
</body>
</html>