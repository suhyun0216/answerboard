<%@page import="com.hk.dbinfo.Util"%>
<%@page import="com.hk.ansdtos.AnsDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.ansdaos.AnsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String command = request.getParameter("command");
	//클래스명.메서드명 -> static으로 선언해놓고 호출하는 방법
	AnsDao dao = new AnsDao();
	
	if(command.equals("boardlist")){
		List<AnsDto> lists = dao.getAllList();
		request.setAttribute("lists", lists);
// 		pageContext.forward("boardlist.jsp");
		pageContext.forward("boardlist2.jsp"); //jstl버젼
	
	}else if(command.equals("insertform")){
		response.sendRedirect("insertboard.jsp");
	
	}else if(command.equals("insertboard")){
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		boolean isS = dao.insertBoard(new AnsDto(id,title,content));
		if(isS){
			out.print(Util.jsForward("새글추가 성공", "anscontroller.jsp?command=boardlist"));
		}else{
			out.print(Util.jsForward("새글추가 실패", "insertboard.jsp"));
		}
	
	}else if(command.equals("detail")){
		int seq=Integer.parseInt(request.getParameter("seq"));
		String count = request.getParameter("count"); //글목록에서만 전달되는 값
		if(count!=null){
			dao.readCount(seq);//글조회수 증가
		}
		AnsDto dto = dao.getBoard(seq); 
		//구한 객체(dto)를 상세보기 (detailborad.jsp)페이지로 전달
		request.setAttribute("dto", dto);
		pageContext.forward("detailboard.jsp");
	
	}else if(command.equals("updateform")){
		int seq=Integer.parseInt(request.getParameter("seq"));
		AnsDto dto = dao.getBoard(seq);
		request.setAttribute("dto", dto);
		pageContext.forward("updateform.jsp");
	
	}else if(command.equals("updateboard")){
		int seq=Integer.parseInt(request.getParameter("seq"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		boolean isS = dao.updateBoard(new AnsDto(seq,title,content));
		if(isS){
			out.print(Util.jsForward("수정성공", "anscontroller.jsp?command=detail&seq="+seq));
		}else{
			out.print(Util.jsForward("수정실패", "anscontroller.jsp?command=updateform&seq="+seq));
		}
	
	}else if(command.equals("muldel")){
		String[] seq = request.getParameterValues("chk");
		boolean isS = dao.mulDelBoard(seq);
		if(isS){
			out.print(Util.jsForward("삭제성공", "anscontroller.jsp?command=boardlist"));
		}else {
			out.print(Util.jsForward("삭제실패", "anscontroller.jsp?command=boardlist"));
		}
	}else if(command.equals("replyboard")){
		int seq=Integer.parseInt(request.getParameter("seq"));
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		boolean isS = dao.replyBoard(new AnsDto(seq,id,title,content));
		if(isS){
			out.print(Util.jsForward("답글달기 성공", "anscontroller.jsp?command=boardlist"));
		}else{
			out.print(Util.jsForward("답글달기 실패", "anscontroller.jsp?command=detailboard&seq="+seq));
		}
	}
		
%>
</body>
</html>