<!-- 회원가입 등록 -->

<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.gbhz.DB"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String USER_ID = request.getParameter("id");
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
	
	
	
	String query = "INSERT INTO TB_USER(USER_ID, USER_PASSWD, USER_NAME, USER_PERMISSION, USER_PHONE, USER_EMAIL, VENDER_ID)";
	query += " VALUES('@USER_ID@','@USER_PASSWD@','@USER_NAME@','@USER_PERMISSION@','@USER_PHONE@','@USER_EMAIL@','@VENDER_ID@')"; 
	query = query.replaceAll("@USER_ID@", USER_ID);
	query = query.replaceAll("@USER_PASSWD@", USER_PASSWD);
	query = query.replaceAll("@USER_NAME@", USER_NAME);
	query = query.replaceAll("@USER_PERMISSION@","VENDER");
	query = query.replaceAll("@USER_PHONE@", USER_PHONE);
	query = query.replaceAll("@USER_EMAIL@", USER_EMAIL);
	
	String query2 = "INSERT INTO TB_VENDER(VENDER_NAME, VENDER_LICENSE_NUMBER, VENDER_LICENSE_SCAN, VENDER_ADDRESS, VENDER_PHONE)";
	query2 += " VALUES('@VENDER_NAME@','@VENDER_LICENSE_NUMBER@','@VENDER_LICENSE_SCAN@','@VENDER_ADDRESS@','@VENDER_PHONE@')";
	query2 = query2.replaceAll("@VENDER_NAME@", VENDER_NAME);
	query2 = query2.replaceAll("@VENDER_LICENSE_NUMBER@", VENDER_LICENSE_NUMBER);
	query2 = query2.replaceAll("@VENDER_LICENSE_SCAN@", VENDER_LICENSE_SCAN);
	query2 = query2.replaceAll("@VENDER_ADDRESS@", VENDER_ADDRESS);
	query2 = query2.replaceAll("@VENDER_PHONE@", VENDER_PHONE);
	 
	int updateCount = DB.update(query);
	int updateCount2 = DB.update(query2);
	
	//수정할거 - 이미지파일변환(PDF파일등도 올라가는지 확인)
	
%>
<html>
	<head>
		<title>회원가입 완료</title>
		<link rel="stylesheet" type="text/css" href="css/member.css"/>		
	</head>
	<body>
		<h1>회원가입이 완료되었습니다.</h1>
		<h3>기본 정보</h3>
		<%-- <form name="join" method="post" action="modify.jsp">
			<p>ID: <%=request.getParameter("id")%></p>
			<p>PWD: **</p>
			<p>ID: <%=request.getParameter("id")%></p>
			<p>ID: <%=request.getParameter("id")%></p>
			<p>회사명: <%=request.getParameter("workName")%></p>
	
			<button><a href="login.jsp">로그인하기</a></button>
		</form> --%>
		<form action="modify.jsp" method="POST" name="join">
	        <table class="tablef" width="1000px">            
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="id">아이디</label>
	                </td>
	                <td>
	                    <%=USER_ID %>
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="pwd">비밀번호</label>
	                </td>
	                <td>
	                    ****
	                </td>
	            </tr>
	            <!-- <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="pwdCheck">비밀번호 확인</label>
	                </td>
	                <td>
	                    <input type="password" name="pwdCheck" id="pwdCheck" size="30">
	                </td>
	            </tr>
	            <tr> -->
	                <td bgcolor="#ececec" align="center">
	                    <label for="sname">담당자 이름</label>
	                </td>
	                <td>
	                    <%=USER_NAME %>
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="phone">담당자 연락처</label>
	                </td>
	                <td>
	                    <%=USER_PHONE %>
	                </td>
	                <!-- <td>
	                    <select id="phone">
	                        <option value=""></option>
	                        <option value="010">010</option>
	                        <option value="011">011</option>
	                        <option value="019">019</option>
	                    </select>
	                    -
	                    <input type="text" name="phone" id="phone" size="4" maxlength="4"> -
	                    <input type="text" name="phone" id="phone" size="4" maxlength="4">
	                </td> -->
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="email">담당자 이메일</label>
	                </td>
	                <td>
	                    <%=USER_EMAIL %>
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
	                    <%=VENDER_NAME %>
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="licenseNumber">사업자 등록번호</label>
	                </td>
	                <td>
	                	<%=VENDER_LICENSE_NUMBER %>
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="licenseScan">사업자등록증</label>
	                </td>
	                <td>
	                    <%=VENDER_LICENSE_SCAN %>
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="venderAddr">업체주소</label>
	                </td>
	                <td>
	                    <%=VENDER_ADDRESS %> 
	                </td>
	            </tr>
	            <tr>
	                <td bgcolor="#ececec" align="center">
	                    <label for="workNumber">업체 전화 번호</label>
	                </td>
	                <td>
	                	<%=VENDER_PHONE %>
	                </td>
	            </tr>
	            <input type="hidden" name="id_check">
	            <tr>
	            	<!-- <td>
		        		<input class="btnclick" type="submit" value="확인" onClick="location='login.jsp'">
		        		<input class="btnclick" type="submit" value="수정"> -->
	        		<td colspan="2" align="center">
	        			<br/><br/><br/>
	        			<input type="button" value="확 인" onClick="location='login.jsp'">
	        			<input type="button" value="수 정" onClick="location='modify.jsp'">
	        			<br/><br/><br/>
	        		</td>
		        </tr>
	        </table>
	    </form>
		
	</body>
</html>