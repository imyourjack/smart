package kr.smhrd.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardRegisterFormController implements Controller{//인터페이스 상속
	public String requestHandler(HttpServletRequest request, HttpServletResponse response) 
			       throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		//글쓰기화면으로 이동
		
		//RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/boardForm.jsp");
		//rd.forward(request, response);
		return "boardForm"; // "/WEB-INF/views/boardForm.jsp"
	}

}
