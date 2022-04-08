
/*업무 시작일 마감일*/
$(function(){
	$('#task_start').flatpickr({
		dateFormat: "Y-m-d",
		minDate:"today"
	});
	
	$('#task_last').flatpickr({
		dateFormat: "Y-m-d",
		minDate:"today"
	});
	
	$('#schedule_start').flatpickr({
		dateFormat: "Y-m-d",
		minDate:"today"
	});
	
	$('#schedule_last').flatpickr({
		dateFormat: "Y-m-d",
		minDate:"today"
	});
	
});

/* 업무 리포트 차트, 퍼센트 */
$(function(){
	let all_num = $('#taskReport_number').text();
	let request_num = $('.trn1').text();
	let progress_num = $('.trn2').text();
	let complete_num = $('.trn3').text();
	let hold_num = $('.trn4').text();
	
	$('.task_report_request_percent').text(Math.floor(request_num/all_num*100));
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

/* 게시물 고정 */
$(function () {
    $('.fixed_icon, .fixIcon').on('click',function () {
    	var bno = $(this).attr('value');
    	$.ajax({
    		type: "POST",
    	    url: "/boardFix",  
    	    dataType: "json",
    	    data: "bno=" + bno,
    	    async: false,
    	    success: function (data) {
    	        if(data == true){
    	        	console.log('게시물 고정!');
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

$(function(){ // 댓글 삭제
	$('.delete_reply').on('click',function(){
		var reply_no = $(this).attr('value');
    	$.ajax({
    		type: "POST",
    	    url: "/deleteReply",  
    	    dataType: "json",
    	    data: "reply_no=" + reply_no,
    	    async: false,
    	    success: function (data) {
    	        if(data == true){
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

$(function(){ // 일정 시작일, 마감일에 현재 날짜 입력
	$('#task_write').on('click',function(){
		$('#task_start').val(new Date().toISOString().slice(0, 10));
		$('#task_last').val(new Date().toISOString().slice(0, 10));
	});
});

$(function(){ // 업무 시작일, 마감일에 현재 날짜 입력
	$('#schedule_write').on('click',function(){
		$('#schedule_start').val(new Date().toISOString().slice(0, 10));
		$('#schedule_last').val(new Date().toISOString().slice(0, 10));
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
            },
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