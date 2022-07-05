<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.net.*" %>    
<%
String comt_no   = request.getParameter("comt_no");
String edit_note = request.getParameter("edit_note");

//======================== 게시물 자료 작은 따옴표  처리 ========
edit_note = edit_note.replace("'","''");

%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
//======================== 게시물 자료 입력  처리 ========
String sql = "";
sql  = "update comment ";
sql += "set comt_note = '" + edit_note + "' ";
sql += "where comt_no = " + comt_no;
System.out.println(sql);
stmt.executeUpdate(sql);

sql  = "select board_no,comt_no,comt_userno,comt_name,comt_note,date(comt_date) as comt_date ";
sql += "from comment ";
sql += "where comt_no = '" + comt_no + "' ";
System.out.println(sql);
ResultSet result = stmt.executeQuery(sql);
result.next();
String board_no    = result.getString("board_no");
String comt_userno = result.getString("comt_userno");
String comt_name   = result.getString("comt_name");
String comt_note   = result.getString("comt_note");
String comt_date   = result.getString("comt_date");
%>
<%@ include file="../dbms/dbclose.jsp" %>
<td  colspan="3">
	<%= comt_note %>
</td>
<td>
	<a class="btn rp" href="#" onclick="EditComment(this,<%= comt_no %>);">수정</a>
	<a class="btn rp" href="commentdel.jsp?no=<%= board_no %>&cno=<%= comt_no %>">삭제</a>
</td>


