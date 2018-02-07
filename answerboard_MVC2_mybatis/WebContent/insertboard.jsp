<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function boardList(){
		location.href = "AnsController.do?command=boardlist";
	}
	
</script>
</head>
<body>

<jsp:include page="header.jsp"/>
<div id="container">
<h1>게시글작성하기</h1>
<form action="AnsController.do" method="post">
<input type="hidden" name="command" value="insertboard">
<table class="table table-striped">
	<tr>
		<th>아이디</th>
		<td><input class="form-control" type="text" name="id"></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input class="form-control" type="text" name="title"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea class="form-control" rows="10" cols="60" name="content"></textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="글작성">
			<input type="button" value="목록" onclick="boardList()">
		</td>
	</tr>

</table>
</form>
</div>
<jsp:include page="footer.jsp"/>
<script type="text/javascript">
	$(function(){
		$("form").submit(function(){
			$("tr>td").each(function(){
				if($(this).children().val()==""){
					alert($(this).children().attr("name")+"을 입력하세요");
					$(this).children().focus();
					bool = false;//submit이벤트 취소
					return false;//each에 구현된 function종료
				}
			});
			return bool; // submit에 구현된 function 종료 --> sublit 종료
		});
	});
</script>
</body>
</html>