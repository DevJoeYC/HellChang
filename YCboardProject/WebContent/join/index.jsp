<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<script>

	//아이디 중복 검사 변수
	var IsOverLap = false;
	
	window.onload = function()
	{
		
		$("#joinid").focus();
		
		$("#joinid").keyup(function(){
			//아이디 중복 안됨.
			IsOverLap = false;
			
			var id = $("#joinid").val();
			if( id == "" )
			{
				$("#idmsg").html("아이디를 입력하시오.");
				return;
			}
			$.ajax({
				type: "get",
				url: "idcheck.jsp?id=" + id,
				dataType: "html",
				success : function(data)
				{
					data = data.trim();
					if(data == "올바른경로아님")
					{
						$("#idmsg").html("아이디조회오류")	
					}
					if(data == "중복")
					{
						$("#idmsg").html("중복된아이디")
						Isoverlap = true;
					}else
					{
						$("#idmsg").html("사용가능한아이디")	
					}
				}
			})
		});
	}
	
	function DoSubmit()
	{
		if(IsOverLap == true)
		{
			alert("중복된 아이디로 회원가입을 할 수 없습니다.");
			return;
		}
		if($("#joinid").val() == "")
		{
			alert("아이디를 입력하세요.");
			$("#joinid").focus();
			return;
		}
		if($("#joinpw").val() == "")
		{
			alert("비밀번호를 입력하세요.");
			$("#joinpw").focus();
			return;
		}
		if($("#joinpw").val() != $("#pwcheck").val())
		{
			alert("비밀번호가 일치하지 않습니다.");
			$("#joinpw").focus();
			return;
		}	
		if($("#name").val() == "")
		{
			alert("이름을 입력하세요.");
			$("#name").focus();
			return;
		}	
		if($("#sign").val() == "")
		{
			alert("자동방지가입코드를 입력하세요.");
			$("#sign").focus();
			return;
		}	
		//Ajax로 가동방지 가입코드를 가져온다.
		$.ajax({
			type : "get",
			url: "signok.jsp",
			dataType: "html",
			success : function(sign) 
			{
				sign = sign.trim();
				if($("#sign").val() == sign)
				{
					if(confirm("회원 가입 하시겠습니까?") != 1)
					{
						return;
					}
					$("#join").submit();					
				}else
				{
					alert("자동가입 방지코드가 일치하지 않습니다.");	
				}
			}
		});	
	}	
</script>
<!-- 컨텐츠 출력부 -->
<td rowspan="2" valign="top" align="center">
<span id="mainContent">
	<table border="0" style="width:100%;">
		<tr>
			<td style="height:40px">
				<div class="submenu" align="center">회원가입</div>
			</td>
		</tr>																		
	</table>
	<form id="join" name="join" method="post" action="joinok.jsp" >
		<table border="1" style="width:500px; border-radius: 10px;">
			<tr>
				<td style="width:130px;">아이디 (*)</td>
				<td>
					<input type="text" id="joinid" name="joinid" style="width:95%">
					<span id="idmsg">&nbsp;</span>
				</td>
			</tr>
			<tr>
				<td>비밀번호 (*)</td>
				<td><input type="password" id="joinpw" name="joinpw"  style="width:95%"></td>
			</tr>
			<tr>
				<td>비밀번호 확인 (*)</td>
				<td><input type="password" id="pwcheck" name="pwcheck" style="width:95%"></td>
			</tr>			
			<tr>
				<td>이름 (*)</td>
				<td><input type="text" id="name" name="name"  style="width:95%"></td>
			</tr>		
			<tr>
				<td>성별 (*)</td>
				<td>
					<input type="radio" id="gender" name="gender" checked>남자
					<input type="radio" id="gender" name="gender">여자
				</td>
			</tr>
			<tr>
				<td>자동가입방지코드</td>
				<td>
					<table border="0">
						<tr>
							<td>
								<img src="sign.jsp">
							</td>
							<td>
								<input type="text" id="sign" name="sign" size="12">
							</td>
						<tr>
					</table>			
									
				</td>
			</tr>					
			<tr>
				<td colspan="2" style="text-align:center;">
					<input type="button" onclick="javascript:DoSubmit()" value="가입완료">
				</td>							
			</tr>	
		</table>
	</form>	
</span>
</td>
<!-- 컨텐츠 출력부 -->
<%@ include file="../include/tail.jsp" %>