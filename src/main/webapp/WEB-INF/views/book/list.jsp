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
	#searchResultHeader {
	    padding: 20px 0;
	    border-bottom: 1px solid #eee;
	    margin-bottom: 30px;
	}
	
	#searchResultHeader h3 {
	    color: #333;
	}
	
	#searchResultHeader span {
	    color: #F7941D;
	    font-weight: bold;
	}

	/* 카테고리 스타일링 */
	.category-wrap {
	    padding: 15px 0;
	}
	
	.category-wrap ul {
	    margin: 0;
	    padding: 0;
	    list-style: none;
	}
	
	.category-wrap ul li {
	    margin-bottom: 8px;
	}
	
	.category-wrap ul li:last-child {
	    margin-bottom: 0;
	}
	
	.category-wrap ul li a {
	    display: block;
	    padding: 5px 10px;
	    color: #333;
	    font-size: 14px;
	    transition: all 0.3s ease;
	    text-decoration: none;
	}
	
	.category-wrap ul li a:hover,
	.category-wrap ul li a.active {
	    color: #F7941D;
	    background-color: #f8f9fa;
	}
	
	/* 대분류 카테고리 스타일 */
	.main-category {
	    border-right: 1px solid #eee;
	    padding-right: 15px;
	    margin-right: 15px;
	}
	
	.main-category li a {
	    font-weight: 500;
	}
	
	/* 중분류 카테고리 스타일 */
	.sub-category {
	    border-right: 1px solid #eee;
	    padding-right: 15px;
	    margin-right: 15px;
	}
	
	/* 소분류 카테고리 스타일 */
	.last-category {
	    color: #666;
	}
	
	/* 카테고리 레이아웃 */
	.category-wrap {
	    display: flex;
	    background: #fff;
	    border: 1px solid #eee;
	    border-radius: 4px;
	}
	
	.category-wrap > ul {
	    flex: 1;
	    min-width: 150px;
	    max-height: 400px;
	    overflow-y: auto;
	}
	
	/* 상품 리스트 스타일링 */
	.book-list {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 20px;
	}
	
	.book-item {
	    width: 100%;
	    padding: 20px;
	    background-color: #fff;
	    border-bottom: 1px solid #ddd;
	    border-radius: 5px;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	}
	
	.book-item .row {
	    align-items: center;
	}
	
	.book-item .book-img {
	    text-align: center;
	}
	
	.book-item .book-img img {
	    max-width: 100%;
	    height: auto;
	}
	
	.book-item .book-info {
	    margin-top: 20px;
	}
	
	.book-item .book-title a {
	    font-size: 20px;
	    font-weight: 800;
	    margin-bottom: 10px;
	}
	
	.book-meta {
	    font-size: 14px;
	    color: #888;
	    margin-bottom: 10px;
	}
	
	.book-meta span {
	    display: inline-block;
	}
	
	.book-item .book-author {
	    font-size: 14px;
	    color: #888;
	    margin-bottom: 10px;
	}
	
	.book-pubdate {
	    font-size: 14px;
	    color: #888;
	    margin-bottom: 10px;
	}
	
	.book-discount {
	    font-size: 16px;
	    color: #F7941D;
	    font-weight: bold;
	    margin-right: 5px;
	}
	
	.book-final-price {
	    font-size: 16px;
	    color: #000;
	    font-weight: bold;
	    margin-right: 5px;
	}
	
	.book-original-price {
	    font-size: 12px;
	    color: #888;
	    text-decoration: line-through;
	}
	
	/* 상품 소개 스타일링 */
	.book-intro {
	    font-size: 14px;
	    color: #666;
	    margin-top: 10px;
	    margin-bottom: 20px;
	    line-height: 1.5;
	    max-height: 3em; /* 2줄 높이로 제한 (line-height * 2) */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    display: -webkit-box;
	    -webkit-line-clamp: 2;
	    -webkit-box-orient: vertical;
	}
	
	/* 장바구니, 바로구매 버튼 스타일링 */
	.book-buttons {
	    display: flex;
	    flex-direction: column;
	    align-items: flex-end;
	    justify-content: center;
	    height: 100%;
	}
	
	.book-buttons .btn {
	    margin-bottom: 10px;
	}
	
	.btn-cart, .btn-buy {
	    font-size: 14px;
	    font-weight: 700;
	    border-radius: 4px;
	    margin-right: 10px;
	}
	
	.btn-cart {
	    background-color: #767676;
	    color: #fff;
	    border: none;
	}
	
	.btn-buy {
	    background-color: #6c5ce7;
	    color: #fff;
	    border: none;
	}

	.btn-cart:hover {
	    background-color: #4d4d4d;
	}
	
	.btn-buy:hover {
	    background-color: #4a3e8e;
	}

	</style>
	
