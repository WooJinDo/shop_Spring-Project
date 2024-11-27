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
	.ck-editor__editable {
	    min-height: 400px;
	}
	#puble_year, #author_name {
		width: 50%;
	}
	.ui-datepicker-trigger {	/* 캘린더 css 설정 */ 
		margin-left: 5px;
		width: 2%;
		cursor: pointer;
	}
	
	/* 모달 기본 스타일 */
	.modal {
	    display: none;
	    position: fixed;
	    z-index: 1;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    overflow: auto;
	    background-color: rgba(0,0,0,0.4);
	}

	.modal-content {
	    background-color: #fefefe;
	    margin: 10% auto;
	    padding: 20px;
	    border: 1px solid #888;
	    width: 80%;
	    max-width: 800px;
	    border-radius: 5px;
	}
	
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	    color: black;
	    text-decoration: none;
	    cursor: pointer;
	}
	
	.modal-content {
	    max-height: 80vh;
	    overflow-y: auto;
	}
	
	.author-list-container {
	    margin-top: 20px;
	}
	
	.author-list-container table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	.author-list-container th,
	.author-list-container td {
	    padding: 8px;
	    border: 1px solid #ddd;
	}
	
	.select-author {
	    padding: 5px 10px;
	    background-color: #007bff;
	    color: white;
	    border: none;
	    border-radius: 3px;
	    cursor: pointer;
	}
	
	.select-author:hover {
	    background-color: #0056b3;
	}
	
	.modal-pagination {
	    margin-top: 20px;
	}
	
	/* 이미지 업로드 관련 스타일 */
	.image-upload-container {
	    display: flex;
	    gap: 20px;
	    margin-top: 10px;
	}

	.image-preview-area {
	    width: 400px;
	    min-height: 200px;
	    border: 2px dashed #ddd;
	    padding: 10px;
	}
	
	#imagePreview {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 10px;
	}
	
	.preview-item {
	    position: relative;
	    width: 100px;
	    height: 100px;
	    border-radius: 4px;
	    overflow: hidden;
	}
	
	.preview-item img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	
	.remove-image {
	    position: absolute;
	    top: -8px;
	    right: -8px;
	    background: #ff4444;
	    color: white;
	    border: none;
	    border-radius: 50%;
	    width: 20px;
	    height: 20px;
	    cursor: pointer;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    font-size: 12px;
	}
	
	.remove-image:hover {
	    background: #cc0000;
	}
	
	.new-badge {
	    position: absolute;
	    top: 5px;
	    right: 5px;
	    background: #ff4444;
	    color: white;
	    padding: 2px 5px;
	    border-radius: 3px;
	    font-size: 10px;
	    z-index: 1;
	}

	.thumbnail-badge {
	    position: absolute;
	    top: 5px;
	    left: 5px;
	    background: #4CAF50;
	    color: white;
	    padding: 2px 5px;
	    border-radius: 3px;
	    font-size: 10px;
	    z-index: 1;
	}
	
	.upload-btn-area {
	    flex: 1;
	    padding: 10px;
	}
	
	.upload-btn-area .btn {
	    margin-bottom: 10px;
	}
	
	.form-text.text-muted {
	    font-size: 12px;
	    line-height: 1.5;
	}
	
	/* 파일명 스타일 */
	.file-item {
	    display: flex;
	    align-items: center;
	    margin: 5px 0;
	    padding: 5px;
	    background: #f8f9fa;
	    border-radius: 4px;
	}
	
	.file-name {
	    flex: 1;
	    margin-right: 10px;
	    font-size: 13px;
	}
	
	.file-delete-btn {
	    background: none;
	    border: none;
	    color: #dc3545;
	    padding: 2px 8px;
	    cursor: pointer;
	    border-radius: 3px;
	    transition: all 0.2s;
	}
	
	.file-delete-btn:hover {
	    background: #dc3545;
	    color: white;
	}
	</style>
