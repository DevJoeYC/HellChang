<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<table border="0" style="width:100%;">
	<tr>
		<td colspan="5" style="height:40px; width:100%;" valign="top">
			<div style="text-align:center;" class="submenu"><%= sub_title %></div>
			<div style="text-align:right;"><a class="btn write" href="../board/index.jsp?search_type=<%= sub_type %>">더보기</a></div>
		</td>
	</tr>
	<tr>
		<th class="list_num"></th>
		<th class="list_title">제목</th>
		<th class="list_date">작성일</th>
		<th class="list_author">작성자</th>
		<th class="list_hit">조회수</th>						
	</tr>
	<%				
	sql  = "select board_no,user_no,board_type,board_title,";
	sql += "       board_name,date(board_date) as board_date,board_hit, ";
	//댓글 갯수 얻기
	sql += "(select count(comt_no) from comment where board_no = board.board_no) as comt_no ";
	sql += "from board ";
	sql += "where board_type = '" + sub_type + "' ";
	sql += "order by board_no desc ";
	sql += "limit 0,3 ";	
	seqno = 1;
	result = stmt.executeQuery(sql);
	
	while(result.next() == true)
	{
		String board_no    = result.getString("board_no");
		String user_no     = result.getString("user_no");
		String board_type  = result.getString("board_type");
		String board_title = result.getString("board_title");
		String board_name  = result.getString("board_name");
		String board_date  = result.getString("board_date");
		String board_hit   = result.getString("board_hit");
		String comt_no     = result.getString("comt_no");

		%>
		<tr class="list">
			<td style="text-align:center;"><%= seqno++ %></td>
			<td style="text-align:center;"><a href="../board/view.jsp?no=<%= board_no %>&search_type=<%= sub_type %>"><%= board_title %></a>
				<%
				if(!comt_no.equals("0"))
				{
					%> 
					<span style="color:#ff6600">(<%= comt_no %>)</span>
					<%
				}
				%>
			</td>
			<td style="text-align:center;"><%= board_date %></td>
			<td style="text-align:center;"><%= board_name %></td>
			<td style="text-align:center;"><%= board_hit %></td>
		</tr>
		<%
	}
	
	if(seqno == 1)
	{
		%>
		<tr>
			<td colspan="5" style="background-color:#f4f4f4;height:80px;text-align:center;">
				조회된 자료가 없습니다.
			</td>						
		</tr>					
		<%
	}
	%>				
</table>							
