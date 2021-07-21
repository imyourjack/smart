<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">


$(document).ready(()=> {
	list();  
}); 

function list() {     //list를 호출하기위해 함수에 담아줌
	   $("#bf").css("display", "none");
	   $("#bc").css("display", "none");
	   $.ajax({
		   url : "ajaxlist.do", //서버로요청 -> AjaxBoardlistController---↓
			type : "get",       //           
			//data : {"msg":msg},
			datatype : "json", //  JSON=dic : {"idx":1, "name" : "홍길동"} 
			success : callback, //콜백함수
			error : function() {alert("error");}		   
	   });
}
   

function callback(data) {
	//alert(data);
	var view="<table class='table table-bordered table-hover'>";
	view+="<tr>"; //동적으로 붙히기때문에 여기서부터는 +를 붙힘
	view+="<td>번호</td>";
	view+="<td>제목</td>";
	view+="<td>조회수</td>";
	view+="<td>작성자</td>";
	view+="<td>작성일</td>";
	view+="<td>삭제</td>";
	
	view+="</tr>";
	$.each(data, (index, obj)=> {  //포문사용법 쥰나복잡하네 
		view+="<tr>"; //동적으로 붙히기때문에 여기서부터는 +를 붙힘
		view+="<td id='idx"+index+"'>"+obj.idx+"</td>";
		view+="<td><a href='javascript:contentFn("+index+")'>"+obj.title+"</a></td>";//"+obj.idx+"
		view+="<td>"+obj.count+"</td>";
		view+="<td>"+obj.writer+"</td>";
		view+="<td>"+obj.indate+"</td>";
		                                                    //disabled='disabled' 버튼 안눌러지게.
		view+="<c:if test='${sessionScope.userVO==null || sessionScope.userVO.user_id!=\'admin\'}'>";//관리자가 아니면 삭제 못하게		
		view+="<td><button class='btn btn-warning' onclick='delbtn("+obj.idx+")' disabled='disabled'>삭제</button></td>";
		view+="</c:if>";
		//로그인 성공했고, 관리자라면 삭제 가능
		view+="<c:if test='${sessionScope.userVO.user_id==\'admin\'}'>";		
		view+="<td><button class='btn btn-warning' onclick='delbtn("+obj.idx+")'>삭제</button></td>";
		view+="</c:if>";			
		view+="</tr>";	                                                        
		
	});   
 	view+="<tr>";
 	view+="<td colspan='6'>";
 	view+="<c:if test='${!empty sessionScope.userVO}'>";//로그인 했을때 글쓰기창이 보임
 	view+="<input type='button' value='글쓰기' class='btn btn-info' onclick='btnWrite()'/>";
 	view+="</c:if>";
 	view+="</td>";
 	view+="</tr>";	
	view+="</table>";
	$("#msg").html(view);
}

function contentFn(index) {
	var idx=$("#idx"+index).text();  //obj.idx 즉 선택한 컨텐츠 아이디 숫자를 가지고와야함!. alert(idx);
$.ajax({
	  url : "ajaxcontent.do",
	  type : "get",
	  data : {"idx" : idx},
	  datatype : "json",
	  success : callContent, //콜백
	  error : function () {alert("error");}			
});
	
}

