<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.commentbox').keyup(function() {
			var content = $(this).val();
			$('#counter').html("(" + content.length + " / 최대200자)");
			//글자수 실시간 카운팅 
			if (content.length > 200) {
				alert("최대 200자까지 입력가능합니다.");
				$(this).val(content.substring(0, 200));
				$('#counter').html("(200 / 최대 200자)");
			}
		});
	});
</script>
</head>
<body>

	<div class="container">
		<form name="commentInsertForm" method="post"
			enctype="multipart/form-data">
			<div class="comtitle">
				<h3>댓 글</h3>
			</div>

			<div class="cominput"  style="text-align: center;">
				<textarea class="commentbox" name="Com_Content"
					placeholder="댓글을 입력해주세요." style="width: 80%;"></textarea>

				<div class="com2">

					<div class="com_btn">
						<button type="button" class="button3">취소</button>
						<button type="button" name="commentInsertBtn" class="button1">등록</button>
					</div>
					<span style="color: #aaa;" id="counter">(0 / 최대 200자)</span>

				</div>
			</div>
		</form>
	</div>
</body>
</html>