</head>
<body class="js">
	
<%@ include file="/WEB-INF/views/common/commonHeader.jsp" %>
	
<!-- Breadcrumbs -->
<div class="breadcrumbs">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="bread-inner">
					<ul class="bread-list">
						<li><a href="/">홈<i class="ti-arrow-right"></i></a></li>
						<li class="active"><a href="/book/list">도서</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- End Breadcrumbs -->

<!-- Product Style 1 -->
<section class="product-area shop-sidebar shop-list shop section" style="padding: 50px 0;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 col-md-8 col-12">
				<div class="row">
					<!-- 카테고리 영역 수정 -->
					<div class="col-12">
						<h3 class="hbook">도서 목록</h3>
					    <!-- Single Widget -->
					    <div class="single-widget category">
					        <h3 class="title">카테고리</h3>
					        <div class="category-wrap">
					            <!-- 대분류 카테고리 -->
					            <ul class="main-category">
					                <li><a href="javascript:void(0);" data-code="" class="active">전체</a></li>
					                <!-- 대분류 목록이 여기에 동적으로 추가됨 -->
					            </ul>
					            
					            <!-- 중분류 카테고리 -->
					            <ul class="sub-category">
					                <!-- 중분류 목록이 여기에 동적으로 추가됨 -->
					            </ul>
					            
					            <!-- 소분류 카테고리 -->
					            <ul class="last-category">
					                <!-- 소분류 목록이 여기에 동적으로 추가됨 -->
					            </ul>
					        </div>
					    </div>
					</div>
				</div>
				<div class="row">
						<!-- Start Single List -->
						<div class="col-12">
							<div id="bookCategoryList">
								<!-- List 영역 -->
							</div>
						</div>
						<!-- End Single List -->
						<div class="col-12">
							<div id="Pagination" class="col-12">
								<!-- Pagination 영역 -->
							</div>	
						</div>
					</div>
			</div>
		</div>
	</div>
</section>
<!--/ End Product Style 1  -->	


