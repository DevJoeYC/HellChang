<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//�ѱ�ó��
request.setCharacterEncoding("euc-kr");

//join.jsp ���� �Ѿ���� ������ �ޱ�
String id       = request.getParameter("joinid");
String pw       = request.getParameter("joinpw");
String name     = request.getParameter("name");
String gender   = request.getParameter("gender");

//������ ��ȿ�� �˻�
if(id == null || pw == null || name == null || gender == null)
{
	response.sendRedirect("index.jsp");
	return;
}
if( id.equals("") || pw.equals("") || name.equals("") || gender.equals(""))
{
	response.sendRedirect("index.jsp");
	return;
}
%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
//�ߺ��� ���̵� �˻�
String sql;
sql = "select user_no from user where user_id = '" + id + "'";
ResultSet result = stmt.executeQuery(sql);
if( result.next() == true )
{
	%>
	<%@ include file="../dbms/dbclose.jsp" %>
	<script>
		window.onload = function()
		{
			alert("�̹� ���� �� ���̵��Դϴ�.");
			document.location = "index.jsp";
		}
	</script>
	<%
	return;
}
//======================== ȸ������ �Է�  ó�� ========
sql  = "insert into user (user_id,user_pw,user_name,user_gender) ";
sql += "values ('" + id + "',md5('" + pw + "'),'" + name + "','" + gender + "') ";
System.out.println(sql);
//�۾� ó���� Ŭ������ �Ҵ� �޴´�.
stmt.executeUpdate(sql);
%>
<script>
	window.onload = function()
	{
		alert("ȸ�������� �Ϸ�Ǿ����ϴ�.");
		document.location = "../main/index.jsp";
	}
</script>
<%@ include file="../dbms/dbclose.jsp" %>
