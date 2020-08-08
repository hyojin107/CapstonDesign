<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.util.List"%><%@page import="net.sf.json.JSONObject"%><%@page import="java.util.Map"%><%@page import="com.gbhz.DB"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	String ret = "{}";
	String type = request.getParameter("type");
	
	if ("test-map".equals(type)) {
		Map<Object, Object> user = DB.selectDetail("select * from TB_USER WHERE USER_ID = 'user1'");
		JSONObject userJson = JSONObject.fromObject(user);
		ret = userJson.toString();
	} else if ("user-list".equals(type)) {
		List<Map<Object, Object>> list = DB.select("select * from TB_USER");
		JSONArray listJson = JSONArray.fromObject(list);
		ret = listJson.toString();
	} else if ("field-list".equals(type)) {
		List<Map<Object, Object>> list = DB.select("select * from TB_FIELD");
		JSONArray listJson = JSONArray.fromObject(list);
		ret = listJson.toString();
	} else if ("test-list".equals(type)) {
		List<Map<Object, Object>> list = DB.select("select * from TB_USER");
		JSONArray listJson = JSONArray.fromObject(list);
		ret = listJson.toString();
	} else if ("test-list".equals(type)) {
		List<Map<Object, Object>> list = DB.select("select * from TB_USER");
		JSONArray listJson = JSONArray.fromObject(list);
		ret = listJson.toString();
	}
%><%=ret%>