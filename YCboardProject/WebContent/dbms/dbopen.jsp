<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %> 
<%
//JDBC 드라이버를 로딩한다.
Class.forName("com.mysql.cj.jdbc.Driver");

String host   = "jdbc:mysql://127.0.0.1:3306/community";
host += "?useUnicode=true&characterEncoding=utf-8";
host += "&serverTimezone=UTC";
String userid = "root";
String passwd = "ezen";
Connection conn = null;
//데이터베이스에 연결한다.
conn = DriverManager.getConnection(host,userid,passwd);

//작업 처리용 클래스를 할당 받는다.
Statement stmt = conn.createStatement();
%>