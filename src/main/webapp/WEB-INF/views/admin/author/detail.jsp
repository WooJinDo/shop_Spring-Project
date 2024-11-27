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
						<h2 style="padding-bottom: 20px;">작가 상세</h2>
						</div>
							<div class="form-main">
								<!-- Form -->
								<form id="detailForm" class="form">
								<div class="row">
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>작가 이름<span>*</span></label>
											<input type="text" id="authorName" disabled="disabled" placeholder="" >
										</div>
									</div>
								
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label style="display: block; float: left;">소속 국가<span>*</span></label>
											<input type="text" id="nationId" disabled="disabled" placeholder="" > 
										</div>
									</div>
								
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group message" style="margin-bottom: 0px;">
											<label>소개내용<span>*</span></label>
											<textarea id="authorIntro" disabled="disabled" placeholder="" ></textarea>
										</div>
									</div>
									
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>등록일</label>
											<input type="text" id="regDate" disabled="disabled" placeholder="" >
										</div>
									</div>
									
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>수정일</label>
											<input type="text" id="updateDate" disabled="disabled" placeholder="" >
										</div>
									</div>
								
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group login-btn">
											<button id="btn_update" class="btn" type="button" >수정</button>
											<button id="btn_delete" class="btn" type="button" style="float: right;">삭제</button>
											<button id="btn_list" class="btn" type="button">목록</button>
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
	var author_id = '<c:out value= "${author_id}" />';
    
	/* 게시글 상세 조회 시작 */
	authorDetail();
	
	/* 게시글 상세 조회 */
	function authorDetail() {
		var nationMap = {
				'01': '국내',
				'02': '국외'
		};
		
	    $.ajax({
	        url: '/api/author/' + author_id,
	        method: 'GET',
	        dataType: "json",                     // 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
	        success: function(response) {
	        	
	        	$('#authorName').val(response.author_name);
        		$('#nationId').val(nationMap[response.nation_id]);	
	        	$('#authorIntro').val(response.author_intro);
	        	$('#regDate').val(response.reg_date);
	        	$('#updateDate').val(response.update_date);
	        	
    		},
			error: function(xhr, status, error) { // 실패 시 실행되는 함수
				console.error("상세조회 실패: " + status + ", " + error);     // 에러 처리
                if(xhr.responseText) {
                    alert(xhr.responseText);
                } else {
                	alert("상세 조회에 실패하였습니다.");
                }
			}
	    });
	}
	
	/* 게시글 삭제 */
  	$('#btn_delete').on('click', function(e) {	
  		
        if (confirm('정말로 삭제하시겠습니까?')) {
            $.ajax({
                url: '/api/author/' + author_id, 
                method: 'DELETE', 
                success: function(response) {
                    alert('저자가 성공적으로 삭제되었습니다.');
                    goListPage(); // 삭제 후 리스트 페이지로 이동
                },
                error: function(xhr, status, error) {
                    console.error('삭제 실패: ' + status + ', ' + error);
                    if(xhr.responseText) {
                        alert(xhr.responseText);
                    } else {
                    	alert('삭제에 실패했습니다. 다시 시도해주세요.');
                    }
                }
            });
        }
    	
    });
	
	
    $("#btn_list").on('click', function() {
    	goListPage();
    });
	
	/* 수정페이지로 이동할 때 쿼리스트링 유지 */
	$("#btn_update").on('click', function() {
		var urlParams = new URLSearchParams(window.location.search); // 브라우저의 현재 URL에서 쿼리스트링(쿼리 파라미터)를 가져옴
        var page = urlParams.get('currentPage') || 1;
        var searchType = urlParams.get('searchType') || '';
        var keyword = urlParams.get('keyword') || '';
        
		// URL 쿼리스트링 생성 - 빈 값은 제외
        var queryParams = [];
        if(page) {
            queryParams.push('currentPage=' + page);
        }
        if(searchType && keyword) {
            queryParams.push('searchType=' + searchType);
            queryParams.push('keyword=' + encodeURIComponent(keyword)); // URI의 특정 부분을 안전하게 인코딩(특수문자, 공백)
        }
        
     	// 쿼리스트링 조합
        var newUrl = queryParams.length > 0 ? '?' + queryParams.join('&') : ''; // join() 배열의 요소들을 하나의 문자열로 합칠 때
        
		window.location.href = '/admin/author/update/' + author_id + newUrl;
	});
	
	/* 목록페이지로 이동할 때 쿼리스트링 유지 */
	function goListPage() {
		var urlParams = new URLSearchParams(window.location.search); // 브라우저의 현재 URL에서 쿼리스트링(쿼리 파라미터)를 가져옴
        var page = urlParams.get('currentPage') || 1;
        var searchType = urlParams.get('searchType') || '';
        var keyword = urlParams.get('keyword') || '';
        
		// URL 쿼리스트링 생성 - 빈 값은 제외
        var queryParams = [];
        if(page) {
            queryParams.push('currentPage=' + page);
        }
        if(searchType && keyword) {
            queryParams.push('searchType=' + searchType);
            queryParams.push('keyword=' + encodeURIComponent(keyword)); // URI의 특정 부분을 안전하게 인코딩(특수문자, 공백)
        }
        
     	// 쿼리스트링 조합
        var newUrl = queryParams.length > 0 ? '?' + queryParams.join('&') : ''; // join() 배열의 요소들을 하나의 문자열로 합칠 때
        
        window.location.href = '/admin/author/list' + newUrl;
	}
	
});
</script>
</body>
</html>