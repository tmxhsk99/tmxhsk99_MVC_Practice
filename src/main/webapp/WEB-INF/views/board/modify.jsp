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
<script type="text/javascript">
	$(document).ready(function() {

		var formObj = $("form");

		$('button').on("click", function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");
			colsole.log("오퍼레이션" + operation);

			if (operation === 'remove') {
				formObj.attr("action", "/board/remove");
			} else if (operation === 'list') {
				//move to list
				self.location = "/board/list";
				return;
			}
			formObj.submit;
		});
	});
</script>
<title>SB Admin 2 - Bootstrap Admin Theme</title>
</head>
<body>
	<%@include file="../includes/header.jsp"%>
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Register</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board Read Page</div>
				<!-- /.panel heading -->
				<div class="panel-body">
					<form role="form" action="/board/modify" method="post">
						<div class="form-gruop">
							<label>Bno</label> <input class="form-control" name="bno"
								value='<c:out value="${board.bno}"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>Title</label> <input class="form-control" name="title"
								value="<c:out value='${board.title}'/>">
						</div>

						<div class="form-group">
							<label>Text area</label>
							<textarea rows="3" class="form-control" rows="3" name="content"><c:out
									value="${board.content}" /></textarea>
						</div>

						<div class="form-group">
							<label>Writer</label> <input class="form-control" name="writer"
								value="<c:out value ='${board.writer}'/>">
						</div>
						<div class="form-group">
							<label>RegDate</label> <input class="form-control" name="regDate"
								value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>'
								readonly="readonly">
						</div>
						<div class="form-group">
							<label>Update Date</label> <input class="form-control"
								name="updateDate"
								value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>'
								readonly="readonly">
						</div>
						<button type="submit" data-oper='modify' class="btn btn-default">Modify
						</button>
						<button type="submit" data-oper='remove' class="btn btn-danger">Remove
						</button>
						<button type="submit" data-oper='list' class="btn btn-info">
							List</button>
					</form>
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








