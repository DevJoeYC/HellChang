<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

//페이징을 위한 변수 선언
int total   = 0;  //전체 게시물 갯수
int maxpage = 0;  //최대 페이지 갯수
int curpage = 1;  //현재 페이지 번호
int startno = 0;  //SQL limit 시작 번호
int startBlock = 0; //페이징 시작 블럭 번호
int endBlock   = 0; //페이징 끝 블럭 번호

String search_type = request.getParameter("search_type");
String search_kind = request.getParameter("search_kind");
String search_key  = request.getParameter("search_key");

if(search_type == null) search_type = "T";
if(search_kind == null) search_kind = "T";
if(search_key  == null) search_key  = "";

//(3) "index.jsp?page=1" 에서 넘어온 page를 분석한다.
if( request.getParameter("page") != null)
{
	//넘어온 page 값을 정수형 curpage 로 변환한다. 
	curpage = Integer.parseInt(request.getParameter("page"));
}else
{
	//넘어온 page 값이 없으므로 현재 페이지 번호를 1로 설정한다. 
	curpage = 1;
}

%>
<!-- 컨텐츠 출력부 -->
<table border="0" style="width:100%; height:100%;">
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
	<tr>
		<td style="height:25px; text-align:right;">
		
		<a class="btn write" href="index.jsp?search_type=T&page=<%= curpage %>">리스트</a>
		<%
			if(login_id == null)
			{
				
			}else if(login_level.equals("A") && search_type.equals("G"))
			{
				%><a href="../board/write.jsp?search_type=G" class="btn write">글쓰기</a><%	
			}else if(login_level.equals("U") && search_type.equals("G"))
			{
				
			}else
			{
				%><a href="../board/write.jsp?search_type=<%= search_type %>" class="btn write">글쓰기</a><%
			}
			%>
		</td>
	</tr>						
	<tr>
		<td valign="top">
			<table border="0" style="width:100%;">
				<tr>
					<th class="list_num"></th>
					<th class="list_title">제목</th>
					<th class="list_date">작성일</th>
					<th class="list_author">작성자</th>
					<th class="list_hit">조회수</th>							
				</tr>
				<%@ include file="gboard.jsp" %>
			</table>
		</td>
	</tr>
				<%
				//where  구문을 작성한다.
				where = "";
				where += "where board_type = '" + search_type + "' ";
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
				sql = "";
				sql += "select count(*) as count ";
				sql += "from board ";
				sql += where;
				//System.out.println(sql);
				
				result = stmt.executeQuery(sql);
				result.next();
				total = result.getInt("count");
				result.close();
				
				//(5)최대 페이지 갯수를 계산한다.
				maxpage = total / 10;
				if( total % 10 != 0) maxpage++;	
				
				sql  = "select board_no,user_no,board_type,board_title,";
				sql += "       board_name,date(board_date) as board_date,board_hit, ";
				sql += "(select attach_pname from attach where board_no = board.board_no order by attach_no asc limit 1) as attach_pname, ";
				sql += "(select attach_fname from attach where board_no = board.board_no order by attach_no asc limit 1) as attach_fname, ";
				//댓글 갯수 얻기
				sql += "(select count(comt_no) from comment where board_no = board.board_no) as comt_no ";
				sql += "from board ";
				sql += where;
				sql += "order by board_no desc ";
				
				//(2) SQL의  limit 시작 번호를 계산한다. (1 based 페이지)
				startno = (curpage - 1) * 12;
				
				//(1) 페이지당 10개씩 가져오도록 limit 를 처리한다.
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
						<div><div class="idate"><%= board_date %></div><div class="ihit">조회 <%= board_hit %></div></div>
					</div>
					<%
				}
				%>
		</td>
	</tr>
	<tr>
		<td style="text-align:center;">
		<!-- 
		◀ 1 2 3 4 5 6 7 8 9  ▶
		 -->
		
		<%
		//(6)최대 페이지 갯수 만큼 페이지를 표시한다.
		/*
		for(int pageno = 1; pageno <= maxpage; pageno++)
		{
			%><%= pageno %> | <%
		}
		*/
		//(7)최대 페이지 갯수 만큼 페이지를 표시한다.
		/*
		for(int pageno = 1; pageno <= maxpage; pageno++)
		{
			%><a href="tindex.jsp?page=<%= pageno %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>"><%= pageno %></a><%
		}
		*/
		//(8)페이징 시작블럭번호와 끝블럭 번호를 계산한다.
		startBlock = ( (curpage - 1)  / 10) * 10 + 1;
		endBlock   = startBlock + 10 - 1; 
		//(9)endBlock 이 최대 페이지 번호보다 크면 안됨.
		if( endBlock > maxpage)
		{
			//예: maxpage가 22인데, endBlock이 30이면 endBlock을 22로 변경
			endBlock = maxpage;
		}
		
		if(startBlock != 1)
		{
			%>
			<div class="page_nation"><a class="arrow prev" href="tindex.jsp?page=<%= startBlock - 1 %>&search_type=<%= search_type %>&search_kind=<%= search_kind %>&search_key=<%= search_key %>"></a></div>
			<%
		}
		
		//(10)최대 페이지 갯수 만큼 페이지를 표시한다.
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
					<option value="G" <%= search_type.equals("G") ? "selected" : "" %>>공지사항</option>
					<option value="T" <%= search_type.equals("T") ? "selected" : "" %>>회원 사진 게시판</option>
					<option value="R" <%= search_type.equals("R") ? "selected" : "" %>>루틴 공유 게시판</option>
					<option value="M" <%= search_type.equals("M") ? "selected" : "" %>>식단 공유 게시판</option>
					<option value="L" <%= search_type.equals("L") ? "selected" : "" %>>헬스용품 추천 게시판</option>													
				</select>
				<select name="search_kind">
					<option value="T" <%= search_kind.equals("T") ? "selected" : "" %>>제목</option>
					<option value="C" <%= search_kind.equals("C") ? "selected" : "" %>>내용</option>
					<option value="A" <%= search_kind.equals("A") ? "selected" : "" %>>제목 + 내용</option>													
				</select>
				<input type="text" size="20" id="search_key" name="search_key" value="<%= search_key %>">
				<a href="javascript:document.search.submit();" class="btn write">검색</a>
			</form>
		</td>
	</tr>																		
</table>
<!-- 컨텐츠 출력부 -->
<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>