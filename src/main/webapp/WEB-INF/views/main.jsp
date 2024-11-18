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
	.carousel-indicators li {
       cursor: pointer;
      }
      
      .carousel-inner .carousel-item img {
      	height: 500px;
      	object-fit: cover;
      }
	</style>
</head>
<body class="js">
<%@ include file="/WEB-INF/views/common/commonHeader.jsp" %>
	
	<!-- Start Area 2 -->
	<section class="hero-area2">
		<!-- 배너 -->
	    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
	      <ol class="carousel-indicators">
	        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
	        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
	        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
	      </ol>
	      <div class="carousel-inner">
	        <div class="carousel-item active">
	          <img src="${pageContext.request.contextPath}/resources/images/background1.jpg" class="d-block w-100" alt="...">
	        </div>
	        <div class="carousel-item">
	          <img src="${pageContext.request.contextPath}/resources/images/background2.jpg" class="d-block w-100" alt="...">
	        </div>
	        <div class="carousel-item">
	          <img src="${pageContext.request.contextPath}/resources/images/background3.jpg" class="d-block w-100" alt="...">
	        </div>
	      </div>
	      <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
	        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	        <span class="sr-only">Previous</span>
	      </a>
	      <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
	        <span class="carousel-control-next-icon" aria-hidden="true"></span>
	        <span class="sr-only">Next</span>
	      </a>
	    </div>
	</section>
	<!--/ End Hero Area 2 -->
	
	<!-- Start Product Area -->
    <div class="product-area section">
            <div class="container">
				<div class="row">
					<div class="col-12">
						<div class="section-title">
							<h2>많이 보고 있는 상품</h2>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<div class="product-info">
							<div class="nav-main">
								<!-- Tab Nav -->
								<ul class="nav nav-tabs" id="myTab" role="tablist">
									<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#domestic" role="tab">국내도서</a></li>
									<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#overseas" role="tab">국외도서</a></li>
								</ul>
								<!--/ End Tab Nav -->
							</div>
							<div class="tab-content" id="myTabContent">
								<!-- Start Single Tab -->
								<div class="tab-pane fade show active" id="domestic" role="tabpanel">
									<div class="tab-single">
										<div class="row">
											<div class="col-xl-3 col-lg-4 col-md-4 col-12">
												<div class="single-product">
													<div class="product-img">
														<a href="#" class="ready">
															<img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
														</a>
														<div class="button-head">
															<div class="product-action">
																<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
																<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
																<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
															</div>
															<div class="product-action-2">
																<a title="Add to cart" href="#" class="ready">Add to cart</a>
															</div>
														</div>
													</div>
													<div class="product-content">
														<h3><a class="ready" href="#">테스트1</a></h3>
														<div class="product-price">
															<span>$29.00</span>
														</div>
													</div>
												</div>
											</div>
											<div class="col-xl-3 col-lg-4 col-md-4 col-12">
												<div class="single-product">
													<div class="product-img">
														<a class="ready" href="#">
															<img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<span class="new">New</span>
														</a>
														<div class="button-head">
															<div class="product-action">
																<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
																<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
																<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
															</div>
															<div class="product-action-2">
																<a class="ready" title="Add to cart" href="#">Add to cart</a>
															</div>
														</div>
													</div>
													<div class="product-content">
														<h3><a class="ready" href="#">테스트2</a></h3>
														<div class="product-price">
															<span>$29.00</span>
														</div>
													</div>
												</div>
											</div>
											<div class="col-xl-3 col-lg-4 col-md-4 col-12">
												<div class="single-product">
													<div class="product-img">
														<a class="ready" href="#">
															<img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<span class="price-dec">30% Off</span>
														</a>
														<div class="button-head">
															<div class="product-action">
																<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
																<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
																<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
															</div>
															<div class="product-action-2">
																<a class="ready" title="Add to cart" href="#">Add to cart</a>
															</div>
														</div>
													</div>
													<div class="product-content">
														<h3><a class="ready" href="#">테스트3</a></h3>
														<div class="product-price">
															<span>$29.00</span>
														</div>
													</div>
												</div>
											</div>
											<div class="col-xl-3 col-lg-4 col-md-4 col-12">
												<div class="single-product">
													<div class="product-img">
														<a class="ready" href="#">
															<img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<span class="out-of-stock">Hot</span>
														</a>
														<div class="button-head">
															<div class="product-action">
																<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
																<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
																<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
															</div>
															<div class="product-action-2">
																<a class="ready" title="Add to cart" href="#">Add to cart</a>
															</div>
														</div>
													</div>
													<div class="product-content">
														<h3><a class="ready" href="#">테스트4</a></h3>
														<div class="product-price">
															<span class="old">$60.00</span>
															<span>$50.00</span>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--/ End Single Tab -->
								<!-- Start Single Tab -->
								<div class="tab-pane fade" id="overseas" role="tabpanel">
									<div class="tab-single">
										<div class="row">
											<div class="col-xl-3 col-lg-4 col-md-4 col-12">
												<div class="single-product">
													<div class="product-img">
														<a class="ready" href="#">
															<img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
														</a>
														<div class="button-head">
															<div class="product-action">
																<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
																<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
																<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
															</div>
															<div class="product-action-2">
																<a class="ready" title="Add to cart" href="#">Add to cart</a>
															</div>
														</div>
													</div>
													<div class="product-content">
														<h3><a class="ready" href="#">테스트1</a></h3>
														<div class="product-price">
															<span>$29.00</span>
														</div>
													</div>
												</div>
											</div>
											<div class="col-xl-3 col-lg-4 col-md-4 col-12">
												<div class="single-product">
													<div class="product-img">
														<a class="ready" href="#">
															<img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
														</a>
														<div class="button-head">
															<div class="product-action">
																<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
																<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
																<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
															</div>
															<div class="product-action-2">
																<a class="ready" title="Add to cart" href="#">Add to cart</a>
															</div>
														</div>
													</div>
													<div class="product-content">
														<h3><a class="ready" href="#">테스트2</a></h3>
														<div class="product-price">
															<span>$29.00</span>
														</div>
													</div>
												</div>
											</div>
											<div class="col-xl-3 col-lg-4 col-md-4 col-12">
												<div class="single-product">
													<div class="product-img">
														<a class="ready" href="#">
															<img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
														</a>
														<div class="button-head">
															<div class="product-action">
																<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
																<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
																<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
															</div>
															<div class="product-action-2">
																<a class="ready" title="Add to cart" href="#">Add to cart</a>
															</div>
														</div>
													</div>
													<div class="product-content">
														<h3><a class="ready" href="#">테스트3</a></h3>
														<div class="product-price">
															<span>$29.00</span>
														</div>
													</div>
												</div>
											</div>
											<div class="col-xl-3 col-lg-4 col-md-4 col-12">
												<div class="single-product">
													<div class="product-img">
														<a class="ready" href="#">
															<img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
															<span class="new">New</span>
														</a>
														<div class="button-head">
															<div class="product-action">
																<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
																<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
																<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
															</div>
															<div class="product-action-2">
																<a class="ready" title="Add to cart" href="#">Add to cart</a>
															</div>
														</div>
													</div>
													<div class="product-content">
														<h3><a class="ready" href="#">테스트4</a></h3>
														<div class="product-price">
															<span>$29.00</span>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--/ End Single Tab -->
							</div>
						</div>
					</div>
				</div>
            </div>
    </div>
	<!-- End Product Area -->
	
	<!-- Start Most Popular -->
	<div class="product-area most-popular section">
        <div class="container">
            <div class="row">
				<div class="col-12">
					<div class="section-title">
						<h2>화제의 신상</h2>
					</div>
				</div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="owl-carousel popular-slider">
						<!-- Start Single Product -->
						<div class="single-product test1">
							<div class="product-img">
								<a class="ready" href="#">
									<img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
									<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
									<span class="out-of-stock">Hot</span>
								</a>
								<div class="button-head">
									<div class="product-action">
										<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
										<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
										<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
									</div>
									<div class="product-action-2">
										<a class="ready" title="Add to cart" href="#">Add to cart</a>
									</div>
								</div>
							</div>
							<div class="product-content">
								<h3><a class="ready" href="#">테스트1</a></h3>
								<div class="product-price">
									<span class="old">$60.00</span>
									<span>$50.00</span>
								</div>
							</div>
						</div>
						<!-- End Single Product -->
						<!-- Start Single Product -->
						<div class="single-product test2">
                            <div class="product-img">
                                <a class="ready" href="#">
                                    <img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
									<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
                                </a>
								<div class="button-head">
									<div class="product-action">
										<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
										<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
										<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
									</div>
									<div class="product-action-2">
										<a class="ready" title="Add to cart" href="#">Add to cart</a>
									</div>
								</div>
                            </div>
                            <div class="product-content">
                                <h3><a class="ready" href="#">테스트2</a></h3>
                                <div class="product-price">
                                    <span>$50.00</span>
                                </div>
                            </div>
                        </div>
						<!-- End Single Product -->
						<!-- Start Single Product -->
						<div class="single-product test3">
                            <div class="product-img">
                                <a class="ready" href="#">
                                    <img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
									<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
									<span class="new">New</span>
                                </a>
								<div class="button-head">
									<div class="product-action">
										<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
										<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
										<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
									</div>
									<div class="product-action-2">
										<a class="ready" title="Add to cart" href="#">Add to cart</a>
									</div>
								</div>
                            </div>
                            <div class="product-content">
                                <h3><a class="ready" href="#">테스트3</a></h3>
                                <div class="product-price">
                                    <span>$50.00</span>
                                </div>
                            </div>
                        </div>
						<!-- End Single Product -->
						<!-- Start Single Product -->
						<div class="single-product test4">
                            <div class="product-img">
                                <a class="ready" href="#">
                                    <img class="default-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
									<img class="hover-img" src="${pageContext.request.contextPath}/resources/images/no-image.jpg" alt="#">
                                </a>
								<div class="button-head">
									<div class="product-action">
										<a class="ready" data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
										<a class="ready" title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
										<a class="ready" title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
									</div>
									<div class="product-action-2">
										<a class="ready" title="Add to cart" href="#">Add to cart</a>
									</div>
								</div>
                            </div>
                            <div class="product-content">
                                <h3><a class="ready" href="#">테스트4</a></h3>
                                <div class="product-price">
                                    <span>$50.00</span>
                                </div>
                            </div>
                        </div>
						<!-- End Single Product -->
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- End Most Popular Area -->
	
	
<%@ include file="/WEB-INF/views/common/commonFooter.jsp" %>

</body>
</html>
