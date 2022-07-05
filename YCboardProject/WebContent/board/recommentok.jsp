<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("euc-kr");

String board_no  = request.getParameter("board_no");
String user_no   = request.getParameter("user_no");
String CmtNote = request.getParameter("CmtNote");

String search_type = request.getParameter("search_type");
String search_kind = request.getParameter("search_kind");
String search_key  = request.getParameter("search_key");
String curr_page   = request.getParameter("page");
String no  	       = request.getParameter("no");
//기본 세팅
if(search_type == null) search_type = "G";
if(search_kind == null) search_kind = "T";
if(search_key  == null) search_key  = "";
if(curr_page  == null)  curr_page    = "1";

//======================== 세션에서 로그인 정보를 가져온다. ========
String login_id    = (String)session.getAttribute("id");
String login_no    = (String)session.getAttribute("no");
String login_name  = (String)session.getAttribute("name");
String login_level = (String)session.getAttribute("level");



if(board_no == null || user_no == null || CmtNote == null || login_id == null)
{
	
	response.sendRedirect("index.jsp");	
	return;
}

out.println("board_no:" + board_no + "<br>");
out.println("user_no:" + user_no + "<br>");
out.println("comt_userno:" + login_no + "<br>");
out.println("comt_name:" + login_name + "<br>");
out.println("comt_note:" + CmtNote + "<br>");


//======================== 게시물 자료 작은 따옴표  처리 ========
CmtNote = CmtNote.replace("'","''");

%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
//======================== 게시물 자료 입력  처리 ========
String sql = "";
sql  = "insert into comment (board_no,comt_userno,comt_name,comt_note,comt_rp) ";
sql += "values ('" + board_no + "','" + login_no + "','" + login_name + "','" + CmtNote + "','" + 1 + "')";
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

response.sendRedirect("view.jsp?no=" + no + "&" + webParam);
%>


