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

//======================== 게시물 내용을 정리한다. ========
board_title = board_title.replace("<","&lt;");
board_title = board_title.replace(">","&gt;");

board_note = board_note.replace("<","&lt;");
board_note = board_note.replace(">","&gt;");

%>
<script>
	
	window.onload = function()
	{
		$("#title").focus();
	}
	
	//글쓰기 완료 버튼 클릭시 처리
	function DoModify()
	{
		if($("#title").val() == "")
		{
			alert("제목을 입력하세요.");
			$("#title").focus();
			return;
		}
		if($("#contents").val() == "")
		{
			alert("내용을 입력하세요.");
			$("#contents").focus();
			return;
		}		
		if(confirm("변경된 게시글을 저장하시겠습니까?") != 1)
		{
			return;	
		}
		$("#modify").submit();
	}
	
</script>
<!-- 컨텐츠 출력부 -->
<span id="mainContent">
<table border="0" style="width:1220px;" >
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
<form id="modify" name="modify" method="post" action="modifyok.jsp" enctype="multipart/form-data">
			<input type="hidden" name="no" value="<%= no %>">
			<input type="hidden" name="search_type" value="<%= search_type %>">
			<input type="hidden" name="search_kind" value="<%= search_kind %>">
			<input type="hidden" name="search_key" value="<%= search_key %>">
			<input type="hidden" name="page" value="<%= curr_page %>">
<table border="0" style="width:1220px;">
	<tr>
		<td colspan="3">
			<input style="width:1220px;" type="text" id="title" name="title" value="<%= board_title %>">
		</td>
			
	</tr>
	<tr>
		<td colspan="3">
			<select name="subject" id="subject">
				<%
				if( login_level.equals("A") )
				{
					%><option value="G" <%= search_type.equals("G") ? "selected" : "" %>>공지사항</option><%
				}
				%>
				<option value="T" <%=search_type.equals("T") ? "selected" : ""%>>회원사진</option>
				<option value="M" <%=search_type.equals("M") ? "selected" : ""%>>식단공유</option>
				<option value="R" <%=search_type.equals("R") ? "selected" : ""%>>루틴공유</option>
				<option value="L" <%=search_type.equals("L") ? "selected" : ""%>>헬스용품추천</option>
			</select>
		</td>
	</tr>
	<tr>
		<td ><%= board_name %></td>
		<td align="right"><span><%= board_date %></span></td>
		<td align="right"><span><%= board_hit %></span></td>
	</tr>
			<%
			if(search_type.equals("T"))
			{
				%>
				<tr>
					<td colspan="3" style="width:100%; height:500px;" align="center">
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
						<!-- 
						<img src="download.jsp?file=<%= attach_pname %>&name=<%= attach_fname  %>">
						 -->
						<%
					}%>
					</td>
				</tr>
				<%
			}
			%>
			<tr>
				<td colspan="3" align="center">
					<textarea id="contents" name="contents" style="width:100%; height:500px; text-align:left;"><%= board_note %></textarea>
				</td>
			</tr>

<%
if(search_type.equals("T")) 
{
	%>
	<tr>
		<td style="text-align:center; height:25px; width:150px; background-color:#f4f4f4"">첨부파일</td>
		<td style="width:1000px">
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
		</td>
	</tr>
	<tr>
		<td style="text-align:center; background-color:#f4f4f4">첨부파일</td>
		<td><input id="attach" name="attach" type="file" style="width:95%" name=""></td>
	</tr>
	<%
}
%>
<br>
	<tr>
		<td colspan="3" align="center">
			<a href="javascript:DoModify()"class="btn write">수정완료</a>
		</td>
	</tr>
</table>
</form>
</span>
<!-- 컨텐츠 출력부 -->
<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>