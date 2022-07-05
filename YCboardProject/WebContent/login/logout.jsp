<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
session.removeAttribute("id");
session.removeAttribute("no");
session.removeAttribute("name");
session.removeAttribute("level");

response.sendRedirect("../main/index.jsp");
%>