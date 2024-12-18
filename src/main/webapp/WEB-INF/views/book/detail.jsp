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
	/* 이미지 갤러리 스타일 */
	.product-gallery {
	    width: 100%;
	    height: 500px;  /* 이미지 컨테이너 고정 크기 */
	    margin-bottom: 30px;
	    position: relative;
	}
	
	.product-gallery .main-image {
	    width: 100%;
	    height: 400px;  /* 메인 이미지 고정 크기 */
	    border: 1px solid #eee;
	    margin-bottom: 10px;
	    overflow: hidden;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	}
	
	.product-gallery .main-image img {
	    max-width: 100%;
	    max-height: 100%;
	    object-fit: contain;
	}
	
	.thumbnail-gallery {
	    display: flex;
	    gap: 10px;
	    overflow-x: auto;
	}
	
	.thumbnail-item {
	    width: 80px;
	    height: 80px;
	    border: 1px solid #ddd;
	    cursor: pointer;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	}
	
	.thumbnail-item img {
	    max-width: 100%;
	    max-height: 100%;
	    object-fit: contain;
	}
	
	.thumbnail-item.active {
	    border-color: #F7941D;
	}
	
	.book-info {
	    padding: 20px;
	    background: #fff;
	    border: 1px solid #eee;
	    border-radius: 4px;
	}
	
	.book-meta {
	    margin: 15px 0;
	    padding: 15px 0;
	    border-top: 1px solid #eee;
	    border-bottom: 1px solid #eee;
	}
	
	.book-meta dl {
	    display: flex;
	    margin-bottom: 10px;
	}
	
	.book-meta dt {
	    width: 100px;
	    color: #666;
	}
	
	.book-meta dd {
	    flex: 1;
	}
	
	/* 가격 정보 스타일 */
	.discount-rate {
	    font-size: 24px;
	    color: #F7941D;
	    font-weight: bold;
	    margin-right: 6px;
	}
	
	.current-price {
	    font-size: 24px;
	    color: #000;
	    font-weight: bold;
	    margin-right: 6px;
	}
	
	.original-price {
	    font-size: 14px;
	    color: #888;
	    text-decoration: line-through;
	}
	
	/* 탭 스타일 */
	.product-info {
	    margin-top: 50px;
	}
	
	.nav-main {
		border-bottom: 1px solid #eaeaea;
	}
	
	.nav.tabs {
	  	width: 1170px;
	    margin: 0 auto;
	    display: flex;
	    margin-bottom: 0;
	    padding: 0;
	}
	
	/* 탭 메뉴 아이템 */
	.nav.tabs .nav-item {
	    margin: 0;
	    padding: 0;
	}
	
	/* 탭 메뉴 링크 */
	.nav.tabs .nav-link {
	    position: relative;
	    padding: 15px 30px;
	    font-size: 16px;
	    color: #666;
	    border: none;
	    background: none;
	    font-weight: 500;
	}
	
	/* 탭 메뉴 호버 효과 */
	.nav.tabs .nav-link:hover {
	    color: #000;
	}
	
	/* 활성화된 탭 스타일 */
	.nav.tabs .nav-link.active {
	    color: #000;
	    font-weight: bold;
	}
	
	/* 활성화된 탭 밑줄 효과 */
	.nav.tabs .nav-link.active:after {
	    content: '';
	    position: absolute;
	    left: 0;
	    bottom: -1px; /* border-bottom과 일치하도록 위치 조정 */
	    width: 100%;
	    height: 3px;
	    background-color: #000;
	}
	
	/* 탭 컨텐츠 영역 */
	.tab-content {
		width: 1170px;
		margin: 0 auto;
	    padding: 30px 0;
	}
	
	/* 수량 선택 스타일 */
	.product-buy {
	    margin-top: 20px;
	}
	
	.input-group {
	    margin: 10px 0;
	}
	
	.input-number {
	    text-align: center;
	}
	.shop.single .quantity .input-number {
		border: 1px solid #ccc;
		border-radius: 6px;
	}
	
	/* 수량 입력창 화살표 제거 */
	.input-number::-webkit-outer-spin-button,
	.input-number::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}

	/* 버튼 스타일 */
	.shop.single .add-to-cart {
	    margin-top: 20px;
	    display: block;
	}
	
	.shop.single .add-to-cart .btn {
	    margin-right: 10px;
	    min-width: 150px;
	    background: #fff;
		color: #6c5ce7;
		border: 1px solid #6c5ce7;
		border-radius: 6px;
		height: 50px;		
		line-height: 50px;
		font-size: 16px;
	}
	
	.add-to-cart #btnBuy {
		background:#6c5ce7;
		color: #fff;
	}
	
	.add-to-cart #btnCart:hover {
		color: #6c5ce7;
		background:#6c5ce717;
	}
	.add-to-cart #btnBuy:hover {
		background:#382f7f;
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
						<li id="categoryName1"></li>
						<li id="categoryName2"></li>
						<li id="categoryName3"></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- End Breadcrumbs -->

