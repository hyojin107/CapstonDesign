<%@page import="com.gbhz.DB"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%>
<%
	String user_id = request.getParameter("user_id");
	String field_id = request.getParameter("field_id");
	String ch01 = request.getParameter("ch01");
	String ch02 = request.getParameter("ch02");
	String ch03 = request.getParameter("ch03");
	String ch04 = request.getParameter("ch04");
	
	if(ch01==null && ch02==null && ch03==null && ch04==null){
		ch01 = ch02 = ch03 = ch04 = "on";
	}
	
	// 사용자 데이터
	Map<Object, Object> user = DB.selectDetail("select * from TB_USER WHERE USER_ID = '"+user_id+"'");
	request.setAttribute("user",user);
	
	// 현재 사용 중인 야적장 데이터
	List<Map<Object, Object>> contract = DB.select("SELECT c.CONTRACT_ID, DATE_FORMAT(c.CONTRACT_DATE,'%Y-%m-%d') DATE, CONCAT(l.START_DATE,'~',l.END_DATE) PERIOD, f.FIELD_SIZE, f.FIELD_PRICE FROM TB_CONTRACT c INNER JOIN TB_LEASE_FORM l ON(c.LEASE_FORM_ID=l.LEASE_FORM_ID) INNER JOIN TB_FIELD f ON(l.FIELD_ID=f.FIELD_ID) WHERE l.LESSEE_ID='"+user.get("USER_ID")+"' AND l.`STATUS`='허가' AND DATE_FORMAT(NOW(),'%Y-%m-%d')<=l.END_DATE");
	request.setAttribute("contract", contract);
	
	// test
	/* List<Map<Object, Object>> user2 = DB.select("SELECT count(*) AS count FROM TB_USER WHERE USER_ID='user1'");
	Map<Object, Object> user3=user2.get(0);
	int test = Integer.parseInt((user3.get("count")).toString());
	System.out.println(test); */
	
	// 임대 신청 이력 데이터
	String sql = "SELECT l.LEASE_FORM_ID, DATE_FORMAT(l.DATE,'%Y-%m-%d') DATE, f.FIELD_SIZE, f.FIELD_PRICE, l.`STATUS`";
	sql += " FROM TB_LEASE_FORM l INNER JOIN TB_FIELD f ON(l.FIELD_ID=f.FIELD_ID)";
	sql += " WHERE l.LESSEE_ID='@LESSEE_ID@'";
	sql += " and l.STATUS in ('@STATUS-CH01@','@STATUS-CH02@','@STATUS-CH03@','@STATUS-CH04@')";
	sql = sql.replaceAll("@LESSEE_ID@", (String)user.get("USER_ID"));
	sql = sql.replaceAll("@STATUS-CH01@", "on".equals(ch01)?"필수 서류 미제출":"");
	sql = sql.replaceAll("@STATUS-CH02@", "on".equals(ch02)?"승인 대기":"");
	sql = sql.replaceAll("@STATUS-CH03@", "on".equals(ch03)?"허가":"");
	sql = sql.replaceAll("@STATUS-CH04@", "on".equals(ch04)?"반려":"");
	
	List<Map<Object, Object>> history = DB.select(sql);
	request.setAttribute("history", history);
%>

<div class="lease-list">
	<div>
		<table class="table-type02 table-type03">
			<tr>
				<td class="contView"><a href="/content.jsp?body=lease-list&user_id=${user.USER_ID}">현재 사용 중인 야적장</a></td>
				<td class="histView"><a href="/content.jsp?body=lease-list&user_id=${user.USER_ID}&view=history">임대 신청 이력</a></td>
			</tr>
		</table>
	</div>
	
	<div class="contract" style="display:none;">
		<table class="table-type01 table-type03">
			<tr><th style="width:7em;">계약 번호</th><th>계약 일자</th><th>계약 기간</th><th>면적</th><th>금액</th></tr>
			<c:forEach items="${contract}" var="tr">
				<tr>
					<td>${tr.CONTRACT_ID}</td><td>${tr.DATE}</td><td>${tr.PERIOD}</td><td>${tr.FIELD_SIZE}㎡</td><td>${tr.FIELD_PRICE}원</td>
				</tr>			
			</c:forEach>
		</table>
	</div>
	
	<div class="history" style="display:none;">
		<form id="check" method="post" action="/content.jsp?body=lease-list">
			<input type="checkbox" id="status-ch01" name="ch01">필수 서류 미제출
			<input type="checkbox" id="status-ch02" name="ch02">승인 대기
			<input type="checkbox" id="status-ch03" name="ch03">허가
			<input type="checkbox" id="status-ch04" name="ch04">반려
			<input type="hidden" name="user_id" value="${param.user_id}">
			<input type="hidden" name="view" value="${param.view}">
		</form>
		
		<table class="table-type01 table-type03">
			<tr><th style="width:7em;">신청 번호</th><th>신청 일자</th><th>면적</th><th>금액</th><th>신청 상태</th></tr>
			<c:forEach items="${history}" var="tr">
				<tr>
					<td>${tr.LEASE_FORM_ID}</a></td><td>${tr.DATE}</td><td>${tr.FIELD_SIZE}㎡</td><td>${tr.FIELD_PRICE}원</td><td>${tr.STATUS}</td>
				</tr>			
			</c:forEach>
		</table>
	</div>
</div>

<script type="text/javascript">
	$(".body-frame").addClass("no-sub");
	if ("${param.ch01}" == 'on') $("#status-ch01").prop("checked",true);
	if ("${param.ch02}" == 'on') $("#status-ch02").prop("checked",true);
	if ("${param.ch03}" == 'on') $("#status-ch03").prop("checked",true);
	if ("${param.ch04}" == 'on') $("#status-ch04").prop("checked",true);
	$("#status-ch01,#status-ch02,#status-ch03,#status-ch04").on("change",function(event) {
		$("#check").submit();
	});
	if ("${param.view}"=="history"){
		$(".history").show();
		$("td.histView").addClass("active");
	} else {
		$(".contract").show();
		$("td.contView").addClass("active");
	}
</script>