<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>    
<%
request.setCharacterEncoding("euc-kr");
String uploadPath = "D:\\YCJo\\workspace\\YCboardProject\\WebContent\\upload";

//���ε尡 ������ �ִ� ���� ũ�⸦ �����Ѵ�.
int size = 10 * 1024 * 1024;
MultipartRequest multi = 
	new MultipartRequest(request,uploadPath,size,
		"EUC-KR",new DefaultFileRenamePolicy());

//���� �޾ƿ�
String search_type = multi.getParameter("search_type");
String search_kind = multi.getParameter("search_kind");
String search_key  = multi.getParameter("search_key");
String curr_page   = multi.getParameter("page");

String no  	    = multi.getParameter("no");
String title    = multi.getParameter("title");
String subject  = multi.getParameter("subject");
String contents = multi.getParameter("contents");

//�⺻ ����
if(search_type == null) search_type = "G";
if(search_kind == null) search_kind = "T";
if(search_key  == null) search_key  = "";
if(curr_page  == null)  curr_page    = "1";



System.out.println("title:" + title);
System.out.println("subject:" + subject);
System.out.println("contents:" + contents);

//======================== ������ ��ȿ�� �˻� ó�� ========  
if( no == null || title == null || subject == null || contents == null)
{
	response.sendRedirect("write.jsp");	
	return;
}

if( no.equals("") ||title.equals("") || subject.equals("") || contents.equals(""))
{
	response.sendRedirect("write.jsp");	
	return;
}

//======================== ���ǿ��� �α��� ������ �����´�. ========
String login_id    = (String)session.getAttribute("id");
String login_no    = (String)session.getAttribute("no");
String login_name  = (String)session.getAttribute("name");
String login_level = (String)session.getAttribute("level");
%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
//======================== �Խù� �ڷ� ���� ����ǥ  ó�� ========
title = title.replace("'","''");
contents  = contents.replace("'","''");

//======================== �Խù� �ڷ� �Է�  ó�� ========
String sql = "";
//sql  = "insert into board (user_no,board_name,board_title,board_type,board_note) ";
//sql += "values ('" + login_no + "','" + login_name + "','" + title + "','" + subject + "','" + contents + "') ";
sql  = "update board ";
sql += "set ";
sql += "board_title = '" + title + "', ";
sql += "board_note = '" + contents + "', ";
sql += "board_type = '" + subject + "' ";
sql += "where board_no = '" + no + "'";
System.out.println(sql);
stmt.executeUpdate(sql);


String bno = no;

//======================== ÷������ ����ϱ� ========
//���ε�� ���ϸ��� ��´�.
Enumeration files = multi.getFileNames();
while( files.hasMoreElements() == true)
{
	String fileid   = (String)files.nextElement();
	String filename = (String) multi.getFilesystemName(fileid);
	
	if(filename == null) continue;

	String phyname    = UUID.randomUUID().toString();
	String srcName    = uploadPath + "/" + filename;
	String targetName = uploadPath + "/" + phyname;
	File srcFile      = new File(srcName);
	File targetFile   = new File(targetName);
	srcFile.renameTo(targetFile);
	
	System.out.println("ID : " + fileid + "<br>");
	System.out.println("�����ϸ� : " + filename + "<br>");
	System.out.println("�������ϸ� : " + phyname + "<br>");
	
	//�����ͺ��̽��� ÷�������� �����Ѵ�
	//sql  = "insert into attach (board_no,attach_pname,attach_fname) ";
	//sql += "values ('" + bno + "','" + phyname + "','" + filename + "')";
	sql  = "update attach ";
	sql += "set ";
	sql += "attach_pname = '" + phyname + "', ";
	sql += "attach_fname = '" + filename + "' ";
	sql += "where board_no = '" + no + "'";
	System.out.println(sql);
	stmt.executeUpdate(sql);
}	

String webParam = "";
webParam  = "page=" + curr_page;
webParam += "&search_type=" + search_type;
webParam += "&search_kind=" + search_kind;
webParam += "&search_key=" + search_key;

response.sendRedirect("view.jsp?no=" + bno + "&" + webParam);
%>
<%@ include file="../dbms/dbclose.jsp" %>

