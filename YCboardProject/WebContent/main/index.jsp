<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<!-- ������ ��º� -->
<table border="0" style="width:100%; height:100%;">
		<tr>
			<td style="height:40px;" valign="top">
				<div class="submenu">�ｺ Ŀ�´�Ƽ ��â �Դϴ�.</div>
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
							String sub_title = "��������";
							String sub_type  = "G";
							String sql = "";
							ResultSet result;
							int seqno = 1;
							%>
							<%@ include file="sub2.jsp" %>
						</td>
						<td>
							<%
							sub_title = "��ƾ����";
							sub_type  = "R";
							%>
							<%@ include file="sub.jsp" %>
						</td>
					</tr>
					<tr>
						<td>
							<%
							sub_title = "�Ĵܰ���";
							sub_type  = "M";
							%>
							<%@ include file="sub.jsp" %>
						</td>
						<td>
							<%
							sub_title = "�ｺ�����õ";
							sub_type  = "L";
							%>
							<%@ include file="sub.jsp" %>
						</td>
					</tr>					
				</table>							
			</td>
		</tr>
	</table>
<!-- ������ ��º� -->	
<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>