<%@page import="com.gbhz.DB"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
	String board_id = request.getParameter("no");
	String query = "DELETE FROM TB_BOARD WHERE BOARD_ID='@BOARD_ID@';";
	query = query.replaceAll("@BOARD_ID@", board_id);
	DB.update(query);
%>
<script type="text/javascript">
	alert("글이 삭제되었습니다.");
	location.href="content.jsp?body=board-list";
</script>