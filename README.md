# 📚 도서 쇼핑몰 프로젝트

## 🔍 프로젝트 소개
 Spring MVC 아키텍처를 기반으로 REST API 방식 도서 쇼핑몰 웹 애플리케이션으로, 관리자와 사용자 기능을 구분하여 도서 판매 및 관리 기능을 제공합니다.

## ⚙️ 개발 환경
- **Backend**: Java 8, Spring MVC, Oracle DB, MyBatis
- **Frontend**: HTML5, CSS3, JavaScript(ES5), jQuery, Ajax
- **Tools**: Eclipse, Maven, Git
- **Server**: Apache Tomcat 9.0
- **API**: CKEditor, Daum 우편번호 API


## 📋 주요 기능
### 1. 관리자 기능
#### 1.1 작가 관리
  - 작가 CRUD 기능 구현
  - 검색 기능

[작가 관리 기능 시연]


https://github.com/user-attachments/assets/e0f8958d-ca10-4edf-a83d-95778b4e4c37


<br/>

#### 1.2 상품 관리
- 상품 CRUD 기능 구현
- 멀티 이미지 업로드 및 썸네일 자동 생성
- CKEditor를 활용한 상품 상세 설명 입력
- 임시 저장된 이미지의 실제 저장소 이동
- 3단계 계층형 카테고리 관리

[상품 관리 기능 시연]


https://github.com/user-attachments/assets/f2859228-90a1-4f6f-8b06-1b434b35d3e2


[임시 저장된 이미지의 실제 저장소 이동]

