package com.shop.controller.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.shop.config.FileUploadUtil;
import com.shop.config.PagingUtil;
import com.shop.dto.BookDto;
import com.shop.dto.CategoryDto;
import com.shop.service.BookService;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/api/book")
public class ApiBookController {
	
	@Value("${upload.max.size}")  // 10MB가 기본값
	private long maxFileSize;
	
	@Autowired
	private BookService bookService;
	
    @Autowired
    private FileUploadUtil fileUploadUtil;
    
	/* 
	 * 전체 카테고리 목록 조회 
	 */
	@GetMapping("/category")
	public ResponseEntity<?> bookCategoryList() throws Exception {
		log.info("**전체 카테고리 조회 처리**");
		
		try {
			List<CategoryDto.CategoryListResponse> categoryList = bookService.selectCategoryList();
		    
		    if (categoryList == null || categoryList.isEmpty()) {
		        return ResponseEntity
		            .status(HttpStatus.NOT_FOUND)
		            .contentType(MediaType.APPLICATION_JSON_UTF8)
		            .body("카테고리를 찾을 수 없습니다.");
		    }
		    
		    return ResponseEntity.status(HttpStatus.OK).body(categoryList);
		    
		} catch (Exception e) {
		    log.error("전체 카테고리 조회 실패", e);
		    return ResponseEntity
		        .status(HttpStatus.INTERNAL_SERVER_ERROR)
		        .contentType(MediaType.APPLICATION_JSON_UTF8)
		        .body("카테고리 조회 중 오류가 발생했습니다.");
		}
	}
	
    /*
     * 특정 계층(tier)의 카테고리 목록 조회
     */
    @GetMapping("/category/tier/{tier}")
    public ResponseEntity<?> selectCategoriesByTier(@PathVariable("tier") int tier) throws Exception {
    	log.info("**계층별 카테고리 조회 - tier: " + tier);
        
        try {
            // 계층 유효성 검사
            if (tier < 1 || tier > 3) {
                return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body("계층 값이 잘못되었습니다. 계층은 1에서 3 사이여야 합니다.");
            }

            List<CategoryDto.CategoryListResponse> categories = bookService.selectCategoryListByTier(tier);
            
            if (categories == null || categories.isEmpty()) {
                return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body("계층에 대한 카테고리를 찾을 수 없습니다: " + tier);
            }
            
            return ResponseEntity.ok(categories);
            
        } catch (Exception e) {
            log.error("카테고리 조회 실패 - tier: " + tier, e);
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .body("카테고리 조회 중 오류가 발생했습니다.");
        }
    }