function resetFn() {
	var idx=$("#cidx").val();  //cidx를 가지고와서 취소버튼을 눌렀을때 원래대로 
$.ajax({
	  url : "ajaxcontent.do",
	  type : "get",
	  data : {"idx" : idx},
	  datatype : "json",
	  success : callContent, //콜백
	  error : function () {alert("error");}			
});
	
}
function callContent(data) {  //위에 callContent callback 함수 만들기
	$("#bc").css("display", "block"); 
	$("#bf").css("display", "none");
	var idx=data.idx;
	var title=data.title;
	var contents=data.contents;
	var writer=data.writer;
	$("#cidx").val(idx);   
	$("#ctitle").val(title);
	$("#ccontents").val(contents);
	$("#cwriter").val(writer);
}
function btnWrite() {
	var writer='${sessionScope.userVO.user_name}';
	$("#bc").css("display", "none"); 
	$("#bf").css("display", "block"); //display = none 이였던걸 보여주라라는 뜻
	$("#resetbtn").trigger("click"); //글쓰기후 글쓰기를 새로할때 전에 입력한 정보가 리셋되는 느낌
	$("#writer").val(writer);
}
function delbtn(idx) {
	if(confirm("정말로 삭제 할끄냥??")==true){
	$.ajax({ 
		url : "delete.do",
		type : "get",
		data : {"idx": idx},
		success : list,
	    error : function() {alert("error");}
	});
 }else{
	return false;
 }
}
function writeFn() {
	var formdata=$("#frm").serialize(); //boardForm에 form아이디를 불러옴 serialize란 폼안에 있는 모든 데이터를 읽어올 수 있다.
	//alert(data);
	$.ajax({
		url : "ajaxregister.do",
		type : "post",
		data :formdata ,
		success : list,
		error : function () {alert("error");}					
	});
}
function closeFn() {
	$("#bc").css("display", "none");
	$("#bf").css("display", "none");
}
function updateFn() {
	var formdata=$("#ufrm").serialize();
	//alert(formdata);
	$.ajax({
		url : "ajaxupdate.do",
		type : "post",
		data :formdata ,
		success : list,
		error : function () {alert("error");}					
	});
}

function loginFn() {
	var user_id=$("#user_id").val();
	var password=$("#password").val();
    $.ajax({
    	url : "ajaxlogin.do",
    	type : "post",
    	data : {"user_id" : user_id, "password" : password},
    	success : function(data) {
    		if(data=="NO"){
    			alert("회원인증 실패야ㅠㅠ");
    		}else{
    			location.href="ajax04.jsp"; //다시한번 메인화면으로 
    			alert(user_id+"님 환영해용!!!");
    		}
    		
    	},
    	error : function () {alert("error");}
					
    });
}
function logoutFn() {
	//세션 메모리를 삭제 해야함. 세션트래킹?
   $.ajax({
	   url : "ajaxlogout.do",
	   type : "get",
	   //data :
		success : function(){  			
			location.href="ajax04.jsp";
			alert("로그아웃 성공쓰!!")
		},
		error : function(){alert("error");}
   });
}
function click() {
	$(document).ready(function(key){
		$("#user_id").ketdown(function(key){
			if (key.keyCode == 13){
				alert("엔터키를 눌렀네???");
			}
		});
	});
}

</script>
</head>
<body>
	<div class="container">
  <h4>MVC_FrontController+POJO+Handlermapping+ViewResolver+MyBatis(Ajax)게시판</h4>
  <div class="panel panel-default">
    <div class="panel-heading">
    <c:if test="${sessionScope.userVO==null }"> <%-- request가아닌 session으로 getAttribute하기위해 sessionScope를 붙힘 --%>    
    <form id="loginfrm" class="form-inline"  method="post">
      <div class="form-group">
      <label>ID:</label>
      <input type="text" class="form-control" id="user_id" name = "user_id">
      </div>
      <div class="form-group">
      <label>PWD:</label>
      <input type="password" class="form-control" id="password" name = "password">
      </div> 
      <button type="button" class="btn btn-primary" onclick="loginFn()">로그인</button>

    </form>
     </c:if>
      
      <c:if test="${sessionScope.userVO!=null }">
      ${sessionScope.userVO.user_name}님 방문을 환영합니다!!
      <input type="button" value="로그아웃" onclick="logoutFn()" class ="btn btn-sm btn-primary">
      </c:if>
      </div>

			<div class="panel-body">
				<div style="overflow: scroll;" >
				<div id="msg"></div>
				<div style="display: none" id="bf">
					<c:import url="boardForm.jsp" />
				</div>
				<div style="display: none;" id="bc">
					<c:import url="boardContent.jsp" />
				</div>
				</div>
			</div>
	<div class="panel-footer">빅데이터 분석 서비스 개발자과정(박형민)</div>
  </div>
</div>	
</body>
</html>