<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
String id = request.getParameter("id");
if( id == null || id.equals("") )
{
	%>
	<script>
		alert("올바른경로아님");
	</script>
	<%
	
}
String sql;
sql  = "Select user_no from user ";
sql += "where user_id = '" + id + "' ";
System.out.println(sql);

ResultSet result = stmt.executeQuery(sql);
if( result.next() == true )
{
	//아이디가 중복된 경우
	out.println("중복");
}else
{
	//사용가능한 아이디인 경우
	out.println("사용가능");
}
%>
<%@ include file="../dbms/dbclose.jsp" %>