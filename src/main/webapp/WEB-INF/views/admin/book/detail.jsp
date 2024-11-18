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
	.category-info {
	    padding: 8px;
	    background-color: #f8f9fa;
	    border-radius: 4px;
	}
	
	/* 이지지관련 css */
	.image-preview-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    margin-top: 10px;
	}
	
	.preview-item {
	    position: relative;
	    width: 200px;
	    height: 200px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    overflow: hidden;
	}
	
	.preview-item img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	
	.thumbnail-badge {
	    position: absolute;
	    top: 10px;
	    left: 10px;
	    background: #4CAF50;
	    color: white;
	    padding: 2px 8px;
	    border-radius: 3px;
	    font-size: 12px;
	}
	
	.file-list-container {
	    margin-top: 20px;
	}
	
	.file-list-container table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	.file-list-container th,
	.file-list-container td {
	    padding: 12px;
	    border: 1px solid #ddd;
	    text-align: center;
	}
	
	.file-list-container th {
	    background-color: #f8f9fa;
	}
	
	.download-link {
	    color: #007bff;
	    text-decoration: none;
	}
	
	.download-link:hover {
	    text-decoration: underline;
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
						<h2 style="padding-bottom: 20px;">상품 상세</h2>
						</div>
							<div class="form-main">
								<!-- Form -->
								<form id="detailForm" class="form">
								<div class="row">
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>상품명<span>*</span></label>
											<input type="text" id="bookName" disabled="disabled" placeholder="" >
										</div>
									</div>
								
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label style="display: block; float: left;">작가 이름<span>*</span></label>
											<input type="text" id="authorName" disabled="disabled" placeholder="" > 
										</div>
									</div>
									
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>카테고리<span>*</span></label>
											<div class="form-group" style="margin-bottom: 0px;">
												<div class="category-info">
												    <span id="category1"></span>
												    <span> > </span>
												    <span id="category2"></span>
												    <span> > </span>
												    <span id="category3"></span>
												</div>
											</div>
										</div>
									</div>
								
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>출판일<span>*</span></label>
											<input type="text" id="publeYear" disabled="disabled" placeholder="" >
										</div>
									</div>
								
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label style="display: block; float: left;">출판사<span>*</span></label>
											<input type="text" id="publisher" disabled="disabled" placeholder="" > 
										</div>
									</div>
									
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>상품 가격<span>*</span></label>
											<input type="text" id="bookPrice" disabled="disabled" placeholder="" >
										</div>
									</div>
								
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label style="display: block; float: left;">상품 재고<span>*</span></label>
											<input type="text" id="bookStock" disabled="disabled" placeholder="" > 
										</div>
									</div>
									
									<div class="col-lg-6 col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>상품 할인율(%)<span>*</span></label>
											<input type="text" id="bookDiscount" disabled="disabled" placeholder="" >
										</div>
									</div>
								
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group message" style="margin-bottom: 0px;">
											<label>상품 내용<span>*</span></label>
											<textarea id="bookContents" placeholder="" ></textarea>
										</div>
									</div>
									
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group message" style="margin-bottom: 0px;">
											<label>상품 소개<span>*</span></label>
											<textarea id="bookIntro" placeholder="" ></textarea>
										</div>
									</div>
																		
									<div class="col-12" style="margin-bottom: 20px;">
								    	<div class="form-group" style="margin-bottom: 0px;">
									        <label>상품 이미지<span>*</span></label>
									        <div id="imagePreview" class="image-preview-container">
									            <!-- 이미지들이 여기에 동적으로 추가됩니다 -->
									        </div>
									    </div>
									</div>
									
									<div class="col-12">
									    <div class="file-list-container">
									    	<h4>첨부된 이미지 목록</h4>
									        <table class="table">
									            <thead>
									                <tr>
									                    <th>No.</th>
									                    <th>파일명</th>
									                    <th>등록일</th>
									                    <th>다운로드</th>
									                </tr>
									            </thead>
									            <tbody id="fileList">
									                <!-- 파일 목록이 여기에 동적으로 추가됩니다 -->
									            </tbody>
									        </table>
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
											<button id="btn_delete" class="btn" type="button" style="float: right;" >삭제</button>
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
<script type="importmap">
{
    "imports": {
        "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/43.3.0/ckeditor5.js",
        "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/43.3.0/",
        "customEditor": "${pageContext.request.contextPath}/resources/js/custom-ekeditor5.js"
    }
}
</script>
<script type="module">
import * as customEditor from 'customEditor';

/* 위지윅 ckeditor 적용 */
customEditor.ClassicEditor
	.create(document.querySelector('#bookContents'), customEditor.editorConfig)
	.then(editor => {
		console.log('Editor 초기화', editor);
		window.editor2 = editor;
		editor.enableReadOnlyMode( 'my-feature-id' );	// 읽기 전용 설정
		//editor.disableReadOnlyMode( 'my-other-feature-id' ); // 읽기 전용 해제
	})
	.catch(error => {
		console.error('CKEditor 초기화 실패:', error);
	});

customEditor.ClassicEditor
	.create(document.querySelector('#bookIntro'), customEditor.editorConfig)
	.then(editor => {
		console.log('Editor 초기화', editor);
		window.editor = editor;	// 전역 변수 설정
		editor.enableReadOnlyMode( 'my-feature-id' );	// 읽기 전용 설정
		//editor.disableReadOnlyMode( 'my-other-feature-id' ); // 읽기 전용 해제
	})
	.catch(error => {
		console.error('CKEditor 초기화 실패:', error);
	});
</script>
<script>
$(document).ready(function() {
	var book_id = '<c:out value= "${book_id}" />';
	
	/* 게시글 상세 조회 시작 */
	bookDetail();
	
	/* 게시글 상세 조회 */
	function bookDetail() {
	    $.ajax({
	        url: '/api/book/' + book_id,
	        method: 'GET',
	        dataType: "json",                     // 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
	        success: function(response) {
	        	var bookDetail = response.bookDetail;
	            var bookImages = response.bookImages;
	            
	        	$('#bookName').val(bookDetail.book_name);
	        	$('#authorName').val(bookDetail.author_name);
	        	$('#publeYear').val(bookDetail.puble_year);
	        	$('#publisher').val(bookDetail.publisher);
	        	$('#bookPrice').val(bookDetail.book_price.toLocaleString() + "원");
	        	$('#bookStock').val(bookDetail.book_stock + "개");
	        	$('#bookDiscount').val(bookDetail.book_discount + "%");
// 	        	$('#bookIntro').val(bookDetail.book_intro);
// 	        	$('#bookContents').val(bookDetail.book_contents);
	        	$('#regDate').val(bookDetail.reg_date);
	        	$('#updateDate').val(bookDetail.update_date);
	        	
	        	 // 카테고리 초기화 추가
	            initializeDetailCategory(bookDetail.category_code);
	        	
	        	 // CKEditor 내용 설정(이미 초기화된 에디터가 있다면 데이터 설정)
				if(window.editor2) {
					window.editor2.setData(bookDetail.book_contents || "");	
				}
				if(window.editor) {
					window.editor.setData(bookDetail.book_intro || "");
				}
				
				// 첨부된 이미지 파일 표시
				displayProductImages(bookImages);
				
    		},
			error: function(xhr, status, error) { // 실패 시 실행되는 함수
				console.error("상세조회 실패: " + status + ", " + error);     // 에러 처리
				alert("상세 조회에 실패하였습니다.");
			}
	    });
	}
	
	/* 이미지와 파일 목록 표시 함수 */
	function displayProductImages(bookImages) {
	    var imagesHtml = '';
	    var fileListHtml = '';
	    var validImageCount = 0;  // 유효한 이미지 카운트
	    
	    if (bookImages && bookImages.length > 0) {
	        // 이미지 미리보기 생성
	        bookImages.forEach((img, index) => {
	        	if (img.is_deleted !== 'Y') {  // 삭제되지 않은 이미지만 처리
	        		validImageCount++;
		        	imagesHtml += '<div class="preview-item">'
		        	imagesHtml += '<img src="/uploads/' + img.upload_path + img.saved_name + '" alt="' + img.original_name + '">'
		        			+ (img.is_thumbnail === 'Y' ? '<div class="thumbnail-badge">대표이미지</div>' : '');
		        	imagesHtml += '</div>';
		        		
		            // 파일 목록 생성
		            fileListHtml += '<tr>';
		            fileListHtml += '<td>' + validImageCount + '</td>';
		            fileListHtml += '<td>' + img.original_name + '</td>';
		            fileListHtml += '<td>' + img.reg_date + '</td>';
		            fileListHtml += '<td><a href="/api/download/' + img.image_id + '" class="download-link">다운로드</a></td>';
		            fileListHtml += '</tr>';
	        	}
	        });
	    } else {
	        imagesHtml = '<p>등록된 이미지가 없습니다.</p>';
	        fileListHtml = '<tr><td colspan="4">등록된 파일이 없습니다.</td></tr>';
	    }
	    
	    $('#imagePreview').html(imagesHtml);
	    $('#fileList').html(fileListHtml);
	}
	
	
    /* 전역 변수로 카테고리 배열과 선택된 카테고리 코드 저장 */
    var categoryData = []; // 초기 한 번만 전체 데이터를 로드하고 이후에는 클라이언트단에서 필터링하여 처리하기 위해
    var selectedCategory = {
        tier1Code: '',   // 대분류 코드
        tier2Code: '',   // 중분류 코드
        tier3Code: ''    // 소분류 코드
    };

    /* 상세 페이지 로드 시 카테고리 정보 초기화 */
    function initializeDetailCategory(categoryCode) {
        $.ajax({
            url: '/api/book/category',
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                if(response.length > 0) {
                    categoryData = response; // 전역 변수에 저장
                    if(categoryCode) {
                        // 선택된 카테고리 코드로부터 계층 구조 파싱
                        parseSelectedCategory(categoryCode);	// 소분류 카테고리 코드
                        // 카테고리 렌더링
                        renderDetailCategories();
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error("카테고리 데이터 로드 실패: " + status + ", " + error);
			  	if(xhr.responseText) {
			  		alert(xhr.responseText);
			  	} else {
			  		alert("카테고리 정보를 불러오는데 실패했습니다.");
			  	}
            }
        });
    }

    /* 선택된 카테고리 코드로부터 계층 구조 파싱 */
    function parseSelectedCategory(categoryCode) {
        // 선택된 카테고리 찾기
        var selectedItem = findCategoryByCode(categoryCode);
        if (!selectedItem) {
        	return;
        }

        // 선택된 카테고리의 tier에 따라 처리
        switch(selectedItem.tier) {
            case 3: // 소분류인 경우
                selectedCategory.tier3Code = selectedItem.category_code;
                // 부모 카테고리(중분류) 찾기
                var parentItem = findCategoryByCode(selectedItem.category_parent_code);
                if (parentItem) {
                    selectedCategory.tier2Code = parentItem.category_code;
                    // 조부모 카테고리(대분류) 찾기
                    var grandParentItem = findCategoryByCode(parentItem.category_parent_code);
                    if (grandParentItem) {
                        selectedCategory.tier1Code = grandParentItem.category_code;
                    }
                }
                break;
                
            case 2: // 중분류인 경우
                selectedCategory.tier2Code = selectedItem.category_code;
                // 부모 카테고리(대분류) 찾기
                var parentItem = findCategoryByCode(selectedItem.category_parent_code);
                if (parentItem) {
                    selectedCategory.tier1Code = parentItem.category_code;
                }
                break;
                
            case 1: // 대분류인 경우
                selectedCategory.tier1Code = selectedItem.category_code;
                break;
        }
    }
    
    /* 카테고리 코드로 카테고리 찾기 */
    function findCategoryByCode(categoryCode) {
        for (var i = 0; i < categoryData.length; i++) {
            if (categoryData[i].category_code === categoryCode) {
                return categoryData[i];
            }
        }
        return null;
    }

    /* 카테고리 텍스트로 렌더링 */
    function renderDetailCategories() {
        // 대분류 렌더링
        renderDetailCategoryText('category1', selectedCategory.tier1Code);
        
        // 중분류가 있는 경우
        if (selectedCategory.tier1Code) { 	// 대분류가 선택된 상태에서 중분류를 렌더링
            renderDetailCategoryText('category2', selectedCategory.tier2Code);
        }

        // 소분류가 있는 경우
        if (selectedCategory.tier2Code) { 	// 중분류가 선택된 상태에서 소분류를 렌더링
            renderDetailCategoryText('category3', selectedCategory.tier3Code);
        }
    }

    /* 특정 카테고리 코드를 텍스트로 렌더링 */
    function renderDetailCategoryText(elementId, categoryCode) {
        var category = findCategoryByCode(categoryCode);
        if (category) {
            $('#' + elementId).text(category.category_name);
        } else {
            $('#' + elementId).text("선택된 카테고리 없음");
        }
    }

	/* 상품 삭제 */
  	$('#btn_delete').on('click', function(e) {	
  		
        if (confirm('정말로 삭제하시겠습니까?')) {
            $.ajax({
                url: '/api/book/' + book_id, 
                method: 'DELETE', 
                success: function(response) {
                    alert('상품이 성공적으로 삭제되었습니다.');
                    goListPage(); // 삭제 후 리스트 페이지로 이동
                },
                error: function(xhr, status, error) {
                    console.error('삭제 실패: ' + status + ', ' + error);
                    alert('삭제에 실패했습니다. 다시 시도해주세요.');
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
        
		window.location.href = '/admin/book/update/' + book_id + newUrl;
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
        
        window.location.href = '/admin/book/list' + newUrl;
	}
	
	
});
</script>
</body>
</html>