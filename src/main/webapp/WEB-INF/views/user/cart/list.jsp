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
    /* 장바구니 스타일 */
    .cart-items {
        margin: 20px 0;
    }
    
    .cart-item {
        border: 1px solid #eee;
        padding: 20px;
        margin-bottom: 20px;
        background: #fff;
        border-radius: 4px;
    }
    
    .cart-item .book-img {
        width: 100%;
        height: 160px;
        object-fit: cover;
        border: 1px solid #ddd;
    }
    
    .cart-info h4 {
        margin: 0 0 10px;
        font-size: 18px;
    }
    
    .cart-price {
        margin: 10px 0;
    }
    
    .discount-rate {
        color: #F7941D;
        font-weight: bold;
        margin-right: 5px;
    }
    
    .final-price {
        font-size: 18px;
        font-weight: bold;
    }
    
    .original-price {
        color: #999;
        text-decoration: line-through;
        margin-left: 5px;
    }
    
    /* 장바구니 선택삭제 영역 스타일 */
	.cart-control {
	    padding: 15px;
	    background: #fff;
	    border: 1px solid #eee;
	    border-radius: 4px;
	    margin-bottom: 20px;
	    display: flex;
	    align-items: center;
	    gap: 15px;
	}
	
	.checkbox {
	    display: flex;
	    align-items: center;
	    gap: 8px;
	    cursor: pointer;
	}
	
	.cart-control .btn-delete {
	    padding: 6px 12px;
	    background: #fff;
	    border: 1px solid #dc3545;
	    color: #dc3545;
	    border-radius: 4px;
	    font-size: 14px;
	}
	
	.cart-control .btn-delete:hover {
	    background: #dc3545;
	    color: #fff;
	}

	/* 수량 선택 스타일 */
	.quantity {
	    display: inline-block;
	}
	
	.quantity .input-group {
		width: 121px;
		display: inline-block;
	}
	
	.quantity .button.minus {
		left:0;
		border-radius:0;
		overflow:hidden;
	}
	
	.quantity .button.plus {
		right: 0;
		border-radius:0;
		overflow:hidden;
	}
	
	.quantity .button {
		position: absolute;
		top: 0;
		display:inline-block;
	}
	
	.quantity .button button {
		padding: 0;
		width: 35px;
		height: 45px;
		line-height: 45px;
		border-radius: 0px;
		background: transparent;
		color: #282828;
		font-size: 12px;
		border: none;
	}

	.quantity .input-number {
		border: 1px solid #ccc;
		border-radius: 6px;
		width: 100%;
		text-align: center;
		height: 45px;
		padding: 0px 38px;
	}
	
	/* 수량 입력창 화살표 제거 */
	.quantity .input-number::-webkit-outer-spin-button,
	.quantity .input-number::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
	
    /* 장바구니 요약 정보 */
    .cart-summary {
        background: #f8f9fa;
        padding: 20px;
        border-radius: 4px;
    }
    
    .cart-summary dl {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    
    .cart-summary .total {
        border-top: 2px solid #333;
        padding-top: 10px;
        margin-top: 10px;
        font-weight: bold;
    }
    
    .cart-summary .total dd {
        color: #F7941D;
        font-size: 24px;
    }
    
    /* 주문 버튼 */
    .order-buttons {
        margin-top: 20px;
        text-align: center;
    }
    
    .btn-order {
        width: 200px;
        height: 50px;
        background: #F7941D;
        color: #fff;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        font-weight: bold;
    }
    
    .btn-order:hover {
        background: #e88a1a;
    }
    
    /* 빈 장바구니 */
    .empty-cart {
        text-align: center;
        padding: 50px 0;
    }
    
    .empty-cart i {
        font-size: 48px;
        color: #ddd;
        margin-bottom: 20px;
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
                        <li class="active">장바구니</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Breadcrumbs -->

<!-- Cart Section -->
<section class="cart-section section">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section-title">
                    <h2>장바구니</h2>
                </div>
            </div>
        </div>
        
        <!-- 장바구니 선택삭제 영역 추가 -->
        <div class="row mb-3">
            <div class="col-12">
                <div class="cart-control">
                    <label class="checkbox">
                        <input type="checkbox" id="checkAll">
                        <span>전체선택</span>
                    </label>
                    <button type="button" class="btn btn-delete" id="btnSelectedDelete">선택삭제</button>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- 장바구니 상품 목록 -->
            <div class="col-lg-8 col-md-12 col-12">
                <div class="cart-items" id="cartList">
                    <!-- 장바구니 목록이 여기에 동적으로 추가됨 -->
                </div>
            </div>

            <!-- 장바구니 요약 -->
            <div class="col-lg-4 col-md-12 col-12">
                <div class="cart-summary">
                    <dl>
                        <dt>상품금액</dt>
                        <dd id="totalPrice">0원</dd>
                    </dl>
                    <dl>
                        <dt>할인금액</dt>
                        <dd id="totalDiscount">0원</dd>
                    </dl>
                    <dl class="total">
                        <dt>결제예정금액</dt>
                        <dd id="finalPrice">0원</dd>
                    </dl>

                    <div class="order-buttons">
                        <button type="button" class="btn btn-order" id="btnOrder">
                            주문하기
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End Cart Section -->

<%@ include file="/WEB-INF/views/common/commonFooter.jsp" %>
<%@ include file="/WEB-INF/views/common/commonJs.jsp" %>

<script>
$(document).ready(function() {
    /* 장바구니 목록 로드 */
    loadCartList();
    
    function loadCartList() {
        $.ajax({
            url: '/api/cart',
            method: 'GET',
            dataType: 'json',		// 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
            success: function(response) {
            	// 장바구니 목록 렌더링
                renderCartList(response);
            	
            	// 전체 금액 계산
                calculateTotalPrice(response);
            },
            error: function(xhr, status, error) {
                console.error("장바구니 목록 로드 실패:", error);
                if(xhr.responseText) {
                    alert(xhr.responseText);
                } else {
                    alert("장바구니 목록을 불러오는데 실패했습니다.");
                }
            }
        });
    }
    
    /* 장바구니 목록 렌더링 */
    function renderCartList(cartList) {
        var html = '';
        
        if(cartList && cartList.length > 0) {
            cartList.forEach(function(item) {
                html += '<div class="cart-item" data-cart-id="' + item.cart_id + '">';
                html += '<div class="row align-items-center">';
                
                // 체크박스 추가
                html += '<div class="col-md-1">';
                html += '<input type="checkbox" class="cart-checkbox" name="cartId" value="' + item.cart_id + '">';
                html += '</div>';
                
                // 상품 이미지
                html += '<div class="col-md-3">';
                html += '<img src="' + (item.upload_path ? '/uploads/' + item.upload_path + "thumb_" + item.saved_name 
                        : '/resources/images/no-image.jpg') + '" class="book-img">';
                html += '</div>';
                
                // 상품 정보
                html += '<div class="col-md-5">';
                html += '<div class="cart-info">';
                html += '<h4>' + item.book_name + '</h4>';
                
                // 가격 정보
                var finalPrice = calculateFinalPrice(item.book_price, item.book_discount);
                html += '<div class="cart-price">';
                if(item.book_discount > 0) {
                    html += '<span class="discount-rate">' + item.book_discount + '%</span>';
                }
                html += '<span class="final-price">' + finalPrice.toLocaleString() + '원</span>';
                if(item.book_discount > 0) {
                    html += '<span class="original-price">' + item.book_price.toLocaleString() + '원</span>';
                }
                html += '</div>';
                html += '</div>';
                html += '</div>';
                
                // 수량 조절
                html += '<div class="col-md-3">';
                html += '<div class="quantity">';
                html += '<div class="input-group">';
                html += '<div class="button minus">';
                html += '<button type="button" class="btn-number" data-type="minus" data-cart-id="' + item.cart_id + '">';
                html += '<i class="ti-minus"></i>';
                html += '</button>';
                html += '</div>';
                
                html += '<input type="number"  value="' + item.cart_count + '" min="1" max="' + item.book_stock 
                        + '" data-cart-id="' + item.cart_id + '" class="input-number">';
                        
                html += '<div class="button plus">';
                html += '<button type="button" class="btn-number" data-type="plus" data-cart-id="' + item.cart_id + '">';
                html += '<i class="ti-plus"></i>';
                html += '</button>';
                html += '</div>';
                html += '</div>';
                html += '</div>';
                html += '</div>';
                
                // 삭제 버튼
//                 html += '<div class="col-md-2 text-right">';
//                 html += '<button type="button" class="btn btn-remove" data-cart-id="' + item.cart_id + '">';
//                 html += '<i class="ti-close"></i>';
//                 html += '</button>';
//                 html += '</div>';
                
                html += '</div>';
                html += '</div>';
            });
        } else {
            html = '<div class="empty-cart">';
            html += '<i class="ti-shopping-cart"></i>';
            html += '<p>장바구니가 비어있습니다.</p>';
            html += '</div>';
        }
        
        $('#cartList').html(html);
    }
    
    /* 최종 가격 계산 */
    function calculateFinalPrice(price, discount) {
        return Math.floor(price * (1 - discount/100));
    }
    
    /* 전체 금액 계산 */
    function calculateTotalPrice(cartList) {
        var totalPrice = 0;		// 상품금액
        var totalDiscount = 0;	// 할인금액
        var finalPrice = 0;		// 결제금액
        
        cartList.forEach(function(item) {
            var itemTotalPrice = item.book_price * item.cart_count;
            var itemFinalPrice = calculateFinalPrice(item.book_price, item.book_discount) * item.cart_count;
            
            totalPrice += itemTotalPrice;
            totalDiscount += (itemTotalPrice - itemFinalPrice);
            finalPrice += itemFinalPrice;
        });
        
        $('#totalPrice').text(totalPrice.toLocaleString() + '원');
        $('#totalDiscount').text('-' + totalDiscount.toLocaleString() + '원');
        $('#finalPrice').text(finalPrice.toLocaleString() + '원');
    }
    
    /* 수량 변경 이벤트 */
    $(document).on('click', '.btn-number', function() {
        var type = $(this).data('type'); // minus, plus
        var cartId = $(this).data('cart-id');
        var $input = $('input[data-cart-id="' + cartId + '"]');
        var currentVal = parseInt($input.val());
        var maxValue = parseInt($input.attr('max'));
        
        // 입력값이 없으면 1로 설정
        if(isNaN(currentVal)) {
            $input.val(1);
            updateCartCount(cartId, 1);
            return;
        }

        if(type === 'minus') {
            // 최소 수량은 1
            if(currentVal > 1) {
                $input.val(currentVal - 1);
                updateCartCount(cartId, currentVal - 1);
            }
        } else if(type === 'plus') {
            // 재고 체크
            if(currentVal < maxValue) {
                $input.val(currentVal + 1);
                updateCartCount(cartId, currentVal + 1);
            } else {
                alert('재고가 부족합니다. 최대 주문 가능 수량은 ' + maxValue + '개입니다.');
            }
        }
    });
    
    /* 수량 직접 입력 이벤트 */
    $(document).on('change', '.quantity input', function() {
        var $input = $(this);
        var cartId = $input.data('cart-id');
        var currentVal = parseInt($input.val());
        var maxValue = parseInt($input.attr('max'));
        
        // 입력값 유효성 검사
        if(isNaN(currentVal) || currentVal < 1) {
            alert('수량은 1개 이상이어야 합니다.');
            $input.val(1);
            currentVal = 1;
        } else if(currentVal > maxValue) {
            alert('재고가 부족합니다. 최대 주문 가능 수량은 ' + maxValue + '개입니다.');
            $input.val(maxValue);
            currentVal = maxValue;
        }
        updateCartCount(cartId, currentVal);
    });
    
    /* 장바구니 수량 업데이트 */
    function updateCartCount(cartId, count) {
        $.ajax({
            url: '/api/cart/' + cartId + '?count=' + count,
            method: 'PUT',
            success: function() {
                loadCartList();
            },
            error: function(xhr, status, error) {
                console.error("수량 변경 실패:", error);
                if(xhr.responseText) {
                    alert(xhr.responseText);
                } else {
                    alert("수량 변경에 실패했습니다.");
                }
                loadCartList();
            }
        });
    }
    
    /* 전체 선택 체크박스 이벤트 */
    $('#checkAll').on('change', function() {
        var isChecked = $(this).prop('checked');
        $('.cart-checkbox').prop('checked', isChecked);
    });
    
    /* 개별 체크박스 이벤트 */
    $(document).on('change', '.cart-checkbox', function() {
        var totalCheckboxes = $('.cart-checkbox').length; // 전체 장바구니 목록 체크박스 개수
        var checkedCheckboxes = $('.cart-checkbox:checked').length; // 체크된 장바구니 목록 체크박스 개수
        
        $('#checkAll').prop('checked', totalCheckboxes === checkedCheckboxes);
    });
    
    /* 선택 삭제 버튼 클릭 */
    $('#btnSelectedDelete').on('click', function() {
        var selectedItems = $('.cart-checkbox:checked');
        if(selectedItems.length === 0) {
            alert('삭제할 상품을 선택해주세요.');
            return;
        }
        
        if(confirm('선택하신 ' + selectedItems.length + '개의 상품을 삭제하시겠습니까?')) {
            var cartIds = [];
            selectedItems.each(function() {
                cartIds.push($(this).val());
            });
            
            $.ajax({
                url: '/api/cart/selected',
                method: 'DELETE',
                contentType: 'application/json',	// 콘텐츠 타입을 JSON으로 설정 - 클라이언트(브라우저)에서 서버로 보내는 데이터의 형식	
                data: JSON.stringify(cartIds),		// 직렬화된 데이터를 JSON 형식으로 변환
                success: function() {
                    alert('선택하신 상품이 삭제되었습니다.');
                    loadCartList();
                },
                error: function(xhr) {
                    if(xhr.responseText) {
                        alert(xhr.responseText);
                    } else {
                        alert('상품 삭제에 실패했습니다.');
                    }
                }
            });
        }
    });
    
    /* 주문하기 버튼 클릭 */
    $('#btnOrder').on('click', function() {
        // TODO: 주문 페이지로 이동
        alert('주문 기능은 준비중입니다.');
    });
});
</script>
</body>
</html>