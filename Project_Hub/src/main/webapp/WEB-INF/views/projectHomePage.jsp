<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- jstl c태그 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 라이브러리 코드 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar","\n"); %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Project HomePage</title>
<link href="/resources/css/projectHomePage.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
	<!-- 부트스트랩 아이콘cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- 주소록 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 지도 api -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3fea17d9b713a1da00c584f2f93c5426&libraries=services"></script>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/f1b7ad5b17.js" crossorigin="anonymous"></script>
<!-- jQuery.validate 플러그인 삽입 -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
<!-- chart.js cdn -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">

/* 업무 리포트 차트, 퍼센트 */
$(function(){
	var all_num = ${taskReport_number[0]};
	var request_num = ${taskReport_number[1]};
	var progress_num = ${taskReport_number[2]};
	var complete_num = ${taskReport_number[3]};
	var hold_num = ${taskReport_number[4]};
	
	$('.task_report_request_percent').html(Math.floor(request_num/all_num*100));
	$('.task_report_progress_percent').text(Math.floor(progress_num/all_num*100));
	$('.task_report_complete_percent').text(Math.floor(complete_num/all_num*100));
	$('.task_report_hold_percent').text(Math.floor(hold_num/all_num*100));
	
	/* task_report_chart */
	const chart_data = {
	    labels: ['요청', '진행', '완료', '보류'],
	    datasets: [{
	        label: '업무상태',
	        data: [request_num, progress_num, complete_num, hold_num],
	        backgroundColor: [
	            '#00b2ff',
	            '#00b01c',
	            '#402a9d',
	            '#777'
	        ],
	        hoverOffset: 5
	    }]
	};
	const chart_config = {
	    type: 'doughnut',
	    data: chart_data,
	    options: {
	        plugins: {
	            legend: {
	                position: 'right'
	                
	            }
	        }
	    }
	};
	const chart = new Chart($('#task_report_chart'), chart_config);
	/* task_report_chart end */
	
});

/* 업무 리포트 */
$(function () {
	$('.taskReport_title').click(function(){
		console.log("taskReport_title click!");
		var display = $('.taskReport_content').css('display');
		if(display == 'none'){
			$('.taskReport_content').slideDown();
			$('.fa-angle-down').remove();
			$('#taskReport_toggle').append('<i class="fa-solid fa-angle-up"></i>');
		}else{
			$('.taskReport_content').slideUp();
			$('.fa-angle-up').remove();
			$('#taskReport_toggle').append('<i class="fa-solid fa-angle-down"></i>');
		}
	});
});

/* 게시글 고정 취소 */
$(function () {
    $('.fix_cancel').on('click',function () {
    	console.log('fix_cancel click!');
    	var bno = $(this).attr('value');
    	console.log(bno);
    	$.ajax({
    		type: "POST",
    	    url: "/boardFixCancel",   //데이터를 주고받을 파일 주소
    	    dataType: "json",
    	    data: "bno=" + bno,
    	    async: false,
    	    success: function (data) {   //파일 주고받기가 성공했을 경우. data 변수 안에 값을 담아온다.
    	        if(data == true){
    	        	console.log('게시글 고정 취소!');
    	        	$('.apply_modal').css({ opacity: 0 }).animate({ opacity: 1 }, 900);
    	            $('.apply_modal').css({ opacity: 1 }).animate({ opacity: 0 }, 400);
    	            setTimeout(function() {
		            	location.reload();
		            	}, 1300);
    	        }
    	    }
    	});
    });
}); 
/* 북마크 */
$(function () {
    $('.bookmarkBtn').on('click',function () {
    	console.log('bookmarkBtn click!');
    	var bno = $(this).val();
    	console.log(bno);
    	if($(this).hasClass('bookmark_on')){
    		$(this).removeClass('bookmark_on');
    	}else{
    		$(this).addClass('bookmark_on');
    	}
    	
    	$.ajax({
    		type: "POST",
    	    url: "/clickBookmarkBtn", 
    	    dataType: "json",
    	    data: "bno=" + bno,
    	    async: false,
    	    success: function (data) { 
    	        if(data == true){
    	        	console.log('북마크 등록!');
    	        }else{
    	        	console.log('북마크 취소!');
    	        }    
    	    }
    	});
    });
});
$(function(){ // 댓글 수정
	$('.modify_reply').on('click',function(){
		let modify_reply_display = $(this).parents('.replyBody').children('.modify_reply_modal').css('display');
		console.log('modify_reply click!' + modify_reply_display);
		if(modify_reply_display == 'none'){
			$(this).parents('.replyBody').children('.modify_reply_modal').css('display', 'block');
		} else if(modify_reply_display == 'block'){
			$(this).parents('.replyBody').children('.modify_reply_modal').css('display', 'none');
		}
	});
});

$(function () { // 업무상태,우선순위 추가 버튼 클릭
    $('.stts_addBtn').on('click',function () {
    	console.log('stts_addBtn click!')
    	var opacity = $('.stts_add').css('opacity');
    	if(opacity == 0){
    		$('.stts_add').css('display', 'block');
    		$('.stts_add').css({ opacity: 0 }).animate({ opacity: 1 }, 700);
    	}else{
    		$('.stts_add').css({ opacity: 1 }).animate({ opacity: 0 }, 700);
    		$('.request_div,.progress_div,.completion_div,.hold_div').removeClass('stts_check');
    		$('#task_status_checked').val(null);
    		setTimeout(function() {
    			$('.stts_add').css('display', 'none');
            	}, 700);
    	}
    });
    $('.prrt_addBtn').on('click',function () {
    	console.log('prrt_addBtn click!')
    	var opacity = $('.prrt_add').css('opacity');
    	if(opacity == 0){
    		$('.prrt_add').css('display', 'block');
    		$('.prrt_add').css({ opacity: 0 }).animate({ opacity: 1 }, 700);
    	}else{
    		$('.prrt_add').css({ opacity: 1 }).animate({ opacity: 0 }, 700);
    		$('.l_div,.u_div,.h_div,.e_div').removeClass('prrt_check');
    		$('#task_priority_checked').val(null);
    		setTimeout(function() {
    			$('.prrt_add').css('display', 'none');
            	}, 700);
    	}
    });
});

/* 업무 우선순위 클릭 */
$(function () {
    $('.l_div,.u_div,.h_div,.e_div').on('click',function () {
    	console.log('prrt_div click!')
    	if($(this).attr('prrt') == $('#task_priority_checked').val()){
    		$(this).removeClass('prrt_check');
    		$('#task_priority_checked').val('0');
    	}else{
        $('.l_div,.u_div,.h_div,.e_div').removeClass('prrt_check');
        $(this).addClass('prrt_check');
        $('#task_priority_checked').val($(this).attr('prrt'));
        console.log($(this).attr('prrt'));
        console.log($('#task_priority_checked').val());
    	}
    });
});

