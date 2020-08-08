<%@ page info="userid check" errorPage="error.jsp"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@page import="com.gbhz.DB"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" import="java.sql.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	String userid =request.getParameter("id");
	
	List<Map<Object, Object>> user = DB.select("Select count(*) as count from TB_USER WHERE USER_ID= '"+userid+"'");
	Map<Object, Object> user2 = user.get(0);
	int test = Integer.parseInt((user2.get("count")).toString());
	System.out.println(test);
	
%>

<html>
	<head>
		<title>아이디 중복검사</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link rel="StyleSheet" href="style.css" type="text/css">
		<script language="JavaScript">
	
			function checkEnd(){
			 var form = document.id_check;
			 opener.userInfo.id.value       = form.userid.value;
			 opener.userInfo.id_check.value = form.test.value;
			 self.close();
			}
			
			function doCheck(){
			 var form = document.id_check;
			 if(!callBack(form.userid, 6, 12)){
			  return;
			 }
			 form.submit();
			}
			
			function callBack(target, lmin, lmax){
				var Alpha = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
				var Digit = '1234567890'
				var astr = Alpha + Digit;
				var i;
				var tValue = target.value;
				if(tValue.length<lmin || tValue.length>lmax){
					if(lmin==lmax){ alert('아이디는 ' + lmin + '글자 이상이어야 합니다.'); }
					else alert('아이디는 ' + lmin + '~' + lmax + '글자 이내로 입력하셔야 합니다.');
					target.focus();
					return false;
				}	
				if(astr.length > 1){
					for(i=0; i<tValue.length; i++){
						if(astr.indexOf(tValue.substring(i, i+1)) < 0){
							alert('아이디에 허용할 수 없는 문자가 입력되었습니다.');
							target.focus();
							return false;
						}
					}
				}
				return true;
			} 
		</script>
	</head>

<body text="#000000" bgcolor="#FFFFFF" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
	<br />
	<br />
	<form name="id_check" method="post" action="id_check.jsp">
		<input type="hidden" name="test" value="<%=test%>">
		<table width="300" border="0" cellspacing="0" cellpadding="0"
			align="center" class="style1">
			<tr>
				<td>원하는 아이디를 입력하세요.</td>
			</tr>
		</table>
		<table width="380" border="0" bgcolor="#B6C1D6" height="39"
			align="center" class="style1">
			<tr>
				<td bgcolor="#ffffff" width="40%" align="center">
					<input type="text" name="userid" value="<%=userid%>" onFocus="this.value=''" maxlength="16" size="16" class="input_style1">
					<!-- <input type="button" value="중복확인" onClick="doCheck()" class="input_style1"></td> -->
			</tr>
			<tr>
				<td>
					<%
						if (test > 0) {
					%> ▶ [<%=userid%>]은 등록되어있는 아이디입니다.<br>▷ 다시 시도해주십시오. <%
						} else {
					%> ▶ [<%=userid%>]은 사용 가능합니다. <%
						}
					%>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" salign="center">
			<tr>
				<td align="center"><input type="button" value="확인" onClick="checkEnd()" class="style1"></td>
			</tr>
		</table>
	</form>
</body>
</html>