<!-- 마이페이지 회원정보 수정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.gbhz.DB"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	/* String USER_ID = request.getParameter("id"); */
	String USER_ID = (String)session.getAttribute("id");
	String USER_PASSWD = request.getParameter("pwd");
	String USER_PHONE = request.getParameter("phone");
	String USER_NAME = request.getParameter("sname"); //담당자 이름
	String USER_EMAIL = request.getParameter("email");
	//업체
	String VENDER_NAME = request.getParameter("workName");
	String VENDER_LICENSE_NUMBER = request.getParameter("licenseNumber");
	String VENDER_LICENSE_SCAN = request.getParameter("licenseScan");
	String VENDER_ADDRESS = request.getParameter("venderAddr");
	String VENDER_PHONE = request.getParameter("workNumber");
	
	String user_id = request.getParameter("user_id");
	String vender_id = request.getParameter("vender_id");
	
	// 사용자 데이터
	Map<Object, Object> user = DB.selectDetail("select * from TB_USER WHERE USER_ID = '"+user_id+"'");
	request.setAttribute("user",user);
	// 업체 데이터
	Map<Object, Object> vender = DB.selectDetail("select * from TB_VENDER WHERE VENDER_ID = '"+vender_id+"'");
	request.setAttribute("vender",vender);
	
	String query = "UPDATE TB_USER SET USER_PASSWD=?, USER_NAME=?, USER_PHONE=?, USER_EMAIL=?";
	query = query.replaceAll("@USER_PASSWD@", USER_PASSWD);
	query = query.replaceAll("@USER_NAME@", USER_NAME);
	query = query.replaceAll("@USER_PHONE@", USER_PHONE);
	query = query.replaceAll("@USER_EMAIL@", USER_EMAIL);
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원정보수정</title>
		<link rel="stylesheet" type="text/css" href="css/member.css"/>
		
		<script type="text/javascript">
			function openWindow(theURL, winName, features){
				window.open(theURL, winName, features);
			}
			
			function checkValue(){
				if(document.userInfo.id.value==""){
					alert("아이디를 입력하세요.");
					return false;
				}
				if(!document.userInfo.pwd.value){
					alert("비밀번호를 입력하세요.");
					return false;
				}
				if(document.userInfo.pwd.value != document.userInfo.pwdCheck.value){
					alert("비밀번호를 동일하게 입력하세요.");
					return false;
				}
				if(!document.userInfo.sname.value){
					alert("담당자 이름을 입력하세요.");
					return false;
				}
				if(!document.userInfo.phone.value){
					alert("담당자 연락처를 입력하세요.");
					return false;
				}
				if (document.userInfo.phone.value.indexOf("010") < 0) {
			        alert('번호 형식이 틀립니다. 010을 포함하여 작성해주세요.');
			        document.userInfo.email.focus();
			        return false;
			     }
				if (document.userInfo.phone.value.indexOf("-") < 0) {
			        alert('번호 형식이 틀립니다. -를 포함하여 작성해주세요.');
			        document.userInfo.email.focus();
			        return false;
			     }
				if(!document.userInfo.email.value){
					alert("담당자 이메일을 입력하세요.");
					return false;
				}
				if (document.userInfo.email.value.indexOf("@") < 0) {
			        alert('Email주소 형식이 틀립니다. @포함하여 작성해주세요.');
			        document.userInfo.email.focus();
			        return false;
			      }
			      if (document.userInfo.email.value.indexOf(".") < 0) {
			        alert('Email 도메인 주소가 틀립니다.');
			        document.userInfo.email.focus();
			        return false;
			      }
				if(!document.userInfo.workName.value){
					alert("업체명을 입력하세요.");
					return false;
				}
				if(!document.userInfo.licenseNumber.value){
					alert("사업자 등록번호를 입력하세요.");
					return false;
				}
				if(!document.userInfo.venderAddr.value){
					alert("업체 주소를 입력하세요.");
					return false;
				}
				if(!document.userInfo.workNumber.value){
					alert("업체 전화번호를 입력하세요.");
					return false;
				}
			}
		</script>
	</head>
	<body>
		<h1>야적장임대마스터</h1>
	    <h2>-회원가입-</h2>
	    <h3>기본 정보</h3>
	    <form action="join.jsp" method="POST" name="userInfo" onsubmit="return checkValue()">
	        <table class="tablef" width="1000px">            
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="id">아이디</label>
	                </td>
	                <td>
	                    <%=USER_ID %>	//id는 수정불가
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="pwd">비밀번호</label>
	                </td>
	                <td>
                    	<input type="password" name="pwd" id="pwd" size="30" value="<%=USER_PASSWD %>"> 
                    <br/>*영문 대소문자/숫자/특수문자를 혼용하여 2종류 6~12자
                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="pwdCheck">비밀번호 확인</label>
	                </td>
	                <td>
	                    <input type="password" name="pwdCheck" id="pwdCheck" size="30" value="<%=USER_PASSWD %>">
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="sname">담당자 이름</label>
	                </td>
	                <td>
	                    <input type="text" name="sname" id="sname" size="30" value="<%=USER_NAME %>"> 
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="phone">담당자 연락처</label>
	                </td>
	                <td>
	                    <input type="text" name="phone" id="phone" size="30" minlength="10" maxlength="13" value="<%=USER_PHONE %>">
	                	(010포함하여 입력해주세요.)
                	</td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="email">담당자 이메일</label>
	                </td>
	                <td>
	                    <input type="text" name="email" id="email" size="35" value="<%=USER_EMAIL %>">
	                </td>
	            </tr>
	        </table>
	
	<!-----------------------------------------------업체 정보----------------------------------------------------->
	
	    <h3 class="h3add">업체 정보</h3>
	        <table class="tablef" width="1000px">
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="workName">업체명</label>
	                </td>
	                <td>
	                    <input type="text" name="workName" id="workName" size="30" value="<%=VENDER_NAME %>">
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="licenseNumber">사업자 등록번호</label>
	                </td>
	                <td>
	                	<input type="text" name="licenseNumber" id="licenseNumber" size="30" maxlength="25" value="<%=VENDER_LICENSE_NUMBER %>">
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="licenseScan">사업자등록증</label>
	                </td>
	                <td>
	                    <input type="file" name="licenseScan" value="<%=VENDER_LICENSE_SCAN %>">
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="venderAddr">업체주소</label>
	                </td>
	                <td>
	                    <input type="text" name="venderAddr" id="venderAddr" size="45" value="<%=VENDER_ADDRESS %>">
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="workNumber">업체 전화 번호</label>
	                </td>
	                <td>
	                	 <input type="text" name="workNumber" id="workNumber" size="30" maxlength="11" value="<%=VENDER_PHONE %>">
	                </td>
	            </tr>
	        </table>
	        <input type="hidden" name="id_check">
	        <input class="btnclick" type="submit" id="join" value="수정완료" onClick="join.jsp">
	    </form>
	</body>
</html>