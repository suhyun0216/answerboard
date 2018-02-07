<%@page import="com.hk.ansdtos.AnsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>답변형 게시판 글목록 보기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	function insertForm(){
		location.href = "anscontroller.jsp?command=insertform"
	}
	
	$(function(){
		$("h1").click(function(){
			$("th").slice(6,10).toggle();
			$("tr").each(function(){
				$(this).children("td").slice(6,10).toggle();
			});
		});
	})
</script>
</head>
<%
	List<AnsDto> lists = (List<AnsDto>)request.getAttribute("lists");
%>
<body>
<jsp:include page="header.jsp"/>
<div id="container">
<h1>답변형 게시판 글목록 보기</h1>
<form action="anscontroller.jsp" method="post">
<input type="hidden" name="command" value="muldel">
<table border="1">
	<col width="50px"><col width="50px"><col width="100px"><col width="200px">
	<col width="100px"><col width="50px"><col width="50px"><col width="50px">
	<col width="50px"><col width="50px">
	<tr>
		<th><input  class="form-control" type="checkbox" name="all" onclick=""></th>
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
	
	<%
		if(lists.size()==0){
			%>
		<tr><td colspan="10">----작성된 글이 없습니다----</td></tr>
			<%
		}else{
			for(AnsDto dto:lists){
				%>
				<tr>
					<td><input type="checkbox" name="chk" value="<%=dto.getSeq()%>"></td>
					<td><%=dto.getSeq()%></td>
					<td><%=dto.getId()%></td>
					<%
						if(dto.getDelFlag().equals("Y")){
							%>
							<td>---삭제된 글입니다---</td>
							<%
						}else{
							%>
					<td>
						<a href="anscontroller.jsp?command=detail&seq=<%=dto.getSeq()%>"><%=dto.getTitle()%></a>
					</td>
							<%
						}
					%>
					<td><%=dto.getRegDate()%></td>
					<td><%=dto.getReadCount()%></td>
					<td><%=dto.getRefer()%></td>
					<td><%=dto.getStep()%></td>
					<td><%=dto.getDepth()%></td>
					<td><%=dto.getDelFlag()%></td>
				</tr>	
				<%
			}
		}
	%>
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