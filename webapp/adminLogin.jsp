<%@page import="com.gbhz.DB"%>
<%@page import="java.util.Map"%>
<%@page import="com.gbhz.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	String userId=request.getParameter("userId");
	String userPw=request.getParameter("userPw");
	if (userId==null || userId.trim().length()<1 ||
		userPw==null || userPw.trim().length()<1
	) {
		session.invalidate();		
	} else {
				UserVO userVO= new UserVO();
		userVO.setUserId(userId);
		userVO.setUserNm("관리자");
		userVO.setUserCorp("(주)파랑미니언즈");
		session.setAttribute("loginInfo", userVO);
		String body = request.getParameter("body");
		if (body==null || body.trim().length()<1) {
			// 사용자 loging.jsp에서 로그인
			response.sendRedirect("/");
		} else {
			// 로그인 안된 상태의 다른화면에서 리다이렉트된 로그인 ==> 로그인 후 해당페이지 이동
			//String fUrl = request.getAttribute("javax.servlet.forward.request_uri");
			response.sendRedirect("/content.jsp?body="+body);
		}
	}
%><!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>울산항만공사 - 야적장임대관리서비스 - 로그인</title>
	<link rel="stylesheet" href="css/contents.css"/>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
</head>
<body class="login">
	<div class="login-form">
		<div class="home">
			<h2>울산항만공사</h2>
			<h3>야적장임대관리서비스</h3>
		</div>
		<form action="" method="post">
			<input type="text" id="userId" name="userId">
			<input type="password" id="userpw" name="userPw">
			<input type="button" value="로그인" id="loginBtn" onclick="loginBtn();">
		</form>
		<ul>
			<li><a href="member.jsp">회원가입</a></li>
			<li><a href="#">아이디/비밀번호 찾기</a></li>
		</ul>
	</div>
</body>
</html>
<script type="text/javascript">
	function loginBtn(){
		var tmpLogin = document.getElementById("userId").value;
		if(tmpLogin!="admin"){
			alert("관리자 권한이 없습니다. 초기 화면으로 이동합니다.");
			return;
		}
		var form = $("#loginBtn");
		form.submit();
	}
</script>