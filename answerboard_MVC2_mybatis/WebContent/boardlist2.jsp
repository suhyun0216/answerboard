<%@page import="com.hk.ansdtos.AnsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>

<% request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>답변형 게시판 글목록 보기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$(".detail").children("a").hover(
			function() {
				var seq = $(this).parent().prev().prev().eq(0).text();
				$.ajax({
					url:"./Detail.do",
					data:"seq="+seq,
					type:"post",
					datatype:"json",
					success:function(obj){
						var dto = obj["dto"];
						$("textarea[name=content]").val(dto["content"]);
					}
				})
		}, function() {
			
		})
	})


	function insertForm(){
		location.href = "AnsController.do?command=insertform"
	}
	
	$(function(){
		$("h1").click(function(){
			$("th").slice(6,10).toggle();
			$("tr").each(function(){
				$(this).children("td").slice(6,10).toggle();
			});
		});
	})
	
	function allSel(bool){
		$("input[name=chk]").prop("checked",bool)
	}
</script>
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="container">
<jsp:useBean id="util" class="com.hk.dbinfo.Util"/>
<h1>답변형 게시판 글목록 보기</h1>
<textarea rows="2" cols="60" name="content" readonly="readonly"></textarea>
<form action="AnsController.do" method="post">
<input type="hidden" name="command" value="muldel">
<table class="table table-hover">
	<col width="50px"><col width="50px"><col width="100px"><col width="200px">
	<col width="100px"><col width="50px"><col width="50px"><col width="50px">
	<col width="50px"><col width="50px">
	<tr>
		<th><input type="checkbox" name="all" onclick="allSel(this.checked)"></th>
		<th>번호</th>
		<th>작성자</th>
		<th>제목</th>
		<th>작성일</th>
		<th>조회수</th>
		<th>refer</th>
		<th>step</th>
		<th>depth</th>
		<th>삭제</th>
	</tr>
		<c:choose>
			<c:when test="${empty lists}">
				<tr><td colspan="10">----작성된 글이 없습니다----</td></tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${lists}" var="dto">
					<tr>
						<td><input type="checkbox" name="chk" value="${dto.seq}"></td>
						<td>${dto.seq}</td>
						<td>${dto.id}</td>
						<c:choose>
							<c:when test="${dto.delFlag=='Y'}">
								<td>--삭제된 글입니다--</td>
							</c:when>
							<c:otherwise>
								<td class="detail">
									<jsp:setProperty property="arrowNbsp" name="util" value="${dto.depth}"/>
									<jsp:getProperty property="arrowNbsp" name="util" />
									<a href="AnsController.do?count=count&command=detail&seq=${dto.seq}">${dto.title}</a>
								</td>
							</c:otherwise>	
						</c:choose>
						<td><f:formatDate value="${dto.regDate}" pattern="yyyy년MM월dd일"/></td>
						<td>${dto.readCount}</td>
						<td>${dto.refer}</td>
						<td>${dto.step}</td>
						<td>${dto.depth}</td>
						<td>${dto.delFlag}</td>
					</tr>
				</c:forEach>
			</c:otherwise>	
		</c:choose>
	<tr>
		<td colspan="10">
			<input type="button" value="글추가" onclick="insertForm()">
			<input type="submit" value="삭제">
		</td> 
	</tr>
</table>
</form>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>