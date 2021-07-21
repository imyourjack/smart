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
 $(document).ready(()=> { //익명함수(어노니머스) => 람다식
		alert("jQuery START~")
 $("#btn").click(()=>{ 
	var su=$("#su").val();            //val(x) => get동작 , val("aaa") => set동작
	var sum=0;
	for (var i = 1; i <= su; i++) {
		sum+=i;
	}
	$("#msg").html("<font color ='red'>"+sum+"</font>");
  });
 });
</script> 
</head>
<body>
<input type="text" name="su" id="su">
<input type="button" value="클릭" id="btn">
<div id="msg">여기에 결과 값을 출력</div>
</body>
</html>