![1](https://github.com/user-attachments/assets/0033718c-54e9-46eb-92a8-a5ee48a20cbb)

![2](https://github.com/user-attachments/assets/5adea203-c3bc-4149-ad55-1da9b22cbfdf)


<br/>

#### 1.3 회원 관리
- 회원 목록 조회 및 검색
- 회원 상태 관리 (정상/탈퇴)
- 권한 관리 (관리자/일반회원)
- 회원 정보 수정

[회원 관리 기능 시연]


https://github.com/user-attachments/assets/27046566-a46a-4efc-b2bf-cd2debb7ced2

https://github.com/user-attachments/assets/7b7c445a-d4f7-4267-882f-4a7a097fb470


<br/>

### 2. 사용자 기능
#### 2.1 회원 기능
- 회원가입 시 실시간 ID 중복체크
- 이메일 인증
- BCrypt를 활용한 비밀번호 암호화
- 유효성 검사
- 권한별 접근 제어 및 세션 타임아웃 처리

[회원가입 프로세스 시연]


https://github.com/user-attachments/assets/6e35e38c-9726-4aea-bb0b-9dc17b402fd0

![이메일 인증](https://github.com/user-attachments/assets/be143683-a372-49a1-837e-c749a6a0dad6)


[권한별 페이지 접근 및 세션만료 프로세스 시연]


https://github.com/user-attachments/assets/4c851dbd-4695-41a5-8e70-c178a390b03e


<br/>

#### 2.2 상품 조회
- 계층형 카테고리별 상품 조회
- 상품 검색 및 필터링
- 검색 필터링
- 페이징 처리
- 상품 상세정보 (이미지 갤러리, 상품 정보)

[상품 조회 기능 시연]


https://github.com/user-attachments/assets/bb4465c1-0120-4b9e-9386-68a79f0f6095


<br/>

#### 2.3 장바구니
- 상품 담기 및 수량 조절
- 선택 상품 삭제
- 재고 수량 체크
- 실시간 금액 계산

[장바구니 기능 시연]


https://github.com/user-attachments/assets/7261ad74-59f7-4f46-aa88-782d788c280b


<br/>
  
## 💡 핵심 구현 내용

### 1. REST API 설계
```java
@RestController
@RequestMapping("/api/book")
public class ApiBookController {
    // 상품 등록 API 예시
    @PostMapping
    public ResponseEntity<?> bookAdd(@RequestPart("bookData") BookDto.BookRequest request,
            @RequestPart("files") List<MultipartFile> files) {
        // 구현 내용
    }
}
```

### 2. 트랜잭션 및 예외 처리
```java
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
		
		// 구현 내용...

		}
		
	} catch (Exception e) {
		log.error("상품 수정 실패", e);
		throw new RuntimeException("상품 수정 중 오류가 발생했습니다.", e);
	}
}
```

### 3.  보안 처리
```java
@Log4j
public class AuthenticationInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response
		, Object handler) throws Exception {
		
        HttpSession session = request.getSession();
        String requestURI = request.getRequestURI();
        log.info("AuthenticationInterceptor: preHandle called for path: " + request.getRequestURI());
        
    	// 로그인 여부 확인 - 로그인 하지 않았을 떄 
        if (!StringUtils.isNotBlank((String)session.getAttribute("userId"))) {
        	log.info("사용자가 존재하지 않습니다");
            // 로그인되지 않은 경우 - 관리자, 사용자 페이지 접근
            if (requestURI.startsWith("/admin") || requestURI.startsWith("/user")) {
                response.sendRedirect("/accessDenied");
                return false;
            }
            return true; // 공개 페이지는 접근 허용
        }

        // 로그인된 경우
        String role = (String) session.getAttribute("role");
        log.info("ROLE : " + role);

        if (requestURI.startsWith("/admin")) {
            // 관리자 페이지 접근 시
            if (!"ADMIN".equals(role)) {
                response.sendRedirect("/accessDenied");
                return false;
            }
        } else if (requestURI.startsWith("/user")) {
            // 일반 사용자 페이지 접근 시
            if (!"USER".equals(role) && !"ADMIN".equals(role)) {
                response.sendRedirect("/accessDenied");
                return false;
            }
        }

        return true; // 조건을 모두 통과하면 접근 허용
    }
	
}

```

### 4. 이미지 처리
```java
/**
 * 이미지 업로드 처리
 */
@Transactional
@Override
public void uploadImage(ImageDto.ImageUploadRequest request, List<MultipartFile> files)
		throws Exception {
	try {
		log.info("이미지 업로드*********  ");
		if (files != null && !files.isEmpty()) {
			// 1. 썸네일 처리가 필요한 타입인지 확인
			boolean needThumbnail = THUMBNAIL_TYPES.contains(request.getImageType());
			boolean hasExistingThumbnail = false;
			
			// 2. 썸네일이 필요한 타입일 경우 기존 썸네일 존재 여부 확인
			if(needThumbnail) {
				hasExistingThumbnail = checkExistingThumbnail(request.getImageType()
									, request.getRefId());
				log.info("기존 썸네일 유무********* : " + hasExistingThumbnail);
			}
			
			for (int i = 0; i < files.size(); i++) {
				MultipartFile file = files.get(i);
				
				if (!file.isEmpty()) {
					// 3. 썸네일 여부 결정: 썸네일이 필요한 타입이고, 
					// 기존 썸네일이 없고, 첫 번째 이미지인 경우
					boolean shouldBeThumbnail = needThumbnail && 
								!hasExistingThumbnail && i == 0;
					log.info("썸네일 생성 유무********* : " + shouldBeThumbnail);
					
					// 4. 파일 업로드 처리 
					// shouldBeThumbnail이 false면 썸네일 생성 안함
					String savedPath = fileUploadUtil.uploadFile(file
							, request.getImageType(), shouldBeThumbnail);
					
					// 5. 이미지 정보 생성
					ImageVO imageVo = ImageVO.builder()
						.image_type(request.getImageType())
						.ref_id(request.getRefId())
						// 첫 번째 이미지를 썸네일로 설정
						.is_thumbnail(shouldBeThumbnail ? "Y" : "N") 
						// ... 기타 필드 설정
						.build();
					
					// 6. DB에 이미지 정보 저장
					imageMapper.insertImage(imageVo);
					
					// 7. 썸네일 타입이고, 썸네일로 설정되었다면 플래그 업데이트
					if(needThumbnail && shouldBeThumbnail) {
						hasExistingThumbnail = true;
					}
				}
			}
		}
	} catch (Exception e) {
		log.error("이미지 업로드 실패", e);
		throw new RuntimeException("이미지 업로드 중 오류가 발생했습니다.", e);
	}
}


/**
 * 썸네일 생성
 */
public void createThumbnail(File originalFile, String datePath, String fileName) {
	try {
		BufferedImage originalImage = ImageIO.read(originalFile);
		int thumbnailWidth = 300;
		
		BufferedImage thumbnailImage = Scalr.resize(originalImage, 
			Scalr.Method.AUTOMATIC, 
			Scalr.Mode.FIT_TO_WIDTH,
			thumbnailWidth);
		
		String thumbnailPath = uploadPath + datePath + "thumb_" + fileName;
		File thumbnailFile = new File(thumbnailPath);
		ImageIO.write(thumbnailImage, 
					 FilenameUtils.getExtension(fileName), 
					 thumbnailFile);
					 
	} catch (IOException e) {
		logger.error("썸네일 생성 실패: " + e.getMessage());
	}
}
```


### 5. 스케줄링 작업
```java
   /**
     * 일반 이미지 정리 - 매일 새벽 2시 실행
     * 삭제된지 7일 지난 이미지 물리적 삭제 처리
     */
    @Scheduled(cron = "0 0 2 * * *") // 매일 새벽 2시에 실행 (초 분 시 일 월 요일)
    public void cleanupDeletedImages() {
    	try {
            log.info("일반 이미지 정리 - 매일 새벽 2시 실행");
            // 1. 삭제된지 7일 지난 이미지 조회
            List<ImageVO> expiredImages = imageMapper.selectExpiredImages();
            
            if (!expiredImages.isEmpty()) {
                List<Long> imageIds = new ArrayList<>();
                
                // 2. 물리적 파일 삭제
                for (ImageVO image : expiredImages) {
                    // 원본 이미지 삭제
                    String originalPath = uploadPath + image.getUpload_path() 
                                       + image.getSaved_name();
                    File originalFile = new File(originalPath);
                    if (originalFile.exists()) {
                        originalFile.delete();
                    }
                    
                    // 썸네일 이미지 삭제
                    if("Y".equals(image.getIs_thumbnail())) {
                    	String thumbPath = uploadPath + image.getUpload_path()
                						+ "thumb_" + image.getSaved_name();
				       File thumbFile = new File(thumbPath);
				       if (thumbFile.exists()) {
				           thumbFile.delete();
				       }
                    }
                    
                    imageIds.add(image.getImage_id());
                }
                log.info("만료되어 정리된 이미지 개수 : " + imageIds.size());
                // 3. 만료된 이미지 DB에서 완전히 삭제 (물리적 삭제)
                if (!imageIds.isEmpty()) {
                	imageMapper.deleteExpiredImages(imageIds);
                }
            }
        } catch (Exception e) {
            // 로그 기록 및 예외 처리
            log.error("일반 이미지 정리 작업 실패", e);
        }
    }
```

### 6. 데이터베이스 인덱스 활용 및 MyBatis 동적 쿼리
```sql
<select id="selectImagesByRefId" resultType="com.shop.model.ImageVO">
        SELECT /*+ INDEX(ui IDX_UPLOADED_IMAGE_01) */
            IMAGE_ID
            , IMAGE_TYPE
            , REF_ID
            , ORIGINAL_NAME
            , SAVED_NAME
            , UPLOAD_PATH
            , FILE_SIZE
            , IS_THUMBNAIL
            , IS_DELETED
            , TO_CHAR(REG_DATE, 'YYYY-MM-DD') AS REG_DATE
        FROM UPLOADED_IMAGE ui
        WHERE IMAGE_TYPE = #{imageType}
        <if test="refId != null">
            AND REF_ID = #{refId}
        </if>
        AND IS_DELETED = 'N'
        ORDER BY IS_THUMBNAIL DESC, IMAGE_ID ASC 
    </select>
```

### 7. 모달 및 비동기 통신
```javascript
// 모달창을 활용한 작가 선택 UI
function modalAuthorList(page) {
	var formData = {
		currentPage: page,
		itemsPerPage: 5,
		searchType: $('select[name="searchType"]').val(),
		keyword: $('input[name="keyword"]').val()
	};

	$.ajax({
		url: '/api/author',
		method: 'GET',
		dataType: 'json',		
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
```

<br/>

## 🔧 기술 스택 상세

### 1. 프론트엔드
- **비동기 통신**
  - jQuery와 Ajax를 활용한 실시간 데이터 처리
  - REST API 호출 및 JSON 기반 데이터 통신
  - 비동기 파일 업로드 처리

- **사용자 경험(UX) 최적화**
  - 실시간 입력값 유효성 검사
  - 모달창을 활용한 직관적인 UI 구현
  - 파일 업로드 미리보기 기능
  - 동적 UI 업데이트
  - 페이지네이션을 통한 데이터 분할 처리

### 2. 백엔드
- **Spring MVC 기반 설계**
  - REST API 아키텍처 구현
  - HTTP Methods(GET/POST/PUT/DELETE) 기반 엔드포인트 설계

- **데이터 접근 계층**
  - MyBatis를 활용한 동적 쿼리 처리
  - Oracle DB 연동 및 효율적인 데이터 처리
  - 트랜잭션 관리를 통한 데이터 정합성 보장

- **보안 및 검증**
  - 인터셉터를 통한 사용자 권한 검증
  - 요청 데이터 유효성 검사
  - 예외 처리를 통한 안정성 확보

### 3. 특징적 구현 사항
- **파일 처리**
  - 다중 이미지 업로드 지원
  - 자동화된 미사용 이미지 정리
  - 에디터 이미지를 임시 저장소 활용으로 업로드 안정성 확보

- **예외 처리**
  - 사용자 친화적 에러 메시지 제공
  - 예외 로깅을 통한 시스템 모니터링

- **자동화된 유지보수**
  - 스케줄링을 통한 임시 파일 정리
  - 만료 데이터 자동 정리

<br/>

## 🌟 성과 및 개선사항

### 성과
- Spring MVC 아키텍처를 활용한 확장 가능한 웹 애플리케이션 구현
- REST API 설계를 통한 효율적인 데이터 통신 구현
- MyBatis 동적 쿼리를 활용한 효율적인 데이터베이스 처리
- 체계적인 예외 처리와 트랜잭션 관리

### 개선사항
- JUnit을 활용한 단위 테스트 코드 작성
- 코드 리팩토링
- 전역 예외 처리 (@ControllerAdvice) 를 컨트롤러 계층에서 전역적으로 수행
- 미진한 기능 추가적 개발