    /*
     * 특정 카테고리의 하위 카테고리 목록 조회
     */
    @GetMapping("/category/sub/{parentCode}")
    public ResponseEntity<?> selectSubCategoryList(@PathVariable("parentCode") String parentCode) throws Exception {
        log.info("**하위 카테고리 조회 - parentCode: " + parentCode);
        
        try {
            // 상위 카테고리 코드 유효성 검사
            if (parentCode == null || parentCode.trim().isEmpty()) {
                return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body("잘못된 상위 카테고리 코드입니다.");
            }

            List<CategoryDto.CategoryListResponse> subCategoryList = bookService.selectSubCategoryList(parentCode.trim());
            
            if (subCategoryList == null || subCategoryList.isEmpty()) {
                return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body("상위 코드에 대한 하위 범주를 찾을 수 없습니다: " + parentCode);
            }
            
            return ResponseEntity.status(HttpStatus.OK).body(subCategoryList);
            
        } catch (Exception e) {
            log.error("카테고리별 상품 조회 실패 - 시스템 에러", e);
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .body("시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
        }
    }

    /*
     * 카테고리별 상품리스트 조회
     */
    @GetMapping("/category/{categoryCode}")
    public ResponseEntity<?> selectBooksByCategory(
            @PathVariable("categoryCode") String categoryCode,
            BookDto.BookListCatetorySearchRequest request) throws Exception {
        
    	log.info("**카테고리별 상품 조회 시작 - categoryCode: " + categoryCode + 
                ", currentPage: " + request.getCurrentPage());
        
        try {
        	// 카테고리 코드 유효성 검사
            if (categoryCode == null || categoryCode.trim().isEmpty() || "all".equals(categoryCode)) {
            	request.setCategoryCode(null);  // 전체 조회를 위해 null 설정
            } else {
            	request.setCategoryCode(categoryCode);
            }
            
            // 전체 상품 수 조회
            int totalItems = bookService.selectTotalCountByCategory(request);
            log.info("카테고리별 전체 상품 수: " + totalItems);
            
            // 페이징 정보 계산
            PagingUtil pagingUtil = new PagingUtil(request.getCurrentPage(), 
                                                 request.getItemsPerPage(), 
                                                 totalItems);
            
            // 페이징된 상품 리스트
            request.setOffset(pagingUtil.getOffset());
            request.setLimit(pagingUtil.getLimit());
            List<BookDto.BookListCatetoryResponse> bookCategoryList = 
            		bookService.selectBookListByCategory(request);
            
            Map<String, Object> response = new HashMap<>();
            response.put("totalCount", totalItems);
            response.put("paging", pagingUtil);
            response.put("bookCategoryList", bookCategoryList);
            
            log.info("카테고리별 상품 조회 완료 - 조회된 상품 수: " + 
                    (bookCategoryList != null ? bookCategoryList.size() : 0));
            
            return ResponseEntity.status(HttpStatus.OK).body(response);
            
        } catch (Exception e) {
            log.error("카테고리별 상품 조회 실패", e);
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .body("상품 조회 중 오류가 발생했습니다.");
        }
    }
    
    /* 
     * 카테고리별 도서 상세 조회 
     */
    @GetMapping("/detail/{id}")
    public ResponseEntity<?> shopBookDetail(@PathVariable("id") int bookId) throws Exception {
        log.info("**도서 상세 조회 처리**");
        try {
            Map<String, Object> result = bookService.selectShopBookDetail(bookId);
            return ResponseEntity.status(HttpStatus.OK).body(result);
            
        } catch (Exception e) {
            log.error("도서 상세 조회 실패", e);
            return ResponseEntity
        		.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .body("도서 상세 정보 조회 중 오류가 발생했습니다.");
        }
    }	
    
	/* 
	 * 관리자 - 상품 등록, @RequestPart 주로 JSON 데이터와 파일을 같이 받을 때 사용 
	 */
	@PostMapping
	public ResponseEntity<?> bookAdd(@RequestPart("bookData") BookDto.BookRequest request,
            @RequestPart("files") List<MultipartFile> files) throws Exception {
		log.info("**상품 등록 처리**");
		
		// 1. 전체 파일 크기 체크
		long totalSize = 0;
		String maxFileSizeInMB = (maxFileSize / (1024 * 1024)) + "MB";
		for(MultipartFile file : files) {
			totalSize += file.getSize();
			
			// 2. 개별 파일 크기 체크
			if(file.getSize() > maxFileSize) {
				return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
						.contentType(MediaType.APPLICATION_JSON_UTF8)
						.body("개별 파일 크기가 최대 크기 " + maxFileSizeInMB + "를 초과했습니다");
			}
			
			// 3. 파일 타입 체크
			if (!fileUploadUtil.validateFileType(file)) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                		.contentType(MediaType.APPLICATION_JSON_UTF8)
                		.body("허용되지 않는 파일 형식입니다. (jpg, jpeg, png, gif 파일만 가능)");
            }
		}
		
		// 4. 전체 파일 크기 체크
		if(totalSize > maxFileSize) {
			return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
					.contentType(MediaType.APPLICATION_JSON_UTF8)
					.body("전체 파일 크기가 최대 크기 " + maxFileSizeInMB + "를 초과했습니다");
		}
		
		bookService.add(request, files);
		
		return ResponseEntity.status(HttpStatus.CREATED).body(true);
	}
	
