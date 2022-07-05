<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//======================== 세션에서 로그인 정보를 가져온다. ========
String login_id    = (String)session.getAttribute("id");
String login_no    = (String)session.getAttribute("no");
String login_name  = (String)session.getAttribute("name");
String login_level = (String)session.getAttribute("level");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>헬스 커뮤니티 헬창</title>
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
				alert("아이디를 입력하시오")
				document.login.id.focus();
				return false;
			}
			if( document.login.pw.value == "")
			{
				alert("비밀번호를 입력하시오")
				document.login.pw.focus();
				return false;
			}*/
			if($("#loginid").val() == "")
			{
				alert("아이디를 입력하시오");
				$("#loginid").focus();
				return false;
			}
			if($("#loginpw").val() == "")
			{
				alert("비밀번호를 입력하시오.");
				$("#loginpw").focus();
				return false;
			}
			//로그인처리
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
						//로그인 완료됨
						document.location = "../main/index.jsp";
					}else
					{
						$("#loginmsg").html("아이디 또는 비밀번호가 일치하지 않습니다.");
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
										<input type="text" id="loginid" name="loginid" value="" placeholder="아이디">
									</td>
									<td width="250px" align="center">
										<input class="login btn"type="button" onclick="Loginbutton()" value="로그인">
									</td>
								</tr>
								<tr>
									<td>
										<input type="password" id="loginpw" name="loginpw" value="" placeholder="비밀번호">
									</td>
									<td colspan="2" align="center">
										<a href="../join/index.jsp" class="btn write">회원가입</a>
									</td>
								</tr>
								<% 
							}else
							{
								%>
								<td align="center">
									[<%= login_name %>]님 환영
								</td>
								<td align="center">
									<a href="../login/logout.jsp" class="btn write">로그아웃</a>
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
								<a class="leftmenu" href="../board/index.jsp?search_type=G"><div class="<%= search_menu.equals("G") ? "selectmenu" : "menu" %>">공지사항</div></a>
								<a class="leftmenu" href="../board/tindex.jsp?search_type=T"><div class="<%= search_menu.equals("T") ? "selectmenu" : "menu" %>">회원사진</div></a>
								<a class="leftmenu" href="../board/index.jsp?search_type=R"><div class="<%= search_menu.equals("R") ? "selectmenu" : "menu" %>">루틴공유</div></a>
								<a class="leftmenu" href="../board/index.jsp?search_type=M"><div class="<%= search_menu.equals("M") ? "selectmenu" : "menu" %>">식단공유</div></a>
								<a class="leftmenu" href="../board/index.jsp?search_type=L"><div class="<%= search_menu.equals("L") ? "selectmenu" : "menu" %>">헬스용품추천</div></a>
							</td>
						</tr>
					</table>
				<td valign="top">		
