<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String id = request.getParameter("id");
String pw = request.getParameter("pw");

//======================== ������ ��ȿ�� �˻� ó�� ========  
if( id == null || pw == null || id.equals("") || pw.equals(""))
{
	out.println("ERROR");
	return;
}
//System.out.println("id:" + id);
//System.out.println("pw:" + pw);
%>
<%@ include file="../dbms/dbopen.jsp"%>
<%
String sql = "";
sql += "select user_no,user_name,user_level "; 
sql += "from user  ";
sql += "where user_id = '" + id + "' and user_pw = md5('" + pw + "') "; 
//System.out.println(sql);
ResultSet result = stmt.executeQuery(sql);
if( result.next() == false)
{
	//���̵� ����
	out.println("ERROR");
}else
{
	out.println("OK");
	
	//���ǿ� ����� �α��� ������ �����Ѵ�.
	String uno    = result.getString("user_no");
	String uname  = result.getString("user_name");
	String ulevel = result.getString("user_level");
	result.close();	
	
	session.setAttribute("id"   ,id);
	session.setAttribute("no"   ,uno);
	session.setAttribute("name" ,uname);	
	session.setAttribute("level",ulevel);
}
%> 
<%@ include file="../dbms/dbclose.jsp"%>
