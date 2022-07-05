<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String search_type = request.getParameter("search_type");
String search_kind = request.getParameter("search_kind");
String search_key  = request.getParameter("search_key");
String curr_page   = request.getParameter("page");
String board_no = request.getParameter("board_no");
String no = request.getParameter("no");

if(board_no == null)
{
	response.sendRedirect("index.jsp");
	return;
}
%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
String sql = "delete from comment where board_no = '" + board_no + "' ";
System.out.println(sql);
stmt.executeUpdate(sql);

sql = "delete from attach where board_no = '" + board_no + "' ";
System.out.println(sql);
stmt.executeUpdate(sql);

sql = "delete from board where board_no = '" + board_no + "' ";
System.out.println(sql);
stmt.executeUpdate(sql);
%>
<%@ include file="../dbms/dbclose.jsp" %>
<%

String webParam = "";
webParam  = "page=" + curr_page;
webParam += "&search_type=" + search_type;
webParam += "&search_kind=" + search_kind;
webParam += "&search_key=" + search_key;
if(search_type.equals("T"))
{
	response.sendRedirect("../board/tindex.jsp?"+ webParam);
}else
{
	response.sendRedirect("../board/index.jsp?"+ webParam);	
}

%> 