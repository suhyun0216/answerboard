package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hk.ansdaos.AnsDao;
import com.hk.ansdtos.AnsDto;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class Detail
 */
@WebServlet("/Detail.do")
public class Detail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

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
		response.setContentType("text/json; charset=utf-8");
		
		String seq = request.getParameter("seq");
		int sseq = Integer.parseInt(seq);
		AnsDao dao = new AnsDao();
		AnsDto dto = dao.getBoardAjax(sseq);
		System.out.println(dto);
		Map<String, AnsDto> map = new HashMap<String, AnsDto>();
		map.put("dto", dto);
		
		JSONObject obj = JSONObject.fromObject(map);
		PrintWriter pw = response.getWriter();
		obj.write(pw);
		
	}

}
