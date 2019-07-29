<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>kuzuro 게시판</title>
</head>
<body>
<div id ="root">
<hr />
	<header>
		<h1>kuzuro 게시판</h1>	
	</header>

</div>
	<nav>
		처음 화면 - 글쓰기 - 로그인
	</nav>

<hr />

	<section id ="container">
		<form role="form" method ="post" autocomplete="off">
			<p>
				<label for ="title">글제목</label><input type="text" id="title" name ="title"/>
			</p>
			
			<p>
				<label for="content">글 내용</label><textarea id="content" name="content"></textarea>
			</p>
			
			<p>
				<label for ="writer">글쓴이</label><input type="text" id="writer" name ="writer"/>
			</p>
			
			<p>
				<button type="submit">작성</button>
			</p>
			
			
			
	
		</form>
	
	</section>



</body>
</html>