<%@ include file="/WEB-INF/views/common/commonFooter.jsp" %>
<script>
$(document).ready(function() {
	/* 초기 대분류 카테고리 로드 */
	loadMainCategoryList();
	
	/* 초기 전체 상품 로드 */
	loadBookListByCategory('all', 1);
   
   /* 대분류 카테고리 클릭 이벤트 */
   $(document).on('click', '.main-category a', function(e) {
       e.preventDefault();
       $('.main-category a').removeClass('active');
       $(this).addClass('active');
       
       var categoryCode = $(this).data('code');
       if(categoryCode) {
           loadSubCategoryList(categoryCode);
       } else {
           $('.sub-category, .last-category').empty();
       }
   });
   
   /* 대분류 카테고리 로드 */
   function loadMainCategoryList() {
       $.ajax({
           url: '/api/book/category/tier/1',
           method: 'GET',
           success: function(response) {
               var html = '';
               response.forEach(function(category) {
                   html += '<li><a href="javascript:void(0);" data-code="' + 
                          category.category_code + '">' + 
                          category.category_name + '</a></li>';
               });
               $('.main-category').append(html);
           },
           error: function(xhr, status, error) {
            console.error("카테고리 로드 실패:", error);
		  	if(xhr.responseText) {
		  		alert(xhr.responseText);
		  	} else {
		  		alert("카테고리 로드에 실패했습니다.");
		  	}
           }
       });
   }
   
   /* 중분류 카테고리 클릭 이벤트 */ 
   $(document).on('click', '.sub-category a', function(e) {
       e.preventDefault();
       $('.sub-category a').removeClass('active');
       $(this).addClass('active');
       
       var categoryCode = $(this).data('code');
       if(categoryCode) {
           loadLastCategoryList(categoryCode);
       } else {
           $('.last-category').empty();
       }
   });
   
   /* 중분류 카테고리 로드 */
   function loadSubCategoryList(parentCode) {
       $.ajax({
           url: '/api/book/category/sub/' + parentCode,
           method: 'GET',
           success: function(response) {
               var html = '';
               response.forEach(function(category) {
                   html += '<li><a href="javascript:void(0);" data-code="' + 
                          category.category_code + '">' + 
                          category.category_name + '</a></li>';
               });
               $('.sub-category').html(html);
               $('.last-category').empty();
           },
           error: function(xhr, status, error) {
               console.error("하위 카테고리 로드 실패:", error);
		  	if(xhr.responseText) {
		  		alert(xhr.responseText);
		  	} else {
		  		alert("하위 카테고리 로드에 실패했습니다.");
		  	}
           }
       });
   }
   
   /* 소분류 카테고리 클릭 이벤트 */ 
   $(document).on('click', '.last-category a', function(e) {
       e.preventDefault();
       $('.last-category a').removeClass('active');
       $(this).addClass('active');
   });
   
   /* 소분류 카테고리 로드 */
   function loadLastCategoryList(parentCode) {
       $.ajax({
           url: '/api/book/category/sub/' + parentCode,
           method: 'GET',
           success: function(response) {
               var html = '';
               response.forEach(function(category) {
                   html += '<li><a href="javascript:void(0);" data-code="' + 
                          category.category_code + '">' + 
                          category.category_name + '</a></li>';
               });
               $('.last-category').html(html);
           },
           error: function(xhr, status, error) {
               console.error("하위 카테고리 로드 실패:", error);
		  	if(xhr.responseText) {
		  		alert(xhr.responseText);
		  	} else {
		  		alert("하위 카테고리 로드에 실패했습니다.");
		  	}
           }
       });
   }
   
	/* 카테고리 클릭 시 상품 목록 및 검색 상품 로드 함수 */
   function loadBookListByCategory(categoryCode, page) {
		// 폼 데이터를 객체로 변환
		var formData = {
		    currentPage: page,
		    itemsPerPage: 10,
            searchType: $('select[name="searchType"]').val(),
            keyword: $('input[name="keyword"]').val().trim()
		};
        
		$.ajax({
			url: '/api/book/category/' + categoryCode,
			method: 'GET',
			dataType: 'json',		// 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
			data: formData,
			success: function(response) {
        		
	            // 검색 결과일 경우 카테고리 숨기고 검색 결과 헤더 표시
	            if(formData.keyword) {
	                $('.category, .hbook').hide();
	                renderSearchHeader(formData.keyword, response.totalCount);
	            } else {
	                $('.category, .hbook').show();
	                $('#searchResultHeader').hide();
	            }
	            
                // 카테고리 상품 목록 리스트 렌더링
                renderBookCategoryList(response.bookCategoryList);
				   
				// 페이징 렌더링
				drawPaging(categoryCode, response.paging);
        
				// URL 업데이트
	            updateURL(categoryCode, page, formData.searchType, formData.keyword);
		     	
	       },
	       error: function(xhr, status, error) {
	           console.error("상품 목록 로드 실패:", error);
	           if(xhr.responseText) {
	               alert(xhr.responseText);
// 	           } else {
	               alert("상품 목록 로드에 실패했습니다.");
	           }
	       }
	   });
   }

	/* 카테고리 상품 목록 리스트 렌더링 */
	function renderBookCategoryList(bookCategoryList) {
	    var html = '';
	    if (bookCategoryList && bookCategoryList.length > 0) {
	        html += '<div class="book-list">';
	        
	        bookCategoryList.forEach(function(book) {
	            html += '<div class="book-item">';
	            html += '<div class="row">';
	            
	            // 상품 이미지
	            html += '<div class="col-md-3">';
	            html += '<div class="book-img">';
	            html += '<a href="/book/detail/' + book.book_id + '">';
	            html += '<img src="' 
	            		+ (book.upload_path ? '/uploads/' 
	            		+ book.upload_path + "thumb_" 
	            		+ book.saved_name : '/resources/images/no-image.jpg') 
	            		+ '" alt="' + book.book_name + '">';
	            html += '</a>';
	            html += '</div>';
	            html += '</div>';
	            
	            // 상품 정보
	            html += '<div class="col-md-7">';
	            html += '<div class="book-info">';
	            html += '<h3 class="book-title">';
	            html += '<a href="/book/detail/' + book.book_id + '">' + book.book_name + '</a>';
	            html += '</h3>';
	            html += '<p class="book-meta">';
	            html += '<span class="book-author">' + book.author_name + "&nbsp|&nbsp" + '</span>';
	            html += '<span class="book-publisher">' + book.publisher + "&nbsp|&nbsp" + '</span>';
	            html += '<span class="book-pubdate">' + book.puble_year + '</span>';
	            html += '</p>';
	            
	            // 가격 정보
	            html += '<div class="book-price">';
	            if (book.book_discount > 0) {
	                html += '<span class="book-discount">' + book.book_discount + '%</span>';
	                html += '<span class="book-final-price">' + calculateFinalPrice(book.book_price, book.book_discount).toLocaleString() + '원</span>';
	                html += '<span class="book-original-price">' + book.book_price.toLocaleString() + '원</span>';
	            } else {
	                html += '<span class="book-final-price">' + book.book_price.toLocaleString() + '원</span>';
	            }
	            html += '</div>';
	            
	         	// 상품 소개
	         	var cleanIntro = stripHtml(book.book_intro || '');
	         	var truncatedIntro = truncateText(cleanIntro, 200); // 200자로 제한
	            html += '<div class="book-intro">' + truncatedIntro + '</div>';
	            html += '</div>';
	            html += '</div>';
	            
	            // 장바구니, 바로구매 버튼
	            html += '<div class="col-md-2">';
	            html += '<div class="book-buttons">';
	            html += '<button class="btn btn-cart" data-book-id="' + book.book_id + '"><span>장바구니</span></button>';
	            html += '<button class="btn btn-buy"><span>바로구매</span></button>';
	            html += '</div>';
	            html += '</div>';
	            
	            html += '</div>';
	            html += '</div>';
	        });
	        
	        html += '</div>';
	    } else {
	        html = '<div class="col-12 py-5">';
	        html += '<div class="text-center">';
	        html += '<i class="fa fa-search mb-3" style="font-size: 48px; color: #ccc;"></i>';
	        html += '<p class="text-muted">등록된 상품이 없습니다.</p>';
	        html += '</div>';
	        html += '</div>';
	    }
	    $('#bookCategoryList').html(html);
	}
	
   	/* 페이지 렌더링  */
    function drawPaging(categoryCode, paging) {
		if (!paging || paging.totalPages <= 1) {
		    $('#Pagination').empty();
		    return;
		}
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
            loadBookListByCategory(categoryCode, pageNum);
        });
    }
   	
	/* 검색 결과 헤더 렌더링 함수 */
	function renderSearchHeader(keyword, totalCount) {
		// 기존 검색 헤더 제거 
	    $('#searchResultHeader').remove();
	    var html ='<div id="searchResultHeader" class="mb-4">'
					+ '<h3><span>&#039;' + keyword + '&#039;</span> 에 대한 검색 결과 (' + totalCount.toLocaleString() + '개)</h3>'
					+ '</div>';
	    $('#bookCategoryList').before(html); // 선택한 요소의 앞에 새로운 HTML 콘텐츠를 삽입
	}
	
	/* URL 업데이트 함수 */
	function updateURL(categoryCode, page, searchType, keyword) {
		// URL 쿼리스트링 생성 - 빈 값은 제외
	    var queryParams = [];
	    if(page) {
	        queryParams.push('currentPage=' + page);
	    }
	    
	    if(categoryCode && categoryCode !== 'all') {
	        queryParams.push('categoryCode=' + categoryCode);
	    }
	    
	    if(searchType && keyword) {
	    	queryParams.push('searchType=' + searchType);
	    	queryParams.push('keyword=' + encodeURIComponent(keyword)); // URI의 특정 부분을 안전하게 인코딩(특수문자, 공백)
        }
	    
 		// 쿼리스트링 조합
 		// join() 배열의 요소들을 하나의 문자열로 합칠 때
	    var newUrl = queryParams.length > 0 ? '?' + queryParams.join('&') : '';
	 	// URL 쿼리스트링 갱신
	    history.pushState(null, '', newUrl);
	}
	
   /* 최종 가격 계산 함수 */
   function calculateFinalPrice(originalPrice, discount) {
       if(!discount) {
    	   return originalPrice;
       }
       return Math.floor(originalPrice * (1 - discount / 100));
   }
   
   /* HTML 태그 및 스타일 제거 함수 */
   function stripHtml(html) {
       // 임시 div 엘리먼트 생성
       var temp = document.createElement("div");
       // HTML 내용 삽입
       temp.innerHTML = html;
       
       // 텍스트 내용만 추출 - 태그가 제거된 후의 텍스트만 반환
       return temp.textContent || temp.innerText || "";
   }
   
   /* 텍스트 길이 제한 함수 */
   function truncateText(text, maxLength) {
       if(!text) {
    	   return '';
       }
       if(text.length <= maxLength) {
    	   return text;
       }
       return text.substring(0, maxLength) + '...';
   }
   	
   /* 각 카테고리 클릭 이벤트에 상품 로드 추가 */
   $(document).on('click', '.main-category a, .sub-category a, .last-category a', function(e) {
       e.preventDefault();
       var categoryCode = $(this).data('code') || 'all';
       loadBookListByCategory(categoryCode, 1);
   });
   
   /* 장바구니 클릭 이벤트 */
   $(document).on('click', '.btn-cart', function(e) {
	    e.preventDefault();
	    var checkLogin = ${not empty sessionScope.userId ? 'true' : 'false'};
	    
	    // 로그인 체크
	    if(!checkLogin) {
	        if(confirm('로그인이 필요한 서비스입니다. 로그인 하시겠습니까?')) {
	            location.href = '/member/login';
	        }
	        return;
	    }
	    
	    var bookId = $(this).data('book-id');
	    addToCart(bookId, 1); // 목록에서는 기본 수량 1로 설정
	});
   
   /* 장바구니 추가 함수 */
   function addToCart(bookId, quantity) {
       var cartData = {
           book_id: bookId,
           cart_count: quantity
       };

       $.ajax({
           url: '/api/cart',
           type: 'POST',
           contentType: 'application/json; charset=utf-8',		// 클라이언트(브라우저)에서 서버로 보내는 데이터의 형식
           data: JSON.stringify(cartData),
           success: function(response) {
               if(confirm('장바구니에 추가되었습니다. 장바구니로 이동하시겠습니까?')) {
                   location.href = '/user/cart/list';
               }
           },
           error: function(xhr, status, error) {
        	   if(xhr.responseText) {
                   alert(xhr.responseText);
               } else {
                   alert('장바구니 담기에 실패했습니다. 잠시 후 다시 시도해주세요.');
               }
           }
       });
   }
   
});
</script>
</body>
</html>