</head>
<body class="js">
<%@ include file="/WEB-INF/views/common/admin/commonHeader.jsp" %>

	<section id="contact-us" class="contact-us section" style="padding: 20px 0;">
		<div class="container" style="max-width: 100%;">
				<div class="contact-head">
					<div class="row">
						<div class="col-lg-8 col-12" style="margin-left: 15%; flex: 0 0 70%; max-width: 70%;">
						<div class="login-form">
						<h2 style="padding-bottom: 20px;">상품 등록</h2>
						</div>
							<div class="form-main">
								<!-- Form -->
								<form id="bookAddForm" class="form" enctype="multipart/form-data">
								<div class="row">
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label style="width: 100%;">작가명<span style="position:relative; right: -5px;">*</span></label>
											<input type="text" id="author_name" disabled="disabled" placeholder="" >
											<input type="hidden" id="author_id" name="author_id" >
											
											<!-- 모달창 -->
											<button type="button" id="btn_authorId" class="btn" style="z-index: 0;">작가 선택</button>
											<div id="myModal" class="modal">
											    <div class="modal-content">
											        <span class="close">&times;</span>
											        <h2 style="margin-bottom: 10px;">작가 선택</h2>
													<div class="row">
														<div class="col-lg-12 col-12">
															<div class="form-main" style="padding: 10px;">
																<div class="row">
																	<div class="col-lg-2 col-12" style="flex: 0 0 15%; max-width: 25%;">
																		<div class="form-group" style="float:right; margin-bottom: 0px;">
																			<select id="searchType" name="searchType">
																		        <option value="authorName">작가</option>
																		        <option value="nationName">소속국가</option>
																		    </select>
																		</div>
																	</div>
																	<div class="col-lg-5 col-12" style="padding: 0 15px 0 0;">
																		<div class="form-group" style="margin-bottom: 0px;">
																			<input type="text" name="keyword">
																		</div>
																	</div>
																	
																	<div class="col-lg-2 col-12" style="padding: 0px;">
																		<div class="form-group" style="margin-bottom: 0px;">
																			<button type="button" id="btn_search" class="btn">검색</button>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
													
											        <!-- 작가 목록 테이블 -->
											        <div class="author-list-container">
											            <table>
											                <thead>
											                    <tr>
											                        <th class="text-center">작가번호</th>
											                        <th class="text-center">작가명</th>
											                        <th class="text-center">소속국가</th>
											                        <th class="text-center">선택</th>
											                    </tr>
											                </thead>
											                <tbody id="modalAuthorList">
											                    <!-- List 영역 -->
											                </tbody>
											            </table>
											            <div id="modalPagination">
											            	<!-- modalPagination 영역 -->
											            </div>
											        </div>
											    </div>
											</div>
											
										</div>
										<span class="input_msg"></span>
									</div>
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>상품 카테고리 코드<span>*</span></label>
										</div>
										<div class="form-group" style="margin-bottom: 0px; display: flex;">
											<select id="category1">
										        <option value="">대분류</option>
										    </select>
										    
										    <select id="category2">
										        <option value="">중분류</option>
										    </select>
										    
										    <select id="category3">
										        <option value="">소분류</option>
										    </select>
										</div>
										<span class="input_msg"></span>
									</div>
									
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>상품명<span>*</span></label>
											<input type="text" id="book_name" name="book_name" placeholder="" >
										</div>
										<span class="input_msg"></span>
									</div>
									
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label style="width: 100%;">출판일<span style="position:relative; right: -5px;">*</span></label>
											<!-- autocomplete="off" - 사용자가 이전에 해당 필드에 입력했던 값을 브라우저가 제안하지 않게 -->
											<input type="text" id="puble_year" name="puble_year" autocomplete="off" readonly="readonly" placeholder="" >
										</div>
										<span class="input_msg"></span>
									</div>
									
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>출판사<span>*</span></label>
											<input type="text" id="publisher" name="publisher" placeholder="" >
										</div>
										<span class="input_msg"></span>
									</div>
									
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>상품 가격<span>*</span></label>
											<input type="text" id="book_price" name="book_price" placeholder="" >
										</div>
										<span class="input_msg"></span>
									</div>
									
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>상품 재고<span>*</span></label>
											<input type="text" id="book_stock" name="book_stock" placeholder="" >
										</div>
										<span class="input_msg"></span>
									</div>
									
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>상품 할인율(%)<span>*</span></label>
											<input type="text" id="book_discount" name="book_discount" placeholder="" >
											<label>할인 가격 : </label>
											<span id="book_discount_price"></span>
										</div>
										<span class="input_msg"></span>
									</div>
								
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group message" style="margin-bottom: 0px;">
											<label>상품 내용<span>*</span></label>
											<textarea id="book_contents" name="book_contents" placeholder=""></textarea>
										</div>
										<span class="input_msg"></span>
									</div>
									
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group message" style="margin-bottom: 0px;">
											<label>상품 소개<span>*</span></label>
											<textarea id="book_intro" name="book_intro" placeholder=""></textarea>
										</div>
										<span class="input_msg"></span>
									</div>									
									
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>상품 이미지<span>*</span></label>
											<div class="image-upload-container">
												<!-- 이미지 미리보기 영역 -->
												<div class="image-preview-area">
													<div id="imagePreview"></div>
												</div>
												<!-- 이미지 업로드 버튼 영역 -->
												<div class="upload-btn-area">
													<!--  multiple - 여러 파일을 동시에 선택, accept="image/*" - 파일 선택 창에서 이미지 파일만 필터링 -->
													<input type="file" id="bookImage" name="bookImage" multiple accept="image/*" style="display: none;">
													<button type="button" id="uploadTrigger" class="btn">이미지 선택</button>
													<div id="selectedFileNames" class="selected-files">
														<!-- 파일명 목록이 여기에 표시됨 -->
													</div>
													<small class="form-text text-muted">
														* 첫 번째 이미지가 대표 이미지로 설정됩니다.<br>
														* 이미지는 최대 5개까지 업로드 가능합니다.<br>
														* 권장 크기: 800 x 800px (1:1 비율)
													</small>
												</div>
											</div>
										</div>
										<span class="input_msg"></span>
									</div>
								
									<div class="col-12" style="margin-bottom: 20px;">
										<div class="form-group login-btn">
											<button class="btn" type="submit" >등록</button>
											<button id="btn_list" class="btn" type="button">취소</button>
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
    .create(document.querySelector('#book_contents'), {
        ...customEditor.editorConfig,
        ckfinder: {
            uploadUrl: '/api/editor/upload?type=BOOK_CONTENTS'  // 다른 타입 지정
        }
    })
    .then(function(editor) {
        console.log('상품 내용 Editor 초기화', editor);
        window.editor2 = editor;
    })
    .catch(error => {
        console.error('CKEditor 초기화 실패:', error);
    });

