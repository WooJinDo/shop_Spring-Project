<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE HTML>
<html>
<style>
	/* 한글 폰트 적용 */
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');
	/* 전체 사이트 기본 폰트 설정 */
	* {
	    font-family: 'Noto Sans KR', sans-serif;
	    word-break: keep-all; /* 단어 단위로 줄바꿈 */
	    letter-spacing: -0.3px; /* 자간 설정 */
	}
	
	/* 메인 메뉴 스타일 개선 */
	.header.shop .nav-inner .main-menu > li > a {
	    color: #333;
	    font-size: 16px;
	    font-weight: 500;
	    padding: 15px 20px;
	    position: relative;
	    transition: all 0.3s ease;
	}
	
	/* 드롭다운 메뉴 스타일 */
	.header.shop .nav-inner .dropdown {
	    background: #fff;
	    border-radius: 3px;
	    box-shadow: 0 0 5px rgba(0,0,0,0.1);
	}
	
	.header.shop .nav-inner .dropdown li a {
	    color: #666;
	    font-size: 14px;
	    font-weight: 400;
	    padding: 10px 20px;
	    transition: all 0.3s ease;
	}
	
	.header.shop .nav-inner .dropdown li a:hover {
	    color: #ff4444;
	    background: #f8f9fa;
	}
	
	/* 활성 메뉴 스타일 */
	.header.shop .nav-inner .main-menu > li:hover > a,
	.header.shop .nav-inner .main-menu > li.active > a {
	    color: #ff4444;
	}
	
	/* 구분선 */
	.header.shop .nav-inner .main-menu > li:not(:last-child) {
	    border-right: 1px solid #eee;
	}
	
	.header.shop .nice-select .list {
    	width: 150px;
	}
</style>


<!-- Preloader -->
<div class="preloader">
	<div class="preloader-inner">
		<div class="preloader-icon">
			<span></span>
			<span></span>
		</div>
	</div>
</div>
<!-- End Preloader -->

