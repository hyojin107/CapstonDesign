<%@page import="com.gbhz.DB"%>
<%@page import="java.util.Map"%>
<%@page import="com.gbhz.UserVO"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	String userId=request.getParameter("userId");
	String userPw=request.getParameter("userPw");
	
	if (userId==null || userId.trim().length()<1 ||
		userPw==null || userPw.trim().length()<1
	) {
		session.invalidate();		
	} else {
		String loginSql = "SELECT * FROM parang_db.tb_user AS U LEFT OUTER JOIN parang_db.tb_vender AS V ON ( U.VENDER_ID = V.VENDER_ID ) WHERE U.USER_ID='@ID@' AND U.USER_PASSWD='@PW@'";
		loginSql = loginSql.replaceAll("@ID@", userId).replaceAll("@PW@", userPw);
		Map<Object, Object> user = DB.selectDetail(loginSql);
		if (user != null){
			session.setAttribute("user",user);
			
			UserVO userVO= new UserVO();
			userVO.setUserId(userId);
			userVO.setUserNm((String)user.get("USER_NAME"));
			userVO.setUserCorp((String)user.get("VENDER_NAME"));
			userVO.setVenderId((String)user.get("VENDER_ID"));
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
		} else {
			request.setAttribute("errorMessage", "사용자 ID 또는 비밀번호가 잘못되었습니다.");
		}
	}
%><!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>울산항만공사 - 야적장임대관리서비스 - 로그인</title>
	<link rel="stylesheet" href="css/contents.css"/>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
	<c:if test="${errorMessage ne null and errorMessage ne ''}">
		<script type="text/javascript">
			alert("${errorMessage}");
		</script>
	</c:if>
</head>
<body class="login">
	<div class="login-form">
		<div class="home" OnClick="location.href='/'">
			<h2>울산항만공사</h2>
			<h3>야적장임대관리서비스</h3>
		</div>
		<form action="" method="post">
			<input type="text" id="userId" name="userId">
			<input type="password" id="userpw" name="userPw">
			<input type="submit" value="로그인">
		</form>
		<ul>
			<li><a href="member.jsp">회원가입</a></li>
			<li><a href="#">아이디/비밀번호 찾기</a></li>
		</ul>
	</div>
</body>
</html>