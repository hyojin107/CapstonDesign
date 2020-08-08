<%@page import="java.util.Map"%>
<%@page import="com.gbhz.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%><%
	Map loginUser = (Map)session.getAttribute("user");
	//UserVO userVO = (UserVO)session.getAttribute("loginInfo");
	//session.setAttribute("loginInfo", "AAAA");
%><!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="css/contents.css"/>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
	<c:if test="${ loginInfo ne null && loginInfo ne '' }">
		<script type="text/javascript">
			var gLogin = true;
		</script>
	</c:if>
</head>
<body class="important">
<div class="header">
	<div class="menu-icon">
		<div class="menu">
			<span class="close-menu">X</span>
			<div>웹서비스 전체 메뉴</div>
			<ul>
				<li>
					<span><a href="content.jsp?body=service-info">서비스소개</a></span>
					<ul>
						<li><span><a href="content.jsp?body=service-info">서비스 개요</a></span></li>
						<li><span><a href="#">신청 안내</a></span></li>
					</ul>
				</li>
				<c:if test="${ loginInfo ne null && loginInfo ne '' }">
					<li>
					<span><a href="content.jsp?body=lease-map">야적장 임대 신청</a></span>
					<ul>
						<li><span><a href="content.jsp?body=lease-map">야적장 임대 신청</a></span></li>
						<li><span><a href="content.jsp?body=lease-list&user_id=user1">현재 사용 중인 야적장</a></span></li>
						<li><span><a href="content.jsp?body=lease-list&user_id=user1&view=history">임대 신청 이력</a></span></li>
					</ul>
					</li>
					<li><span><a href="content.jsp?body=statistics-list">통계자료</a></span></li>
				</c:if>
				<c:if test="${loginInfo eq null || loginInfo eq ''}">
					<li>
						<span><a href="content.jsp?body=lease-map">야적장 조회</a></span>
					</li>
				</c:if>
				<li><span><a href="content.jsp?body=board-list">공지사항</a></span></li>
			</ul>
		</div>
	</div>
	<div class="title"><span>울산항만공사</span><span>야적장임대관리서비스</span></div>
	<div class="service-info">서비스소개</div>
	<c:if test="${loginInfo ne null && loginInfo ne ''}">
		<div class="user-info">
			<div>
				<div class="menu-top-pin"></div>
				<span class="user-name">(주) ${user.VENDER_NAME}<br/><b>${user.USER_NAME}</b> 님,<br/> 안녕하세요</span>
				<ul>
					<li><a href="/member.jsp">회원 정보 수정</li>
					<li><a href="content.jsp?body=lease-list&view=history&user_id=user1">임대 계약 관리</a></li>
					<li class="logout"><b>로그아웃</b></li>
				</ul>
			</div>
		</div>
	</c:if>
	<c:if test="${loginInfo eq null || loginInfo eq ''}">
		<div class="login"><a href="${pageContext.request.contextPath }/login.jsp">로그인</a></div>
	</c:if>
</div>
<div class="body-frame">
	<div class="side">
		<h2>문의사항</h2>
		<ul>
			<li class="active">FAQ</li>
			<li>1:1문의</li>
		</ul>
	</div>
	<div class="body"><jsp:include page="/WEB-INF/content-jsp/${param.body}.jsp"></jsp:include></div>
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
			<option value="/adminLogin.jsp">관리자 페이지</option>
		</select>
	</div>
</div>
<script type="text/javascript">
	// 메뉴아이콘을 클릭하면 메뉴 고정
	$(".header .menu-icon").on("click", function() {
		$("body").addClass("show-menu");
		$(".header .menu-icon .menu .close-menu").show();
	});
	// 메뉴가 보일때 닫기 버튼 (X)
	$(".header .menu-icon .menu .close-menu").on("click", function(ev) {
		$("body").removeClass("show-menu");
		
		ev.stopPropagation(); // 상위 엘리먼트로 이벤트 전파 중지
		ev.stopImmediatePropagation(); // 이벤트 이후 동일 액션에 대한 이벤트 수행 중단
		ev.preventDefault(); // 엘리먼트 기본 동작 중지 ( a tag link 이동 등 )
		$(".header .menu-icon .menu").hide();
		$(this).hide(); // this는 이벤트를 받은 엘리먼트 자신을 의미
		setTimeout(function() { $(".header .menu-icon .menu").css("display",""); }, 100);
		return false; // ev.preventDefault()와 동일
	});
	// 사용자 정보 클릭시 세부 정보 보임/숨김
	$(".user-info").on("click", function(ev) {
		$(this).toggleClass("active"); // class "active"가 있으면 빼고, 없으면 추가
	});
	
	// title을 클릭하면 메인으로 이동
	$(".header .title,.footer .title").on("click", function() {
		window.location.href = "/";
	});
	// 로그아웃
	$(".logout").on("click", function() {
		if (!confirm("로그아웃을 진행하시겠습니까 ?")) return;
		$.post("/logout.jsp", function() {
			window.location.href = "/";
		});
	});
</script>
</body>
</html>