<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../dbms/dbopen.jsp" %>    
<%
String comt_no  = request.getParameter("cno");

String sql = "";
sql  = "select comt_no,comt_userno,comt_name,comt_note,date(comt_date) as comt_date ";
sql += "from comment ";
sql += "where comt_no = '" + comt_no + "' ";
System.out.println(sql);
ResultSet result = stmt.executeQuery(sql);
result.next();
String comt_userno = result.getString("comt_userno");
String comt_name   = result.getString("comt_name");
String comt_note   = result.getString("comt_note");
String comt_date   = result.getString("comt_date");
%>    
<td colspan="3"><input type="text" id="edit_note" name="edit_note" value="<%= comt_note %>" style="width:95%"></td>
<td width="110px" align="center"><a class="btn rp" href="#" onclick="EditCommentOK(this,<%= comt_no %>);" >수정완료</a></td>
<%@ include file="../dbms/dbclose.jsp" %>

