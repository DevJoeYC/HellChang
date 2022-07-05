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

//업로드가 가능한 최대 파일 크기를 지정한다.
int size = 10 * 1024 * 1024;
MultipartRequest multi = 
	new MultipartRequest(request,uploadPath,size,
		"EUC-KR",new DefaultFileRenamePolicy());

//값을 받아옴
String search_type = multi.getParameter("search_type");
String search_kind = multi.getParameter("search_kind");
String search_key  = multi.getParameter("search_key");
String curr_page   = multi.getParameter("page");

String no  	    = multi.getParameter("no");
String title    = multi.getParameter("title");
String subject  = multi.getParameter("subject");
String contents = multi.getParameter("contents");

//기본 세팅
if(search_type == null) search_type = "G";
if(search_kind == null) search_kind = "T";
if(search_key  == null) search_key  = "";
if(curr_page  == null)  curr_page    = "1";



System.out.println("title:" + title);
System.out.println("subject:" + subject);
System.out.println("contents:" + contents);

//======================== 데이터 유효성 검사 처리 ========  
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

//======================== 세션에서 로그인 정보를 가져온다. ========
String login_id    = (String)session.getAttribute("id");
String login_no    = (String)session.getAttribute("no");
String login_name  = (String)session.getAttribute("name");
String login_level = (String)session.getAttribute("level");
%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
//======================== 게시물 자료 작은 따옴표  처리 ========
title = title.replace("'","''");
contents  = contents.replace("'","''");

//======================== 게시물 자료 입력  처리 ========
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

//======================== 첨부파일 등록하기 ========
//업로드된 파일명을 얻는다.
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
	System.out.println("논리파일명 : " + filename + "<br>");
	System.out.println("물리파일명 : " + phyname + "<br>");
	
	//데이터베이스에 첨부파일을 저장한다
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

