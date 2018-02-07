<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="header.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	//글 수정하기
	function updateForm(seq){
		location.href = "AnsController.do?command=updateform&seq="+seq;
	}
	//글 삭제하기
	function delBoard(seq){
		//글 여러개 삭제하는 기능을 사용할거라 "chk"이름으로  seq를 전달함
		location.href = "AnsController.do?command=muldel&chk="+seq;
	}
	//답글 폼 보여주기 : show(), offset(), animate(), css속성(scrollTop)
	function replyForm(){
		$("#replyForm").show();
		var replyPosition=$("#replyForm").offset().top;
		$("#container").animate({
			"scrollTop":replyPosition
		},2000);
	}
	
	//유효값 처리
	$(function(){
		$("form").submit(function(){
			$("#replyForm tr>td").each(function(){
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
</head>
<body>
<div id="container">
<h1>게시글 상세보기</h1>
<table class="table table-striped">
	<tr>
		<th>번호</th>
		<td>${dto.seq}</td>
	</tr>
	<tr>
		<th>아이디</th>
		<td>${dto.id}</td>
	</tr>
	<tr>
		<th>작성일</th>
		<td><fmt:formatDate value="${dto.regDate}" pattern="yyyy년MM월dd일"/> </td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${dto.title}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea class="form-control" rows="10" cols="60" placeholder="Readonly input here…" readonly>${dto.content}</textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input class="btn btn-primary" type="button" value="수정" onclick="updateForm(${dto.seq})">
			<input class="btn btn-warning" type="button" value="삭제" onclick="delBoard(${dto.seq})">
			<input class="btn btn-success" type="button" value="답글" onclick="replyForm()">
	
		</td>
	</tr>
</table>
<div id="replyForm">
	<hr>
	<h2>답글달기</h2>
	<form action="AnsController.do" method="post">
		<input type="hidden" name="command" value="replyboard"/>
		<input type="hidden" name="seq" value="${dto.seq}"/>
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
				<td><textarea class="form-control" name="content" rows="10" cols="60"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input class="btn btn-primary" type="submit" value="답글"/>
				</td>
			</tr>
		</table>
	</form>
</div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>