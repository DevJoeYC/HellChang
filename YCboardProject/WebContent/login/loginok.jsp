<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String id = request.getParameter("id");
String pw = request.getParameter("pw");

//======================== 데이터 유효성 검사 처리 ========  
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
	//아이디 없음
	out.println("ERROR");
}else
{
	out.println("OK");
	
	//세션에 사용자 로그인 정보를 저장한다.
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
