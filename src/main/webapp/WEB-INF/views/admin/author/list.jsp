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

	<!-- Shopping Cart -->
	<div class="shopping-cart section" style="max-width: 100%; background: none;">
		<div class="container" style="max-width: 100%;">
			<div class="row">
				<div class="col-12" style="margin-left: 15%; flex: 0 0 35%; max-width: 35%;">
					<h2>작가 관리</h2>
				</div>
				<div class="col-12" style="flex: 0 0 35%; max-width: 35%;">
					<!-- Total Amount -->
					<div class="total-amount" style="margin: 0 0 20px 0;">
						<div style="text-align: right;">
							<div class="col-lg-8 col-md-5 col-12" style="max-width: 100%; padding: 0px;">
								<div class="left">
									<div class="coupon">
										<form id="searchForm" style="float: right;">
										<select id="searchType" name="searchType">
									        <option value="authorName">작가</option>
									        <option value="authorIntro">내용</option>
									        <option value="authorNameIntro">작가+내용</option>
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
								<th class="text-center" style="width: 15%;">번호</th>
								<th class="text-center" style="width: 15%;">작가 이름</th>
								<th class="text-center" style="width: 15%;">등록 날짜</th>
								<th class="text-center" style="width: 15%;">수정 날짜</th>
								<th class="text-center" style="width: 15%;"><i class="ti-trash remove-icon"></i></th>
							</tr>
						</thead>
						<tbody id="authorList">
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
            keyword: urlParams.get('keyword') ? decodeURIComponent(urlParams.get('keyword')) : ''
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
        $('#searchType').niceSelect('update');      // 값 설정 후 nice-select 드롭다운을 수동으로 업데이트
 	}
 	
 	/* 초기화 */
    initializeForm();
 	
    /* 첫 페이지부터 시작 */
    authorList(getUrlParameters().currentPage);

    /* 검색 폼 제출 이벤트 처리 */
    $('#searchForm').on('submit', function(e) {
        e.preventDefault(); // 기본 동작을 방지
        authorList(1); // 검색 시 첫 페이지부터 시작
    });

    /* 게시글 리스트 조회 */
    function authorList(page) {
        var $form = $('#searchForm');
        
     	// 폼 데이터를 객체로 변환
        var formData = {
            currentPage: page,
            itemsPerPage: 10,
            searchType: $form.find('select[name="searchType"]').val(),
            keyword: $form.find('input[name="keyword"]').val()
        };



        $.ajax({
            url: '/api/author',
            method: 'GET',
            dataType: 'json',		// 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
            data: formData,
            success: function(response) {
                var authorListHtml = '';
                
        		// URL 쿼리스트링 생성 - 빈 값은 제외
                var queryParams = [];
                if(page) {
                    queryParams.push('currentPage=' + page);
                }
                if(formData.searchType && formData.keyword) {
                    queryParams.push('searchType=' + formData.searchType);
                    queryParams.push('keyword=' + encodeURIComponent(formData.keyword)); // URI의 특정 부분을 안전하게 인코딩(특수문자, 공백)
                }
                
             	// 쿼리스트링 조합
                var newUrl = queryParams.length > 0 ? '?' + queryParams.join('&') : ''; // join() 배열의 요소들을 하나의 문자열로 합칠 때
                
                if(response.totalCount > 0) {
                    $.each(response.authorList, function(index, list) {
                        authorListHtml += '<tr class="text-center">';
                        authorListHtml += '<td><span>' + ((response.totalCount - list.rnum) + 1) + '</span></td>';
                        authorListHtml += '<td><a href="/admin/author/detail/' + list.author_id + newUrl + '">' + list.author_name + '</a></td>';
                        authorListHtml += '<td><span>' + list.reg_date + '</span></td>';
                        authorListHtml += '<td><span>' + list.update_date + '</span></td>';
                        authorListHtml += '<td><a href="#" data-delete="' + list.author_id + '"><i class="ti-trash remove-icon"></i></a></td>';
                        authorListHtml += '</tr>';
                    });
                } else {
                    authorListHtml += '<tr class="text-center">';    
                    authorListHtml += '<td colspan="5"><span>데이터가 존재하지 않습니다.</span></td>';
                    authorListHtml += '</tr>';
                }
                $('#authorList').html(authorListHtml);
                
             	// 페이징 렌더링
                drawPaging(response.paging);
             	
            	// URL 쿼리스트링 갱신
                history.pushState(null, '', newUrl);
            },
            error: function(xhr, status, error) {
                console.error("리스트 조회 실패: " + status + ", " + error);
                if(xhr.responseText) {
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
            authorList(pageNum);
        });
    }
	
	/* 게시글 삭제 */
  	$('#authorList').on('click', '[data-delete]', function(e) {	// 동적으로 생성된 요소 data-delete (AJAX로 추가된 항목들 등)에도 이벤트 핸들러를 연결
    	e.preventDefault();
        var authorId = $(this).data('delete'); 
        
        if (confirm('정말로 삭제하시겠습니까?')) {
            $.ajax({
                url: '/api/author/' + authorId, 
                method: 'DELETE', 
                success: function(response) {
                    alert('저자가 성공적으로 삭제되었습니다.');
                    
                    // 삭제 후 리스트 갱신 (현재 페이지로 다시 조회)
                    authorList(getUrlParameters().currentPage); // 삭제 시점의 최신 파라미터 가져오기
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
	
}); // $(document).ready 종료
	
</script>
</body>
</html>
