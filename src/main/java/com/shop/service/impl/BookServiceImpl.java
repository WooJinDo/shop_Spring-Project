package com.shop.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.shop.dao.BookMapper;
import com.shop.dto.BookDto;
import com.shop.dto.CategoryDto;
import com.shop.dto.ImageDto;
import com.shop.dto.ImageDto.ImageUploadRequest;
import com.shop.model.BookVO;
import com.shop.model.CategoryVO;
import com.shop.model.ImageVO;
import com.shop.service.BookService;
import com.shop.service.ImageService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BookServiceImpl implements BookService {
	
	@Autowired
	private BookMapper bookMapper;
	
    @Autowired
    private ImageService imageService;
    
    /**
	 * 전체 카테고리 목록 조회
	 */
	@Override
	public List<CategoryDto.CategoryListResponse> selectCategoryList() throws Exception {
		try {
			List<CategoryVO> voList = bookMapper.selectCategoryList();
			List<CategoryDto.CategoryListResponse> dtoList = new ArrayList<>();
			
			for(CategoryVO vo : voList) {
				dtoList.add(CategoryDto.CategoryListResponse.from(vo));
			}
			
			return dtoList;
        } catch (Exception e) {
            log.error("전체 카테고리 조회 실패", e);
            throw new RuntimeException("전체 카테고리 조회 중 오류가 발생했습니다.");
        }
	}
	
	/**
	 * 특정 계층의 카테고리 조회 
	 */
    @Override
    public List<CategoryDto.CategoryListResponse> selectCategoryListByTier(int tier) 
    		throws Exception {
        try {
        	List<CategoryVO> voList = bookMapper.selectCategoryListByTier(tier);
        	List<CategoryDto.CategoryListResponse> dtoList = new ArrayList<>();
    		
    		for(CategoryVO vo : voList) {
    			dtoList.add(CategoryDto.CategoryListResponse.from(vo));
    		}
    		
            return dtoList;
        } catch (Exception e) {
            log.error("계층별 카테고리 조회 실패", e);
            throw new RuntimeException("카테고리 조회 중 오류가 발생했습니다.");
        }
    }
    
    /**
	 * 특정 부모 카테고리의 하위 카테고리 조회
	 */
    @Override
    public List<CategoryDto.CategoryListResponse> selectSubCategoryList(String parentCode) 
    		throws Exception {
        try {
            List<CategoryVO> voList = bookMapper.selectSubCategoryList(parentCode);
        	List<CategoryDto.CategoryListResponse> dtoList = new ArrayList<>();
    		
    		for(CategoryVO vo : voList) {
    			dtoList.add(CategoryDto.CategoryListResponse.from(vo));
    		}
    		
            return dtoList;
        } catch (Exception e) {
            log.error("하위 카테고리 조회 실패", e);
            throw new RuntimeException("하위 카테고리 조회 중 오류가 발생했습니다.");
        }
    }
    
    /**
	 * 카테고리별 상품리스트 조회
	 */
    @Override
    public List<BookDto.BookListCatetoryResponse> 
    selectBookListByCategory(BookDto.BookListCatetorySearchRequest request) throws Exception {
        try {
            List<BookVO> voList = bookMapper.selectBookListByCategory(request);
        	List<BookDto.BookListCatetoryResponse> dtoList = new ArrayList<>();
    		
    		for(BookVO vo : voList) {
    			dtoList.add(BookDto.BookListCatetoryResponse.from(vo));
    		}
    		
            return dtoList;
        } catch (Exception e) {
        	log.error("카테고리별 상품 리스트 조회 실패 - categoryCode: " + request.getCategoryCode(), e);
            throw new RuntimeException("상품 목록 조회 중 오류가 발생했습니다.");
        }
    }
    
    
    /**
	 * 카테고리별 상품 전체 개수 조회
	 */
    @Override
    public int selectTotalCountByCategory(BookDto.BookListCatetorySearchRequest request)
    		throws Exception {
        try {
            return bookMapper.selectTotalCountByCategory(request);
            
        } catch (Exception e) {
            log.error("카테고리별 상품 전체 개수 조회 실패 - categoryCode: " + 
                      request.getCategoryCode(), e);
            throw new RuntimeException("상품 개수 조회 중 오류가 발생했습니다.");
        }
    }
    
	/**
	 * 카테고리별 도서 상세 조회
	 */	
	@Override
	public Map<String, Object> selectShopBookDetail(int bookId) throws Exception {
		try {
			// 1. 결과를 담을 Map 생성
			Map<String, Object> result = new HashMap<>();
			
			// 2. 상품 기본 정보 조회
			BookVO vo = bookMapper.selectShopBookDetail(bookId);	
			BookDto.ShopBookDetailResponse shopBookDetail = BookDto.ShopBookDetailResponse.from(vo);
			
			// 3. 상품 이미지 정보 조회 (통합 이미지 테이블)
			List<ImageDto.ImageUploadResponse> imageList =  imageService.selectImagesByRefId("BOOK", (long) bookId);
			
			// 4. 결과 Map에 저장
			result.put("bookDetail", shopBookDetail);
			result.put("bookImages", imageList);
			
			return result;
			
		} catch (Exception e) {
			log.error("상품 상세 조회 실패 - bookId: " + bookId, e);
            throw new RuntimeException("상품 상세 정보 조회 중 오류가 발생했습니다.", e);
		}
		
	}
    
	/**
	 * 관리자 - 상품 등록
	 */	
	@Transactional
	@Override
	public void add(BookDto.BookRequest request, List<MultipartFile> files) throws Exception {
		try {
			// 1. 에디터 이미지 처리
	        // 임시 이미지들을 실제 경로로 이동 및 컨텐츠 내용과 url 업데이트(/uploads/temp -> /uploads/editor 경로로)
	        String updatedContents = imageService.moveEditorImagesToRealPath(request.getBook_contents(), "BOOK_CONTENTS");
	        String updatedIntro = imageService.moveEditorImagesToRealPath(request.getBook_intro(), "BOOK_INTRO");
	        
			// 2. 상품 정보 등록
			BookVO vo = BookVO.builder()
					.author_id(request.getAuthor_id())
					.category_code(request.getCategory_code().trim())
					.book_name(request.getBook_name().trim())
					.puble_year(request.getPuble_year().trim())
					.publisher(request.getPublisher().trim())
					.book_price(request.getBook_price())
					.book_stock(request.getBook_stock())
					.book_discount(request.getBook_discount())
					.book_contents(updatedContents)
					.book_intro(updatedIntro)
					.build();
			
			bookMapper.add(vo);
			int bookId = vo.getBook_id(); // 생성된 book_id
			
			log.info("상품 정보 등록 *************************** : " + vo);
			
			// 3. 이미지 파일 처리 - 통합 이미지 서비스 사용
			if (files != null && !files.isEmpty()) {
				// 이미지 업로드 요청 객체 생성
				ImageDto.ImageUploadRequest imageRequest = ImageUploadRequest.builder()
						.imageType("BOOK") 		// 상품
						.refId((long) bookId)	// 상품ID 참조
						.build();
				
				// 이미지 서비스를 통한 파일 업로드 처리
				imageService.uploadImage(imageRequest, files);
			}
			
		} catch (Exception e) {
            log.error("상품 등록 실패", e);
            throw new RuntimeException("상품 등록 중 오류가 발생했습니다.", e);
        }
		
	}
	
	/**
	 * 관리자 - 상품 수정
	 */
	@Transactional
	@Override
	public void update(BookDto.BookUpdateRequest request, List<MultipartFile> files) throws Exception {
		try {
			// 1. 기존 게시글 조회
			BookVO oldBook = bookMapper.selectBookDetail(request.getBook_id());
	        if (oldBook == null) {
	            throw new RuntimeException("수정할 상품을 찾을 수 없습니다.");
	        }
	        
	        if ("N".equals(oldBook.getUse_flag())) {
	            throw new RuntimeException("삭제된 상품은 수정할 수 없습니다.");
	        }
	        
	        // 2. 에디터 이미지 처리
	        // 2-1. 임시 이미지들을 실제 경로로 이동 및 컨텐츠 내용과 url 업데이트(/uploads/temp -> /uploads/editor 경로로)
			String updatedContents = imageService.moveEditorImagesToRealPath(request.getBook_contents(), "BOOK_CONTENTS");
			String updatedIntro = imageService.moveEditorImagesToRealPath(request.getBook_intro(), "BOOK_INTRO");
	        
	        // 2-2. 미사용 이미지 정리
			imageService.cleanupUnusedEditorImages(oldBook.getBook_contents(), updatedContents);
			imageService.cleanupUnusedEditorImages(oldBook.getBook_intro(), updatedIntro);
            
	         // 3. 상품 정보 수정
			BookVO vo = BookVO.builder()
					.book_id(request.getBook_id())
					.author_id(request.getAuthor_id())
					.category_code(request.getCategory_code().trim())
					.book_name(request.getBook_name().trim())
					.puble_year(request.getPuble_year().trim())
					.publisher(request.getPublisher().trim())
					.book_price(request.getBook_price())
					.book_stock(request.getBook_stock())
					.book_discount(request.getBook_discount())
					.book_contents(updatedContents)
					.book_intro(updatedIntro)
					.build();
			bookMapper.update(vo);
			log.info("수정 결과 *************************** : " + vo);
			
			// 4. 새로운 이미지 추가 전에 기존 썸네일 존재 여부 확인
			if (files != null && !files.isEmpty()) {
				// 이미지 업로드 요청 객체 생성
				ImageDto.ImageUploadRequest imageRequest = ImageUploadRequest.builder()
						.imageType("BOOK") 		// 상품
						.refId((long) request.getBook_id())	// 상품ID 참조
						.build();
				
				// 이미지 서비스를 통한 파일 업로드 처리
				imageService.uploadImage(imageRequest, files);
			}
			
		} catch (Exception e) {
            log.error("상품 수정 실패", e);
            throw new RuntimeException("상품 수정 중 오류가 발생했습니다.", e);
        }
	}
	
	/**
	 * 관리자 - 상품 삭제
	 */
	@Transactional
	@Override
	public void delete(int bookId) throws Exception {
		try {
	        // 1. 기존 상품 정보 조회 (에디터 이미지 URL 추출을 위해)
	        BookVO oldBook = bookMapper.selectBookDetail(bookId);
	        if(oldBook == null) {
	            throw new RuntimeException("삭제할 상품을 찾을 수 없습니다.");
	        }

	        // 2. 상품 정보 논리적 삭제 처리
	        if("N".equals(oldBook.getUse_flag())) {
	        	throw new RuntimeException("이미 삭제된 상품입니다.");
	        }
	        bookMapper.delete(bookId);
	        log.info("상품 정보 삭제 완료 - bookId: " + bookId);

	        // 3. 상품 이미지 논리적 삭제 처리
	        List<ImageDto.ImageUploadResponse> bookImages = 
	            imageService.selectImagesByRefId("BOOK", (long) bookId);
	        
	        for(ImageDto.ImageUploadResponse image : bookImages) {
	            imageService.softDeleteImage(image.getImage_id());
	        }
	        log.info("상품 이미지 삭제 완료 - imageCount: " + bookImages.size());

	        // 4. 에디터 이미지 논리적 삭제 처리
	        // 4-1. 상품 내용의 에디터 이미지 삭제
	        List<String> contentUrls = imageService.extractImageUrls(oldBook.getBook_contents(), false);
	        for(String url : contentUrls) {
	            String imagePath = url.replace("/uploads/", "");
	            ImageVO imageVO = imageService.selectImageByPath(imagePath);
	            if(imageVO != null) {
	                imageService.softDeleteImage(imageVO.getImage_id());
	            }
	        }
	        
	        // 4-2. 상품 소개의 에디터 이미지 삭제
	        List<String> introUrls = imageService.extractImageUrls(oldBook.getBook_intro(), false);
	        for(String url : introUrls) {
	            String imagePath = url.replace("/uploads/", "");
	            ImageVO imageVO = imageService.selectImageByPath(imagePath);
	            if(imageVO != null) {
	                imageService.softDeleteImage(imageVO.getImage_id());
	            }
	        }
	        log.info("에디터 이미지 삭제 완료 - contentUrlCount: " + contentUrls.size() + 
	                ", introUrlCount: " + introUrls.size());

	    } catch (Exception e) {
	        log.error("상품 삭제 실패 - bookId: " + bookId, e);
	        throw new RuntimeException("상품 삭제 중 오류가 발생했습니다.", e);
	    }
	}

	/**
	 * 관리자 - 상품 전체 게시글 수
	 */	
	@Override
	public int selectTotalCount(BookDto.BookSearchRequest request) throws Exception {
		try {
			return bookMapper.selectTotalCount(request);
			
	    } catch (Exception e) {
	        log.error("전체 건수 조회 실패", e);
	        throw new Exception("전체 건수 조회 중 오류가 발생했습니다.");
	    }
	}

	/**
	 * 관리자 - 상품 리스트
	 * offset - 시작 게시물 번호, limit - 끝 게시물 번호
	 */	
	@Override
	public List<BookDto.BookListResponse> selectBookList(BookDto.BookSearchRequest request) 
			throws Exception {
		try {
			List<BookVO> voList = bookMapper.selectBookList(request);
			List<BookDto.BookListResponse> dtoList = new ArrayList<>();
			
			for(BookVO vo : voList) {
				dtoList.add(BookDto.BookListResponse.from(vo));
			}
			
			return dtoList;
		
	    } catch (Exception e) {
	        log.error("상품 리스트 조회 실패", e);
	        throw new Exception("상품 리스트 조회 중 오류가 발생했습니다.");
	    }
	}

	/**
	 * 관리자 - 상품 상세 조회
	 */	
	@Override
	public Map<String, Object> selectBookDetail(int bookId) throws Exception {
		try {
			// 1. 결과를 담을 Map 생성
			Map<String, Object> result = new HashMap<>();
			
			// 2. 상품 기본 정보 조회
			BookVO vo = bookMapper.selectBookDetail(bookId);	
			BookDto.BookDetailResponse bookDetail = BookDto.BookDetailResponse.from(vo);
			
			// 3. 상품 이미지 정보 조회 (통합 이미지 테이블)
			List<ImageDto.ImageUploadResponse> imageList =  imageService.selectImagesByRefId("BOOK", (long) bookId);
			
			// 4. 결과 Map에 저장
			result.put("bookDetail", bookDetail);
			result.put("bookImages", imageList);
			
			return result;
			
		} catch (Exception e) {
			log.error("상품 상세 조회 실패 - bookId: " + bookId, e);
            throw new RuntimeException("상품 상세 정보 조회 중 오류가 발생했습니다.", e);
		}
		
	}
	
}
