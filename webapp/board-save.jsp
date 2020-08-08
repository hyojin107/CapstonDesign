<%@page import="com.gbhz.DB"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
	String title = request.getParameter("btitle");
	String content = request.getParameter("bcontent");
	
	String query = "INSERT INTO TB_BOARD(TITLE,CONTENTS,WRITER_ID)";
	query += " VALUES('@TITLE@','@CONTENTS@','admin')";
	
	query = query.replaceAll("@TITLE@", title);
	query = query.replaceAll("@CONTENTS@", content);
	
	DB.update(query);
%>
<script type="text/javascript">
	alert("글 등록이 완료되었습니다.");
	location.href="content.jsp?body=board-list";
</script>