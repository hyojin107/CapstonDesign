<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.gbhz.DB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String user_id = request.getParameter("user_id");
	String field_id = request.getParameter("field_id");

	// 사용자 데이터
	Map<Object, Object> user = DB.selectDetail("select * from TB_USER WHERE USER_ID = '"+user_id+"'");
	request.setAttribute("user",user);
	// 업체 데이터
	Map<Object, Object> vender = DB.selectDetail("select * from TB_VENDER WHERE VENDER_ID = '"+user.get("VENDER_ID")+"'");
	request.setAttribute("vender",vender);
	// 야적장 데이터
	Map<Object, Object> field = DB.selectDetail("select * from TB_FIELD WHERE FIELD_ID = '"+field_id+"'");
	request.setAttribute("field",field);
%>
<div class="application">
	<h1>임 대 신 청 서</h1>
	<form method="post" action="/lease-apply.jsp" id="application">
		<table class="table-type01 table-type05">
			<tr>
				<th rowspan="3">신청인</th><th>업체명</th><td colspan="3">${vender.VENDER_NAME}</td>
				<th>업체 전화번호</th><td colspan="2">${vender.VENDER_PHONE}</td>
			</tr>
			<tr>
				<th>성명</th><td colspan="3">${user.USER_NAME}</td>
				<th>전화번호</th><td colspan="2">${user.USER_PHONE}</td>
			</tr>
			<tr>
				<th>주소</th><td colspan="3">${vender.VENDER_ADDRESS}</td>
				<th>사업자등록번호</th><td colspan="2">${vender.VENDER_LICENSE_NUMBER}</td>
			</tr>
			<tr>
				<th rowspan="3">야적장</th><th>면적</th><td>${field.FIELD_SIZE}㎡</td>
				<th>주소</th><td colspan="4">${field.FIELD_ADDRESS} (${field.FIELD_NAME})</td></tr>
			<tr>
				<th>사용 목적</th>
				<td colspan="6">	
					<select name="purpose" style="width: 50%; padding: 0.3em;">
						<option value="op01">화물을 싣고 내림</option>
						<option value="op02">화물을 내림</option>
						<option value="op03">화물을 실음</option>
						<option value="op04">수리</option>
						<option value="op05">해난</option>
						<option value="op06">급유</option>
						<option value="op07">접안대기</option>
						<option value="op08">화물대기</option>
						<option value="op09">상시대기</option>
						<option value="op10">출항대기</option>
						<option value="op11">해상하역</option>
						<option value="op12">계선</option>
						<option value="op13">수입화물 장치</option>
						<option value="op14">수출화물 장치</option>
						<option value="op15">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>사용 기간</th>
				<td colspan="6">
					<input type="text" id="startDate" name="startDate">&nbsp;08시 00분부터&nbsp;
					<input type="text" id="endDate" name="endDate">&nbsp;24시 00분까지
				</td>
			</tr>
			<tr>
				<td colspan="8" style="text-align:center;">「항만공사법」제29조, 같은 법 시행령 제12조제2항 및 같은 법 시행규칙 제9조에 따라 위와 같이 항만시설 사용승낙을 신청합니다.<br/><p><b>2019년 06월 24일</b></p><p><b>□□□(울산)항만공사 사장</b> 귀하</p><input type="checkbox" name="agree" value="yes"></td>
		</table>
		<div class="button">
			<input type="button" value="야적장 재선택" class="blue-button" onclick="fieldBtn();">
			<input type="button" value="신청" class="blue-button" onclick="submitBtn();">
			<input type="button" value="취소" class="blue-button" onclick="cancelBtn();">
		</div>
		
		<input type="hidden" value="${user.USER_ID}" name="user_id">
		<input type="hidden" value="${user.VENDER_ID}" name="vender_id">
		<input type="hidden" value="${field.FIELD_ID}" name="field_id">
	</form>
</div>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		$("#startDate,#endDate").datepicker({
			dateFormat:"yy-mm-dd",
			changeYear:true,
			changeMonth:true
		});
  	});
	$.datepicker.setDefaults({
    	prevText: '이전 달',
    	nextText: '다음 달',
		currentText: '오늘',
    	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], //월 이름
    	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], //
    	dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    	dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    	showMonthAfterYear: true,
    	yearSuffix: '년'
	});  
</script>
  
<script type="text/javascript">
	$(".body-frame").addClass("no-sub");
	
	function fieldBtn(){
		window.location="/content.jsp?body=lease-map";
	}
	
	function submitBtn(){
		if(!confirm("확인 버튼을 누르면 임대 신청이 완료됩니다.")) return;
		var form = $("#application");
		form.submit();
	}
	
	function cancelBtn(){
		if(!confirm("임대 신청을 취소하겠습니까?")) return;
		window.location="/";
	}
</script>