<!-- Header -->
<header class="header shop v2">
	<!-- Topbar -->
	<div class="topbar">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-md-12 col-12">
					<!-- Top Left -->
					<div class="top-left">
						<ul class="list-main">
							<li><i class="ti-headphone-alt"></i> 1588-1234</li>
							<li><i class="ti-email"></i> book@shop.com</li>
						</ul>
					</div>
					<!--/ End Top Left -->
				</div>
				<div class="col-lg-8 col-md-12 col-12">
					<!-- Top Right -->
					<div class="right-content">
						<ul class="list-main">
							<!-- <li><i class="ti-location-pin"></i> Store location</li> -->
							<!-- <li><i class="ti-alarm-clock"></i> <a href="#">Daily deal</a></li> -->
							<c:choose>
								<c:when test="${empty sessionScope.userId}">
									<!-- 로그인하지 않은 메뉴들 -->
									<li><i class="ti-power-off"></i><a href="/member/login">로그인</a></li>
									<li><i class="ti-plus"></i><a href="/member/register">회원가입</a></li>
								</c:when>
								<c:otherwise>
									<!-- 로그인한 메뉴들 -->
									<c:if test="${sessionScope.role eq 'USER' || sessionScope.role eq 'ADMIN'}">
										<li><i class="fa fa-heart-o" aria-hidden="true"></i> <a class="ready" href="#">찜한상품</a></li>
										<li><i class="fa fa-user-circle-o" aria-hidden="true"></i> <a class="ready" href="#">내 정보</a></li>
										<li><i class="ti-bag"></i> <a href="/user/cart/list">장바구니</a></li>
									</c:if>
									
									<c:if test="${sessionScope.role eq 'ADMIN'}">
										<li><i class="ti-shift-left"></i> <a href="/admin/member/list">관리자페이지 이동</a></li>
									</c:if>
									
									<li><i class="ti-unlock"></i> <a href="/member/logout">로그아웃</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
					<!-- End Top Right -->
				</div>
			</div>
		</div>
	</div>
	<!-- End Topbar -->
	<div class="middle-inner">
		<div class="container">
			<div class="row">
				<div class="col-lg-2 col-md-2 col-12">
					<!-- Logo -->
					<div class="logo">
						<a href="/"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo"></a>
					</div>
					<!--/ End Logo -->
				</div>
				<div class="col-lg-8 col-md-7 col-12">
					<div class="search-bar-top">
						<div class="search-bar">
							<select id="searchType" name="searchType">
								<option value="all">통합검색</option>
								<option value="bookName">책 제목</option>
								<option value="authorName">작가</option>
							</select>
							<form id="searchForm">
								<input name="keyword" placeholder="검색어를 입력해주세요." type="search">
								<button class="btnn"><i class="ti-search"></i></button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Header Inner -->
	<div class="authorList">
		<div class="container">
			<div class="cat-nav-head">
				<div class="row">
					<div class="col-12">
						<div class="menu-area">
							<!-- Main Menu -->
							<nav class="navbar navbar-expand-lg">
							    <div class="navbar-collapse">    
							        <div class="nav-inner">    
							            <ul class="nav main-menu menu navbar-nav">
							                <li><a href="/book/list">전체도서</a></li>
							                <li><a class="ready" href="#">테스트1<span class="new">New</span></a></li><!-- 신간도서 -->
							                <li><a class="ready" href="#">테스트2</a></li><!-- 베스트셀러 -->
							                <li><a class="ready" href="#">테스트3</a></li><!-- 특가할인 -->
							                <li><a class="ready" href="#">테스트4</a></li><!-- 이벤트 -->
							                <li><a class="ready" href="#">테스트5<i class="ti-angle-down"></i></a><!-- 고객센터 -->
							                    <ul class="dropdown">
							                        <li><a class="ready" href="#">공지사항</a></li>
							                        <li><a class="ready" href="#">자주묻는질문</a></li>
							                        <li><a class="ready" href="#">1:1문의</a></li>
							                    </ul>
							                </li>
							            </ul>
							        </div>
							    </div>
							</nav>
							<!--/ End Main Menu -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/ End Header Inner -->
</header>
<!--/ End Header -->
<%@ include file="/WEB-INF/views/common/commonJs.jsp" %>	
<script>
$(document).ready(function() {
    /* URL에서 파라미터 가져오기 */
    function getUrlParameters() {
        var urlParams = new URLSearchParams(window.location.search);
        return {
            searchType: urlParams.get('searchType') || 'all',
         	// 인코딩된 문자열을 다시 원래의 형태로 변환
         	// 이를 화면에 표시하거나 다시 사용할 때는 원래 형태로 디코딩해야 함
            keyword: urlParams.get('keyword') ? decodeURIComponent(urlParams.get('keyword')) : ''
        };
    }

    /* 페이지 로드시 검색 폼 초기화 */
    function initializeSearchForm() {
        var params = getUrlParameters();
        $('#searchType').val(params.searchType);
        $('input[name="keyword"]').val(params.keyword); 
        $('#searchType').niceSelect('update');
    }

    /* 초기화 함수 호출 */
    initializeSearchForm();

    /* 검색 폼 제출 이벤트 처리 */
    $('#searchForm').on('submit', function(e) {
        e.preventDefault();
        
        var searchType = $('#searchType').val();
        var keyword = $('input[name="keyword"]').val().trim();
        
        if(!keyword) {
            alert("검색어를 입력해주세요");
            return false;
        }

        window.location.href = '/book/list?searchType=' + searchType + '&keyword=' + encodeURIComponent(keyword);
    });
    
	// 준비 안된 기능 클릭 이벤트
	$('.ready').on('click', function() {
		event.preventDefault(); // 기본 동작 방지 (페이지 이동)
	    alert('해당 기능은 준비중입니다.');
	});
	
});
</script>
</html>
	
	