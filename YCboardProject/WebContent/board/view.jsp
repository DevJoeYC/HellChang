<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%

//값을 받아옴
String search_type = request.getParameter("search_type");
String search_kind = request.getParameter("search_kind");
String search_key  = request.getParameter("search_key");
String curr_page   = request.getParameter("page");
//기본 세팅
if(search_type == null) search_type = "G";
if(search_kind == null) search_kind = "T";
if(search_key  == null) search_key  = "";
if(curr_page  == null)  curr_page    = "1";

String no = request.getParameter("no");
if( no == null || no.equals(""))
{
	%>
	<script>
		window.onload = function()
		{
			alert("올바른 게시물 정보가 아닙니다.");
			document.location = "../main/index.jsp";
		}
	</script>
	<%
	return;
}
%>
<%@ include file="../dbms/dbopen.jsp" %>
<% 
//======================== 게시물 자료를 조회한다. ======== 
String sql = "";
sql  = "select board_no,user_no,board_type,board_title,board_note,board_name,date(board_date) as date,board_hit ";
sql += "from board ";
sql += "where board_no = '" + no + "' ";
System.out.println(sql);
ResultSet result = stmt.executeQuery(sql);
if( result.next() == false)
{
	%>
	<script>
		window.onload = function()
		{
			alert("올바른 게시물 정보가 아닙니다.");
			document.location = "../main/index.jsp";
		}
	</script>
	<%@ include file="../dbms/dbclose.jsp" %>
	<%
	return;
}
String board_no    = result.getString("board_no");
String user_no     = result.getString("user_no");
String board_type  = result.getString("board_type");
String board_title = result.getString("board_title");
String board_note  = result.getString("board_note");
String board_name  = result.getString("board_name");
String board_date  = result.getString("date");
String board_hit   = result.getString("board_hit");

//======================== 조회수를 증가시킨다. ========
sql = "update board set board_hit = board_hit + 1 where board_no = " + no;
stmt.executeUpdate(sql);

//======================== 게시물 내용을 정리한다. ========
board_title = board_title.replace("<","&lt;");
board_title = board_title.replace(">","&gt;");

board_note = board_note.replace("<","&lt;");
board_note = board_note.replace(">","&gt;");
board_note = board_note.replace("\n","\n<br>");

%>
<!-- 컨텐츠 출력부 -->
<span id="mainContent">
<table border="0" style="width:100%;" >
	<tr>
		<td style="height:40px;" valign="top">
			<div class="submenu">
			<%
			if(search_type.equals("G"))
			{
				%>공지사항<%
			}else if(search_type.equals("T"))
			{
				%>회원사진<%
			}else if(search_type.equals("R"))
			{
				%>루틴공유<%
			}else if(search_type.equals("M"))
			{
				%>식단공유<%
			}else if(search_type.equals("L"))
			{
				%>헬스용품추천<%
			}
			%>
			</div>
		</td>
	</tr>
</table>
<table border="0" style="width:100%;">
	<tr>
		<div class="today view title"><%= board_title %></div>
	</tr>
	<tr>
		<td style="width:70%;"><%= board_name %></td>
		<td style="width:25%;" align="right"><%= board_date %></td>
		<td style="width:5%;" align="right"><%= board_hit %></td>
	</tr>
	<tr>
		<td colspan="3" style="height:1px;background-color:#cccccc"></td>
	</tr>
	<%
		if(search_type.equals("T"))
		{
			%>
			<tr>	
				<td colspan="3" style="width:100%; height:400px;" align="center">
				<%
				sql  = "select attach_pname,attach_fname ";
				sql += "from attach ";
				sql += "where board_no = '" + no + "' ";
				sql += "order by attach_fname asc ";
				System.out.println(sql);
				result = stmt.executeQuery(sql);
				while( result.next() == true)
				{
					String attach_pname = result.getString("attach_pname");
					String attach_fname = result.getString("attach_fname");
					%>
					<img src="download.jsp?file=<%= attach_pname %>&name=<%= attach_fname  %>" width="300px" height="300px"><br>
					<%
				}
			%></td>
			</tr>
			<%
		}
	%>
		<tr>
			<td height="300px" colspan="3" align="left" valign="middle">
				<%= board_note %>
			</td>
		</tr>
	</tr>
	<tr>
		<td colspan="3" style="height:1px;background-color:#cccccc"></td>
	</tr>
</table>
<%
if(search_type.equals("T")) 
{
	%>
	<div class="dttach box">
		<div style="float:left;text-align:center; height:25px; width:150px;">첨부파일</div>
		<div style="float:left;">
			<%
			sql  = "select attach_pname,attach_fname ";
			sql += "from attach ";
			sql += "where board_no = '" + no + "' ";
			sql += "order by attach_fname asc ";
			System.out.println(sql);
			result = stmt.executeQuery(sql);
			while(result.next() == true)
			{
				String attach_pname= result.getString("attach_pname");
				String attach_fname = result.getString("attach_fname");
				%>
				<a href="download.jsp?file=<%= attach_pname %>&name=<%= attach_fname %>"><%= attach_fname %></a>
				<%
			}
			%>
		</div>
	</div>
	<%
}
%>
<br>
<div align="right">
<%
sql = "select board_no,board_type from board where board_no < '" + no + "' and board_type='"+ board_type +"' order by board_no desc limit 0,1 ";
System.out.println(sql);
result = stmt.executeQuery(sql);
if(result.next() == true)
{
	String board_pno = result.getString("board_no");
	search_type = result.getString("board_type");
	%>
	<a href="../board/view.jsp?no=<%= board_pno %>&page=<%= curr_page %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>" class="btn write">
	이전글
	</a>
	<%
}	
%>
	&nbsp;
	<%
	if(search_type.equals("T"))
	{
		%>
		<a href="../board/tindex.jsp?page=<%= curr_page %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>" class="btn write">
		목록
		</a>
		<%
	}else
	{
		%><a href="../board/index.jsp?page=<%= curr_page %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>" class="btn write">
		목록
		</a><%
	}
	%>
	&nbsp;
<%
sql = "select board_no,board_type from board where board_no > '" + no + "' and board_type='"+ board_type +"' order by board_no limit 0,1 ";
System.out.println(sql);
result = stmt.executeQuery(sql);
if(result.next() == true)
{
	String board_nno = result.getString("board_no");
	search_type = result.getString("board_type");
	%>	
	<a href="../board/view.jsp?no=<%= board_nno %>&page=<%= curr_page %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>" class="btn write">
	다음글
	</a>
	&nbsp;
	<%
}
%>
<%
if(login_id != null)
{
	if(login_level.equals("A")|| login_no.equals(user_no))
	{
		%>
			<a href="delete.jsp?board_no=<%= board_no %>&no=<%= no %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>&page=<%= curr_page %>" class="btn write">글삭제</a>
			<a href="modify.jsp?no=<%= no %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>&page=<%= curr_page %>" class="btn write">글수정</a>
		<%
	}
}
%>
</div>
<%@ include file="../board/comment.jsp" %>
</span>
<!-- 컨텐츠 출력부 -->
<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>