/* 업무상태 클릭 */
$(function () {
    $('.request_div,.progress_div,.completion_div,.hold_div').on('click',function () {
    	console.log('stts_div click!')
    	if($(this).attr('stts') == $('#task_status_checked').val()){
    		$(this).removeClass('stts_check');
    		$('#task_status_checked').val('0');
    	}else{
        $('.request_div,.progress_div,.completion_div,.hold_div').removeClass('stts_check');
        $(this).addClass('stts_check');
        $('#task_status_checked').val($(this).attr('stts'));
        console.log($(this).attr('stts'));
        console.log($('#task_status_checked').val());
    	}
    });
});

$(function () {
    $('#selectColorTypes li').click(function () {
        $('#selectColorTypes li').removeClass();
        $(this).addClass('selected');
        $('#selectedpmcolor').val($(this).attr('value'));
        console.log($(this).attr('value'));
        console.log($('#selectedpmcolor').val());

    });
});

function favoriteButton(pno) {
    console.log(pno);

    $('.apply_modal').css({ opacity: 0 }).animate({ opacity: 1 }, 1200);
    $('.apply_modal').css({ opacity: 1 }).animate({ opacity: 0 }, 700);


    $.ajax({
        type: "POST",
        url: "/clickFavorite",   //데이터를 주고받을 파일 주소
        dataType: "json",
        data: "pno=" + pno,
        cache: false,
        async: false,
        success: function (data) {   //파일 주고받기가 성공했을 경우. data 변수 안에 값을 담아온다.
            console.log("clickFavorite ajax success data = " + data);

            $('.pmfavorite').load(window.location.href + ' .pmfavorite');
        }
    });

}

