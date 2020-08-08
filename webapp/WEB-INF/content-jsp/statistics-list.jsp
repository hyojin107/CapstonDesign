<%@page import="com.gbhz.UserVO"%>
<%@page import="com.gbhz.DB"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%><%
	String startNum = request.getParameter("startNum");
	if (startNum==null || startNum.length()<1) startNum="0";
	String sql = "SELECT concat(@RN:=@RN+1, '') AS SN,  F.*, V.VENDER_NAME, (SELECT COUNT(*) FROM parang_db.TB_FIELD) as TOT_CNT FROM parang_db.TB_FIELD F LEFT OUTER JOIN TB_USER as U on (F.USER_ID = U.USER_ID) LEFT OUTER JOIN TB_VENDER as V on (U.VENDER_ID = V.VENDER_ID) , (SELECT @RN:=@startNum@) TMP LIMIT @startNum@, 10";
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
%><script type="text/javascript">
	$(".body-frame").addClass("no-sub");
	function numComma(number) {
		var num = (""+number).split(".");
		num[0] = num[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return num.join(".");
	}
</script>
<div class="statistics">
	<h2>야적장 임대 통계</h2>
	<table class="table-type01 table-type03">
		<tr>
			<th style="width:4em;">　</th>
			<th style="width:7em;">번호</th>
			<th style="width:21em;">위치</th>
			<th>면적</th>
			<th>금액</th>
			<th>상태</th>
			<th>계약업체</th>
		</tr>
		<c:forEach items="${list}" var="tr">
			<tr>
				<td>${tr.SN}</td>
				<td>${tr.FIELD_NAME}</td>
				<td>${tr.FIELD_ADDRESS}</td>
				<td>
					<!-- <script type="text/javascript">
						var cost = ${tr.FIELD_SIZE}; 
						numComma(cost);
					</script> -->${tr.FIELD_SIZE}㎡
				</td>
				<td>${tr.FIELD_PRICE}원</td>
				<td>
					<c:if test="${tr.FIELD_STATUS eq 'av'}">
						가능
					</c:if>
					<c:if test="${tr.FIELD_STATUS eq 'unav'}">
						불가능
					</c:if>
				</td>
				<td>${tr.VENDER_NAME}</td>
			</tr>			
		</c:forEach>
	</table>
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
</div>