<!-- Shop Single -->
<section class="shop single section">
	<div class="container">
		<div class="row"> 
			<div class="col-12">
				<div class="row">
					<div class="col-lg-6 col-12">
						<!-- Product Slider -->
						<div class="product-gallery">
						    <!-- 메인 이미지 -->
						    <div class="main-image">
						        <img id="mainImage" src="/resources/images/no-image.jpg" alt="메인 이미지">
						    </div>
						    <!-- 썸네일 이미지 -->
						    <div class="thumbnail-gallery" id="thumbnailGallery">
						        <!-- 썸네일 이미지들이 여기에 동적으로 추가됨 -->
						    </div>
						</div>
						<!-- End Product slider -->
					</div>
					<div class="col-lg-6 col-12">
						<div class="product-des">
						    <!-- 도서 기본 정보 -->
						    <div class="short">
						        <h4 id="bookTitle"></h4>
						        <div class="book-meta">
						            <dl>
						                <dt>저자</dt>
						                <dd id="authorName"></dd>
						            </dl>
						            <dl>
						                <dt>출판사</dt>
						                <dd id="publisher"></dd>
						            </dl>
						            <dl>
						                <dt>출간일</dt>
						                <dd id="publeYear"></dd>
						            </dl>
						        </div>
								<!-- 가격 정보 부분 -->
								<div class="price-info">
								    <div class="book-price">
								        <span class="discount-rate" id="discountRate"></span>
								        <span class="current-price" id="discountPrice"></span>
								        <span class="original-price" id="originalPrice"></span>
								    </div>
								</div>
						    </div>
						
						    <!-- 구매 관련 정보 -->
						    <div class="product-buy">
						        <div class="quantity">
						            <h6>수량</h6>
						            <div class="input-group">
						                <div class="button minus">
						                    <button type="button" class="btn btn-number" data-type="minus">
						                        <i class="ti-minus"></i>
						                    </button>
						                </div>
						                <input type="number" id="quantity" name="quantity" class="input-number" value="1" min="1">
						                <div class="button plus">
						                    <button type="button" class="btn btn-number" data-type="plus">
						                        <i class="ti-plus"></i>
						                    </button>
						                </div>
						            </div>
						        </div>
						        <div class="add-to-cart">
						            <button class="btn" id="btnCart"><span>장바구니</span></button>
						            <button class="btn" id="btnBuy"><span>바로구매</span></button>
