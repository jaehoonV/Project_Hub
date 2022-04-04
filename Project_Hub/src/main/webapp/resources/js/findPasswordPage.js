$(document).ready(function() {
	$('#findPwChk').click(function() {
		var name = $('#name').val();
		var email = $('#email').val();

		// 이름이나 이메일 미입력시 validation
		if ($('#name').val() == "" || $('#email').val() == "") {
			$('#findPasswordFrm').submit();
		} else {
			$.ajax({
				type : "POST",
				url : '/findPw',
				data : {
					name : name,
					email : email
				},
				success : function(data) {
					if (data == "true") {
						$('#findPasswordFrm').submit();
					} else if (data == "false") {
						$('#sysError').css('display', 'none');
						$('#error').css('display', 'block');
					} else if (data == "sysError") {
						$('#error').css('display', 'none');
						$('#sysError').css('display', 'block');
					}
				}
			});
		}
	});
	$('#findPasswordFrm').validate({
		rules : {
			name : {
				required : true
			},
			email : {
				required : true,
				email : true
			}
		},
		messages : {
			name : {
				required : "이름을 입력해 주세요."
			},
			email : {
				required : "이메일을 입력해 주세요.",
				email : "이메일 형식에 맞춰 입력해주세요."
			}
		},
		submitHandler : function() { // 유효성 검사를 통과시 전송
			findPasswordFrm.submit();
			alert("인증 메일을 발송하였습니다. e-mail을 확인해주세요.");
		},
		success : function(e) {
			//
		}
	});// end validate()
});