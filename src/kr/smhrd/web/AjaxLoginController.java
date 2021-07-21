package kr.smhrd.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import kr.smhrd.model.BoardDAOMybatis;
import kr.smhrd.model.UserVO;

public class AjaxLoginController implements Controller {

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String user_id = request.getParameter("user_id");
		String password = request.getParameter("password");
		
		UserVO vo = new UserVO();
		vo.setUser_id(user_id);
		vo.setPassword(password);
		
		BoardDAOMybatis dao = new BoardDAOMybatis();
		UserVO userVO = dao.loginMember(vo);
		
		PrintWriter out = response.getWriter();			
		if(userVO!=null) {
			out.print("YES"); //인증성공(1)
			//객체바인딩 : 로그인 성공했다는 사실을 모든 웹페이지가 공유할 수 있도록 해야한다. => 세션바인딩
			HttpSession session = request.getSession();
			// userVO 에 로그인정보가 들어가있음.request.setAttribute = 한사람의 정보만 저장..
			session.setAttribute("userVO", userVO); //-> ${userVO}
		}else {
			out.print("NO"); // 인증실패 (0)
		}
		return null;
	}

}
