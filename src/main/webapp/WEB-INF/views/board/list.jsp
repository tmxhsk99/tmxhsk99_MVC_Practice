<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Bootstrap Admin Theme</title>
<script src="/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						var result = '<c:out value="${result}"/>';

						checkModal(result);

						history.replaceState({}, null, null);
						//글쓰기를 수정이나 삭제했을때 클라이언트에게 리액션을 주는 기능 
						function checkModal(result) {

							if (result === '' || history.state) {
								return;
							}

							if (parseInt(result) > 0) {
								$(".modal-body").html(
										"게시글 " + parseInt(result)
												+ " 번이 등록되었습니다.");
							}

							$("#myModal").modal("show");
						}
						//글쓰기를 클릭했을때 글쓰기로 이동하는 기능 
						$("#regBtn").on("click", function() {

							self.location = "/board/register";

						});
						//목록 번호를 클릭했을때 그페이지로 이동시키는 기능
						var actionForm = $('#actionForm');
						$(".paginate_button a").on(
								"click",
								function(e) {
									e.preventDefault();
									console.log('click');
									//alert($(this).attr("href"));클릭한 버튼이  가지고있는 href값
									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									actionForm.submit();
								});
						//list.jsp 게시물 조회를 위한 이벤트 처리 추가 
						$(".move")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											actionForm
													.append("<input type='hidden' name='bno' value='"
															+ $(this).attr(
																	"href")
															+ "'>");
											actionForm.attr("action",
													"/board/get");
											actionForm.submit();
											/* 게시물의 제목을 클릭하면 <form> 태그에 추가로 bno 값을 전송하기 위해서 <input> 태그를 만들어 추가하고 , <form>태그의 action은 ''board/get'으로 변경합니다. 위의
											처리가 정상적으로 되었다면 게시물의 제목을 클릭했을때 pageNum과 amount 파라미터가 추가로 전달되는것을 볼수 있다 .*/
										});
					});
</script>
</head>

<body>


	<%@include file="../includes/header.jsp"%>
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Tables</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">

			<div class="panel panel-default">
				<div class="panel-heading">
					Board List Page
					<button id="regBtn" type="button" class="btn btn-xs pull-right">Register
						New Board</button>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<table width="100%"
						class="table table-striped table-bordered table-hover"
						id="dataTables-example">
						<thead>
							<tr>
								<th>#번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>수정일</th>
							</tr>
						</thead>
						<c:forEach items="${list}" var="board">
							<tr>
								<td><c:out value="${board.bno}" /></td>
								<td><a class='move' href='<c:out value ="${board.bno}"/>'>
										<c:out value="${board.title}" />
								</a></td>
								<td><c:out value="${board.writer}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.regdate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.updateDate}" /></td>
							</tr>
						</c:forEach>

					</table>
					<form id="searchForm" action="/board/list" method="get">
						<select name="type">
							<option value="">---</option>
							<option value="T">제목</option>
							<option value="C">내용</option>
							<option value="W">작성자</option>
							<option value="TC">제목 or 내용</option>
							<option value="TW">제목 or 작성자</option>
							<option value="TWC">제목 or 작성자 or 내용</option>
						</select> <input type="text" name="keyword" /> <input type="hidden"
							name="pageNum" value="${pageMaker.cri.pageNum}"> <input
							type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<button class='btn btn-default'>Search</button>
					</form>
					<div class='pull-right'>
						<ul class="pagination">
							<c:if test="${pageMaker.prev }">
								<li class="paginate_button previous"><a
									href="${pageMaker.startPage-1}">Previous</a></li>
							</c:if>

							<c:forEach var="num" begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}">
								<li class="paginate_button ${pageMaker.cri.pageNum==num ? "active":""}"><a
									href="${num}">${num}</a></li>
							</c:forEach>

							<c:if test="${pageMaker.next}">
								<li class="paginate_button next"><a href="#">Next</a></li>
							</c:if>
						</ul>
					</div>

					<form action="/board/list" method="get" id="actionForm">
						<input type="hidden" name="pageNum"
							value="${pageMaker.cri.pageNum}"> <input type="hidden"
							name="amount" value="${pageMaker.cri.amount}">
					</form>
					<!-- Modal  추가 -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">Modal title</h4>
								</div>
								<div class="modal-body">처리가 완료되었습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
									<button type="button" class="btn btn-primary">Save
										changes</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->

				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>





	</div>
	<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->
	<%@include file="../includes/footer.jsp"%>

</body>

</html>
