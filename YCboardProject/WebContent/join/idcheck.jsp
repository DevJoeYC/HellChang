<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
String id = request.getParameter("id");
if( id == null || id.equals("") )
{
	%>
	<script>
		alert("�ùٸ���ξƴ�");
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
	//���̵� �ߺ��� ���
	out.println("�ߺ�");
}else
{
	//��밡���� ���̵��� ���
	out.println("��밡��");
}
%>
<%@ include file="../dbms/dbclose.jsp" %>