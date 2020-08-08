<%@page import="com.gbhz.DB"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
	String board_id = request.getParameter("no");
	String title = request.getParameter("btitle");
	String content = request.getParameter("bcontent");
	
	String query = "UPDATE TB_BOARD SET TITLE='@TITLE@', CONTENTS='@CONTENTS@' WHERE BOARD_ID='";
	query += board_id;
	query += "';";
	
	query = query.replaceAll("@TITLE@", title);
	query = query.replaceAll("@CONTENTS@", content);
	
	DB.update(query);
%>
<script type="text/javascript">
	alert("글이 수정되었습니다.");
	location.href="content.jsp?body=board-list";
</script>