<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.gbhz.DB"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
	String startNum = request.getParameter("startNum");
	if (startNum==null || startNum.length()<1) startNum="0";
	String sql = "SELECT concat(@RN:=@RN+1, '') AS SN,  A.*, date_format(DATE, '%Y-%m-%d') as date_ymd, (SELECT COUNT(*) FROM parang_db.TB_BOARD) as TOT_CNT ";
	sql += "FROM parang_db.TB_BOARD A, (SELECT @RN:=@startNum@) TMP ORDER BY DATE DESC LIMIT @startNum@, 10 ";
	sql = sql.replaceAll("@startNum@", startNum);
	List<Map<Object, Object>> list = DB.select(sql);
	request.setAttribute("list", list);
	
	long pageCount=0;
	if (list!=null && list.size()>0) {
		System.out.println(list.get(0).get("TOT_CNT").getClass().getName());
		long totCnt = (Long)list.get(0).get("TOT_CNT");
		pageCount = (totCnt+5)/10;
	}
	request.setAttribute("pageCount", pageCount);
%>
<h2>공지사항</h2>
<div class="search-box">
	<select name="condition">
		<option>제목</option>
		<option>내용</option>
		<option>작성자</option>
	</select>
	<input id="userTitle">
	<input name="searchBtn" class="blue-button" type="submit" value="검색">
</div>

<table class="table-type01 table-type04">
	<tr>
		<th style="width:6em;">번호</th>
		<th>제목</th>
		<th style="width:10em;">작성자</th>
		<th style="width:12em;">작성일자</th>
		<th style="width:10em;">조회수</th>
	</tr>
	<c:forEach items="${list}" var="tr">
		<tr>
			<td class="td-type01">${tr.SN}</td>
			<td class="td-type02"><a href="content.jsp?body=board-list-detail&no=${tr.BOARD_ID}">${tr.TITLE}</a></td>
			<td class="td-type01">관리자</td>
			<td class="td-type01">${tr.date_ymd}</td>
			<td class="td-type01">${tr.VIEWS}</td>
		</tr>
	</c:forEach>
</table>

<div style="text-align: right">
	<c:if test="${user.USER_PERMISSION eq 'ADMIN'}">
		<input type="button" id="writeBtn" value="글 등록" onClick="location.href='content.jsp?body=board-write'" class="blue-button">
	</c:if>
</div>

<div class="list-page-num">
	<ul>
		<li class="no-action">-</li><c:forEach begin="1" step="1" end="${pageCount}" var="pg"><li>${pg}</li></c:forEach><li class="no-action">-</li>
	</ul>
</div>
<form action="" method="post" id="goPage">
	<input type="hidden" name="body" value="${param.body}"/>
	<input type="hidden" name="startNum" value="${param.startNum}"/>
</form>
<script type="text/javascript">
	var currentPage = Math.ceil( (("${param.startNum}"||"0")*1)/10 );
	$(".list-page-num li:not(.no-action)").on("click", function() {
		// 페이지 이동
		$("[name=startNum]").val(($(this).text()-1)*10);
		$("#goPage").submit();
	}).eq(currentPage).addClass("active");
</script>

<script type="text/javascript">
	$(".body-frame").addClass("no-sub");
</script>