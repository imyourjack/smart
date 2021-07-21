<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
 $(document).ready(()=>{
	// CalcController <- calc.do
	$("#btn").click(()=>{
		var su=$("#su").val();
		$.ajax({
			url : "calc.do", //서버로요청 -> CalcController
			type : "get",
			data : {"su":su}, //su=100
			//datatype : "html"
			success : callback, //콜백함수
			error : function() {alert("error")}
										
		});
	});	
	 
 });
 function callback(data) {
	//alert(data);
	$("#msg").html(data);
}
</script>
</head>
<body>
<input type="text" name="su" id="su">
<input type="button" value="클릭" id="btn">
<div id="msg">여기에 결과 값을 출력</div>
</body>
</html>