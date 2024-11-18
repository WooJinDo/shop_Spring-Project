<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<style>
	.header.shop .logo {
		margin: 0px;
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
	<div class="middle-inner">
		<div class="container" style="max-width: 100%; border-bottom: 1px solid;">
			<div class="row">
				<div class="col-lg-2 col-md-2 col-12" style="flex: 0 0 10%; max-width: 10%;">
					<!-- Logo -->
					<div class="logo">
						<a href="/admin/member/list"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo"></a>
					</div>
					<!--/ End Logo -->
				</div>
				<div class="col-lg-8 col-md-7 col-12" style="flex: 0 0 50%; max-width: 50%;">
					<div class="cat-nav-head">
						<div class="row">
							<div class="col-12">
								<div class="menu-area">
									<!-- Main Menu -->
									<nav class="navbar navbar-expand-lg">
										<div class="navbar-collapse">	
											<div class="nav-inner">	
												<ul class="nav main-menu menu navbar-nav">
													<li style="margin:0px 15px;"><a href="/admin/member/list" style="font-size: large; font-weight: bold;">회원관리</a></li>												
													<li style="margin:0px 15px;"><a href="/admin/book/list" style="font-size: large; font-weight: bold;">상품<i class="ti-angle-down"></i></a>
														<ul class="dropdown">
															<li><a href="/admin/book/list">상품 관리</a></li>
															<li><a href="/admin/book/add">상품 등록</a></li>
														</ul>
													</li>
													<li style="margin:0px 15px;"><a href="/admin/author/list" style="font-size: large; font-weight: bold;">작가<i class="ti-angle-down"></i></a>
														<ul class="dropdown">
															<li><a href="/admin/author/list">작가 관리</a></li>
															<li><a href="/admin/author/add">작가 등록</a></li>
														</ul>
													</li>
													<li style="margin:0px 15px;"><a href="/admin/order/list" style="font-size: large; font-weight: bold;">주문현황</a></li>									
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
				<div class="col-lg-2 col-md-3 col-12" style="flex: 0 0 30%; max-width: 30%;">
					<div class="right-content">
						<ul class="list-main">
							<li><i class="ti-shift-left"></i> <a href="/">메인페이지 이동</a></li>
							<li><i class="ti-unlock"></i> <a href="/member/logout">로그아웃</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<!--/ End Header -->
	
</html>
	
	