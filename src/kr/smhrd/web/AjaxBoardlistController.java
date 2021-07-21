package kr.smhrd.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.smhrd.model.BoardDAOMybatis;
import kr.smhrd.model.BoardVO;
import kr.smhrd.model.UserVO;

public class AjaxBoardlistController implements Controller{

	@Override
	public String requestHandler(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		BoardDAOMybatis dao = new BoardDAOMybatis();
		List<BoardVO> list = dao.boardList();
	    // Json -> Gson API
		Gson g = new Gson();
		String blist = g.toJson(list); //[{   }, { }, {  }]
		//System.out.println(blist);
		response.setContentType("text/json;charset=euc-kr");// 프린트라이터 마임타입 (한글안꺠지게)
		PrintWriter out = response.getWriter();
		out.println(blist);
		
		return null;
	}

}
