$(document)
		.ready(
				function() {
					$('.profilebtn-modify').click(function() {
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

					let valueId = '';
					let valueById = '';

					$('.ch-confirm-btn')
							.click(
									function() {
										console.log('.ch-confirm-btn clicked')
										valueId = $(this).siblings("input")
												.attr('id');
										console.log('valueId >>>>> ' + valueId);
										valueById = $('#' + valueId).val();
										console.log('valueById >>>>> '
												+ valueById);

										$.validator
												.addMethod(
														"regex",
														function(value,
																element, regexp) {
															let re = new RegExp(
																	regexp);
															let res = re
																	.test(value);
															return res;
														});

										switch (valueId) {
										case "change_name":
											/* 회원정보 수정 이름 null 방지 */
											$('#change_name_box')
													.validate(
															{
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
																submitHandler : function() { // 유효성
																	// 검사를
																	// 통과시
																	// 전송
																	console
																			.log("change_name_box submit >>>>>> "
																					+ valueId
																					+ valueById);
																	user_modify();
																}
															});// end
											// validate()
											break;
										case "change_company_name":
											$('#change_cmpname_box')
													.validate(
															{
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
																submitHandler : function() { // 유효성
																	// 검사를
																	// 통과시
																	// 전송
																	user_modify();
																}
															});// end
											// validate()
											break;
										case "change_job_position":
											$('#change_jobp_box')
													.validate(
															{
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
																submitHandler : function() { // 유효성
																	// 검사를
																	// 통과시
																	// 전송
																	user_modify();
																}
															});// end
											// validate()
											break;
										case "change_phone_num":
											$('#change_phonen_box')
													.validate(
															{
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
																submitHandler : function() { // 유효성
																	// 검사를
																	// 통과시
																	// 전송
																	console
																			.log('change_phonen_box validation'
																					+ valueId
																					+ valueById);
																	user_modify();
																}
															});// end
											// validate()
											break;
										case "change_tel_num":
											$('#change_teln_box')
													.validate(
															{
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
																submitHandler : function() { // 유효성
																	// 검사를
																	// 통과시
																	// 전송
																	user_modify();
																}
															});// end
											// validate()
											break;
										}

										function user_modify() {
											console.log("user_modify >>>>> "
													+ valueId + valueById);
											$.ajax({
												type : "post",
												url : "/modify",
												cache : false,
												async : false,
												data : {
													valueId : valueId,
													valueById : valueById
												},
												success : function(data) {
													afterModify(valueId,
															valueById);
												},
												error : function(error) {
													console.log('error 전달됨')
												}
											});
										}
										; // user_modify end

									}); // $('.ch-confirm-btn').click(function()
					// end

					let change_pw = '';
					let change_pwChk = '';

					$('#change_pw_btn')
							.click(
									function() {
										console.log('#change_pw_btn clicked');
										change_pw = $('#change_pw').val();
										change_pwChk = $('#change_pwChk').val();
										console.log("change_pw, pwChk >>>> "
												+ change_pw + '/'
												+ change_pwChk);

										$('#change_pw_box')
												.validate(
														{
															rules : {
																change_pw : {
																	required : true,
																	rangelength : [
																			8,
																			16 ]
																},
																change_pwChk : {
																	required : true,
																	equalTo : '#change_pw'
																},
															},
															messages : {
																change_pw : {
																	required : "비밀번호를 입력하세요.",
																	rangelength : "비밀번호는 {0}자에서 {1}자까지 사용 가능합니다."
																},
																change_pwChk : {
																	required : "다시 한 번 입력하세요.",
																	equalTo : "동일하게 입력하세요."
																},
															},
															submitHandler : function() { // 유효성
																// 검사를
																// 통과시
																// 전송
																pw_modify();
															}
														});// end validate()

										function pw_modify() {
											console.log("pw_modify >>>>>");
											console.log("change_pw >>>>>"
													+ change_pw);
											$.ajax({
												type : "post",
												url : "/modify",
												cache : false,
												async : false,
												data : {
													valueId : 'change_pw',
													valueById : change_pw
												},
												success : function(data) {
													afterModify('change_pw',
															change_pw);
												},
												error : function(error) {
													console.log('error 전달됨')
												}
											});

										}
										;

									}); // $('#change_pw_btn').click(function()
					// end

					function afterModify(valueId, valueById) {
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
						}
						;
						$('input').val(null);
						$(".defaultview").addClass("d-block");
						$(".editview").removeClass("d-block");
						$('.apply_modal').css({
							opacity : 0
						}).animate({
							opacity : 1
						}, 1200);
						$('.apply_modal').css({
							opacity : 1
						}).animate({
							opacity : 0
						}, 700);

					}
					; // function afterModify end

					$('#mySetting').on('hidden.bs.modal', function() {
						location.reload();
					});

					$(function searchBookmark() {
						var bname = $('.bookmark-search-input').val();
						var bookmarkCount = 0;
						var bookmarkCount_text = 0;
						var bookmarkCount_task = 0;
						var bookmarkCount_schedule = 0;
						$
								.ajax({
									type : "POST",
									url : "/searchBookmark_task",
									dataType : "json",
									data : "bname=" + bname,
									async : false,
									success : function(data) {
										console.log(data);
										$('#bookmark_list_ul').empty();
										if (data.length >= 1) {
											data
													.forEach(function(item) {
														str = '<li id="bookmark_list_li">';
														if (item.bidentifier == '1') { // 글
															str += '<div class="board_kind"><i class="far fa-file-alt" style="width:50px;"></i><span class="board_kind_type">';
															str += ' 글</span></div>';
														} else if (item.bidentifier == '2') { // 업무
															str += '<div class="board_kind"><i class="fas fa-list-ul" style="width:50px;"></i><span class="board_kind_type">';
															str += ' 업무</span></div>';
														} else { // 일정
															str += '<div class="board_kind"><i class="far fa-calendar-alt" style="width:50px;"></i><span class="board_kind_type">';
															str += ' 일정</span></div>';
														}
														str += '<div class="board_text_wrap"><div class="board_name">'
																+ item.title
																+ '</div>';
														str += '<p class="board_project_name">'
																+ item.pname
																+ '</p></div>';
														str += '<div class="bookmark_list_right"><div class="bookmark_list_name">'
																+ item.bwriter
																+ '</div>';
														str += '<div class="bookmark_list_date">'
																+ item.day
																+ '</div></div></li>'

														$('#bookmark_list_ul')
																.append(str);
														bookmarkCount++;
														bookmarkCount_task = bookmarkCount;
													});
										}
									}
								});
						$
								.ajax({
									type : "POST",
									url : "/searchBookmark_text", // 데이터를 주고받을
									// 파일 주소
									dataType : "json",
									data : "bname=" + bname,
									async : false,
									success : function(data) { // 파일 주고받기가 성공했을
										// 경우. data 변수
										// 안에 값을 담아온다.
										console.log(data);
										if (data.length >= 1) {
											data
													.forEach(function(item) {
														str = '<li id="bookmark_list_li">';
														if (item.bidentifier == '1') {
															str += '<div class="board_kind"><i class="far fa-file-alt" style="width:50px;"></i><span class="board_kind_type">';
															str += ' 글</span></div>';
														} else if (item.bidentifier == '2') {
															str += '<div class="board_kind"><i class="fas fa-list-ul" style="width:50px;"></i><span class="board_kind_type">';
															str += ' 업무</span></div>';
														} else {
															str += '<div class="board_kind"><i class="far fa-calendar-alt" style="width:50px;"></i><span class="board_kind_type">';
															str += ' 일정</span></div>';
														}
														str += '<div class="board_text_wrap"><div class="board_name">'
																+ item.title
																+ '</div>';
														str += '<p class="board_project_name">'
																+ item.pname
																+ '</p></div>';
														str += '<div class="bookmark_list_right"><div class="bookmark_list_name">'
																+ item.bwriter
																+ '</div>';
														str += '<div class="bookmark_list_date">'
																+ item.day
																+ '</div></div></li>'

														$('#bookmark_list_ul')
																.append(str);
														bookmarkCount++;
														bookmarkCount_text = bookmarkCount
																- bookmarkCount_task;
													});
										}
									}
								});
						$
								.ajax({
									type : "POST",
									url : "/searchBookmark_schedule", // 데이터를
									// 주고받을
									// 파일 주소
									dataType : "json",
									data : "bname=" + bname,
									async : false,
									success : function(data) { // 파일 주고받기가 성공했을
										// 경우. data 변수
										// 안에 값을 담아온다.
										console.log(data);
										if (data.length >= 1) {
											data
													.forEach(function(item) {
														str = '<li id="bookmark_list_li">';
														if (item.bidentifier == '1') {
															str += '<div class="board_kind"><i class="far fa-file-alt" style="width:50px;"></i><span class="board_kind_type">';
															str += ' 글</span></div>';
														} else if (item.bidentifier == '2') {
															str += '<div class="board_kind"><i class="fas fa-list-ul" style="width:50px;"></i><span class="board_kind_type">';
															str += ' 업무</span></div>';
														} else {
															str += '<div class="board_kind"><i class="far fa-calendar-alt" style="width:50px;"></i><span class="board_kind_type">';
															str += ' 일정</span></div>';
														}
														str += '<div class="board_text_wrap"><div class="board_name">'
																+ item.title
																+ '</div>';
														str += '<p class="board_project_name">'
																+ item.pname
																+ '</p></div>';
														str += '<div class="bookmark_list_right"><div class="bookmark_list_name">'
																+ item.bwriter
																+ '</div>';
														str += '<div class="bookmark_list_date">'
																+ item.day
																+ '</div></div></li>'

														$('#bookmark_list_ul')
																.append(str);
														bookmarkCount++;
														bookmarkCount_schedule = bookmarkCount
																- bookmarkCount_task
																- bookmarkCount_text;
													});
										}
									}
								});
						$('#bookmark_count').text(bookmarkCount);
						$('#bookmark_count_text').text(bookmarkCount_text);
						$('#bookmark_count_task').text(bookmarkCount_task);
						$('#bookmark_count_schedule').text(
								bookmarkCount_schedule);

						$('.searchBtn').click(function() {
							console.log('searchBtn click!');
							searchBookmark();
						});
					});

				});