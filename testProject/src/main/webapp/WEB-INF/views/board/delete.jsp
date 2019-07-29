<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>kuzuro 게시판</title>

<!-- 제이쿼리 -->
 <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>

</head>
<body>
<div id ="root">
<hr />
	<header>
		<h1>kuzuro 게시판</h1>	
	</header>

</div>
	<nav>
		처음 화면 - 글쓰기 - 삭제화면
	</nav>

<hr />

	<section id ="container">
		<form role="form" method ="post" autocomplete="off">
		
			<p>
				<label for ="bno">글번호</label><input type="text" id="bno" name ="bno" value ="${delete}" readonly="readonly"/>
			</p>
		
			<p> 정말 삭제하시겠습니까? </p>
		
			<p>
				<button type="submit">예 , 삭제합니다</button>
				<button type= "button" id ="cancel_btn">아니요, 삭제하지 않겠습니다.</button>
				
				<script>
					var formObj = $("form[role='form']");
					
					$("#cancel_btn").click(function(){
						self.location = "/board/read?bno=${delete}"
							   + "&page=${scri.page}"
							   + "&perPageNum=${scri.perPageNum}"
							   + "&searchType=${scri.searchType}"
							   + "&keyword=${scri.keyword}";
					});
				
				</script>
			</p>

	</form>
	
	
	
	</section>



</body>
</html>