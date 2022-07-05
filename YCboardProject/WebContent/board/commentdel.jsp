<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String board_no = request.getParameter("no");
String comt_no  = request.getParameter("cno");
String search_type  = request.getParameter("search_type");
String search_kind  = request.getParameter("search_kind");
String search_key  = request.getParameter("search_key");

if(board_no == null || comt_no == null)
{
	response.sendRedirect("index.jsp");
	return;
}
%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
String sql = "delete from comment where comt_no = '" + comt_no + "' ";
System.out.println(sql);
stmt.executeUpdate(sql);
%>
<%@ include file="../dbms/dbclose.jsp" %>
<%
response.sendRedirect("view.jsp?no=" + board_no + "&search_type=" + search_type);
%> 