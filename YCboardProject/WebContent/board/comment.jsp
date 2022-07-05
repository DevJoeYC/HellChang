<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<table border="0" width="100%">
<% 
	sql  = "select comt_no,comt_userno,comt_name,comt_note,date(comt_date) as comt_date ";
	sql += "from comment ";
	sql += "where board_no = '" + no + "' ";
	sql += "order by comt_no desc ";
	System.out.println(sql);
	result = stmt.executeQuery(sql);
	while(result.next() == true)
	{
		String comt_no     = result.getString("comt_no");
		String comt_userno = result.getString("comt_userno");
		String comt_name   = result.getString("comt_name");
		String comt_note   = result.getString("comt_note");
		String comt_date   = result.getString("comt_date");
		%>
			<tr>
				<td align="left" valign="top" class="comment nick"><%= comt_name %></td>
			</tr>
			<tr>
				<td colspan="3" class="comment"><%= comt_note %></td>
				<td>
				<%
					if(login_id != null)
					{
						if( login_level.equals("A") || login_no.equals(comt_userno) )
						{
							//관리자 권한이거나 글을 작성한 본인인 경우....
							%>
							<a class="btn rp" href="#" onclick="EditComment(this,<%= comt_no %>);">수정</a>
							<a class="btn rp" href="commentdel.jsp?no=<%= no %>&cno=<%= comt_no %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>">삭제</a>
							<%
						}
					}
					%>
				</td>
			</tr>
			<tr>
				<td class="comment date"><%= comt_date %></td>
			</tr>
		<%
	}
%>

	<br>
	<%
		if(login_id != null)
		{
			%>
			<script>
				function CheckComment()
				{
					if($("#CmtNote").val() == "")
					{
						alert("댓글 내용을 입력하세요.");
						$("#CmtNote").focus();
						return;
					}
					$("#Cmt").submit();
				}
				
				var orgTrHTML = "";
				var orgTr     = null;
				function EditComment(obj,comt_no)
				{
					var tr = $(obj).parent().parent();
					
					if(orgTr != null)
					{
						orgTr.html(orgTrHTML);	
					}
					orgTrHTML = tr.html();
					orgTr     = tr;
					
					$.ajax({
						type : "get",
						url: "commentedit.jsp?cno=" + comt_no,
						dataType: "html",
						success : function(data) 
						{
							tr.html(data);
						}
					});					
				}
				
				function EditCommentOK(obj,comt_no)
				{
					var tr = $(obj).parent().parent();
					
					if($("#edit_note").val() == "")
					{
						alert("댓글 내용을 입력하세요.");
						$("#edit_note").focus();
						return;
					}
					
					$.ajax({
						type : "post",
						url: "editcommentok.jsp?comt_no=" + comt_no ,
						dataType: "html",
						contentType: "application/x-www-form-urlencoded; charset=euc-kr",
						data: 
						{
							edit_note: $("#edit_note").val()
					    },	
						success : function(data) 
						{
							tr.html(data);
						}
					});	
				}
			</script>
			<form name="Cmt" id="Cmt" method="post" action="commentok.jsp">
				<input type="hidden" name="board_no" value="<%= board_no %>">
				<input type="hidden" name="user_no" value="<%= user_no %>">
				<input type="hidden" name="search_type" value="<%= search_type %>">
				<input type="hidden" name="search_kind" value="<%= search_kind %>">
				<input type="hidden" name="search_key" value="<%= search_key %>">
				<input type="hidden" name="page" value="<%= curr_page %>">
				<input type="hidden" name="no" value="<%= no %>">
				<tr>
					<td width="150px" align="right">
					<%= login_name %>	
					</td>
					<td align="center" valign="top">
						<textarea id="CmtNote" name="CmtNote" style="width:720px; height:100px;"></textarea>
					</td>
					<td width="150px" align="left">
						<a href="javascript:CheckComment();" class="btn write">댓글등록</a>
					</td>
				</tr>			
			</form>
		<%	
		}
		%>
</table>