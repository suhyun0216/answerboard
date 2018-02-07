<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">
	header{
		background-color: #86E8B8;
		height: 50px;
	}
	footer{
		background-color: orange;
		height: 50px;
		text-align: center;
		line-height: 50px;
	}
	#container{
		height: 500px;
		width: 1200px;
		margin: 0 auto;
		overflow: auto;
	}
	a{text-decoration: none;}
	input[type=checkbox]{ width: 15px; height: 15px;} 
/* 	답글 폼 추가 */
	#replyForm{display: none;}
	td>img{width: 15px; height: 10px;}
</style>
</head>
<body>
<header>
	<h1><a href="AnsController.do?command=boardlist" title="글목록보기">게시판구현하기</a></h1>
</header>
</body>
</html>