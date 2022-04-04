<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이메일 인증</title>
</head>
<body>
	<script type="text/javascript">
		var email = '${email}';

		alert(email + '님 회원가입을 축하합니다. 이제 로그인이 가능 합니다.');

		window.open('', '_self', '');

		self.location = '/';
	</script>
</body>
</html>