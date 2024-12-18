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
    .info-section {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    
    .info-title {
        font-weight: bold;
        margin-bottom: 10px;
        color: #333;
    }
    
    .status-badge {
        padding: 5px 10px;
        border-radius: 3px;
        font-size: 12px;
        font-weight: bold;
    }
    
    .status-active {
        background-color: #28a745;
        color: white;
    }
    
    .status-inactive {
        background-color: #dc3545;
        color: white;
    }
    
    .money-info {
        font-size: 16px;
        color: #333;
    }
    
    .point-info {
        font-size: 16px;
        color: #007bff;
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
						<h2 style="padding-bottom: 20px;">회원 상세</h2>
						</div>
							<div class="form-main">
								<!-- Form -->
								<form id="detailForm" class="form">
	                                <div class="row">
	                                    <!-- 기본 정보 섹션 -->
	                                    <div class="col-12">
	                                        <div class="info-section">
	                                            <div class="info-title">기본 정보</div>
	                                            <div class="row">
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>아이디<span>*</span></label>
	                                                        <input type="text" id="userId" disabled>
	                                                    </div>
	                                                </div>
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>이름<span>*</span></label>
	                                                        <input type="text" id="userName" disabled>
	                                                    </div>
	                                                </div>
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>이메일<span>*</span></label>
	                                                        <input type="text" id="userEmail" disabled>
	                                                    </div>
	                                                </div>
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>회원 상태<span>*</span></label>
	                                                        <div id="memberStatus"></div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	
	                                    <!-- 주소 정보 섹션 -->
	                                    <div class="col-12">
	                                        <div class="info-section">
	                                            <div class="info-title">주소 정보</div>
	                                            <div class="row">
	                                                <div class="col-lg-4 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>우편번호<span>*</span></label>
	                                                        <input type="text" id="postNo" disabled>
	                                                    </div>
	                                                </div>
	                                                <div class="col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>기본주소<span>*</span></label>
	                                                        <input type="text" id="addr" disabled>
	                                                    </div>
	                                                </div>
	                                                <div class="col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>상세주소<span>*</span></label>
	                                                        <input type="text" id="addrDetail" disabled>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	
	                                    <!-- 포인트/머니 정보 섹션 -->
	                                    <div class="col-12">
	                                        <div class="info-section">
	                                            <div class="info-title">포인트/머니 정보</div>
	                                            <div class="row">
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>보유 머니<span>*</span></label>
	                                                        <div id="money" class="money-info"></div>
	                                                    </div>
	                                                </div>
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>보유 포인트<span>*</span></label>
	                                                        <div id="point" class="point-info"></div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	
	                                    <!-- 가입 정보 섹션 -->
	                                    <div class="col-12">
	                                        <div class="info-section">
	                                            <div class="info-title">가입 정보</div>
	                                            <div class="row">
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>가입일</label>
	                                                        <input type="text" id="regDate" disabled>
	                                                    </div>
	                                                </div>
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>회원 구분</label>
	                                                        <input type="text" id="adminCk" disabled>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	
	                                    <!-- 버튼 영역 -->
	                                    <div class="col-12" style="margin-top: 20px;">
	                                        <div class="form-group login-btn">
		                                        <button id="btn_update" class="btn" type="button">수정</button>
	                                            <button id="btn_list" class="btn" type="button">목록</button>
	                                            <button id="btn_delete" class="btn" type="button" style="float: right;">회원탈퇴</button>
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
	var user_id = '<c:out value= "${user_id}" />';
	
	/* 회원 상세 조회 시작 */
	memberDetail();
	
	/* 회원 상세 조회 */
	function memberDetail() {
		var adminMap = {
			'USER' : '일반회원',
			'ADMIN' : '관리자'
		};
		
	    $.ajax({
	        url: '/api/members/' + user_id,
	        method: 'GET',
	        dataType: "json",                     // 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
	        success: function(response) {
	            
                $('#userId').val(response.user_id);
                $('#userName').val(response.user_name);
                $('#userEmail').val(response.user_email);
                
                // 상태 뱃지 설정
                var statusHtml = response.use_flag === 'Y' 
                    ? '<span class="status-badge status-active">정상</span>'
                    : '<span class="status-badge status-inactive">탈퇴</span>';
                $('#memberStatus').html(statusHtml);
	        	
                // 주소 정보 설정
                $('#postNo').val(response.post_no);
                $('#addr').val(response.addr);
                $('#addrDetail').val(response.addr_detail);
                
                // 포인트/머니 정보 설정
                $('#money').text(response.money.toLocaleString() + '원');
                $('#point').text(response.point.toLocaleString() + 'P');
                
                // 가입 정보 설정
                $('#regDate').val(response.reg_date);
                $('#adminCk').val(adminMap[response.admin_ck]);
	        	
				
    		},
			error: function(xhr, status, error) { // 실패 시 실행되는 함수
				console.error("회원 정보 조회 실패: " + status + ", " + error);     // 에러 처리
                // 서버에서 전달된 메시지 출력
                if (xhr.responseText) {
                    alert(xhr.responseText);
                } else {
                	alert("회원 정보 조회에 실패했습니다.");
                }
			}
	    });
	}
	

	/* 회원 탈퇴 처리 */
  	$('#btn_delete').on('click', function(e) {	
        if (confirm('정말로 이 회원을 탈퇴 처리하시겠습니까?')) {
            $.ajax({
                url: '/api/members/' + user_id, 
                method: 'DELETE', 
                success: function(response) {
                	alert('회원 탈퇴 처리가 완료되었습니다.');
                	goListPage();
                },
                error: function(xhr, status, error) {
                    console.error('탈퇴 처리 실패: ' + status + ', ' + error);
                    // 서버에서 전달된 메시지 출력
                    if (xhr.responseText) {
                        alert(xhr.responseText);
                    } else {
                        alert('탈퇴 처리에 실패했습니다. 다시 시도해주세요.');
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
        var memberStatus = urlParams.get('memberStatus') || 'active';
        
		// URL 쿼리스트링 생성 - 빈 값은 제외
        var queryParams = [];
        if(page) {
            queryParams.push('currentPage=' + page);
        }
        if(memberStatus) {
            queryParams.push('memberStatus=' + memberStatus);
        }
        if(searchType && keyword) {
            queryParams.push('searchType=' + searchType);
            queryParams.push('keyword=' + encodeURIComponent(keyword)); // URI의 특정 부분을 안전하게 인코딩(특수문자, 공백)
        }
        
     	// 쿼리스트링 조합
        var newUrl = queryParams.length > 0 ? '?' + queryParams.join('&') : ''; // join() 배열의 요소들을 하나의 문자열로 합칠 때
        
		window.location.href = '/admin/member/update/' + user_id + newUrl;
	});
	
	/* 목록페이지로 이동할 때 쿼리스트링 유지 */
	function goListPage() {
		var urlParams = new URLSearchParams(window.location.search); // 브라우저의 현재 URL에서 쿼리스트링(쿼리 파라미터)를 가져옴
        var page = urlParams.get('currentPage') || 1;
        var searchType = urlParams.get('searchType') || '';
        var keyword = urlParams.get('keyword') || '';
        var memberStatus = urlParams.get('memberStatus') || 'active';
        
		// URL 쿼리스트링 생성 - 빈 값은 제외
        var queryParams = [];
        if(page) {
            queryParams.push('currentPage=' + page);
        }
        if(memberStatus) {
            queryParams.push('memberStatus=' + memberStatus);
        }
        if(searchType && keyword) {
            queryParams.push('searchType=' + searchType);
            queryParams.push('keyword=' + encodeURIComponent(keyword)); // URI의 특정 부분을 안전하게 인코딩(특수문자, 공백)
        }
        
     	// 쿼리스트링 조합
        var newUrl = queryParams.length > 0 ? '?' + queryParams.join('&') : ''; // join() 배열의 요소들을 하나의 문자열로 합칠 때
        
        window.location.href = '/admin/member/list' + newUrl;
	}
	
});
</script>
</body>
</html>