$(document).ready(function () {
	
	/* 북마크 게시물 표시 */
	var len = $('.bookmarkBtn').length;
	if(len > 0){
		for(var i=0; i <len; i++){
			var bno = $($('.bookmarkBtn')[i]).attr('value');
			$.ajax({
	    		type: "POST",
	    	    url: "/bookmarkCheck",  
	    	    dataType: "json",
	    	    data: "bno=" + bno,
	    	    async: false,
	    	    success: function (data) { 
	    	        if(data == false){
	    	        	$($('.bookmarkBtn')[i]).addClass('bookmark_on');
	    	        }    
	    	    }
	    	});
		}
	}
	
	/* 좋아요 게시물 표시 */
	var len = $('.boardLikeBtn').length;
	if(len > 0){
		for(var i=0; i <len; i++){
			var bno = $($('.boardLikeBtn')[i]).attr('value');
			$.ajax({
	    		type: "POST",
	    	    url: "/boardLikeCheck", 
	    	    dataType: "json",
	    	    data: "bno=" + bno,
	    	    async: false,
	    	    success: function (data) { 
	    	        if(data == true){
	    	        	$($('.boardLikeBtn')[i]).addClass('boardLike_on');
	    	        }    
	    	    }
	    	});
		}
	}
	
	/* 글작성 파일 */
	var fileTarget = $('.file-upload .upload-hidden');
	fileTarget.on('change', function(){  // 값이 변경되면
	    console.log('fileTarget change') 
		if(window.FileReader){  // modern browser
	           var filename = $(this)[0].files[0].name;
	     } 
	     else {  
	           var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
	     }
	     // 추출한 파일명 삽입
	     $(this).siblings('.upload-name').val(filename);
	});
	//preview image 
	var imgTarget = $('.preview-image .upload-hidden');
	imgTarget.on('change', function(){
	     var parent = $(this).parent();
	     parent.children('.upload-display').remove();
	     if(window.FileReader){
	          //image 파일만
	          if (!$(this)[0].files[0].type.match(/image\//)) return;
	          var reader = new FileReader();
	          reader.onload = function(e){
	               var src = e.target.result;
	               parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
	          }
	          reader.readAsDataURL($(this)[0].files[0]);
	     }
	     else {
	          $(this)[0].select();
	          $(this)[0].blur();
	          var imgSrc = document.selection.createRange().text;
	          parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');
	          var img = $(this).siblings('.upload-display').find('img');
	          img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
	     }
	});
	
	/* 업무작성 파일 */
	var task_fileTarget = $('.task_file-upload .task_upload-hidden');
	task_fileTarget.on('change', function(){  // 값이 변경되면
	    console.log('task_fileTarget change'); 
		if(window.FileReader){  // modern browser
			console.log('task_fileTarget window.FileReader true') 
			var task_filename = $(this)[0].files[0].name;
	     } 
	     else {
	    	 console.log('task_fileTarget window.FileReader false')
	         var task_filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
	     }
		console.log(task_filename) 
	     // 추출한 파일명 삽입
	     $(this).siblings('.task_upload-name').val(task_filename);
	});
	
	//preview image 
	var task_imgTarget = $('.task_preview-image .task_upload-hidden');

	task_imgTarget.on('change', function(){
	     var task_parent = $(this).parent();
	     task_parent.children('.task_upload-display').remove();
	     if(window.FileReader){
	          //image 파일만
	          if (!$(this)[0].files[0].type.match(/image\//)) return;
	          var task_reader = new FileReader();
	          task_reader.onload = function(e){
	               var task_src = e.target.result;
	               task_parent.prepend('<div class="task_upload-display"><div class="task_upload-thumb-wrap"><img src="'+task_src+'" class="task_upload-thumb"></div></div>');
	          }
	          task_reader.readAsDataURL($(this)[0].files[0]);
	     }
	     else {
	          $(this)[0].select();
	          $(this)[0].blur();
	          var task_imgSrc = document.selection.createRange().text;
	          task_parent.prepend('<div class="task_upload-display"><div class="task_upload-thumb-wrap"><img class="task_upload-thumb"></div></div>');
	          var task_img = $(this).siblings('.task_upload-display').find('img');
	          img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+task_imgSrc+"\")";        
	     }
	});
	
	var pmi_email = $('.pmi_email').val();
	var pmi_admin_num = $('.pmi_admin_num').val();
	
	/* 참여자 관리, 참여자 이름 검색 */
	$('.searchBtn, .all-btn').on("click",function(){
		/* $('.memberList-ul').empty(); */
		var name = $('.member-search-input').val();
		console.log(name);
		$.ajax({
	        type: "POST",
	        url: "/searchMember",   //데이터를 주고받을 파일 주소
	        dataType: "json",
	        data: "name=" + name,
	        async: false,
	        success: function (data) {   //파일 주고받기가 성공했을 경우. data 변수 안에 값을 담아온다.
	        	console.log(data);
	        	$('.memberList-ul').empty();
	        	if(data.length >=1){
	        		data.forEach(function(item){
	        			str = '<li class="listLi">';
						str += '<div class="listLi_div">';
						str += '<div style="width: 40px; height: 40px; background: black; display: inline-block;"></div>';
						str += '<div class="projectMember_info">';
						str += '<div><strong>'+item.name+'</strong></div></div></div>';
						if(item.pmadmin_num == '1'){
							str	+= '<div class="admin_div">관리자</div>';
						}
						if(pmi_admin_num == '1'){
							str += '<div class="admin_menuBtn"><i class="bi bi-three-dots-vertical"></i>';
							str += '<div class="admin_menu" data="'+item.email+'">';
							if(pmi_email == item.email){
								str += '<a id="exit" href="projectExit">나가기</a>';
								str += '<a id="managerBtn" href="#">';
							}else{
								str += '<a id="export" href="#">내보내기</a>';
								str += '<a id="managerBtn" href="#">';
							}
							if(item.pmadmin_num == '0'){
								str += '<div class="adminSetting">관리자 지정</div></a></div></div></li>';
							} else{
								str += '<div class="adminSetting">관리자 해제</div></a></div></div></li>';
							}
						}else if(pmi_admin_num == '0'){
							if(pmi_email == item.email){
								str += '<div class="admin_menuBtn"><i class="bi bi-three-dots-vertical"></i>';
								str += '<div class="admin_menu" data="'+item.email+'">';
								str += '<a id="exit" href="projectExit">나가기</a></div></div></li>';
							}
						}
						$('.memberList-ul').append(str);
	        		});
	        	}
	        }
	    });
		/* 내보내기 */
		$('#export').click(function(){
			console.log("export click!");
			var email = $(this).parents('.admin_menu').attr('data');
			console.log(email);
			$('.apply_modal').css({ opacity: 0 }).animate({ opacity: 1 }, 800);
	   	    $('.apply_modal').css({ opacity: 1 }).animate({ opacity: 0 }, 500);
			$.ajax({
		        type: "POST",
		        url: "/exportMember",   //데이터를 주고받을 파일 주소
		        dataType: "json",
		        data: "email=" + email,
		        cache: false,
		        async: false,
		        success: function (data) {   //파일 주고받기가 성공했을 경우. data 변수 안에 값을 담아온다.
		        	console.log(data);
		        	setTimeout(function() {
		            	location.reload();
		            	}, 1300);
		        }
		    });
		});
		
		/* 관리자 지정, 해제 */
		$('.adminSetting').click(function(){
			console.log("adminSetting click!");
			var email = $(this).parents('.admin_menu').attr('data');
			console.log(email);
			$('.apply_modal').css({ opacity: 0 }).animate({ opacity: 1 }, 800);
	   	    $('.apply_modal').css({ opacity: 1 }).animate({ opacity: 0 }, 500);
			$.ajax({
		        type: "POST",
		        url: "/adminSettings",   //데이터를 주고받을 파일 주소
		        dataType: "json",
		        data: "email=" + email,
		        cache: false,
		        async: false,
		        success: function (data) {   //파일 주고받기가 성공했을 경우. data 변수 안에 값을 담아온다.
		            if(data == 0){
		            	console.log("adminSettings >> 관리자 지정");
		            } else if(data == 1){
		            	console.log("adminSettings >> 관리자 해제");
		            }
		            setTimeout(function() {
		            	location.reload();
		            	}, 1300);
		        }
		    });
		});
		
		/* 참여자 관리 버튼 */
		$('.admin_menuBtn').click(function(){
			console.log("admin_menuBtn click!");
			var display = $(this).children('.admin_menu').css('display');
			if(display == 'none'){
				$(this).children('.admin_menu').css('display','block');
			}else{
				$(this).children('.admin_menu').css('display','none');
			}
		});
	});
	
	$(window).scroll(function() {
	   $('.memberListMain').css({left: 998 - $(this).scrollLeft()});	   
	});
	
	
	var email_item = 5; 
    $(".append_input_email").click(function () {
        $(".input_email_list").append('<div class="input_email append_input_email_item"><input type="text" class="emailItemInput" id="inputEmail'+(++email_item)+'" placeholder="example@projectHub.com" data-valid="email" maxlength="50" ></div>');
    });
    
    $(function () {
        $('.invitebtn').click(function () {
        	var pno = $('#invite_pno').val();
        	var pname = $('#invite_pname').val();
        	var name= $('#invite_name').val();
        	var emailarr = new Array();
        	var temp = 0;
            for(let i = 1; i <= email_item; i++){
            const email = document.getElementById('inputEmail'+(i)).value;
            console.log(email);
            if(email != ''){
            	emailarr[temp] = email;
            	temp++;
            	}
            }
            var objParams = {
            	"pno" : pno, //pno 저장
            	"pname" : pname, //pname 저장    
            	"name" : name, //pname 저장    
                "emailarr" : emailarr, //이메일 저장
            };
        	$.ajax({
            	type: "POST",
             	url: "/inviteProject",   //데이터를 주고받을 파일 주소
             	dataType: "json",
             	data: objParams,
             	async: false,
           	 	success: function (data) {   //파일 주고받기가 성공했을 경우. data 변수 안에 값을 담아온다.
               	 	console.log("inviteProject ajax success data = " + data);
               	 	$('.invite_apply_modal').css({ opacity: 0 }).animate({ opacity: 1 }, 1200);
                 	$('.invite_apply_modal').css({ opacity: 1 }).animate({ opacity: 0 }, 700);
               	 	$('.emailItemInput').val(null);
                	$('.append_input_email_item').remove();
            	}
        	});
        });
    });

    $(function () {
        var color_id = $('#projectColor').val();
        console.log(color_id);
        switch (color_id) {
            case 'emerald': $('#projectColorDiv').addClass('emerald_color_class');
                $('#invite_button').addClass('emerald_color_class');
                $('#modal_projectColor').addClass('emerald_color_class');
                break;
            case 'green': $('#projectColorDiv').addClass('green_color_class');
                $('#invite_button').addClass('green_color_class');
                $('#modal_projectColor').addClass('green_color_class');
                break;
            case 'yellow': $('#projectColorDiv').addClass('yellow_color_class');
                $('#invite_button').addClass('yellow_color_class');
                $('#modal_projectColor').addClass('yellow_color_class');
                break;
            case 'orange': $('#projectColorDiv').addClass('orange_color_class');
                $('#invite_button').addClass('orange_color_class');
                $('#modal_projectColor').addClass('orange_color_class');
                break;
            case 'red': $('#projectColorDiv').addClass('red_color_class');
                $('#invite_button').addClass('red_color_class');
                $('#modal_projectColor').addClass('red_color_class');
                break;
            case 'pink': $('#projectColorDiv').addClass('pink_color_class');
                $('#invite_button').addClass('pink_color_class');
                $('#modal_projectColor').addClass('pink_color_class');
                break;
            case 'skyblue': $('#projectColorDiv').addClass('skyblue_color_class');
                $('#invite_button').addClass('skyblue_color_class');
                $('#modal_projectColor').addClass('skyblue_color_class');
                break;
            case 'blue': $('#projectColorDiv').addClass('blue_color_class');
                $('#invite_button').addClass('blue_color_class');
                $('#modal_projectColor').addClass('blue_color_class');
                break;
            case 'purple': $('#projectColorDiv').addClass('purple_color_class');
                $('#invite_button').addClass('purple_color_class');
                $('#modal_projectColor').addClass('purple_color_class');
                break;
            case 'darkgrey': $('#projectColorDiv').addClass('darkgrey_color_class');
                $('#invite_button').addClass('darkgrey_color_class');
                $('#modal_projectColor').addClass('darkgrey_color_class');
                break;
            case 'black': $('#projectColorDiv').addClass('black_color_class');
                $('#invite_button').addClass('black_color_class');
                $('#modal_projectColor').addClass('black_color_class');
                break;
            case 'lightgrey': $('#projectColorDiv').addClass('lightgrey_color_class');
                $('#invite_button').addClass('lightgrey_color_class');
                $('#modal_projectColor').addClass('lightgrey_color_class');
                break;
        }
    });

    /* 프로젝트 제목 null 방지 */
    $('#makeProjectForm').validate({
        rules: {
            pname: {
                required: true
            }
        },
        messages: {
            pname: {
                required: "프로젝트 제목을 입력해 주세요",
            }
        },
        submitHandler: function () { //유효성 검사를 통과시 전송
        	makeProjectForm.submit();
        },
        success: function (e) {
            //
        }
    });//end validate()
    
    /* 글 작성 제목, 내용 null 방지 */
    $('#writeTextForm').validate({
        rules: {
        	text_title: {
                required: true
            },
            text_content: {
                required: true
            }
        },
        messages: {
        	text_title: {
                required: "제목을 입력해 주세요."
            },
            text_content: {
                required: "내용을 입력해 주세요."
            }
        },
        submitHandler: function () { //유효성 검사를 통과시 전송
        	writeTextForm.submit();
        },
        success: function (e) {
            //
        }
    });//end validate()
    
    $('#modifyTextForm').validate({
        rules: {
        	text_title: {
                required: true
            },
            text_content: {
                required: true
            }
        },
        messages: {
        	text_title: {
                required: "제목을 입력해 주세요."
            },
            text_content: {
                required: "내용을 입력해 주세요."
            }
        },
        submitHandler: function () { //유효성 검사를 통과시 전송
        	modifyTextForm.submit();
        },
        success: function (e) {
            //
        }
    });//end validate()
    
    /* 업무 작성 제목, 내용 null 방지 */
    $('#writeTaskForm').validate({
        rules: {
        	task_title: {
                required: true
            },
            task_content: {
                required: true
            }
        },
        messages: {
        	task_title: {
                required: "제목을 입력해 주세요."
            },
            task_content: {
                required: "내용을 입력해 주세요."
            }
        },
        submitHandler: function () { //유효성 검사를 통과시 전송
        	writeTaskForm.submit();
        },
        success: function (e) {
            //
        }
    });//end validate()
    $('#modifyTaskForm').validate({
        rules: {
        	task_title: {
                required: true
            },
            task_content: {
                required: true
            }
        },
        messages: {
        	task_title: {
                required: "제목을 입력해 주세요."
            },
            task_content: {
                required: "내용을 입력해 주세요."
            }
        },
        submitHandler: function () { //유효성 검사를 통과시 전송
        	modifyTaskForm.submit();
        },
        success: function (e) {
            //
        }
    });//end validate()
    
    /* 일정 작성 제목, 내용 null 방지 */
    $('#writeScheduleForm').validate({
        rules: {
        	schedule_title: {
                required: true
            },
            schedule_content: {
                required: true
            },
            schedule_location:{
            	required: true
            }
        },
        messages: {
        	schedule_title: {
                required: "제목을 입력해 주세요."
            },
            schedule_content: {
                required: "내용을 입력해 주세요."
            },
            schedule_location:{
            	required: "장소를 입력해 주세요."
            }
        },
        submitHandler: function () { //유효성 검사를 통과시 전송
        	writeScheduleForm.submit();
        },
        success: function (e) {
            //
        }
    });//end validate()
    $('#modifyScheduleForm').validate({
        rules: {
        	schedule_title: {
                required: true
            },
            schedule_content: {
                required: true
            }
        },
        messages: {
        	schedule_title: {
                required: "제목을 입력해 주세요."
            },
            schedule_content: {
                required: "내용을 입력해 주세요."
            }
        },
        submitHandler: function () { //유효성 검사를 통과시 전송
        	modifyScheduleForm.submit();
        },
        success: function (e) {
            //
        }
    });//end validate()
    
    /* 댓글 null 방지 */
    	$('.writeReplyForm').on('submit', function(){
    		console.log($(this));
    		let input_value = $(this).children('.reply_content_input').val();
    		console.log('reply_content_input value ='+input_value);
    		if(input_value == null || input_value == ''){
    			$('.reply_null_error').css({ opacity: 0 }).animate({ opacity: 1 }, 1200);
           	 $('.reply_null_error').css({ opacity: 1 }).animate({ opacity: 0 }, 700);
    			return false;
    		}
   	 	});
    
    	$('.modifyReplyForm').on('submit', function(){
    		console.log($(this));
    		let input_value = $(this).children('.modify_reply_content_input').val();
    		console.log('modify_reply_content_input value ='+input_value);
    		if(input_value == null || input_value == ''){
    			$('.reply_null_error').css({ opacity: 0 }).animate({ opacity: 1 }, 1200);
           	 $('.reply_null_error').css({ opacity: 1 }).animate({ opacity: 0 }, 700);
    			return false;
    		}
   	 	});
    
    // 프로젝트 색상 모달창에 현재 프로젝트 색상을 넘겨줌
    $("#projectColor, #dropdown_projectColor").click(function () {
        var color = $('#projectColor').val() + "✓";
        console.log("color = " + color);

        $('#selectColorTypes li').each(function (index, el) {
            console.log("index = " + index);
            console.log("text = " + $(this).text().replace(/\s/gi, ""));
            if ($(this).text().replace(/\s/gi, "") == color) {
                console.log($(this).text() == color);
                $(this).addClass('selected');
                $('#selectedpmcolor').val($(this).attr('value'));
            };
        });
    });


    //modal 닫을 때 input 초기화
    $('#makeProject').on('hidden.bs.modal', function () {
        $('input').val(null);
        $('label.error').css('display', 'none');
    });

    $('#pmcolorUpdate').on('hidden.bs.modal', function () {
        $('#selectColorTypes li').removeClass();
    });

    $('#project_invite').on('hidden.bs.modal', function () {
        $('.emailItemInput').val(null);
        $('.append_input_email_item').remove();

    });
    
    $('#allMember').on('hidden.bs.modal', function () {
    	$('input').val(null);
    	$('.memberList-ul').empty();
    });
    
    $('#writeText').on('hidden.bs.modal', function () {
    	$('input').val(null);
    	$('textarea').val(null);
    	$('.upload-display').remove();
    });
    
    $('#writeTask').on('hidden.bs.modal', function () {
    	$('input').val(null);
    	$('textarea').val(null);
    	$('.task_upload-display').remove();
    	$('.l_div,.u_div,.h_div,.e_div').removeClass('prrt_check');
        $('.request_div,.progress_div,.completion_div,.hold_div').removeClass('stts_check');
        $('.stts_add').css('opacity', 0); 
        $('.prrt_add').css('opacity', 0); 
        $('.stts_add').css('display', 'none');
        $('.prrt_add').css('display', 'none');
        $('#task_status_checked').val(null);
        $('#task_priority_checked').val(null);
    });
    
    $('#writeSchedule').on('hidden.bs.modal', function () {
    	$('input').val(null);
    	$('textarea').val(null);
    	$('#schedule_location').val(null);
    });
    
    var pname = '${projectInfo.pname}';
    var pdescription = '${projectInfo.pdescription}';
    
    $('#modifyProject').on('hidden.bs.modal', function () {
        $('.modifyPname').val(pname);
        $('.modifyPdescription').val(pdescription);
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
         
       //좋아요
         $('.boardLikeBtn').click(function () {
        	 console.log('boardLikeBtn click');
         	var bno = $(this).val();
         	if($(this).hasClass('boardLike_on')){
        		$(this).removeClass('boardLike_on');
        	}else{
        		$(this).addClass('boardLike_on');
        	}
         	  $.ajax({
         			url: "/boardLike",  
         			type: "GET",   
         			data: {
         				bno: bno,
         			},
         			success : function(data){ 
         				let like = data;
         				// 페이지에 하트수 갱신
                         $('#boardLike'+bno).text(like);
         			}
         		});
       	  });
});
   
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            document.getElementById("schedule_location").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

//글 수정
function modifyText(bno) {
	console.log('modifyText click');
	$.ajax({
		url: "/modifyText_bno",  
		type: "POST",
		dataType: "json",
		data: {
			bno: bno,
		},
		success : function(data){
			console.log(data);
			$('#modify_text_title').val(data.text_title);
			$('#modify_text_content').val(data.text_content);
			$('#modify_text_bno').val(data.bno);
		}
	});
}
	
//업무 수정
function modifyTask(bno) {
	console.log('modifyTask click');
	$.ajax({
		url: "/modifyTask_bno",  
		type: "POST",
		dataType: "json",
		data: {
			bno: bno,
		},
		success : function(data){
			console.log(data);
			$('#modify_task_title').val(data.task_title);
			$('#modify_task_content').val(data.task_content);
			$('#modify_task_bno').val(data.bno);
		}
	});
}
	
//일정 수정
function modifySchedule(bno) {
	console.log('modifySchedule click');
	$.ajax({
		url: "/modifySchedule_bno",  
		type: "POST",
		dataType: "json",
		data: {
			bno: bno,
		},
		success : function(data){
			console.log(data);
			$('#modify_schedule_title').val(data.schedule_title);
			$('#modify_schedule_content').val(data.schedule_content);
			$('#modify_schedule_bno').val(data.bno);
		}
	});
}

</script >
<style type="text/css">
a {
	color: #212529;
	text-decoration: none;
	outline: none
}

a:hover, a:active, a:link, a:visited {
	text-decoration: none;
	color: #212529;
}

* {
	margin: 0;
	padding: 0;
}

p {
	margin: 0;
}

body{
    min-width: 1300px;
    height: 100vh;
	overflow-x: auto;
    overflow-y: hidden;
}

</style>
</head>

<body>
	<header>
		<nav class="topnav">
			<a class="topnav-brand" href="#" style="color: white">Project Hub</a>
			<ul class="topnav-nav">
				<li>
					<div class="btn-group">
						<button type="button" data-toggle="dropdown" aria-expanded="false"
							id="profilebutton">
							<div class="profile-default-button"></div>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<div class="user_info">
								<div class="user_profile"></div>
								<div class="user_name">
									<strong>${memberInfo.name }</strong>
								</div>
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
			<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
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
								<li id="color-type-emerald" value="emerald"><span>emerald</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-green" value="green"><span>green</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-yellow" value="yellow"><span>yellow</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-orange" value="orange"><span>orange</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-red" value="red"><span>red</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-pink" value="pink"><span>pink</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-skyblue" value="skyblue"><span>skyblue</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-blue" value="blue"><span>blue</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-purple" value="purple"><span>purple</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-darkgrey" value="darkgrey"><span>darkgrey</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-black" value="black"><span>black</span><div class="checkIcon"><strong>✓</strong></div></li>
								<li id="color-type-lightgrey" value="lightgrey"><span>lightgrey</span><div class="checkIcon"><strong>✓</strong></div></li>
							</ul>
								<!-- Submit Button-->
								<div class="make-button">
									<button type="button" class="modal_cancel" data-dismiss="modal">취소</button>
									<input type="hidden" name="selectedpmcolor"
										id="selectedpmcolor" value="" />
									<button type="submit" value=""
										class="modal_submit">확인</button>
								</div>
						</form>
						<!-- /makeProject closed-->
					</div>
					<!-- modal-body closed -->
				</div>
			</div>
		</div><!-- modal closed-->
		
		<div class="modal" id="project_invite">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content invite_modal">
					<!-- Modal Header -->
					<div class="modal-header">
						<div id="modal_projectColor" class="project_invite_modal_pmcolor"></div>
						<h6 class="project_invite_title">${projectInfo.pname} 초대하기</h6>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body input_modal_body">
						<div class="input_email_list">
							<div class="project_invite_title">이메일 초대장 발송</div>
							<div class="input_email">
								<input type="text" class="emailItemInput" id="inputEmail1" placeholder="example@projectHub.com" data-valid="email" maxlength="50" >
							</div>
							<div class="input_email">
								<input type="text" class="emailItemInput" id="inputEmail2" placeholder="example@projectHub.com" data-valid="email" maxlength="50" >
							</div>
							<div class="input_email">
								<input type="text" class="emailItemInput" id="inputEmail3" placeholder="example@projectHub.com" data-valid="email" maxlength="50" >
							</div>
							<div class="input_email">
								<input type="text" class="emailItemInput" id="inputEmail4" placeholder="example@projectHub.com" data-valid="email" maxlength="50" >
							</div>
							<div class="input_email">
								<input type="text" class="emailItemInput" id="inputEmail5" placeholder="example@projectHub.com" data-valid="email" maxlength="50" >
							</div>
						</div>
						<button type="button" class="append_input_email">+이메일 추가</button>
					</div><!-- modal-body closed -->
					
					<!-- Modal footer -->
					<div class="modal-footer project_invite_footer">
						<div class="project_invite_button">
							<button type="button" class="modal_cancel" data-dismiss="modal">취소</button>
								<input type="hidden" id="invite_pno" value="${projectInfo.pno}" />
								<input type="hidden" id="invite_pname" value="${projectInfo.pname}" />
								<input type="hidden" id="invite_name" value="${memberInfo.name}" />
							<button type="submit" class="modal_submit invitebtn">초대</button>
						</div>
					</div><!-- modal-footer closed-->
				</div>
			</div>
		</div><!-- modal closed-->

		<div class="main-container">
			<div class="main-header">
				<div class="row">
					<div class="wrapper col-10">
						<div class="item">
							<button type="button" data-toggle="modal"
								data-target="#pmcolorUpdate" id="projectColor"
								value="${projectMemberInfo.pmcolor}">
									<div id="projectColorDiv"></div>
							</button>
						</div>
						<div class="pmfavorite">
							<c:choose>
								<c:when test="${projectMemberInfo.pmfavorite eq 0}">
									<!-- pmfavorite이 0일 때 -->
									<div onclick="favoriteButton(${projectMemberInfo.pno})"
										id="favoriteButton">
										<img src="/resources/assets/img/empty_star.png"
											style="margin-bottom: 5px; width: 27px; height: 27px;"
											alt="empty_star" id="star" /> <img
											src="/resources/assets/img/empty_star_hover.png"
											style="margin-bottom: 5px; width: 27px; height: 27px;"
											alt="empty_star_hover" id="empty_star_hover" />
									</div>
								</c:when>
								<c:otherwise>
									<!-- pmfavorite이 1일 때(default값) -->
									<div onclick="favoriteButton(${projectMemberInfo.pno})"
										id="favoriteButton1">
										<img src="/resources/assets/img/star.png"
											style="margin-bottom: 5px; width: 27px; height: 27px;"
											alt="star" id="star" />
									</div>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="item">
							<div class="dropdown">
								<a role="button" id="projectMenu" data-toggle="dropdown"
									aria-expanded="false"> <i class="fas fa-ellipsis-v"
									id="projectSet"></i>
								</a>
								<div class="dropdown-menu dropdown_projectMenu" aria-labelledby="projectMenu">
									<div class="projectMenu_header">
										<span>프로젝트 번호</span>
										<div class="project_number">${projectInfo.pno }</div>
									</div>
									<button type="button" data-toggle="modal"
									data-target="#pmcolorUpdate" id="dropdown_projectColor"
									value="${projectMemberInfo.pmcolor}">
									<div class="projectColor_dropdownbtn"><i class="fas fa-palette"></i> 색상 설정</div>
									</button>
									<a class="dropdown_projectMenu_a" href="projectExit">
									<i class="fas fa-sign-out-alt"></i> 프로젝트 나가기</a>
									<c:if test="${projectMemberInfo.pmadmin_num eq 1}">
										<a class="dropdown_projectMenu_a" href="#" data-toggle="modal" data-target="#modifyProject">
										<i class="fas fa-pencil-alt"></i> 프로젝트 수정</a>
										<a class="dropdown_projectMenu_a" href="deleteProject">
										<i class="far fa-trash-alt"></i> 프로젝트 삭제</a>
									</c:if>
								</div>
							</div>
						</div>
						<div class="item" id="projectName">
							${projectInfo.pname }</div>
						<div class="item" id="projectDescription">
							${projectInfo.pdescription }</div>
					</div>
					<div class="invite_div">
					<c:if test="${projectMemberInfo.pmadmin_num eq 1}">
						<button type="button" data-toggle="modal"
								data-target="#project_invite" id="invite_button"
								value="${projectInfo.pno}">
								초대하기
						</button>
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
								<span id="taskReport_title_span">업무리포트</span>
								<span id="taskReport_number">${taskReport_number[0]}</span>
								<button id="taskReport_toggle"><i class="fa-solid fa-angle-up"></i></button>
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
										<li style="margin-bottom: 16px;">
											<span class="task_report_request">
												<i class="fa-solid fa-circle fa-xs"></i>
												<span class="task_report_text">요청
													<em>${taskReport_number[1]}</em>
												</span>
												<span class="task_report_request_percent"></span>
												<span class="request_percent">%</span>
											</span>
											<span class="task_report_progress">
												<i class="fa-solid fa-circle fa-xs"></i>
												<span class="task_report_text">진행
													<em>${taskReport_number[2]}</em>
												</span>
												<span class="task_report_progress_percent"></span>
												<span class="progress_percent">%</span>
											</span>
										</li>
										<li>
											<span class="task_report_complete">
												<i class="fa-solid fa-circle fa-xs"></i>
												<span class="task_report_text">완료
													<em>${taskReport_number[3]}</em>
												</span>
												<span class="task_report_complete_percent"></span>
												<span class="complete_percent">%</span>
											</span>
											<span class="task_report_hold">
												<i class="fa-solid fa-circle fa-xs"></i>
												<span class="task_report_text">보류
													<em>${taskReport_number[4]}</em>
												</span>
												<span class="task_report_hold_percent"></span>
												<span class="hold_percent">%</span>
											</span>
										</li>
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
							<div class="write" data-toggle="modal" data-target="#writeTask">
								<i class="fas fa-list-ul"></i> 업무
							</div>
							<div class="write" data-toggle="modal"
								data-target="#writeSchedule">
								<i class="far fa-calendar-alt"></i> 일정
							</div>
						</div>
						<div class="writeBox-body" data-toggle="modal"
							data-target="#writeText">내용을 입력하세요.</div>
					</div>
					<div id="fixContainer">
						<div class="section-title"><strong>상단 고정</strong> <span id="boardFixCount">${boardFixCount}</span></div>
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
											<i class="fas fa-thumbtack fix_cancel" value="${boardListFixed.bno}"></i>
											<c:forEach items="${boardListFixed.textList}" var="textList">
												<c:out value="${textList.text_title}"/>
											</c:forEach>
											<c:forEach items="${boardListFixed.taskList}" var="taskList">
												<c:out value="${taskList.task_title}"/>
											</c:forEach>
											<c:forEach items="${boardListFixed.scheduleList}" var="scheduleList">
												<c:out value="${scheduleList.schedule_title}"/>
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
				<span style="flex: 1;">
				전체
				</span>
				<div id="selectBox">
           			<select id="cntSelectBox" name="cntSelectBox"
               		onchange="changeSelectBox(${pagination.currentPage},${pagination.cntPerPage},${pagination.pageSize});"
               		class="form-control" style="width: 100px;">
               	 		<option value="10"
                  		<c:if test="${pagination.cntPerPage == '10'}">selected</c:if>>10개</option>
               			<option value="20"
                 		<c:if test="${pagination.cntPerPage == '20'}">selected</c:if>>20개</option>
              		 	<option value="30"
                   		<c:if test="${pagination.cntPerPage == '30'}">selected</c:if>>30개</option>
           			</select>
           		</div>
            </div>
					<c:forEach items="${boardList}" var="boardList">
					<div class="card boardContainer">
						<div class="card-body boardBox">
							<div class="boardHeader">
								<div class="profile"></div>
								<div class="boardMember">
									<span><c:out value="${boardList.bwriter}"/></span>
									<span class="writeDate">
									<c:forEach items="${boardList.textList}" var="textList">
									<fmt:formatDate pattern="yyyy/MM/dd" value="${textList.text_day}" />
									</c:forEach>
									
									 <c:forEach items="${boardList.taskList}" var="taskList">
									<fmt:formatDate pattern="yyyy/MM/dd" value="${taskList.task_day}" />
									</c:forEach> 
									
              						 <c:forEach items="${boardList.scheduleList}" var="scheduleList">
									<fmt:formatDate pattern="yyyy/MM/dd" value="${scheduleList.schedule_day}" />
									</c:forEach> 
									
									</span>
								</div>
								<div class="boardStatus">
									<form action="/boardFix" method="post">
									<input type="hidden" name="bno" value="${boardList.bno}">
									<button type="submit" class="boardFix">
										<c:if test="${boardList.bfix eq '0'}"><i class="fas fa-thumbtack fixIcon"></i></c:if>
										<c:if test="${boardList.bfix eq '1'}"><i class="fas fa-thumbtack fixIcon" style="color:#6449fc;"></i></c:if>
									</button>
									</form>
									<c:if test="${boardList.bwriter_email eq memberInfo.email || projectMemberInfo.pmadmin_num eq 1}">
									<div class="dropdown d-inline">
										<a role="button"  data-toggle="dropdown" 
											data-bs-display="static" aria-expanded="false">
										<i class="fas fa-ellipsis-v" id="projectSet"></i>
										</a>
										<div class="dropdown-menu dropdown-menu-end dropdown-menu-lg-start" aria-labelledby="boardMenu">
										<c:if test="${boardList.bwriter_email eq memberInfo.email}">
											<c:forEach items="${boardList.textList}" var="textList">
												<div onclick="modifyText(${boardList.bno})" class="dropdown-item" data-toggle="modal" data-target="#modifyText" style="cursor: pointer;">
													<i class="fas fa-pencil-alt modifyText_btn"></i> 게시글 수정
												</div>
											</c:forEach>
										</c:if>
										<c:if test="${boardList.bwriter_email eq memberInfo.email}">
											<c:forEach items="${boardList.taskList}" var="taskList">
										 		<div onclick="modifyTask(${boardList.bno})" class="dropdown-item" data-toggle="modal" data-target="#modifyTask" style="cursor: pointer;">
												<i class="fas fa-pencil-alt"></i> 게시글 수정
												</div>
											</c:forEach> 
										</c:if>
										<c:if test="${boardList.bwriter_email eq memberInfo.email}">
              								<c:forEach items="${boardList.scheduleList}" var="scheduleList">
              							 		<div onclick="modifySchedule(${boardList.bno})" class="dropdown-item" data-toggle="modal" data-target="#modifySchedule" style="cursor: pointer;">
												<i class="fas fa-pencil-alt"></i> 게시글 수정
												</div>
											</c:forEach>
										</c:if>
										<c:choose>
											<c:when test="${boardList.bwriter_email eq memberInfo.email}">
												<form action="/deleteBoard" method="post">
													<input type="hidden" name="bno" value="${boardList.bno}">
													<button class="dropdown-item" type="submit">
														<i class="far fa-trash-alt"></i> 게시글 삭제
													</button>
												</form>
											</c:when>
											<c:when test="${projectMemberInfo.pmadmin_num eq 1}">
												<form action="/deleteBoard" method="post">
													<input type="hidden" name="bno" value="${boardList.bno}">
													<button class="dropdown-item" type="submit">
														<i class="far fa-trash-alt"></i> 게시글 삭제
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
							<c:out value="${textList.text_title}"/>
							</c:forEach>
							
							 <c:forEach items="${boardList.taskList}" var="taskList">
							<c:out value="${taskList.task_title}"/>
							</c:forEach> 
									
              				<c:forEach items="${boardList.scheduleList}" var="scheduleList">
							<c:out value="${scheduleList.schedule_title}"/>
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
													<c:out value="${bfileList.org_bfile_name}"/>
												</p>
												<p class="fileSize">
													<c:out value="${bfileList.bfile_size}.KB"/>
												</p>
											</div>
											<form action="bfileDown" method="post">
												<input type="hidden" value="${bfileList.bfile_no}" name="bfile_no">
												<button type="submit" class="fileDown" style="background-color: white"><i class="fas fa-arrow-down"></i>
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
								<span>시작일</span> <fmt:formatDate pattern="yyyy/MM/dd" value="${taskList.task_start}" /> <span>부터</span>
							</div>
							<div class="deadline_day">
								<span>마감일</span> <fmt:formatDate pattern="yyyy/MM/dd" value="${taskList.task_last}" /> <span>까지</span>
							</div>
							
							<c:forEach items="${boardList.bfileList}" var="bfileList">
									<div class="card fileBox">
										<div class="card-body fileMain" style="padding: 0;">
											<div class="file"></div>
											<div class="fileInfo">
												<p class="fileName">
													<c:out value="${bfileList.org_bfile_name}"/>
												</p>
												<p class="fileSize">
													<c:out value="${bfileList.bfile_size}.KB"/>
												</p>
											</div>
											<form action="bfileDown" method="post">
												<input type="hidden" value="${bfileList.bfile_no}" name="bfile_no">
												<button type="submit" class="fileDown"><i class="fas fa-arrow-down"></i>
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
                                   <i class="fas fa-map-marker-alt"></i>
                                <span>
                                   <c:out value="${scheduleList.schedule_location}"/>
                                </span>
                             </div>
                          </c:if>
                          <div class="start_day">
                        <span>시작일</span> <fmt:formatDate pattern="yyyy/MM/dd" value="${scheduleList.schedule_start}" /> <span>부터</span>
                     </div>
                     <div class="deadline_day">
                        <span>마감일</span> <fmt:formatDate pattern="yyyy/MM/dd" value="${scheduleList.schedule_last}" /> <span>까지</span>
                     </div>
                     </c:forEach> 
							</div>
							<div class="boardFooter">
								<div class="like_count_div">
									<i class="fas fa-heart" style="color: red;"></i>
									<div id="boardLike${boardList.bno}" style="display: inline-block;">
									${boardList.blike}
									</div>
								</div>
								<div class="likeBookmark">
									<button class="boardLikeBtn boardLikeBtn${boardList.bno}" value="${boardList.bno}">
									<i class="fas fa-heart" style="color: red;"></i> 좋아요
									</button>
									<button class="bookmarkBtn" value="${boardList.bno}"><i class="far fa-bookmark"></i><span> 북마크</span></button>
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
										<span><c:out value="${replyList.reply_writer}"/></span>
										<span class="writeDate"><fmt:formatDate pattern="yyyy/MM/dd" value="${replyList.reply_date}" /></span>
										<c:if test="${replyList.rwriter_email eq memberInfo.email}">
											<span class="modify_reply">수정</span>
											<div class="modify_reply_modal">
											<form action="/modifyReply" class="modifyReplyForm" method="post" enctype="multipart/form-data">
                           						<input type="hidden" name="reply_no" value="${replyList.reply_no }">
                           						<input type="text" name="reply_content" class="modify_reply_content_input" value="${replyList.reply_content }" placeholder="입력은 Enter 입니다.">
                        					</form>
                        					</div>
										</c:if>
									</p>
									<p><c:out value="${replyList.reply_content}"/></p>
									
								<c:forEach items="${replyList.rfileList}" var="rfileList">
									<div class="card fileBox">
										<div class="card-body fileMain" style="padding: 0;">
											<div class="file"></div>
											<div class="fileInfo">
												<p class="fileName">
													<c:out value="${rfileList.org_rfile_name}"/>
												</p>
												<p class="fileSize">
													<c:out value="${rfileList.rfile_size}.KB"/>
												</p>
											</div>
											<form action="rfileDown" method="post">
												<input type="hidden" value="${rfileList.rfile_no}" name="rfile_no">
												<button type="submit" class="fileDown" style="background-color: white"><i class="fas fa-arrow-down"></i>
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
							<div class="modal fade" id="replyView${boardList.bno}" tabindex="-1"
								aria-labelledby="replyView" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered modal-lg">
									<div class="modal-content">
										<div class="modal-header">
								           <h5 class="modal-title" id="replyView">댓글</h5>
								               <button type="button" class="close" data-dismiss="modal"
								                  aria-label="Close">
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
										<span><c:out value="${replyList.reply_writer}"/></span>
										<span class="writeDate"><fmt:formatDate pattern="yyyy/MM/dd" value="${replyList.reply_date}" /></span>
									</p>
									<p><c:out value="${replyList.reply_content}"/></p>
									
								<c:forEach items="${replyList.rfileList}" var="rfileList">
									<div class="card fileBox">
										<div class="card-body fileMain" style="padding: 0;">
											<div class="file"></div>
											<div class="fileInfo">
												<p class="fileName">
													<c:out value="${rfileList.org_rfile_name}"/>
												</p>
												<p class="fileSize">
													<c:out value="${rfileList.rfile_size}.KB"/>
												</p>
											</div>
											<form action="rfileDown" method="post">
												<input type="hidden" value="${rfileList.rfile_no}" name="rfile_no">
												<button type="submit" class="fileDown" style="background-color: white"><i class="fas fa-arrow-down"></i>
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
               <div class="profile"></div>
                  <div class="card replyWriteBox">
                     <div class="card-body replyWriteMain">
                        <form action="/writeReply" class="writeReplyForm" method="post" enctype="multipart/form-data">
                           <input type="hidden" name="reply_writer" value="${memberInfo.name }">
                           <input type="hidden" name="rwriter_email" value="${memberInfo.email }">
                           <input type="hidden" name="bno" value="${boardList.bno}">
                           <input type="text" name="reply_content" class="reply_content_input" placeholder="입력은 Enter 입니다.">
                           <input type="file" name="file" class="reply_input-file" class="upload-hidden" > 
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
            <li class="page-item"> <a class="page-link" href="javascript:void(0);"
                onclick="movePage(1,${pagination.cntPerPage},${pagination.pageSize});">
                &lt;&lt; </a>
             <li class="page-item"><a class="page-link" href="javascript:void(0);"
                onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasPreviousPage == true}">-1</c:if>,${pagination.cntPerPage},${pagination.pageSize});">
                &lt; </a>
 
            <c:forEach begin="${pagination.firstPage}"
                end="${pagination.lastPage}" var="idx">
             <li class="page-item"> <a class="page-link" style="color:<c:out value="${pagination.currentPage == idx ? '#cc0000; font-weight:700; margin-bottom: 2px;' : ''}"/> "
                href="javascript:void(0);" onclick="movePage(${idx},${pagination.cntPerPage},${pagination.pageSize});"><c:out value="${idx}" /></a>
            </c:forEach>
           <li class="page-item">  <a class="page-link" href="javascript:void(0);"
                onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasNextPage == true}">+1</c:if>,${pagination.cntPerPage},${pagination.pageSize});">
                &gt; </a>
             <li class="page-item"> <a class="page-link" href="javascript:void(0);"
                onclick="movePage(${pagination.totalRecordCount},${pagination.cntPerPage},${pagination.pageSize});">
                &gt;&gt; </a>
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
									<span><strong>참여자</strong></span>
									<span id="participantCount">${projectMemberCount}</span> 
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
      
      <div class="modal fade" id="writeText" tabindex="-1"
		aria-labelledby="writeTextLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content write_content">
				<div class="modal-header">
					<h5 class="modal-title" id="writeTextLabel"><strong>글 작성</strong></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
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
   								<label for="input-file" style="margin-bottom:0;"><i class="fas fa-paperclip"></i></label> 
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
	
	<div class="modal fade" id="writeTask" tabindex="-1"
		aria-labelledby="writeTaskLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content write_content">
				<div class="modal-header">
					<h5 class="modal-title" id="writeTaskLabel"><strong>업무 작성</strong></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
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
   								<label for="task_input-file" style="margin-bottom:0;"><i class="fas fa-paperclip"></i></label> 
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
								<input name="task_start" type="datetime-local" class="form-control" id="task_start"></input>
								<label for="task_last" class="col-form-label">마감일</label>
								<input name="task_last" type="datetime-local" class="form-control" id="task_last"></input> 
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
	<div class="modal fade" id="writeSchedule" tabindex="-1"
      aria-labelledby="writeScheduleLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg">
         <div class="modal-content write_content">
            <div class="modal-header">
               <h5 class="modal-title" id="writeScheduleLabel"><strong>일정 작성</strong></h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
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
                        <input name="schedule_location" type="text" class="form-control" onclick="execDaumPostcode()"
                        id="schedule_location" readonly="readonly" style="background-color: white;"></input>
                        
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
							<input
								class="projectTitleInput modifyPname" id="pname" type="text"
								name="pname" value="${projectInfo.pname }" placeholder="제목을 입력하세요" />
						</div>
						<br>
						<!-- Project description  input-->
						<div class="form-project">
							<textarea
								class="projectContentsInput modifyPdescription" id="pdescription"
								name="pdescription"
								placeholder="프로젝트에 관한 설명(옵션)">${projectInfo.pdescription}</textarea> <br>
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
	<div class="modal fade" id="modifyText" tabindex="-1"
		aria-labelledby="modifyTextLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
             <h5 class="modal-title" id="modifyTextLabel">게시물 수정</h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
           	<form action="/modifyText" method="post" id="modifyTextForm" enctype="multipart/form-data">
               <div class="modal-body">
                  <input type="hidden" id= "modify_text_bno" name="bno">
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
   <div class="modal fade" id="modifyTask" tabindex="-1"
      aria-labelledby="modifyTaskLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg">
         <div class="modal-content">
            <div class="modal-header">
             <h5 class="modal-title" id="modifyTaskLabel">게시물 수정</h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
              <form action="/modifyTask" method="post" id="modifyTaskForm" enctype="multipart/form-data">
               <div class="modal-body">
                  <%-- <input type="hidden" name="bidentifier" value="1">
                  <input type="hidden" name="pno" value="${projectInfo.pno }">
                  <input type="hidden" name="bwriter" value="${memberInfo.name }"> --%>
                  <input type="hidden" id= "modify_task_bno" name="bno">
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
	<div class="modal fade" id="modifySchedule" tabindex="-1"
      aria-labelledby="modifySchedule" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg">
         <div class="modal-content">
            <div class="modal-header">
             <h5 class="modal-title" id="modifySchedule">게시물 수정</h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
              <form action="/modifySchedule" method="post" id="modifyScheduleForm" enctype="multipart/form-data">
                  <input type="hidden" id= "modify_schedule_bno" name="bno">
                  <div class="form-group">
                  <input name="schedule_title" type="text" class="form-control" id="modify_schedule_title" placeholder="제목을 입력하세요.">
                  <textarea name="schedule_content" id="modify_schedule_content" placeholder="내용을 입력하세요."></textarea>
                     
                        <hr>
                     
                        <input type="hidden" id="postcode" placeholder="우편번호">
                        <input type="hidden" id="address" placeholder="주소">
                        <input type="hidden" id="detailAddress" placeholder="상세주소">
                        <input type="hidden" id="extraAddress" placeholder="참고항목">
                         
                        <label for="schedule_location" class="col-form-label">장소</label>
                        <input name="schedule_location" type="text" class="form-control" onclick="execDaumPostcode()"
                        id="modify_schedule_location" readonly="readonly" style="background-color: white;"></input>
                        
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