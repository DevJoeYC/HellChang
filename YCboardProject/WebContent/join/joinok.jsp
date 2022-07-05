<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//한글처리
request.setCharacterEncoding("euc-kr");

//join.jsp 에서 넘어오는 데이터 받기
String id       = request.getParameter("joinid");
String pw       = request.getParameter("joinpw");
String name     = request.getParameter("name");
String gender   = request.getParameter("gender");

//데이터 유효성 검사
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
//중복된 아이디 검사
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
			alert("이미 가입 된 아이디입니다.");
			document.location = "index.jsp";
		}
	</script>
	<%
	return;
}
//======================== 회원정보 입력  처리 ========
sql  = "insert into user (user_id,user_pw,user_name,user_gender) ";
sql += "values ('" + id + "',md5('" + pw + "'),'" + name + "','" + gender + "') ";
System.out.println(sql);
//작업 처리용 클래스를 할당 받는다.
stmt.executeUpdate(sql);
%>
<script>
	window.onload = function()
	{
		alert("회원가입이 완료되었습니다.");
		document.location = "../main/index.jsp";
	}
</script>
<%@ include file="../dbms/dbclose.jsp" %>
