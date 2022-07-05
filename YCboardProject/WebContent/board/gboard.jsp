<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//where  ������ �ۼ��Ѵ�.
String where = "";
where += "where board_type = 'G' ";
if(!search_key.equals(""))
{
	if(search_kind.equals("T"))
	{
		//���񿡼� �˻�
		where += "and board_title like '%" + search_key + "%' ";
	}else if(search_kind.equals("C"))
	{
		//���뿡�� �˻�
		where += "and board_note like '%" + search_key + "%' ";
	}else
	{
		//���� + ���뿡�� �˻�
		where += "and (board_title like '%" + search_key + "%'";
		where += "or board_note like '%" + search_key + "%') ";					
	}
}

//(4)�Խù��� ������ ��´�.
String sql = "";
sql += "select count(*) as count ";
sql += "from board ";
sql += where;
//System.out.println(sql);

ResultSet result = stmt.executeQuery(sql);
result.next();
total = result.getInt("count");
result.close();

//(5)�ִ� ������ ������ ����Ѵ�.
maxpage = total / 10;
if( total % 10 != 0) maxpage++;	

sql  = "select board_no,user_no,board_type,board_title,";
sql += "       board_name,date(board_date) as board_date,board_hit, ";
//��� ���� ���
sql += "(select count(comt_no) from comment where board_no = board.board_no) as comt_no ";
sql += "from board ";
sql += where;
sql += "order by board_no desc ";

//(2) SQL��  limit ���� ��ȣ�� ����Ѵ�. (1 based ������)
startno = (curpage - 1) * 3;

//(1) �������� 10���� ���������� limit �� ó���Ѵ�.
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
		<td class="announcement">����</td>
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