	/* 
	 * 관리자 - 상품 리스트 조회 
	 */
	@GetMapping
	public ResponseEntity<?> bookList(BookDto.BookSearchRequest request) throws Exception {
		log.info("**상품 리스트 조회 처리**");
		try {
			int totalItems = bookService.selectTotalCount(request);	// 전체 게시글 수
			// 페이징 정보 계산
			PagingUtil pagingUtil = new PagingUtil(request.getCurrentPage(), request.getItemsPerPage(), totalItems);
			
			// 페이징된 상품 리스트
			request.setOffset(pagingUtil.getOffset());
			request.setLimit(pagingUtil.getLimit());
			List<BookDto.BookListResponse> bookList = bookService.selectBookList(request);
			
			Map<String, Object> response = new HashMap<>();
			response.put("totalCount", totalItems);
			response.put("paging", pagingUtil);
			response.put("bookList", bookList);
			
			return ResponseEntity.status(HttpStatus.OK).body(response);
			
	    } catch (Exception e) {
	        // 시스템 오류
	        log.error("상품 리스트 조회 실패", e);
	        return ResponseEntity
	            .status(HttpStatus.INTERNAL_SERVER_ERROR)
	            .contentType(MediaType.APPLICATION_JSON_UTF8)
	            .body("상품 리스트 조회 중 오류가 발생했습니다.");
	    }
	}
	
	/* 
	 * 관리자 - 상품 상세 조회 
	 */
	@GetMapping("/{id}")
	public ResponseEntity<?> bookDetail(@PathVariable("id") int bookId, Model model) 
			throws Exception {
		log.info("**상품 상세 조회 처리**");
		try {
			Map<String, Object> result = bookService.selectBookDetail(bookId);
			return ResponseEntity.status(HttpStatus.OK).body(result);
			
	    } catch (Exception e) {
	        log.error("상품 상세 조회 실패 - bookId: " + bookId, e);
	        return ResponseEntity
	            .status(HttpStatus.INTERNAL_SERVER_ERROR)
	            .contentType(MediaType.APPLICATION_JSON_UTF8)
	            .body("상품 상세 정보 조회 중 오류가 발생했습니다.");
	    }
	}
	
	/* 
	 * 관리자 - 상품 수정, 파일 업로드 및 수정 같은 경우 POST로
	 */
	@PostMapping("/{id}")
	public ResponseEntity<?> bookUpdate(@PathVariable("id") int bookId, 
			@RequestPart("bookData") BookDto.BookUpdateRequest request,
			@RequestPart("files") List<MultipartFile> files) throws Exception {
		log.info("**상품 수정 처리**");
		
		// 1. 전체 파일 크기 체크
		long totalSize = 0;
		String maxFileSizeInMB = (maxFileSize / (1024 * 1024)) + "MB";
		for(MultipartFile file : files) {
			totalSize += file.getSize();
			// 2. 개별 파일 크기 체크
			if(file.getSize() > maxFileSize) {
				return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
						.contentType(MediaType.APPLICATION_JSON_UTF8)
						.body("개별 파일 크기가 최대 크기 " + maxFileSizeInMB + "를 초과했습니다");
			}
			
			// 3. 파일 타입 체크
			if (!fileUploadUtil.validateFileType(file)) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                		.contentType(MediaType.APPLICATION_JSON_UTF8)
                		.body("허용되지 않는 파일 형식입니다. (jpg, jpeg, png, gif 파일만 가능)");
            }
		}
		
		// 4. 전체 파일 크기 체크
		if(totalSize > maxFileSize) {
			return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
					.contentType(MediaType.APPLICATION_JSON_UTF8)
					.body("전체 파일 크기가 최대 크기 " + maxFileSizeInMB + "를 초과했습니다");
		}
        
		request.setBook_id(bookId);
		bookService.update(request, files);
		
		return ResponseEntity.status(HttpStatus.OK).body(request);
	}
	
	/* 
	 * 관리자 - 상품 삭제
	 */
	@DeleteMapping("/{id}")
	public ResponseEntity<?> bookDelete(@PathVariable("id") int bookId) 
			throws Exception {
		log.info("**상품 삭제 처리**");
		
		try {
			bookService.delete(bookId);
			return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
			
	    } catch (Exception e) {
	        log.error("상품 삭제 실패 - 시스템 에러, bookId: " + bookId, e);
	        return ResponseEntity
	            .status(HttpStatus.INTERNAL_SERVER_ERROR)
	            .contentType(MediaType.APPLICATION_JSON_UTF8)
	            .body("상품 삭제 중 오류가 발생했습니다.");
	    }
	}
		
}
