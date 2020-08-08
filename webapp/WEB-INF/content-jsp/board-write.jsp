<%@include file="/WEB-INF/taglib/taglib.jsp"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
	
%>
<form action="board-save.jsp" method="post" id="write">
	<table class="table-type01 table-type04">
		<tr>
			<th style="width:6em;">제목</th>
			<td><input type="text" id="btitle" name="btitle" class="width-setting"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea id="bcontent" name="bcontent" class="width-setting height-setting"></textarea></td>
		</tr>
	</table>
	
	<div style="text-align: right">
		<input type="reset" value="초기화" class="blue-button">
		<input type="button" value="작성 취소" class="blue-button" onClick="cancelCheck();">
		<input type="button" value="글 등록" class="blue-button" onClick="emptyCheck();">
	</div>
</form>

<script type="text/javascript">
	$(".body-frame").addClass("no-sub");
	function cancelCheck(){
		if(!confirm("정말 취소하시겠습니까?\n입력 취소한 글은 복구할 수 없습니다.")){
			return;
		} else{
			location.href="content.jsp?body=board-list";
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
			var form = $("#write");
			form.submit();
		}
	}
</script>