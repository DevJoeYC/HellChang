<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<script>

	//���̵� �ߺ� �˻� ����
	var IsOverLap = false;
	
	window.onload = function()
	{
		
		$("#joinid").focus();
		
		$("#joinid").keyup(function(){
			//���̵� �ߺ� �ȵ�.
			IsOverLap = false;
			
			var id = $("#joinid").val();
			if( id == "" )
			{
				$("#idmsg").html("���̵� �Է��Ͻÿ�.");
				return;
			}
			$.ajax({
				type: "get",
				url: "idcheck.jsp?id=" + id,
				dataType: "html",
				success : function(data)
				{
					data = data.trim();
					if(data == "�ùٸ���ξƴ�")
					{
						$("#idmsg").html("���̵���ȸ����")	
					}
					if(data == "�ߺ�")
					{
						$("#idmsg").html("�ߺ��Ⱦ��̵�")
						Isoverlap = true;
					}else
					{
						$("#idmsg").html("��밡���Ѿ��̵�")	
					}
				}
			})
		});
	}
	
	function DoSubmit()
	{
		if(IsOverLap == true)
		{
			alert("�ߺ��� ���̵�� ȸ�������� �� �� �����ϴ�.");
			return;
		}
		if($("#joinid").val() == "")
		{
			alert("���̵� �Է��ϼ���.");
			$("#joinid").focus();
			return;
		}
		if($("#joinpw").val() == "")
		{
			alert("��й�ȣ�� �Է��ϼ���.");
			$("#joinpw").focus();
			return;
		}
		if($("#joinpw").val() != $("#pwcheck").val())
		{
			alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			$("#joinpw").focus();
			return;
		}	
		if($("#name").val() == "")
		{
			alert("�̸��� �Է��ϼ���.");
			$("#name").focus();
			return;
		}	
		if($("#sign").val() == "")
		{
			alert("�ڵ����������ڵ带 �Է��ϼ���.");
			$("#sign").focus();
			return;
		}	
		//Ajax�� �������� �����ڵ带 �����´�.
		$.ajax({
			type : "get",
			url: "signok.jsp",
			dataType: "html",
			success : function(sign) 
			{
				sign = sign.trim();
				if($("#sign").val() == sign)
				{
					if(confirm("ȸ�� ���� �Ͻðڽ��ϱ�?") != 1)
					{
						return;
					}
					$("#join").submit();					
				}else
				{
					alert("�ڵ����� �����ڵ尡 ��ġ���� �ʽ��ϴ�.");	
				}
			}
		});	
	}	
</script>
<!-- ������ ��º� -->
<td rowspan="2" valign="top" align="center">
<span id="mainContent">
	<table border="0" style="width:100%;">
		<tr>
			<td style="height:40px">
				<div class="submenu" align="center">ȸ������</div>
			</td>
		</tr>																		
	</table>
	<form id="join" name="join" method="post" action="joinok.jsp" >
		<table border="1" style="width:500px; border-radius: 10px;">
			<tr>
				<td style="width:130px;">���̵� (*)</td>
				<td>
					<input type="text" id="joinid" name="joinid" style="width:95%">
					<span id="idmsg">&nbsp;</span>
				</td>
			</tr>
			<tr>
				<td>��й�ȣ (*)</td>
				<td><input type="password" id="joinpw" name="joinpw"  style="width:95%"></td>
			</tr>
			<tr>
				<td>��й�ȣ Ȯ�� (*)</td>
				<td><input type="password" id="pwcheck" name="pwcheck" style="width:95%"></td>
			</tr>			
			<tr>
				<td>�̸� (*)</td>
				<td><input type="text" id="name" name="name"  style="width:95%"></td>
			</tr>		
			<tr>
				<td>���� (*)</td>
				<td>
					<input type="radio" id="gender" name="gender" checked>����
					<input type="radio" id="gender" name="gender">����
				</td>
			</tr>
			<tr>
				<td>�ڵ����Թ����ڵ�</td>
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
					<input type="button" onclick="javascript:DoSubmit()" value="���ԿϷ�">
				</td>							
			</tr>	
		</table>
	</form>	
</span>
</td>
<!-- ������ ��º� -->
<%@ include file="../include/tail.jsp" %>