package kr.smhrd.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.smhrd.model.BoardDAO;
import kr.smhrd.model.BoardDAOMybatis;
import kr.smhrd.model.BoardVO;

public class BoardRegisterController implements Controller{	   //인터페이스 상속      
	public String requestHandler(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		
		//1. 파라메터 수집(VO)
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String writer = request.getParameter("writer");
		BoardVO vo = new BoardVO(); //객체만들기
		vo.setTitle(title);
		vo.setContents(contents);
		vo.setWriter(writer);
		
		String view = null;
		//BoardDAO dao = new BoardDAO();
		BoardDAOMybatis dao = new BoardDAOMybatis();
		try {
	         int cnt=dao.boardInsert(vo);
	         if (cnt>0) {
	              //저장성공후 -> 다시 리스트페이지로 가기(/list.do)
	        	  //redirect 기법(서버에서 전화돌리기 ->요청돌리기)
	        	 //response.sendRedirect("list.do");
	        	 view = "redirect:/list.do";
	         }else {
	            throw new ServletException("error"); //예외처리
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
		return view;
		
//		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
//		list.add(vo);
//		list.add(vo);
//		list.add(vo);
//		
//		System.out.println(vo);//vo.toString()
//		//받은 데이터를 응답해보자
//		//MIME(마임타입) - 응답의 경우
//		res.setContentType("text/html;charset = euc-kr");//한글이 깨지기 때문에 안깨지게 해주는 방안
//		PrintWriter out = res.getWriter();
//		
//		out.println("<html>");
//		out.println("<body>");
//	      out.println("<table border = 1>");
//	      out.println("<thead>");
//	            out.println("<tr>");
//	            out.println("<th>제목</th>");
//	            out.println("<th>내용</th>");
//	            out.println("<th>작성자</th>");
//	            out.println("</tr>");
//	            out.println("</thead>");
//	            out.println("<tbody>");
//	            for (int i = 0; i < list.size(); i++) {
//	            	vo = list.get(i);
//	            	out.println("<tr>");
//	 	            out.println("<td>"+vo.getTitle()+"</td>");
//	 	            //                                  replaceAll 바꾸기
//	 	            out.println("<td>"+vo.getContents().replaceAll("\n", "<br>")+"</td>");
//	 	            out.println("<td>"+vo.getWriter()+"</td>");
//	 	            out.println("</tr>");
//				}
//	            out.println("</tbody>");
//	            out.println("</table>");
//		out.println("</body>");
//		out.println("</html>");
	}
}
