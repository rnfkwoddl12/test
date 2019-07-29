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
		처음 화면 - 글쓰기 - 수정화면
	</nav>

<hr />

	<section id ="container">
		<form role="form" method ="post" autocomplete="off">
		
			<p>
				<label for ="bno">글번호</label><input type="text" id="bno" name ="bno" value ="${modify.bno}" readonly="readonly"/>
			</p>
		
		
			<p>
				<label for ="title">글제목</label><input type="text" id="title" name ="title" value="${modify.title }" />
			</p>
			
			<p>
				<label for="content">글 내용</label><textarea id="content" name="content"  >${modify.content}</textarea>
			</p>
			
			<p>
				<label for ="writer">작성자</label><input type="text" id="writer" name ="writer" value ="${modify.writer}"/>
			</p>
			
			<p>
				<label for ="reqdate">작성일</label><span><fmt:formatDate value="${modify.reqdate}" pattern="yyyy-mm-dd"/></span>
			</p>
			<p>
				<button type="submit">수정</button><button type="button" id ="cancel_btn">취소</button>
				
				
				<script>
					var formObj = $("form[role='form']");
					
					$("#cancel_btn").click(function(){
						self.location = "/board/read?bno=${modify.bno}"
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