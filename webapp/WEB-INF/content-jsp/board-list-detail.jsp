<%@page import="java.util.Map"%>
<%@page import="com.gbhz.DB"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
	String board_id = request.getParameter("no");
	String query = "SELECT * FROM TB_BOARD WHERE BOARD_ID='@BOARD_ID@'";
	query = query.replaceAll("@BOARD_ID@", board_id);
	Map<Object, Object> board = DB.selectDetail(query);
	request.setAttribute("board", board);
	
	String query2 = "UPDATE TB_BOARD SET VIEWS = VIEWS + 1 WHERE BOARD_ID = '@BOARD_ID@';";
	query2 = query2.replaceAll("@BOARD_ID@", board_id);
	DB.update(query2);
	
	pageContext.setAttribute("newLineChar", "\n");
%>
<table class="table-type01 table-type04">
	<tr>
		<th colspan="4">${board.TITLE}</th>
	</tr>
	<tr>
		<td>관리자</td>
		<td style="width:20em;">　</td>
		<td>${board.DATE}</td>
		<td>${board.VIEWS}</td>
	</tr>
	<tr>
		<td colspan="4">${fn:replace(board.CONTENTS, newLineChar, "<br/>")}</td>
	</tr>
</table>

<div style="text-align: right">
	<input type="button" value="목록으로" class="blue-button" onClick="location.href='content.jsp?body=board-list'">
	<c:if test="${user.USER_PERMISSION eq 'ADMIN'}">
		<input type="button" value="글 수정" class="blue-button" onClick="modifyBtn();">
		<input type="button" value="글 삭제" class="blue-button" onClick="deleteBtn();">
	</c:if>
</div>

<script type="text/javascript">
	$(".body-frame").addClass("no-sub");
	function modifyBtn(){
		var link = "content.jsp?body=board-modify&no=" + ${board.BOARD_ID};
		location.href = link;
	}
	function deleteBtn(){
		if(!confirm("정말 삭제하시겠습니까?\n삭제한 글은 복구할 수 없습니다.")){
			return;
		} else{
			var link = "board-delete.jsp?no=" + ${board.BOARD_ID};
			location.href = link;
		}
	}
</script>