<!-- 						            <button class="btn min" id="btnWish"><i class="ti-heart"></i></button> -->
						        </div>
						    </div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-12">
			<div class="product-info">
				<div class="nav-main">
					<!-- Tab Nav -->
					<ul class="nav tabs" id="myTab" role="tablist">
						<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#intro" role="tab">도서 소개</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#contents" role="tab">도서 내용</a></li>
					</ul>
					<!--/ End Tab Nav -->
				</div>
				<div class="tab-content" id="myTabContent">
				    <!-- 도서 소개 -->
				    <div class="tab-pane fade show active" id="intro" role="tabpanel">
				        <div class="tab-single">
				            <div class="row">
				                <div class="col-12">
				                    <div id="bookIntro" class="book-intro"></div>
				                </div>
				            </div>
				        </div>
				    </div>
				    
				    <!-- 도서 내용 -->
				    <div class="tab-pane fade" id="contents" role="tabpanel">
				        <div class="tab-single">
				            <div class="row">
				                <div class="col-12">
				                    <div id="bookContents" class="book-contents"></div>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>
			</div>
		</div>
	</div>	
</section>
<!--/ End Shop Single -->


<%@ include file="/WEB-INF/views/common/commonFooter.jsp" %>
<script>
$(document).ready(function() {
    var book_id = '<c:out value="${book_id}"/>';
    var currentPrice = 0;  // 현재 판매가 저장
    var maxStock = 0; // 재고 수량 저장 변수 추가
    
    /* 도서 상세 정보 로드 */
    loadBookDetail();
    
    function loadBookDetail() {
        $.ajax({
            url: '/api/books/detail/' + book_id,
            method: 'GET',
	        dataType: "json",                     // 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
            success: function(response) {
            	// 도서 상세 정보 렌더링
                renderBookDetail(response);
            },
            error: function(xhr, status, error) {
                console.error("도서 상세 조회 실패:", error);
    		  	if(xhr.responseText) {
    		  		alert(xhr.responseText);
    		  	} else {
    		  		alert("도서 정보를 불러오는데 실패했습니다.");
    		  	}
            }
        });
    }
    
    /* 장바구니 버튼 클릭 이벤트 */
    $('#btnCart').on('click', function(e) {
        e.preventDefault();
		var checkLogin = ${not empty sessionScope.userId ? 'true' : 'false'};
	    
	    // 로그인 체크
	    if(!checkLogin) {
	        if(confirm('로그인이 필요한 서비스입니다. 로그인 하시겠습니까?')) {
	            location.href = '/member/login';
	        }
	        return;
	    }
        
        // 수량 체크
        var quantity = parseInt($('#quantity').val());
        if(quantity > maxStock) {
        	alert('재고가 부족합니다. 최대 주문 가능 수량은 ' + maxStock + '개입니다.');
            $('#quantity').val(maxStock);
            return;
        }
        addToCart(book_id, quantity);
    });
    
    /* 장바구니 추가 함수 */
    function addToCart(bookId, quantity) {
        var cartData = {
            book_id: bookId,
            cart_count: quantity
        };

        $.ajax({
            url: '/api/carts',
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
    
    /* 수량 변경 이벤트 */
    $('.btn-number').on('click', function() {
        var type = $(this).data('type');	// minus, plus
        var $input = $('#quantity');
        var currentVal = parseInt($input.val());
        
        // 입력값이 없으면 1로 설정
        if(isNaN(currentVal)) {
            $input.val(1);
            return;
        }
        
        if(type === 'minus') {
            // 최소 수량은 1
            if(currentVal > 1) {
                $input.val(currentVal - 1);
            }
        } else if(type === 'plus') {
            // 재고 체크
            if(currentVal < maxStock) {
                $input.val(currentVal + 1);
            } else {
                alert('재고가 부족합니다. 최대 주문 가능 수량은 ' + maxStock + '개입니다.');
            }
        }
        
        // 총 금액 업데이트
        updateTotalPrice();
    });
    
    /* 수량 직접 입력 시 */
    $('#quantity').on('change input', function() {
        var $input = $(this);
        var currentVal = parseInt($input.val());
        
        // 입력값 유효성 검사
        if(isNaN(currentVal) || currentVal < 1) {
            alert('수량은 1개 이상이어야 합니다.');
            $input.val(1);
        } else if(currentVal > maxStock) {
            alert('재고가 부족합니다. 최대 주문 가능 수량은 ' + maxStock + '개입니다.');
            $input.val(maxStock);
        }
        
        // 총 금액 업데이트
        updateTotalPrice();
    });
    
    /* 총 금액 업데이트 */
    function updateTotalPrice() {
        var quantity = parseInt($('#quantity').val());
        var totalPrice = currentPrice * quantity;
        $('#discountPrice').text(totalPrice.toLocaleString() + '원');
    }
    
    /* 도서 상세 정보 렌더링 */
    function renderBookDetail(data) {
        var book = data.bookDetail;
        var images = data.bookImages;
        maxStock = book.book_stock; // 재고 수량 저장
        
        if(book.category_name1 && book.category_name1 !== '') {
            $('#categoryName1').html(book.category_name1 + '<i class="ti-arrow-right"></i> ');	
        }
        if(book.category_name2 && book.category_name2 !== '') {
            $('#categoryName2').html(book.category_name2 + '<i class="ti-arrow-right"></i> ');	
        }
        if(book.category_name3 && book.category_name3 !== '') {
            $('#categoryName3').text(book.category_name3);
        }
        
        $('#bookTitle').text(book.book_name);
        $('#authorName').text(book.author_name);
        $('#publisher').text(book.publisher);
        $('#publeYear').text(book.puble_year);
        
        // 가격 정보
        var discountRate = book.book_discount;
        var originalPrice = book.book_price;
        currentPrice = Math.floor(originalPrice * (1 - discountRate/100));
        
        // 가격 표시
        $('#discountRate').text(discountRate + '%');
        $('#discountPrice').text(currentPrice.toLocaleString() + '원');
        $('#originalPrice').text(originalPrice.toLocaleString() + '원');
        
        $('#quantity').attr('max', maxStock);
        
        // 도서 소개 및 목차
        $('#bookIntro').html(book.book_intro);
        $('#bookContents').html(book.book_contents);
        
        // 이미지 갤러리 렌더링
        renderImageGallery(images, book.book_name);
    }
    
    /* 이미지 갤러리 렌더링 */
    function renderImageGallery(images, bookName) {
        var $mainImage = $('#mainImage');
        var $thumbnailGallery = $('#thumbnailGallery');
        $thumbnailGallery.empty();
        
        if (images && images.length > 0) {
            // 메인 이미지 설정 (첫 번째 이미지)
            var mainImagePath = '/uploads/' + images[0].upload_path + images[0].saved_name;
            $mainImage.attr('src', mainImagePath).attr('alt', bookName);
            
            // 썸네일 이미지 생성
            images.forEach(function(image, index) {
                var imagePath = '/uploads/' + image.upload_path + image.saved_name;
                var $thumbnail = $('<div>')
                    .addClass('thumbnail-item')
                    .addClass(index === 0 ? 'active' : '')
                    .append($('<img>').attr('src', imagePath).attr('alt', bookName))
                    .attr('data-index', index)
                    .attr('data-path', imagePath);
                    
                $thumbnailGallery.append($thumbnail);
            });
        } else {
            // 기본 이미지 설정
            $mainImage.attr('src', '/resources/images/no-image.jpg').attr('alt', '이미지 없음');
            var $thumbnail = $('<div>')
                .addClass('thumbnail-item active')
                .append($('<img>').attr('src', '/resources/images/no-image.jpg').attr('alt', '이미지 없음'));
            $thumbnailGallery.append($thumbnail);
        }
        
        // 썸네일 클릭 이벤트
        $('.thumbnail-item').on('click', function() {
            var imagePath = $(this).data('path');
            $('#mainImage').attr('src', imagePath);
            $('.thumbnail-item').removeClass('active');
            $(this).addClass('active');
        });
    }
});
</script>
</body>
</html>