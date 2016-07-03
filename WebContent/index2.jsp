<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 라이브러리명 : 폰트어썸 -->
	<!-- 아이콘 라이브러리 -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">

	<!-- 라이브러리명 : 노말라이즈 -->
	<!-- 다양한 웹 브라우저 간 레이아웃, 디자인 평준화  -->

	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/normalize/4.2.0/normalize.min.css">

	<!-- 라이브러리명 : jQuery -->
	<!-- 필수라이브러리 -->
	<!-- 브라우저 마다 다른 자바스크립트 API 문제를 해결 -->
	<!-- 브라우저가 기본적으로 제공하는 라이브러리 보다 훨씬 직관적인 API 제공 -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

	<!-- 라이브러리명 : 부트스트랩  -->
	<!-- UI 프레임워크 -->
	<!-- 멋진 디자인을 쉽게 만들 수 있도록 도와준다. -->
	<!-- 반응형 디자인 웹을 만들어 준다. -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/css/bootstrap.css">

	<!-- 부트스트랩 -->
	<!-- 부트스트랩은 js 와 css 파일이 한쌍이다. -->
	<!-- 부트스트랩 js는 jQuery를 사용한다. 즉 jQuery 보다 밑에서 로드되어야 한다. -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/js/bootstrap.min.js"></script>

	<script>
		// 수정버튼이 눌렸을 경우 호출되는 함수입니다.
		// btn = button
		function modifyBtnClicked(node) {
			// node는 클릭된 버튼입니다
			// 일반 자바스크립트 엘리먼트 객체를 제이쿼리화 합니다.
			// 제이쿼리화 하는 이유는 개발자 입장에서 사용하기 쉽게 바꾸기 위해서 입니다.
			var $node = $(node);
			// $node의 부모 엘리먼트인 li 엘리먼트를 찾아서 $li 변수에 넣습니다.
			var $li = $node.parent();
			// li 엘리먼트의 class 속성에 modify-mode 클래스를 추가합니다.
			// 즉 수정모드로 바꿔줍니다.
			$li.addClass('modify-mode');
		}
		// 저장 버튼이 눌렸을경우 호출되는 함수입니다.
		function saveBtnClicked(node) {
			var $node = $(node);
			// 입력 엘리먼트를 찾는다.
			var $input = $node.parent().find('.modify-input');
			// 텍스트 엘리먼트를 찾는다.
			var $text = $node.parent().find('.text');
			// 입력 엘리먼트의 값을 trim() 처리 한다.
			// trim 은 양쪽 공백을 삭제를 의미합니다.
			$input.val($input.val().trim());
			// 입력 엘리먼트의 값이 비어있는지 체크합니다.
			if ($input.val() == '') {
				alert('할일을 입력해주세요.');
				// 입력 엘리먼트에 포커스를 둡니다.
				$input.focus();
				return false;
			}
			// 텍스트 엘리먼트의 내용을 지운 뒤 입력 엘리먼트의 값을 넣습니다.
			// 즉 입력 값으로 바꿔줍니다.
			$text.empty().append($input.val());
			// 수정모드를 끝낸다.
			$node.parent().removeClass('modify-mode');
		}
		// 취소버튼을 클릭했을 때 호출되는 함수입니다.
		function cancelBtnClicked(node) {
			var $node = $(node);
			// 입력 엘리먼트를 찾는다.
			var $input = $node.parent().find('.modify-input');
			// 텍스트 엘리먼트를 찾는다.
			var $text = $node.parent().find('.text');
			// 기존 텍스트 값을 보존하기 위해 
			$input.val($text.text().trim());
			// 수정모드를 끝낸다.
			$node.parent().removeClass('modify-mode');
		}
		// 삭제버튼을 눌렀을경우 호출되는 함수입니다.
		function deleteBtnClicked(node) {
			var $node = $(node);
			// 삭제버튼의 부모인 li를 지워줍니다.
			// 즉 해당 리스트 아이템을 삭제 합니다.
			$node.parent().remove();
		}
		// 추가 버튼을 눌렀을경우 호출되는 함수입니다.
		function formSubmited(form) {
			// form.todo == form 엘리먼트의 자식중 name 속성이 todo인 엘리먼트
			form.todo.value = $.trim(form.todo.value);
			if (form.todo.value == "") {
				alert('할일을 입력해주세요.');
				return false;
			}
			// 새 리스트 아이템 (li)을 만들기 위해 템플릿 li를 추가합니다.
			$('#todo-list').append($('#todo-list-template').html());
			// :last => 위에서 append 로 추가했기 때문에 #todo-list 의 가장 마지막 li가 방금 추가된 li 이다.
			$('#todo-list > li:last .text').empty().append(form.todo.value);
			$('#todo-list > li:last .modify-input').val(form.todo.value);
			form.todo.value = "";
		}
	</script>


	<style>
/*
.modify-input과 .btn-save와 .btn-cancel를 숨긴다.
 왜냐하면 평소에는 보이면 안되기 때문이다.
 */
#todo-list .modify-input, #todo-list .btn-save, #todo-list .btn-cancel {
	display: none;
}
/*
수정모드(li가 modify-mode 클래스를 가짐)일 경우는 .modify-input과 .btn-save와 .btn-cancel를 보여준다.
*/
#todo-list li.modify-mode .modify-input, #todo-list li.modify-mode .btn-save,
	#todo-list li.modify-mode .btn-cancel {
	display: inline;
}
/*
수정모드일 경우 반대로 .text, .btn-remove, .btn-edit 를 숨깁니다.
 */
#todo-list li.modify-mode .text, #todo-list li.modify-mode .btn-remove,
	#todo-list li.modify-mode .btn-edit {
	display: none;
}
</style>

	<div class="container">
		<h1>TODO LIST</h1>

		<form name="todo-input" onsubmit="formSubmited(this); return false;">
			<input type="text" name="todo"> <input
				class="btn btn-primary" type="submit" value="추가">
		</form>

		<!-- 새 할일을 쉽게 추가하기 위해 존재하는 li 템플릿 -->
		<ul id="todo-list-template" style="display: none;">
			<li><span class="text">텍스트</span> <input type="text"
				class="modify-input" value="텍스트">

				<button class="btn btn-info btn-save"
					onclick="saveBtnClicked(this);">
					<i class="fa fa-floppy-o" aria-hidden="true"></i>
				</button>

				<button class="btn btn-info btn-cancel"
					onclick="cancelBtnClicked(this);">
					<i class="fa fa-undo" aria-hidden="true"></i>
				</button>

				<button class="btn btn-info btn-edit"
					onclick="modifyBtnClicked(this);">
					<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
				</button>

				<button class="btn btn-danger btn-remove"
					onclick="deleteBtnClicked(this);">
					<i class="fa fa-times" aria-hidden="true"></i>
				</button></li>
		</ul>

		<!-- 할일들이 추가될 ul -->
		<ul id="todo-list">
		</ul>
	</div>
</body>
</html>