customEditor.ClassicEditor
    .create(document.querySelector('#book_intro'), {
        ...customEditor.editorConfig,
        ckfinder: {
            uploadUrl: '/api/editor/upload?type=BOOK_INTRO'  // 타입 지정
        }
    })
    .then(function(editor) {
        console.log('상품 소개 Editor 초기화', editor);
        window.editor = editor;
    })
    .catch(error => {
        console.error('CKEditor 초기화 실패:', error);
    });
</script>
<script>
$(document).ready(function() {
	/* 작가선택(모달창) */
  	var modal = $("#myModal");
    var btn = $("#btn_authorId");
    var span = $(".close");

    btn.click(function() {
        modal.fadeIn(300);
        modalAuthorList(1); // 모달창 열릴 때 첫 페이지 로드
    });

    span.click(function() {
        modal.fadeOut(300);
    });

    $(window).click(function(event) {
        if (event.target == modal[0]) {
            modal.fadeOut(300);
        }
    });
    
    /* 모달창 내 검색 */
    $('#btn_search').on('click', function() {
        modalAuthorList(1);
    });

    /* 게시글 리스트 조회 */
    function modalAuthorList(page) {
     	// 폼 데이터를 객체로 변환
        var formData = {
            currentPage: page,
            itemsPerPage: 5,
            searchType: $('select[name="searchType"]').val(),
            keyword: $('input[name="keyword"]').val()
        };

        $.ajax({
            url: '/api/author',
            method: 'GET',
            dataType: 'json',		// 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
            data: formData,
            success: function(response) {
                var authorListHtml = '';
                
                if(response.totalCount > 0) {
                    $.each(response.authorList, function(index, list) {
                    	authorListHtml += '<tr class="text-center">';
                        authorListHtml += '<td><span>' + list.author_id + '</span></td>';
                        authorListHtml += '<td><span>' + list.author_name + '</span></td>';
                        authorListHtml += '<td><span>' + list.nation_name + '</span></td>';
                        authorListHtml += '<td><button type="button" class="select-author" ' +
                                       'data-author-id="' + list.author_id + '" ' +
                                       'data-author-name="' + list.author_name + '">선택</button></td>';
                        authorListHtml += '</tr>';
                    });
                } else {
                	 authorListHtml += '<tr class="text-center">';    
                     authorListHtml += '<td colspan="4"><span>데이터가 존재하지 않습니다.</span></td>';
                     authorListHtml += '</tr>';
                }
                $('#modalAuthorList').html(authorListHtml);
                
             	// 페이징 렌더링
                drawPaging(response.paging);
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
        $('#modalPagination').html(pagingtHtml);

     	// $('#Pagination').off('click', 'a') : #Pagination 내부의 a 태그에 할당된 이전의 클릭 이벤트를 제거
		// 페이지 번호 클릭 시 갱신될 때 이벤트 중복 발생(두 개 이상의 동일한 AJAX 요청이 전송)을 방지하기 위해 기존 이벤트를 먼저 제거
        $('#modalPagination').off('click', 'a').on('click', 'a', function(e) {
        	// <a> 태그의 기본 동작인 페이지 이동을 막기 위해 사용
            e.preventDefault();
            var pageNum = $(this).data('page');
            modalAuthorList(pageNum);
        });
    }
	
	/* 모달창 내 선택 버튼 클릭 시 */
	$('#modalAuthorList').on('click', '.select-author', function() {	// $(document).on('click', '.select-author' - 동적(ajax)으로 추가된 요소에도 클릭 이벤트를 바인딩
		var author_id = $(this).data('author-id');
		var author_name = $(this).data('author-name'); 
		
		var $form = $('#bookAddForm');
		$form.find('#author_name').val(author_name);
		$form.find('#author_id').val(author_id);
		
		alert(author_name + "님이 선택되었습니다.");
		modal.fadeOut(300);
    });

	/* 전역 변수로 카테고리 배열로 저장 */
	var categoryData = [];	// 초기 한 번만 전체 데이터를 로드하고 이후에는 클라이언트단에서 필터링하여 처리하기 위해
	
	/* 로드 시 카테고리 리스트 실행 */
	categoryList();
	
    /* 카테고리 리스트 조회 */
    function categoryList() {
        $.ajax({
            url: '/api/book/category',
            method: 'GET',
            dataType: 'json',		// 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
            success: function(response) {
               if(response.length > 0) {
                   categoryData = response; // 전역 변수에 저장
                   renderCategory1(); // 대분류 렌더링
               }
            },
            error: function(xhr, status, error) {
                console.error("카테고리 조회 실패: " + status + ", " + error);
			  	if(xhr.responseText) {
			  		alert(xhr.responseText);
			  	} else {
			  		alert("카테고리 조회에 실패하였습니다.");
			  	}
            }
        });
    }
    
    /* 대분류 렌더링 */
    function renderCategory1() {
        var $category1 = $('#category1');
        $category1.html('<option value="">대분류</option>');
        
//         var tier1Categories = categoryData.filter(function(item) {
//             return item.tier === 1;
//         });

		var tier1Categories = getTierCategories(1);
		
        for (var i = 0; i < tier1Categories.length; i++) {
            var category = tier1Categories[i];
            $category1.append('<option value="' + category.category_code + '">' + 
                             category.category_name + '</option>');
        }
        $category1.niceSelect('update');      // 값 설정 후 nice-select 드롭다운을 수동으로 업데이트
    }

    /* 대분류 변경 시 */
	$('#category1').change(function() {
        var selectedCode = $(this).val();
        renderCategory2(selectedCode);
    });
    
    /* 중분류 렌더링 */
    function renderCategory2(parentCode) {
        var $category2 = $('#category2');
        $category2.html('<option value="">중분류</option>');
        
        if (!parentCode) {
            $category2.prop('disabled', true);
            $category2.niceSelect('update');      // 값 설정 후 nice-select 드롭다운을 수동으로 업데이트
            $('#category3').html('<option value="">소분류</option>').prop('disabled', true);
            $('#category3').niceSelect('update');      
            return;
        }
        
//         var tier2Categories = categoryData.filter(function(item) {
//             return item.tier === 2 && item.category_parent_code === parentCode;
//         });

		var tier2Categories = getTierCategories(2, parentCode);
        
        for (var i = 0; i < tier2Categories.length; i++) {
            var category = tier2Categories[i];
            $category2.append('<option value="' + category.category_code + '">' + 
                             category.category_name + '</option>');
        }
        
        $category2.prop('disabled', false);
        $category2.niceSelect('update');      // 값 설정 후 nice-select 드롭다운을 수동으로 업데이트
        $('#category3').html('<option value="">소분류</option>').prop('disabled', true);
        $('#category3').niceSelect('update');
    }

    /* 중분류 변경 시 */
    $('#category2').change(function() {
        var selectedCode = $(this).val();
        renderCategory3(selectedCode);
    });
    
    /* 소분류 렌더링 */
    function renderCategory3(parentCode) {
        var $category3 = $('#category3');
        $category3.html('<option value="">소분류</option>');
        
        if (!parentCode) {
            $category3.prop('disabled', true);
            $category3.niceSelect('update');      // 값 설정 후 nice-select 드롭다운을 수동으로 업데이트
            return;
        }
        
        var tier3Categories = getTierCategories(3, parentCode);
        
        for (var i = 0; i < tier3Categories.length; i++) {
            var category = tier3Categories[i];
            $category3.append('<option value="' + category.category_code + '">' + 
                             category.category_name + '</option>');
        }
        
        $category3.prop('disabled', false);
        $category3.niceSelect('update');      // 값 설정 후 nice-select 드롭다운을 수동으로 업데이트
    }
    
    /* 특정 계층의 카테고리 목록 가져오기(filter 대신 for 루프 사용) */
    function getTierCategories(tier, parentCode) {
        var result = [];
        for (var i = 0; i < categoryData.length; i++) {
            var item = categoryData[i];
            if (item.tier === tier && (!parentCode || item.category_parent_code === parentCode)) {
                result.push(item);
            }
        }
        return result;
    }
    
	/* 달력 위젯(datepicker) 적용 */
	initializeDatepicker('#puble_year',{
	    setDate: false,  // 기본 오늘 날짜 설정을 비활성화
	}); 
	
	
	
	/* 상품 할인율 계산 및 유효성 검사 */
	$("#book_discount").on('input', function() {
	    // 원래 가격 가져오기
	    var originalPrice = $('#book_price').val();
	    
	    // originalPrice 값 검증
	    if (!originalPrice || originalPrice <= 0 || isNaN(originalPrice)) {
	        alert("상품 가격을 먼저 입력해주세요.");
	        $(this).val(''); // 할인율 입력값 초기화
	        $("#book_discount_price").text(''); // 할인가격 입력값 초기화
	        return;
	    }

	    var discountRate = $(this).val();
	    
	    // 특수문자 및 문자열 체크를 위한 정규식
	    var numberPattern = /^[0-9]*\.?[0-9]*$/;
	    
	    // 입력값이 숫자가 아닌 경우 체크
	    if (!numberPattern.test(discountRate)) {
	        alert("숫자만 입력 가능합니다.");
	        $(this).val(''); // 잘못된 입력값 초기화
	        $("#book_discount_price").text(''); // 할인가격 초기화
	        return;
	    }
	    
	    // 할인율 값 파싱(실수로 변환)
	    discountRate = parseFloat(discountRate) || 0;
	    
	    // 할인율 범위 검증 (0-100)
	    if (discountRate < 0 || discountRate > 100) {
	        alert("할인율은 0에서 100 사이의 값만 입력 가능합니다.");
	        $(this).val('');
	        $("#book_discount_price").text('');
	        return;
	    }
	    
	    // 최종 할인 가격 계산
	    var finalPrice = originalPrice * (1 - (discountRate / 100));
	    
	    // 계산된 가격을 반올림하여 천단위로 표시
	    $("#book_discount_price").text(Math.round(finalPrice).toLocaleString() + "원");
	});

	/* 이미지 업로드 관련 코드 */
    var MAX_FILES = 5; // 이미지 파일의 최대 개수
    var uploadedFiles = []; // 업로드된 파일 정보를 저장하는 배열
    
    /* 이미지 선택 버튼 클릭 이벤트 */
    $('#uploadTrigger').on('click', function() {
        $('#bookImage').click();
    });
    
    /* 파일 선택 시 이벤트 */
    $('#bookImage').on('change', function(e) {
        var files = Array.from(e.target.files); // 선택한 파일 목록을 배열 형태로 가져와 files에 저장
        var totalCount = uploadedFiles.length + files.length; // 현재 uploadedFiles 배열에 저장된 파일 개수와 새로 선택한 files의 개수를 합산
        
     	// 최대 개수를 초과하는지 확인
        if (totalCount > MAX_FILES) {  
            alert('이미지는 최대 ' + MAX_FILES + '개까지 업로드 가능합니다.');
            this.value = ''; //  files 배열의 처리가 중단되어 파일 입력 초기화
            return;
        }
       
     	// 선택된 파일이 있고 최대 개수를 초과하지 않을 때만 처리
        if (files && files.length > 0 && totalCount <= MAX_FILES) {
	     	// 모든 파일 처리가 완료된 후 배지 업데이트를 위한 카운터
	       	var processedFiles = 0;
	     
	        files.forEach(file => {
	            if (!file.type.startsWith('image/')) {
	                alert('이미지 파일만 업로드 가능합니다.');
	                return;
	            }
	            
	            // FileReader 객체를 사용하여 파일을 읽고, onload 이벤트에서 createPreviewItem 함수를 호출하여 미리보기 아이템을 생성
	            var reader = new FileReader();
	            reader.onload = function(e) {
	            	// 미리보기 아이템을 #imagePreview 요소에 추가하고, uploadedFiles 배열에 파일 정보를 저장합니다.
	                var imageItem = createPreviewItem(e.target.result, file);
	                $('#imagePreview').append(imageItem);
	                uploadedFiles.push(file);
	                
	                processedFiles++;
	                // 모든 파일이 처리되었을 때만 배지 업데이트
	                if (processedFiles === files.length) {
	                    updateThumbnailBadges(); // 배지 업데이트
	                    updateSelectedFileNames(); // 모든 파일 처리 후 파일명 업데이트
	                }
	            };
	            reader.readAsDataURL(file); // 파일을 읽고, 그 결과를 Base64 형식으로 변환해 이미지 URL로 사용합니다.
	        });
        }
        
        this.value = ''; // 파일 입력 초기화하여 파일 재선택을 가능하게 합니다.
    });

    /* 이미지 선택 시 파일명 업데이트 */
    function updateSelectedFileNames() {
        var selectedFilesHtml = '';
        
        uploadedFiles.forEach(function(file, index) {
            selectedFilesHtml += '<div class="file-item">'; 
            selectedFilesHtml += '<span class="file-name">' + file.name + '</span>'; 
            selectedFilesHtml += '<button type="button" class="file-delete-btn" data-file-index="' + index + '">'; 
            selectedFilesHtml += '<i class="ti-close"></i>'; 
            selectedFilesHtml += '</button>'; 
            selectedFilesHtml += '</div>'; 
        });
        $('#selectedFileNames').html(selectedFilesHtml);
    }
    
 	/* 파일명 옆 삭제 버튼 클릭 이벤트 */
    $(document).on('click', '.file-delete-btn', function() {
        var fileIndex = $(this).data('file-index');
        
        // 미리보기 이미지 삭제
        var previewItems = $('#imagePreview .preview-item');
        $(previewItems[fileIndex]).remove();
        
        // 새로 업로드할 이미지 파일 배열에서 제거
        uploadedFiles.splice(fileIndex, 1); // splice(변경할 인덱스, 삭제개수, 추가요소)
        
        // 이미지 선택 시 파일명 UI 업데이트
        updateSelectedFileNames();
     	// 썸네일 배지 업데이트
        updateThumbnailBadges();
    });
 	
    /* 미리보기 아이템 생성 */
    function createPreviewItem(previewUrl, file) {
    	var item = $('<div>').addClass('preview-item');
        var img = $('<img>').attr('src', previewUrl);
        var newBadge = $('<div>').addClass('new-badge').text('New');    
        
        return item.append(img, newBadge);
    }
    
    /* 썸네일 배지 업데이트 */
    function updateThumbnailBadges() {
    	// 기존 배지 모두 제거
        $('.thumbnail-badge').remove();
        // 업로드된 파일이 있을 경우
        if (uploadedFiles.length > 0) {
			var firstItem = $('#imagePreview .preview-item').first();
			if (firstItem.length > 0) {
			    var badge = $('<div>').addClass('thumbnail-badge').text('대표');
			    firstItem.append(badge);
			}
        }
    }
    
	/* 상품 목록페이지 이동 */
	$("#btn_list").on('click',function() {
		window.location.href= '/admin/book/list';
	});
	
	/* 상품 등록 */
	$("#bookAddForm").on('submit',function(e) {
		e.preventDefault();  // 폼 제출이 기본적으로 새로고침을 유발하므로, 이를 방지하기 위해
		
		// 폼 객체를 변수에 저장
	    var $form = $(this);
		
	 	// CKEditor 인스턴스에서 데이터 가져오기
        var book_contents = window.editor2.getData();
        var book_intro = window.editor.getData();
        
		// 폼 제출 성공여부
		if(validateForm()) {
	       console.log('폼 제출 성공');
	       var formData = new FormData();
	       
			// 폼 데이터를 객체로 변환
			var bookData = {
				author_id: $form.find('#author_id').val()
				, category_code: $form.find('#category3').val()
				, book_name: $form.find('#book_name').val()
				, puble_year: $form.find('#puble_year').val()
				, publisher: $form.find('#publisher').val()
				, book_price: parseInt($form.find('#book_price').val())
				, book_stock: parseInt($form.find('#book_stock').val())
				, book_discount: parseFloat($form.find('#book_discount').val())
				, book_contents: book_contents
				, book_intro: book_intro
			};
			
			// bookData를 JSON 문자열로 변환하여 FormData에 추가
			formData.append('bookData', new Blob([JSON.stringify(bookData)], {type: 'application/json'}));
			
	     	// 이미지 파일 추가
            uploadedFiles.forEach((file, index) => {
                formData.append('files', file);
            });
			
			$.ajax({
				   url: "/api/book",
		           type: "POST",
		           data: formData,
		           processData: false,  // FormData 처리 방지
		           contentType: false,  // 컨텐츠 타입 자동 설정
				  success: function(response) {         // 성공 시 실행되는 함수
					console.log(response);              // 응답 데이터 처리
					alert('상품을 등록하였습니다.');
					location.href = '/admin/book/list';
				  },
				  error: function(xhr, status, error) { // 실패 시 실행되는 함수
					console.error("등록 실패: " + status + ", " + error);     // 에러 처리
					// 서버에서 반환한 에러 메시지 표시
				  	if(xhr.responseText) {
				  		alert(xhr.responseText);
				  	} else {
				  		alert("상품 등록에 실패하였습니다.");	
				  	}
					
				  }
			}); // ajax 종료
		}
	});
	
	// 전체 폼 유효성 검사
	function validateForm() {
		var isValid = true;
        
		isValid = validateAuthorNameById('author_name') && isValid;
        isValid = validateAuthorNameById('author_id') && isValid;
        isValid = validateCategoryCode(1) && isValid;
        isValid = validateCategoryCode(2) && isValid;
        isValid = validateCategoryCode(3) && isValid;
        isValid = validateBookName() && isValid;
        isValid = validatePubleYear() && isValid;
        isValid = validatePublisher() && isValid;
        isValid = validateBookPrice() && isValid;
        isValid = validateBookStock() && isValid;
        isValid = validateBookDiscount() && isValid;
        isValid = validateBookIntro() && isValid;
        isValid = validateBookContents() && isValid;
        isValid = validateBookImage() && isValid;
        
        return isValid;
    }

    // 작가 번호 유효성 검사
    function validateAuthorNameById(param) {
        var $authorNameById = $('#' + param);
        var authorNameByIdValue = $authorNameById.val().trim();
        if(authorNameByIdValue === '') {
            setErrorFor($authorNameById, '작가를 선택해주세요.');
            return false;
        } else{
            setSuccessFor($authorNameById);
            return true;
        }
    }
    
	 // 상품 카테고리 코드 유효성 검사
    function validateCategoryCode(num) {
        var $categoryCode = $('#category' + num);
        var categoryCodeValue = $categoryCode.val().trim();
        if(categoryCodeValue === '') {
            setErrorFor($categoryCode, '카테고리 코드를 선택해주세요.');
            return false;
        } else{
            setSuccessFor($categoryCode);
            return true;
        }
    }
	 
	 // 상품명 유효성 검사
    function validateBookName() {
        var $bookName = $('#book_name');
        var bookNameValue = $bookName.val().trim();
        if(bookNameValue === '') {
            setErrorFor($bookName, '상품명 입력해주세요.');
            return false;
        } else{
            setSuccessFor($bookName);
            return true;
        }
    }
	 
	 // 출판일 유효성 검사
    function validatePubleYear() {
        var $publeYear = $('#puble_year');
        var publeYearValue = $publeYear.val().trim();
        if(publeYearValue === '') {
            setErrorFor($publeYear, '출판일을 입력해주세요.');
            return false;
        } else{
            setSuccessFor($publeYear);
            return true;
        }
    }
	 
	 // 출판사 유효성 검사
    function validatePublisher() {
        var $publisher = $('#publisher');
        var publisherValue = $publisher.val().trim();
        if(publisherValue === '') {
            setErrorFor($publisher, '출판사를 입력해주세요.');
            return false;
        } else{
            setSuccessFor($publisher);
            return true;
        }
    }
	 
 	// 상품가격 유효성 검사
    function validateBookPrice() {
        var $bookPrice = $('#book_price');
        var bookPriceValue = $bookPrice.val().trim();
        if(bookPriceValue === '') {
            setErrorFor($bookPrice, '상품가격을 입력해주세요.');
            return false;
        } else if(isNaN(bookPriceValue) || parseInt(bookPriceValue) < 0) {
			setErrorFor($bookPrice, '숫자만 입력해야 합니다.');
			return false;
		} else{
            setSuccessFor($bookPrice);
            return true;
        }
    }
 	
 	// 상품재고 유효성 검사
    function validateBookStock() {
        var $bookStock = $('#book_stock');
        var bookStockValue = $bookStock.val().trim();
        if(bookStockValue === '') {
            setErrorFor($bookStock, '상품재고를 입력해주세요.');
            return false;
        } else if(isNaN(bookStockValue) || parseInt(bookStockValue) < 0) {
			setErrorFor($bookStock, '숫자만 입력해야 합니다.');
			return false;
		} else{
            setSuccessFor($bookStock);
            return true;
        }
    }
 	
 	// 상품할인율 유효성 검사
    function validateBookDiscount() {
        var $bookDiscount = $('#book_discount');
        var bookDiscountValue = $bookDiscount.val().trim();
        if(bookDiscountValue === '') {
            setErrorFor($bookDiscount, '상품할인율을 입력해주세요.');
            return false;
        } else{
            setSuccessFor($bookDiscount);
            return true;
        }
    }
    
 	// 상품소개 유효성 검사
    function validateBookIntro() {
        var $bookIntro = $('#book_intro');
        var bookIntroValue = $bookIntro.val().trim();
        if(bookIntroValue === '') {
            setErrorFor($bookIntro, '소개내용을 입력해주세요.');
            return false;
        } else{
            setSuccessFor($bookIntro);
            return true;
        }
    }
 	
 	// 상품목차 유효성 검사
    function validateBookContents() {
        var $bookContents = $('#book_contents');
        var bookContentsValue = $bookContents.val().trim();
        if(bookContentsValue === '') {
            setErrorFor($bookContents, '상품목차를 입력해주세요.');
            return false;
        } else{
            setSuccessFor($bookContents);
            return true;
        }
    }
 	
 	// 파일 업로드 유효성 검사
    function validateBookImage() {
    	var $formControl = $('.image-upload-container').parent().parent();
        if(uploadedFiles.length === 0) {
            $formControl.find('.input_msg').text('최소 1개의 상품 이미지를 업로드해주세요.').css("display","inline-block").css('color', 'red');
            return false;
        } else{
        	$formControl.find('.input_msg').text('').removeAttr('style');
            return true;
        }
    }
 	
 	// 숫자 유효성 검사 함수
//     function isValidNumber(value) {
//         var regex = /^[0-9]+$/; // 숫자만 포함
//         return regex.test(value); // 입력 값이 숫자만으로 이루어졌는지 검사
//     }
 	
 	// 카테고리 코드 유효성 검사 함수
    function isValidCategoryCode(value) {
    	var regex = /^[a-zA-Z0-9]+$/; // 숫자 또는 영어 또는 숫자와 영어만 허용
        return regex.test(value);	 // .test(): 정규표현식(RegExp) 객체에서 사용되는 메서드입니다. 이 메서드는 주어진 문자열이 정규표현식과 일치하는지 검사
    }
 	
 	// 상품할인율 유효성 검사 함수
    function isValidDiscountRate(rate) {
        var regex = /^(100|[1-9]?[0-9])$/; // 0~100까지의 정수만 허용
        return regex.test(rate);
    }

    // 오류 메시지 설정 함수
    function setErrorFor($input, message) {
        var $formControl = $input.parent().parent();
        $formControl.find('.input_msg').text(message).css("display","inline-block").css('color', 'red');
    }

    // 성공 표시 설정 함수
    function setSuccessFor($input) {
    	var $formControl = $input.parent().parent();
        $formControl.find('.input_msg').text('').removeAttr('style');
    }
	
});
</script>

</body>
</html>