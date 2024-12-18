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
    .auth-badge {
    padding: 5px 10px;
    border-radius: 3px;
    font-size: 12px;
    font-weight: bold;
	}
	
	.auth-admin {
	    background-color: #007bff;  /* 관리자는 파란색 */
	    color: white;
	}
	
	.auth-user {
	    background-color: #6c757d;  /* 사용자는 회색 */
	    color: white;
	}
	</style>
</head>
<body class="js">
<%@ include file="/WEB-INF/views/common/admin/commonHeader.jsp" %>
	<!-- Shopping Cart -->
	<div class="shopping-cart section" style="max-width: 100%; background: none;">
		<div class="container" style="max-width: 100%;">
			<div class="row">
				<div class="col-12" style="margin-left: 15%; flex: 0 0 35%; max-width: 35%;">
					<h2>회원 관리</h2>
				</div>
				<div class="col-12" style="flex: 0 0 35%; max-width: 35%;">
					<!-- Total Amount -->
					<div class="total-amount" style="margin: 0 0 20px 0;">
						<div style="text-align: right;">
							<div class="col-lg-8 col-md-5 col-12" style="max-width: 100%; padding: 0px;">
								<div class="left">
									<div class="coupon">
										<form id="searchForm" style="float: right; display: flex;">
										<select id="memberStatus" name="memberStatus">
								            <option value="active">정상회원</option>
								            <option value="all">전체회원</option>
								            <option value="withdrawn">탈퇴회원</option>
								        </select>
									    
									    <select id="searchType" name="searchType">
								            <option value="userName">이름</option>
								            <option value="userId">아이디</option>
								            <option value="userEmail">이메일</option>
							        	</select>
        
									    <input type="text" name="keyword" placeholder="검색어를 입력해주세요">
									    <button type="submit" class="btn">검색</button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--/ End Total Amount -->
				</div>
			</div>
			<div class="row">
				<div class="col-12" style="margin-left: 15%; flex: 0 0 70%; max-width: 70%;">
					<table class="table shopping-summery" style="box-shadow: 0px 0px 15px #0000001a;">
						<thead>
							<tr class="main-hading">
								<th class="text-center">번호</th>
								<th class="text-center">아이디</th>
								<th class="text-center">이름</th>
								<th class="text-center">이메일</th>
								<th class="text-center">권한</th>
								<th class="text-center">가입일</th>
								<th class="text-center">관리</th>
							</tr>
						</thead>
						<tbody id="memberList">
							<!-- List 영역 -->
						</tbody>
					</table>
				</div>
				
				<div id="Pagination" class="col-12">
						<!-- Pagination 영역 -->
				</div>				
			</div>
		</div>
	</div>
	<!--/ End Shopping Cart -->
