<%@page import="com.gbhz.DB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String PURPOSE = request.getParameter("purpose");
	String START_DATE = request.getParameter("startDate");
	String END_DATE = request.getParameter("endDate");
	String LESSEE_ID = request.getParameter("user_id");
	String FIELD_ID = request.getParameter("field_id");
	
	String query = "INSERT INTO TB_LEASE_FORM(PURPOSE,START_DATE,END_DATE,LESSEE_ID,FIELD_ID)";
	query += " VALUES('@PURPOSE@','@START_DATE@','@END_DATE@','@LESSEE_ID@','@FIELD_ID@')";
	
	query = query.replaceAll("@PURPOSE@", PURPOSE);
	query = query.replaceAll("@START_DATE@", START_DATE);
	query = query.replaceAll("@END_DATE@", END_DATE);
	query = query.replaceAll("@LESSEE_ID@", LESSEE_ID);
	query = query.replaceAll("@FIELD_ID@", FIELD_ID);
	
	int updateCount = DB.update(query);
	System.out.println(String.format("임대신청이 완료되었습니다. (업데이트 건수 : %d)", updateCount));
	
	response.sendRedirect("/content.jsp?body=lease-list&view=history&user_id="+LESSEE_ID);
%>