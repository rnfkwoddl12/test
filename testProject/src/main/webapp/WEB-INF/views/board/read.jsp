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
		처음 화면 - 글쓰기 - 상세화면
	</nav>

<hr />

	<section id ="container">
		<form role="form" method ="post" autocomplete="off">
			<input type="hidden" id ="page" name ="page" value ="${scri.page }" readonly="readonly"/>
			<input type="hidden" id ="perPageNum" name ="perPageNum" value ="${scri.perPageNum }" readonly="readonly"/>
			<input type="hidden" id ="searchType" name ="searchType" value ="${scri.searchType }" readonly="readonly"/>
			<input type="hidden" id ="keyword" name ="keyword" value ="${scri.keyword }" readonly="readonly"/>
		
			<p>
				<label for ="bno">글번호</label><input type="text" id="bno" name ="bno" value ="${read.bno}" readonly="readonly"/>
			</p>
		
		</form>
			<p>
				<label for ="title">글제목</label><input type="text" id="title" name ="title" value="${read.title }" readonly="readonly"/>
			</p>
			
			<p>
				<label for="content">글 내용</label><textarea id="content" name="content"  readonly="readonly">${read.content}</textarea>
			</p>
			
			<p>
				<label for ="writer">글쓴이</label><input type="text" id="writer" name ="writer" value ="${read.writer}" readonly="readonly"/>
			</p>
		
			<p>
				<label for ="reqdate">작성일</label><span><fmt:formatDate value="${read.reqdate}" pattern="yyyy-mm-dd"/></span>
			</p>
			<p>
				<button type="button" id ="list_btn">목록</button>
				<button type="button" id ="modity_btn">수정</button>
				<button type="button" id ="delete_btn">삭제</button>
				
				
				<script>
					var formObj = $("form[role='form']");
					
					$("#modity_btn").click(function(){
						formObj.attr("action","/board/modify");
						formObj.attr("method","get");
						formObj.submit();
					});
					
					$("#delete_btn").click(function(){
						formObj.attr("action","/board/delete");
						formObj.attr("method","get");
						formObj.submit();
					});
					
					$("#list_btn").click(function(){
						self.location ="/board/listSearch?"
								+"page=${scri.page}&perPageNum=${scri.perPageNum}"
								+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
								
					});
				
				</script>
			</p>
			
					<!-- 게시물 끝 -->
			<div id="reply">
			 <ol class="replyList">
			 <c:forEach items="${repList}" var="repList">
			 <li>
			  <p>
			   작성자 : ${repList.writer}<br />
			   
			   작성 날짜 :  <fmt:formatDate value="${repList.regdate}" pattern="yyyy-MM-dd" />
			  </p>
			  
			<p>${repList.content}</p>
			<p>
				<button type="button" class="replyUpdate" data-rno="${repList.rno}">수정</button> 
			 	<button type="button" class="replyDelete" data-rno="${repList.rno}">삭제</button>
				<script>
					$(".replyUpdate").click(function(){
						self.location ="/board/replyUpdate?bno=${read.bno}"
								+"&page=${scri.page}"
								+"&perPageNum=${scri.perPageNum}"
								+"&searchType=${scri.searchType}"
								+"&keyword=${scri.keyword}"
								+"&rno="+$(this).attr("data-rno");
					});
				
					
					$(".replyDelete").click(function(){
						self.location ="/board/replyDelete?bno=${read.bno}"
								+"&page=${scri.page}"
								+"&perPageNum=${scri.perPageNum}"
								+"&searchType=${scri.searchType}"
								+"&keyword=${scri.keyword}"
								+"&rno="+$(this).attr("data-rno");
					});
				</script>
			
			 </p>
			 </li>
			 </c:forEach>   
			 </ol>
			</div>
				
				
		<section class="replyForm">
		<form role="form" method="post" autocomplete="off" class="form-horizontal">
		
			<input type="hidden" id="bno" name="bno" value="${read.bno}" readonly="readonly" />
			<input type="hidden" id="page" name="page" value="${scri.page}" readonly="readonly" />
			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}" readonly="readonly" />
			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}" readonly="readonly" />
			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}" readonly="readonly" />
		
			<div class="form-group">
				<label for="writer" class="col-sm-2 control-label">작성자</label>
				<div class="col-sm-10">
					<input type="text" id="writer" name="writer" class="form-control" />
				</div>
			</div>			
			
			<div class="form-group">
				<label for="content" class="col-sm-2 control-label">댓글 내용</label>
				<div class="col-sm-10">
					<textarea id="content" name="content" class="form-control" ></textarea>
				</div>
			</div>
			
			<div class="form-group">
				 <div class="col-sm-offset-2 col-sm-10"> 
					<button type="button" class="repSubmit btn btn-success">작성</button> 
				</div>				
				<script>
				var formObj = $(".replyForm form[role='form']");
										
				$(".repSubmit").click(function(){
					formObj.attr("action", "replyWrite");
					formObj.submit();
				});				
				</script>				
			</div>
		</form>		
		</section>
	
	
	</section>



</body>
</html>