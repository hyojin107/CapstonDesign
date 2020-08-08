<%@page import="com.gbhz.DB"%>
<%@page import="java.util.Map"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
	String board_id = request.getParameter("no");
	String query = "SELECT * FROM TB_BOARD WHERE BOARD_ID='@BOARD_ID@'";
	query = query.replaceAll("@BOARD_ID@", board_id);
	Map<Object, Object> board = DB.selectDetail(query);
	request.setAttribute("board", board);
%>
<form action="board-update.jsp?no=${board.BOARD_ID}" method="post" id="update">
	<table class="table-type01 table-type04">
		<tr>
			<th style="width:6em;">제목</th>
			<td><input type="text" id="btitle" name="btitle" class="width-setting" value="${board.TITLE}"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea id="bcontent" name="bcontent" class="width-setting height-setting">${board.CONTENTS}</textarea></td>
		</tr>
	</table>
	
	<div style="text-align: right">
		<input type="reset" value="초기화" class="blue-button">
		<input type="button" value="작성 취소" class="blue-button" onClick="cancelCheck();">
		<input type="button" value="글 수정" class="blue-button" onClick="emptyCheck();">
	</div>
</form>

<script type="text/javascript">
	$(".body-frame").addClass("no-sub");
	function cancelCheck(){
		if(!confirm("정말 취소하시겠습니까?\n입력 취소한 글은 복구할 수 없습니다.")){
			return;
		} else{
			var link = "content.jsp?body=board-list-detail&no=" + ${board.BOARD_ID};
			location.href = link;
		}
	}
	function emptyCheck(){
		var titleLen = $("#btitle").val().length;
		var contentLen = $("#bcontent").val().length;
		if(titleLen<1){
			alert("제목을 입력하세요.");
		} else if(contentLen<1){
			alert("내용을 입력하세요.");
		}else{
			var form = $("#update");
			form.submit();
		}
	}
</script>