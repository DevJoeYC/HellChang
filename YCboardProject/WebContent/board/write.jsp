<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%

request.getParameter("login_no");
if(login_no == null )
{
	response.sendRedirect("../main/index.jsp");
	return;
}
//값을 받아옴
String search_type = request.getParameter("search_type");
String search_kind = request.getParameter("search_kind");
String search_key  = request.getParameter("search_key");
String curr_page   = request.getParameter("page");
String no          = request.getParameter("no");
//기본 세팅
if(search_type == null) search_type = "G";
if(search_kind == null) search_kind = "T";
if(search_key  == null) search_key  = "";
if(curr_page  == null)  curr_page    = "1";


%>
<script>
	window.onload = function()
	{
		$("#title").focus();
	}
	
	//글쓰기 완료 버튼 클릭시 처리
	function DoWrite()
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
		if(confirm("새로운 게시글을 저장하시겠습니까?") != 1)
		{
			return;	
		}
		$("#write").submit();
		
	}
	
	function setThumbnail(event) { 
		
		var reader = new FileReader(); 
		
		reader.onload = function(event) { 
			
			var img = document.createElement("img"); 
			img.setAttribute("src", event.target.result); 
			img.setAttribute("width", 250);
			document.querySelector("td#image_container").appendChild(img)
			}; 
			reader.readAsDataURL(event.target.files[0]); 
	
		}
	
</script>
<!-- 컨텐츠 출력부 -->
<td rowspan="2" valign="top">
<span id="mainContent">
<table border="0" style="width:100%;">
	<tr>
		<td style="height:40px">
			<div class="submenu">글쓰기</div>
		</td>
	</tr>
</table>		
<form id="write" name="write" method="post" action="writeok.jsp" enctype="multipart/form-data">
			<input type="hidden" name="no" value="<%= no %>">
			<input type="hidden" name="search_type" value="<%= search_type %>">
			<input type="hidden" name="search_kind" value="<%= search_kind %>">
			<input type="hidden" name="search_key" value="<%= search_key %>">
			<input type="hidden" name="page" value="<%= curr_page %>">
	<table border="0" style="width:100%; margin:0px 0px 0px 0px;padding:0px 0px 0px 0px ; border: 1px;">
		<tr>
			<td>
				<select name="subject" id="subject">
					<%
					if( login_level.equals("A") )
					{
						%><option value="G" <%= search_type.equals("G") ? "selected" : "" %>>공지사항</option><%
					}
					%>
					<%
					if( search_type.equals("T") )
					{
						%>
						<option value="T" <%=search_type.equals("T") ? "selected" : ""%>>회원사진</option>
						<option value="M" <%=search_type.equals("M") ? "selected" : ""%>>식단공유</option>
						<option value="R" <%=search_type.equals("R") ? "selected" : ""%>>루틴공유</option>
						<option value="L" <%=search_type.equals("L") ? "selected" : ""%>>헬스용품추천</option>
						<%
					}else
					{
						%>
						<option value="M" <%=search_type.equals("M") ? "selected" : ""%>>식단공유</option>
						<option value="R" <%=search_type.equals("R") ? "selected" : ""%>>루틴공유</option>
						<option value="L" <%=search_type.equals("L") ? "selected" : ""%>>헬스용품추천</option>
						<%
					}
					%>
				</select>
			</td>
			<td><input id="title" type="text" name="title" style="width:100%" placeholder="제목을입력하시오"></td>
			<%
			if(search_type.equals("T")) 
			{
				%>
					<td style="width:25%" align="center">업로드 이미지 미리보기</td>
				<%
			}
			%>
		</tr>
		<tr>
			<td style="width:120px; text-align:center; background-color:#f4f4f4">내용</td>
			<td><textarea id="contents" name="contents" style="width:100%; height:500px;"></textarea></td>
			<%
			if(search_type.equals("T")) 
			{
				%>
				<td align="center" id="image_container"></td>
				<%
			}
			%>
		</tr>
<%
if(search_type.equals("T")) 
{
	%>	
		<tr>
			<td style="width:120px; text-align:center; background-color:#f4f4f4">첨부파일</td>
			<td><input id="attach" name="attach" type="file" accept="image/*" style="width:95%" name="" onchange="setThumbnail(event);"></td>
		</tr>
	<%
}
%>
		<tr>
			<td colspan="3" style="height:1px;background-color:#cccccc"></td>
		</tr>
		<tr>
			<td style="text-align:center;" colspan="2">
				<a class="btn write" href="#" onclick="javascript:DoWrite();">글쓰기 완료</a>
			</td>
		</tr>
	</table>					
</form>		
</span>
<!-- 컨텐츠 출력부 -->
<%@ include file="../include/tail.jsp" %>