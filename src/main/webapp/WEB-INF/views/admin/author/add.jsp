<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- Meta Tag -->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name='copyright' content=''>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%@ include file="/WEB-INF/views/common/commonCss.jsp" %>
	<!-- Title Tag  -->
    <title>Eshop - eCommerce HTML5 Template.</title>
    
	<style>
	.nice-select {
	    float: none;
	    margin-bottom: 0px;
	}
	</style>
</head>
<body class="js">
<%@ include file="/WEB-INF/views/common/admin/commonHeader.jsp" %>

	<!-- Start Contact -->
	<section id="contact-us" class="contact-us section" style="padding: 20px 0;">
		<div class="container" style="max-width: 100%;">
				<div class="contact-head">
					<div class="row">
						<div class="col-lg-8 col-12" style="margin-left: 15%; flex: 0 0 70%; max-width: 70%;">
						<div class="login-form">
						<h2 style="padding-bottom: 20px;">작가 등록</h2>
						</div>
							<div class="form-main">
								<!-- <div class="title">
									<h4>Get in touch</h4>
									<h3>Write us a message</h3>
								</div> -->
								<!-- Form -->
								<form id="authorAddForm" class="form">
								<div class="row">
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>작가 이름<span>*</span></label>
											<input type="text" id="author_name" name="author_name" placeholder="" >
										</div>
										<span class="input_msg"></span>
									</div>
								
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px; float: left;">
											<label style="display: block; float: left;">소속 국가<span>*</span></label>
											<select id="nation_id" name="nation_id">
												<option value="">== 선택 ==</option>
												<option value="01">국내</option>
												<option value="02">국외</option>
											</select>
											<span class="input_msg"></span>
										</div>
									</div>
								
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group message" style="margin-bottom: 0px;">
											<label>소개내용<span>*</span></label>
											<textarea id="author_intro" name="author_intro" placeholder=""></textarea>
										</div>
										<span class="input_msg"></span>
									</div>
								
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group login-btn">
											<button class="btn" type="submit" >등록</button>
											<button id="btn_list" class="btn" type="button">취소</button>
										</div>
									</div>
								</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
	</section>
	<!--/ End Contact -->

<%@ include file="/WEB-INF/views/common/admin/commonFooter.jsp" %>	
<%@ include file="/WEB-INF/views/common/commonJs.jsp" %>
<script>
$(document).ready(function() {
	
	/* 작가 목록페이지 이동 */
	$("#btn_list").on('click',function() {
		window.location.href= '/admin/author/list';
	});
	
	/* 작가 등록 */
	$("#authorAddForm").on('submit',function(e) {
		e.preventDefault();  // 폼 제출이 기본적으로 새로고침을 유발하므로, 이를 방지하기 위해
		
		// 폼 제출 성공여부
		if(validateForm()) {
	       console.log('폼 제출 성공');
		       
			// 폼 데이터를 객체로 변환
			var formData = {
				author_name: $('#author_name').val()
				, author_intro: $('#author_intro').val()
				, nation_id: $('#nation_id').val()
			};
			
			$.ajax({
				  url: "/api/authors",  				// 요청을 보낼 URL
				  type: "POST",                         // HTTP 메서드 (GET, POST 등)
				  dataType: "json",                     // 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
				  contentType: 'application/json; charset=utf-8',     // 콘텐츠 타입을 JSON으로 설정 - 클라이언트(브라우저)에서 서버로 보내는 데이터의 형식
				  data: JSON.stringify(formData),   	// 직렬화된 데이터를 JSON 형식으로 변환
				  success: function(response) {         // 성공 시 실행되는 함수
					console.log(response);              // 응답 데이터 처리
					alert('작가를 등록하였습니다.');
					location.href = '/admin/author/list';
				  },
				  error: function(xhr, status, error) { // 실패 시 실행되는 함수
					  console.error("등록 실패: " + status + ", " + error);     // 에러 처리
	                  if(xhr.responseText) {
	                      alert(xhr.responseText);
	                  } else {
	                	  alert("작가 등록에 실패하였습니다.");
	                  }
				  }
			}); 
		}
	});
	
	// 전체 폼 유효성 검사
	function validateForm() {
		var isValid = true;
        
        isValid = validateAuthorName() && isValid;
        isValid = validateNationId() && isValid;
        isValid = validateAuthorIntro() && isValid;
        
        return isValid;
    }

    // 작가명 유효성 검사
    function validateAuthorName() {
        var $authorName = $('#author_name');
        var authorNameValue = $authorName.val().trim();
        if(authorNameValue === '') {
            setErrorFor($authorName, '이름을 입력해주세요.');
            return false;
        } else if(authorNameValue.length < 2) {
            setErrorFor($authorName, '이름은 2자 이상이어야 합니다.');
            return false;
        } else{
            setSuccessFor($authorName);
            return true;
        }
    }
    
 	// 소속국가 유효성 검사
    function validateNationId() {
        var $nationId = $('#nation_id');
        var nationIdValue = $nationId.val().trim();
        if(nationIdValue === '') {
            setErrorFor($nationId, '소속국가를 선택해주세요.');
            return false;
        } else{
            setSuccessFor($nationId);
            return true;
        }
    }
    
 	// 소개내용 유효성 검사
    function validateAuthorIntro() {
        var $authorIntro = $('#author_intro');
        var authorIntroValue = $authorIntro.val().trim();
        if(authorIntroValue === '') {
            setErrorFor($authorIntro, '소개내용을 입력해주세요.');
            return false;
        } else{
            setSuccessFor($authorIntro);
            return true;
        }
    }

    // 오류 메시지 설정 함수
    function setErrorFor($input, message) {
        var $formControl = $input.parent().parent();
        $formControl.find('.input_msg').text(message).css("display","inline-block").css('color', 'red');
    }

    // 성공 표시 설정 함수
    function setSuccessFor($input) {
    	var $formControl = $input.parent().parent();
        $formControl.find('.input_msg').text('').removeAttr('style');
    }
	
});
</script>

</body>
</html>
