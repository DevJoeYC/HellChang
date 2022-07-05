<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//======================== ���ǿ��� �α��� ������ �����´�. ========
String login_id    = (String)session.getAttribute("id");
String login_no    = (String)session.getAttribute("no");
String login_name  = (String)session.getAttribute("name");
String login_level = (String)session.getAttribute("level");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>�ｺ Ŀ�´�Ƽ ��â</title>
		<link rel="stylesheet" href="../css/board.css"/>
		<link rel="stylesheet" href="../css/page.css"/>
		<link rel="stylesheet" href="../css/img.css"/>
		<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" >
		<script src="../js/jquery-3.6.0.js" ></script>
	</head>
	<body>
	<script>
		window.onload = function()
		{
			document.login.loginid.focus()
		}
		function Loginbutton()
		{
			//alert("")
			/*if( document.login.id.value == "")
			{
				alert("���̵� �Է��Ͻÿ�")
				document.login.id.focus();
				return false;
			}
			if( document.login.pw.value == "")
			{
				alert("��й�ȣ�� �Է��Ͻÿ�")
				document.login.pw.focus();
				return false;
			}*/
			if($("#loginid").val() == "")
			{
				alert("���̵� �Է��Ͻÿ�");
				$("#loginid").focus();
				return false;
			}
			if($("#loginpw").val() == "")
			{
				alert("��й�ȣ�� �Է��Ͻÿ�.");
				$("#loginpw").focus();
				return false;
			}
			//�α���ó��
			$.ajax({
				type : "post",
				url: "../login/loginok.jsp",
				dataType: "html",
				data: 
				{
			        id: $("#loginid").val(),
			        pw: $("#loginpw").val()
			    },	
				success : function(data) 
				{
					data = data.trim();
					if(data == "OK")
					{
						//�α��� �Ϸ��
						document.location = "../main/index.jsp";
					}else
					{
						$("#loginmsg").html("���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
						$("#loginmsg").css("color","red");
					}
				}
			});
			return false;
		}
	</script>
		<table border="0" width="1500px" align="center" height="1000px">
			<tr>
				<td valign="top" width="270px">
					<a href="../main/index.jsp"><img src="../img/logo.jpg" width="270px"></a>
					<table border="0" height="110px" width="270px">
						<form id="login" name="login" method="post" action="../login/loginok.jsp">
							<%
							if( login_id == null )
							{
								%>
								<tr>
									<td colspan="2">
										<input type="text" id="loginid" name="loginid" value="" placeholder="���̵�">
									</td>
									<td width="250px" align="center">
										<input class="login btn"type="button" onclick="Loginbutton()" value="�α���">
									</td>
								</tr>
								<tr>
									<td>
										<input type="password" id="loginpw" name="loginpw" value="" placeholder="��й�ȣ">
									</td>
									<td colspan="2" align="center">
										<a href="../join/index.jsp" class="btn write">ȸ������</a>
									</td>
								</tr>
								<% 
							}else
							{
								%>
								<td align="center">
									[<%= login_name %>]�� ȯ��
								</td>
								<td align="center">
									<a href="../login/logout.jsp" class="btn write">�α׾ƿ�</a>
								</td>
								<%
							}
							%>
						</form>
						<tr>
							<td colspan="3" style="font-size:12px;">
								<span id="loginmsg">&nbsp;</span>
							</td>
						</tr>
						<tr>
						<%
						String search_menu = request.getParameter("search_type");
						if(search_menu == null) search_menu = "";
						%>
							<td colspan="3">
								<a class="leftmenu" href="../board/index.jsp?search_type=G"><div class="<%= search_menu.equals("G") ? "selectmenu" : "menu" %>">��������</div></a>
								<a class="leftmenu" href="../board/tindex.jsp?search_type=T"><div class="<%= search_menu.equals("T") ? "selectmenu" : "menu" %>">ȸ������</div></a>
								<a class="leftmenu" href="../board/index.jsp?search_type=R"><div class="<%= search_menu.equals("R") ? "selectmenu" : "menu" %>">��ƾ����</div></a>
								<a class="leftmenu" href="../board/index.jsp?search_type=M"><div class="<%= search_menu.equals("M") ? "selectmenu" : "menu" %>">�Ĵܰ���</div></a>
								<a class="leftmenu" href="../board/index.jsp?search_type=L"><div class="<%= search_menu.equals("L") ? "selectmenu" : "menu" %>">�ｺ��ǰ��õ</div></a>
							</td>
						</tr>
					</table>
				<td valign="top">		
