<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>울산항만공사 - 야적장임대관리서비스</title>
	<link rel="stylesheet" href="css/contents.css"/>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
</head>
<body class="main">
	<div class="main-frame">
		<div class="main-logo"></div>
		<div class="favorite-menu">
			<ul>
				<li class="link-service"><a href="content.jsp?body=service-info">서비스 소개</a></li>
				<li class="link-Lease"><a href="content.jsp?body=lease-map">임대신청</a></li>
				<li class="link-stat"><a href="content.jsp?body=statistics-list">임대통계</a></li>
				<li class="link-noti"><a href="content.jsp?body=board-list">공지사항</a></li>
			</ul>
		</div>
	</div>
	<div class="footer">
		<div class="title"><span>울산항만공사</span><span>야적장임대관리서비스</span></div>
		<ul>
			<li><a href="#">개인 정보 처리 방침</a></li>
			<li><a href="#">영상정보처리기기 운영·관리 방침</a></li>
			<li><a href="#">저작권 정책</a></li>
			<li><a href="#">이메일무단수집 거부</a></li>
			<li><a href="#">찾아오시는 길</a></li>
		</ul>
		<p>(44780) 울산광역시 남구 장생포고래로 271 / TEL : 052-228-5329 FAX : 052-228-5329<br/>COPYRIGHT 2019 PARANGM ALL RIGHT RESERVED.</p>
		<div class="family-site">
			<select onchange="if(this.value) location.href=(this.value);">
				<option>울산항만공사</option>
				<option value="/content.jsp?body=register-field">관리자 페이지</option>
			</select>
		</div>
	</div>
</body>
</html>