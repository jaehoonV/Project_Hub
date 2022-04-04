$(document).ready(function() {
	$('#resetPwChk').click(function() {
		var email = '${email}';
		var password = $('#password').val();
		var passwordChk = $('#passwordChk').val();

		// 비밀번호, 비밀번호 확인 미입력시 validation
		if ($('#password').val() == "" || $('#passwordChk').val() == "") {
			$('#resetPwFrm').submit();
		} else {
			$.ajax({
				type : "POST",
				url : '/resetPw',
				data : {
					email : email,
					password : password,
				},
				success : function(data) {
					$('#resetPwFrm').submit();
				}
			});
		}
	});
	$('#resetPwFrm').validate({
		rules : {
			password : {
				required : true,
				rangelength : [ 8, 16 ]
			},
			passwordChk : {
				required : true,
				equalTo : '#password'
			}
		},
		messages : {
			password : {
				required : "새 비밀번호를 입력해 주세요.",
				rangelength : "새 비밀번호는 {0}자에서 {1}자까지 사용 가능합니다."
			},
			passwordChk : {
				required : "새 비밀번호 확인을 입력해 주세요.",
				equalTo : "새 비밀번호와 동일하게 입력해 주세요."
			}
		},
		submitHandler : function() { // 유효성 검사를 통과시 전송
			resetPwFrm.submit();
			console.log("submitHandler >>> function");
			alert("비밀번호 재설정이 완료되었습니다.");
		},
		success : function(e) {
			//
		}
	});// end validate()
});