<%@ include file="/WEB-INF/views/common/admin/commonFooter.jsp" %>	
<%@ include file="/WEB-INF/views/common/commonJs.jsp" %>
<script>
$(document).ready(function() {
    /* URL에서 파라미터 가져오기 */
    function getUrlParameters() {
    	var urlParams = new URLSearchParams(window.location.search); // 브라우저의 현재 URL에서 쿼리스트링(쿼리 파라미터)를 가져옴
        return {
            currentPage: urlParams.get('currentPage') || 1,
            searchType: urlParams.get('searchType') || '',
         	// 인코딩된 문자열을 다시 원래의 형태로 변환
         	// 이를 화면에 표시하거나 다시 사용할 때는 원래 형태로 디코딩해야 함
            keyword: urlParams.get('keyword') ? decodeURIComponent(urlParams.get('keyword')) : '',
            memberStatus: urlParams.get('memberStatus') || 'active'  // 추가
        };
    }
    
 	/* 폼 초기화 함수 */
    function initializeForm() {
    	// 초기 페이지 로드 시 URL 파라미터 가져오기
        var params = getUrlParameters();
     	
		// 폼 값 설정
        if(params.searchType){
        	$('#searchForm select[name="searchType"]').val(params.searchType);	
        }
        if(params.keyword){
        	$('#searchForm input[name="keyword"]').val(params.keyword);	
        }
        if(params.memberStatus) {
            $('#searchForm select[name="memberStatus"]').val(params.memberStatus);
        }
        $('#searchType').niceSelect('update');      // 값 설정 후 nice-select 드롭다운을 수동으로 업데이트
        $('#memberStatus').niceSelect('update');      
 	}
 	
	/* 초기화 */
    initializeForm();
    /* 첫 페이지부터 시작 */
    memberList(getUrlParameters().currentPage);

    /* 검색 폼 제출 이벤트 처리 */
    $('#searchForm').on('submit', function(e) {
        e.preventDefault(); // 기본 동작을 방지
        memberList(1); // 검색 시 첫 페이지부터 시작
    });

    /* 게시글 리스트 조회 */
    function memberList(page) {
        var $form = $('#searchForm');
        
     	// 폼 데이터를 객체로 변환
        var formData = {
            currentPage: page,
            itemsPerPage: 10,
            searchType: $form.find('select[name="searchType"]').val(),
            keyword: $form.find('input[name="keyword"]').val().trim(),
            memberStatus: $form.find('select[name="memberStatus"]').val()
        };
        
        var adminMap = {
    			'USER' : '사용자',
    			'ADMIN' : '관리자'
    		};
        
        $.ajax({
            url: '/api/members',
            method: 'GET',
            dataType: 'json',		// 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
            data: formData,
            success: function(response) {
                var memberListHtml = '';
                
				// URL 쿼리스트링 생성 - 빈 값은 제외
		        var queryParams = [];
		        if(page) {
		            queryParams.push('currentPage=' + page);
		        }
		        if(formData.memberStatus) {
		            queryParams.push('memberStatus=' + formData.memberStatus);
		        }
		        if(formData.searchType && formData.keyword) {
		            queryParams.push('searchType=' + formData.searchType);
		            queryParams.push('keyword=' + encodeURIComponent(formData.keyword)); // URI의 특정 부분을 안전하게 인코딩(특수문자, 공백)
		        }
		        
		     	// 쿼리스트링 조합
		        var newUrl = queryParams.length > 0 ? '?' + queryParams.join('&') : ''; // join() 배열의 요소들을 하나의 문자열로 합칠 때
                
                if(response.totalCount > 0) {
                    $.each(response.memberList, function(index, member) {
                        memberListHtml += '<tr class="text-center">';
                        memberListHtml += '<td><span>' + ((response.totalCount - member.rnum) + 1) + '</span></td>';
                        
                        memberListHtml += '<td><a href="/admin/member/detail/' + member.user_id + newUrl + '">' 
                        		+ member.user_id + '</a></td>';
                        		
                        memberListHtml += '<td><span>' + member.user_name  + '</span></td>';
                        memberListHtml += '<td><span>' + member.user_email  + '</span></td>';
                        
                        memberListHtml += '<td><span class="auth-badge '
                        	 + (member.admin_ck === 'ADMIN' ? 'auth-admin' : 'auth-user') + '">'
                        	 + adminMap[member.admin_ck] + '</span></td>';
                        
                        memberListHtml += '<td><span>' + member.reg_date  + '</span></td>';
                        
                        memberListHtml += '<td>' + (member.use_flag === 'Y'
                            		? '<span class="status-badge status-active">정상</span>'
                            	    : '<span class="status-badge status-inactive">탈퇴</span>') + '</td>';
                        memberListHtml += '</tr>';
                    });
                } else {
                    memberListHtml += '<tr class="text-center">';    
                    memberListHtml += '<td colspan="7"><span>데이터가 존재하지 않습니다.</span></td>';
                    memberListHtml += '</tr>';
                }
                $('#memberList').html(memberListHtml);
                
             	// 페이징 렌더링
                drawPaging(response.paging);
             	
             	// URL 쿼리스트링 갱신
                history.pushState(null, '', newUrl);
            },
            error: function(xhr, status, error) {
            	console.error("리스트 조회 실패: " + status + ", " + error);
                // 서버에서 전달된 메시지 출력
                if (xhr.responseText) {
                    alert(xhr.responseText);
                } else {
                	alert("리스트 조회에 실패하였습니다.");
                }
            }
        });
    }
     
	/* 페이지 렌더링  */
    function drawPaging(paging) {
        var pagingtHtml = '';
        
        if(paging.totalPages > 1) {
            pagingtHtml += '<div class="pagination center">';
            pagingtHtml += '<ul class="pagination-list">';
            
            <!-- 이전 페이지 링크 -->
            if(paging.hasPreviousPage) {
                pagingtHtml += '<li>';
                pagingtHtml += '<a href="#" data-page="' + (paging.currentPage - 1) + '">';
                pagingtHtml += '<i class="ti-arrow-left"></i>';
                pagingtHtml += '</a>';
                pagingtHtml += '</li>';
            }
            
            <!-- 페이지 번호 링크 -->
            for(var pageNum = paging.startPage; pageNum <= paging.endPage; pageNum++){
                pagingtHtml += '<li class="' + (pageNum === paging.currentPage ? 'active' : '') + '">';
                pagingtHtml += '<a href="#" data-page="' + pageNum + '">' + pageNum + '</a>';
                pagingtHtml += '</li>';
            }
            
            <!-- 다음 페이지 링크 -->
            if(paging.hasNextPage) {
                pagingtHtml += '<li>';
                pagingtHtml += '<a href="#" data-page="' + (paging.currentPage + 1) + '">';
                pagingtHtml += '<i class="ti-arrow-right"></i>';
                pagingtHtml += '</a>';
                pagingtHtml += '</li>';
            }
            
            pagingtHtml += '</ul>';
            pagingtHtml += '</div>';
        }
        $('#Pagination').html(pagingtHtml);

     	// $('#Pagination').off('click', 'a') : #Pagination 내부의 a 태그에 할당된 이전의 클릭 이벤트를 제거
		// 페이지 번호 클릭 시 갱신될 때 이벤트 중복 발생(두 개 이상의 동일한 AJAX 요청이 전송)을 방지하기 위해 기존 이벤트를 먼저 제거
        $('#Pagination').off('click', 'a').on('click', 'a', function(e) {
        	// <a> 태그의 기본 동작인 페이지 이동을 막기 위해 사용
            e.preventDefault();
            var pageNum = $(this).data('page');
            memberList(pageNum);
        });
    }
	
}); // $(document).ready 종료
	
</script>
</body>
</html>
