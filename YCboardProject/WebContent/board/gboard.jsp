<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//where  구문을 작성한다.
String where = "";
where += "where board_type = 'G' ";
if(!search_key.equals(""))
{
	if(search_kind.equals("T"))
	{
		//제목에서 검색
		where += "and board_title like '%" + search_key + "%' ";
	}else if(search_kind.equals("C"))
	{
		//내용에서 검색
		where += "and board_note like '%" + search_key + "%' ";
	}else
	{
		//제목 + 내용에서 검색
		where += "and (board_title like '%" + search_key + "%'";
		where += "or board_note like '%" + search_key + "%') ";					
	}
}

//(4)게시물의 갯수를 얻는다.
String sql = "";
sql += "select count(*) as count ";
sql += "from board ";
sql += where;
//System.out.println(sql);

ResultSet result = stmt.executeQuery(sql);
result.next();
total = result.getInt("count");
result.close();

//(5)최대 페이지 갯수를 계산한다.
maxpage = total / 10;
if( total % 10 != 0) maxpage++;	

sql  = "select board_no,user_no,board_type,board_title,";
sql += "       board_name,date(board_date) as board_date,board_hit, ";
//댓글 갯수 얻기
sql += "(select count(comt_no) from comment where board_no = board.board_no) as comt_no ";
sql += "from board ";
sql += where;
sql += "order by board_no desc ";

//(2) SQL의  limit 시작 번호를 계산한다. (1 based 페이지)
startno = (curpage - 1) * 3;

//(1) 페이지당 10개씩 가져오도록 limit 를 처리한다.
sql += "limit " + startno + ",3";

result = stmt.executeQuery(sql);

int seqno = total - startno;

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
	<tr>
		<td class="announcement">공지</td>
		<td class="announcement"><a style="color:#FF4E59;" href="../board/view.jsp?no=<%= board_no %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>&page=<%= curpage %>"><%= board_title %></a> 
			<%
			if(!comt_no.equals("0"))
			{
				%> 
				<span style="color:#ff6600">(<%= comt_no %>)</span>
				<%
			}
			%>
		</td>
		<td class="announcement"><%= board_date %></td>
		<td class="announcement"><%= board_name %></td>
		<td class="announcement"><%= board_hit %></td>
	</tr>
	<%
}
%>