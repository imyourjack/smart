package kr.smhrd.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.smhrd.model.BoardDAO;
import kr.smhrd.model.BoardDAOMybatis;

public class BoardDeleteController implements Controller{//인터페이스 상속
	//http://localhost:8081/MVC01/delete.do?idx=7
	public String requestHandler(HttpServletRequest request, HttpServletResponse response) 
			             throws ServletException, IOException {
		
		int idx = Integer.parseInt(request.getParameter("idx")); //String->int로 받기 위함
		
		String view = null;
		//BoardDAO dao = new BoardDAO();
		BoardDAOMybatis dao = new BoardDAOMybatis();
		try {
			int cnt = dao.boardDelete(idx);
			//redirect
			if(cnt > 0) {
				//response.sendRedirect("list.do"); // /MVC01/list.do
				view = "redirect:/list.do";
			}else {
				throw new ServletException("error");//WAS(Tomcat) 에러 던지기
			}
		} catch (Exception e) {		
			e.printStackTrace();
		}
		return view;
	}

}
