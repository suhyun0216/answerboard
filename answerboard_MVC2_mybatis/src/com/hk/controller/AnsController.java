package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hk.ansdaos.AnsDao;
import com.hk.ansdtos.AnsDto;

/**
 * Servlet implementation class AnsController
 */
@WebServlet("/AnsController.do")
public class AnsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnsController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String command = request.getParameter("command");
		AnsDao dao = new AnsDao();
		
		if(command.equals("boardlist")){
			List<AnsDto> lists = dao.getAllList();
			request.setAttribute("lists", lists);
			dispatch("boardlist2.jsp", request, response);
		
		}else if(command.equals("insertform")){
			response.sendRedirect("insertboard.jsp");
		
		}else if(command.equals("insertboard")){
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			boolean isS = dao.insertBoard(new AnsDto(id,title,content));
			if(isS){
				jsForward("새글추가 성공", "AnsController.do?command=boardlist",response);
			}else{
				jsForward("새글추가 실패", "insertboard.jsp",response);
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
			dispatch("detailboard.jsp", request, response);
		
		}else if(command.equals("updateform")){
			int seq=Integer.parseInt(request.getParameter("seq"));
			AnsDto dto = dao.getBoard(seq);
			request.setAttribute("dto", dto);
			dispatch("updateform.jsp", request, response);
		
		}else if(command.equals("updateboard")){
			int seq=Integer.parseInt(request.getParameter("seq"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			boolean isS = dao.updateBoard(new AnsDto(seq,title,content));
			if(isS){
				jsForward("수정성공", "AnsController.do?command=detail&seq="+seq,response);
			}else{
				jsForward("수정실패", "AnsController.do?command=updateform&seq="+seq,response);
			}
		
		}else if(command.equals("muldel")){
			String[] seq = request.getParameterValues("chk");
			boolean isS = dao.mulDelBoard(seq);
			if(isS){
				jsForward("삭제성공", "AnsController.do?command=boardlist",response);
			}else {
				jsForward("삭제실패", "AnsController.do?command=boardlist",response);
			}
		}else if(command.equals("replyboard")){
			int seq=Integer.parseInt(request.getParameter("seq"));
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			boolean isS = dao.replyBoard(new AnsDto(seq,id,title,content));
			if(isS){
				jsForward("답글달기 성공", "AnsController.do?command=boardlist",response);
			}else{
				jsForward("답글달기 실패", "AnsController.do?command=detailboard&seq="+seq,response);
			}
		}
	}
	
	public void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}

	public void jsForward(String msg, String url, HttpServletResponse response) throws IOException{
		String str= "<script type='text/javascript'>"
						+"alert('"+msg+"');"
						+"location.href='"+url+"';"
						+"</script>";
		PrintWriter pw = response.getWriter();
		pw.print(str);
	}
}
