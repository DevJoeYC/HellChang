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
//���� �޾ƿ�
String search_type = request.getParameter("search_type");
String search_kind = request.getParameter("search_kind");
String search_key  = request.getParameter("search_key");
String curr_page   = request.getParameter("page");
String no          = request.getParameter("no");
//�⺻ ����
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
	
	//�۾��� �Ϸ� ��ư Ŭ���� ó��
	function DoWrite()
	{
		if($("#title").val() == "")
		{
			alert("������ �Է��ϼ���.");
			$("#title").focus();
			return;
		}
		if($("#contents").val() == "")
		{
			alert("������ �Է��ϼ���.");
			$("#contents").focus();
			return;
		}		
		if(confirm("���ο� �Խñ��� �����Ͻðڽ��ϱ�?") != 1)
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
<!-- ������ ��º� -->
<td rowspan="2" valign="top">
<span id="mainContent">
<table border="0" style="width:100%;">
	<tr>
		<td style="height:40px">
			<div class="submenu">�۾���</div>
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
						%><option value="G" <%= search_type.equals("G") ? "selected" : "" %>>��������</option><%
					}
					%>
					<%
					if( search_type.equals("T") )
					{
						%>
						<option value="T" <%=search_type.equals("T") ? "selected" : ""%>>ȸ������</option>
						<option value="M" <%=search_type.equals("M") ? "selected" : ""%>>�Ĵܰ���</option>
						<option value="R" <%=search_type.equals("R") ? "selected" : ""%>>��ƾ����</option>
						<option value="L" <%=search_type.equals("L") ? "selected" : ""%>>�ｺ��ǰ��õ</option>
						<%
					}else
					{
						%>
						<option value="M" <%=search_type.equals("M") ? "selected" : ""%>>�Ĵܰ���</option>
						<option value="R" <%=search_type.equals("R") ? "selected" : ""%>>��ƾ����</option>
						<option value="L" <%=search_type.equals("L") ? "selected" : ""%>>�ｺ��ǰ��õ</option>
						<%
					}
					%>
				</select>
			</td>
			<td><input id="title" type="text" name="title" style="width:100%" placeholder="�������Է��Ͻÿ�"></td>
			<%
			if(search_type.equals("T")) 
			{
				%>
					<td style="width:25%" align="center">���ε� �̹��� �̸�����</td>
				<%
			}
			%>
		</tr>
		<tr>
			<td style="width:120px; text-align:center; background-color:#f4f4f4">����</td>
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
			<td style="width:120px; text-align:center; background-color:#f4f4f4">÷������</td>
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
				<a class="btn write" href="#" onclick="javascript:DoWrite();">�۾��� �Ϸ�</a>
			</td>
		</tr>
	</table>					
</form>		
</span>
<!-- ������ ��º� -->
<%@ include file="../include/tail.jsp" %>