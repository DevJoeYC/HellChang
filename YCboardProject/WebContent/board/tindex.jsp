<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

//����¡�� ���� ���� ����
int total   = 0;  //��ü �Խù� ����
int maxpage = 0;  //�ִ� ������ ����
int curpage = 1;  //���� ������ ��ȣ
int startno = 0;  //SQL limit ���� ��ȣ
int startBlock = 0; //����¡ ���� �� ��ȣ
int endBlock   = 0; //����¡ �� �� ��ȣ

String search_type = request.getParameter("search_type");
String search_kind = request.getParameter("search_kind");
String search_key  = request.getParameter("search_key");

if(search_type == null) search_type = "T";
if(search_kind == null) search_kind = "T";
if(search_key  == null) search_key  = "";

//(3) "index.jsp?page=1" ���� �Ѿ�� page�� �м��Ѵ�.
if( request.getParameter("page") != null)
{
	//�Ѿ�� page ���� ������ curpage �� ��ȯ�Ѵ�. 
	curpage = Integer.parseInt(request.getParameter("page"));
}else
{
	//�Ѿ�� page ���� �����Ƿ� ���� ������ ��ȣ�� 1�� �����Ѵ�. 
	curpage = 1;
}

%>
<!-- ������ ��º� -->
<table border="0" style="width:100%; height:100%;">
	<tr>
		<td style="height:40px;" valign="top">
			<div class="submenu">
					<%
					if(search_type.equals("G"))
					{
						%>��������<% 
					}else if(search_type.equals("T"))
					{
						%>ȸ������<%
					}else if(search_type.equals("R"))
					{
						%>��ƾ����<%
					}else if(search_type.equals("M"))
					{
						%>�Ĵܰ���<%
					}else if(search_type.equals("L"))
					{
						%>�ｺ��ǰ��õ<%
					}
					%>
			</div>
		</td>
	</tr>
	<tr>
		<td style="height:25px; text-align:right;">
		
		<a class="btn write" href="index.jsp?search_type=T&page=<%= curpage %>">����Ʈ</a>
		<%
			if(login_id == null)
			{
				
			}else if(login_level.equals("A") && search_type.equals("G"))
			{
				%><a href="../board/write.jsp?search_type=G" class="btn write">�۾���</a><%	
			}else if(login_level.equals("U") && search_type.equals("G"))
			{
				
			}else
			{
				%><a href="../board/write.jsp?search_type=<%= search_type %>" class="btn write">�۾���</a><%
			}
			%>
		</td>
	</tr>						
	<tr>
		<td valign="top">
			<table border="0" style="width:100%;">
				<tr>
					<th class="list_num"></th>
					<th class="list_title">����</th>
					<th class="list_date">�ۼ���</th>
					<th class="list_author">�ۼ���</th>
					<th class="list_hit">��ȸ��</th>							
				</tr>
				<%@ include file="gboard.jsp" %>
			</table>
		</td>
	</tr>
				<%
				//where  ������ �ۼ��Ѵ�.
				where = "";
				where += "where board_type = '" + search_type + "' ";
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
				sql = "";
				sql += "select count(*) as count ";
				sql += "from board ";
				sql += where;
				//System.out.println(sql);
				
				result = stmt.executeQuery(sql);
				result.next();
				total = result.getInt("count");
				result.close();
				
				//(5)�ִ� ������ ������ ����Ѵ�.
				maxpage = total / 10;
				if( total % 10 != 0) maxpage++;	
				
				sql  = "select board_no,user_no,board_type,board_title,";
				sql += "       board_name,date(board_date) as board_date,board_hit, ";
				sql += "(select attach_pname from attach where board_no = board.board_no order by attach_no asc limit 1) as attach_pname, ";
				sql += "(select attach_fname from attach where board_no = board.board_no order by attach_no asc limit 1) as attach_fname, ";
				//��� ���� ���
				sql += "(select count(comt_no) from comment where board_no = board.board_no) as comt_no ";
				sql += "from board ";
				sql += where;
				sql += "order by board_no desc ";
				
				//(2) SQL��  limit ���� ��ȣ�� ����Ѵ�. (1 based ������)
				startno = (curpage - 1) * 12;
				
				//(1) �������� 10���� ���������� limit �� ó���Ѵ�.
				sql += "limit " + startno + ",12";
				
				result = stmt.executeQuery(sql);
				
				seqno = total - startno;
				%>
				<tr>
					<td valign="top" align="center">
				<%
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
					String attach_pname = result.getString("attach_pname");
					String attach_fname = result.getString("attach_fname");
				
					%>
					<div class="imgg">
						<div class="img"><a href="../board/view.jsp?no=<%= board_no %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>&page=<%= curpage %>"><img src="download.jsp?file=<%= attach_pname %>&name=<%= attach_fname %>"></a></div>
						<div class="ino"><%= seqno-- %></div><div class="ititle"><a href="../board/view.jsp?no=<%= board_no %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>&page=<%= curpage %>"><%= board_title %></a></div>
							<%
							if(!comt_no.equals("0"))
							{
								%> 
								<span class="icomt" style="color:#ff6600">[<%= comt_no %>]</span>
								<%
							}
							%>
						<div>
							<div class="iname"><%= board_name %></div>
						</div>
						<div><div class="idate"><%= board_date %></div><div class="ihit">��ȸ <%= board_hit %></div></div>
					</div>
					<%
				}
				%>
		</td>
	</tr>
	<tr>
		<td style="text-align:center;">
		<!-- 
		�� 1 2 3 4 5 6 7 8 9  ��
		 -->
		
		<%
		//(6)�ִ� ������ ���� ��ŭ �������� ǥ���Ѵ�.
		/*
		for(int pageno = 1; pageno <= maxpage; pageno++)
		{
			%><%= pageno %> | <%
		}
		*/
		//(7)�ִ� ������ ���� ��ŭ �������� ǥ���Ѵ�.
		/*
		for(int pageno = 1; pageno <= maxpage; pageno++)
		{
			%><a href="tindex.jsp?page=<%= pageno %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>"><%= pageno %></a><%
		}
		*/
		//(8)����¡ ���ۺ���ȣ�� ���� ��ȣ�� ����Ѵ�.
		startBlock = ( (curpage - 1)  / 10) * 10 + 1;
		endBlock   = startBlock + 10 - 1; 
		//(9)endBlock �� �ִ� ������ ��ȣ���� ũ�� �ȵ�.
		if( endBlock > maxpage)
		{
			//��: maxpage�� 22�ε�, endBlock�� 30�̸� endBlock�� 22�� ����
			endBlock = maxpage;
		}
		
		if(startBlock != 1)
		{
			%>
			<div class="page_nation"><a class="arrow prev" href="tindex.jsp?page=<%= startBlock - 1 %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>"></a></div>
			<%
		}
		
		//(10)�ִ� ������ ���� ��ŭ �������� ǥ���Ѵ�.
		for(int pageno = startBlock; pageno <= endBlock; pageno++)
		{
			if(curpage == pageno)
			{
				%><div class="page_nation"><a class="active" href="tindex.jsp?page=<%= pageno %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>"><%= pageno %></a></div><%
			}else
			{
				%><div class="page_nation"><a href="tindex.jsp?page=<%= pageno %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>"><%= pageno %></a></div><%
			}
		}
		if(endBlock != maxpage)
		{
			%>	
			<div class="page_nation"><a class="arrow next" href="tindex.jsp?page=<%= endBlock + 1 %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>"></a></div>
			<%
		}
		%>
		</td>
	</tr>	
	<tr>
		<td align="center">
			<form id="search" name="search" method="get" action="index.jsp">
				<select name="search_type" onchange="document.search.submit();">
					<option value="G" <%= search_type.equals("G") ? "selected" : "" %>>��������</option>
					<option value="T" <%= search_type.equals("T") ? "selected" : "" %>>ȸ�� ���� �Խ���</option>
					<option value="R" <%= search_type.equals("R") ? "selected" : "" %>>��ƾ ���� �Խ���</option>
					<option value="M" <%= search_type.equals("M") ? "selected" : "" %>>�Ĵ� ���� �Խ���</option>
					<option value="L" <%= search_type.equals("L") ? "selected" : "" %>>�ｺ��ǰ ��õ �Խ���</option>													
				</select>
				<select name="search_kind">
					<option value="T" <%= search_kind.equals("T") ? "selected" : "" %>>����</option>
					<option value="C" <%= search_kind.equals("C") ? "selected" : "" %>>����</option>
					<option value="A" <%= search_kind.equals("A") ? "selected" : "" %>>���� + ����</option>													
				</select>
				<input type="text" size="20" id="search_key" name="search_key" value="<%= search_key %>">
				<a href="javascript:document.search.submit();" class="btn write">�˻�</a>
			</form>
		</td>
	</tr>																		
</table>
<!-- ������ ��º� -->
<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>