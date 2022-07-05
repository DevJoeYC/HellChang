<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<!-- 컨텐츠 출력부 -->
<table border="0" style="width:100%; height:100%;">
		<tr>
			<td style="height:40px;" valign="top">
				<div class="submenu">헬스 커뮤니티 헬창 입니다.</div>
			</td>
		</tr>
		<tr>
			<td style="height:25px; text-align:right;">
			</td>
		</tr>						
		<tr>
			<td valign="top">
				<table border="0" style="width:100%;">
					<tr>
						<td colspan="2">
							<a class="main" href="../main/index.jsp"><img src="../img/main.gif" width="100%" height="200px"></a>
						</td>
					</tr>
					<tr>
						<td>
							<%
							String sub_title = "공지사항";
							String sub_type  = "G";
							String sql = "";
							ResultSet result;
							int seqno = 1;
							%>
							<%@ include file="sub2.jsp" %>
						</td>
						<td>
							<%
							sub_title = "루틴공유";
							sub_type  = "R";
							%>
							<%@ include file="sub.jsp" %>
						</td>
					</tr>
					<tr>
						<td>
							<%
							sub_title = "식단공유";
							sub_type  = "M";
							%>
							<%@ include file="sub.jsp" %>
						</td>
						<td>
							<%
							sub_title = "헬스장비추천";
							sub_type  = "L";
							%>
							<%@ include file="sub.jsp" %>
						</td>
					</tr>					
				</table>							
			</td>
		</tr>
	</table>
<!-- 컨텐츠 출력부 -->	
<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>