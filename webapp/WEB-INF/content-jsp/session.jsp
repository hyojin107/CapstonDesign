<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%><%
	Object loginInfo = session.getAttribute("loginInfo");
	if (loginInfo==null) {
		// 로그인이 필요
		//session.setAttribute("requestUrl", request.getParameter("body"));
		//response.sendRedirect("/login.jsp");
		//System.out.println("로그인 페이지로 리다이렉션");
		RequestDispatcher rd =request.getRequestDispatcher("/login.jsp");
		rd.forward(request, response);
		return;
	}
%>