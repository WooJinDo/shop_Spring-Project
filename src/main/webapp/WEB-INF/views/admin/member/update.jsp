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
    .info-section {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    
    .info-title {
        font-weight: bold;
        margin-bottom: 10px;
        color: #333;
    }
    
    .input_msg {
        display: none;
        font-size: 12px;
        margin-top: 5px;
    }
    
    .point-input {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .point-input button {
        padding: 5px 10px;
        font-size: 12px;
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
						<h2 style="padding-bottom: 20px;">회원 정보 수정</h2>
						</div>
							<div class="form-main">
								<!-- Form -->
 								<form id="updateForm" class="form">
	                                <div class="row">
	                                    <!-- 기본 정보 섹션 -->
	                                    <div class="col-12">
	                                        <div class="info-section">
	                                            <div class="info-title">기본 정보</div>
	                                            <div class="row">
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>아이디<span>*</span></label>
	                                                        <input type="text" id="userId" name="userId" disabled>
	                                                    </div>
	                                                </div>
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>이름<span>*</span></label>
	                                                        <input type="text" id="userName" name="userName">
	                                                        <span class="input_msg"></span>
	                                                    </div>
	                                                </div>
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>이메일<span>*</span></label>
	                                                        <input type="email" id="userEmail" name="userEmail">
	                                                        <span class="input_msg"></span>
	                                                    </div>
	                                                </div>
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                	<div class="form-group" style="margin-bottom: 0px;">
															<label>회원 상태<span>*</span></label>
														</div>
	                                                    <div class="form-group">
	                                                        <select id="useFlag" name="useFlag">
	                                                            <option value="Y">정상</option>
	                                                            <option value="N">탈퇴</option>
	                                                        </select>
	                                                        <span class="input_msg"></span>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	
	                                    <!-- 주소 정보 섹션 -->
	                                    <div class="col-12">
	                                        <div class="info-section">
	                                            <div class="info-title">주소 정보</div>
	                                            <div class="row">
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>우편번호<span>*</span></label>
	                                                        <div class="input-group">
	                                                            <input type="text" id="postNo" name="postNo" disabled>
	                                                            <button class="btn" onclick="execDaumPostcode()" type="button" style="width:50%; margin-left:10px;">우편번호 찾기</button>
	                                                        </div>
	                                                        <span class="input_msg"></span>
	                                                    </div>
	                                                </div>
	                                                <div class="col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>기본주소<span>*</span></label>
	                                                        <input type="text" id="addr" name="addr" disabled>
	                                                        <span class="input_msg"></span>
	                                                    </div>
	                                                </div>
	                                                <div class="col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>상세주소<span>*</span></label>
	                                                        <input type="text" id="addrDetail" name="addrDetail">
	                                                        <span class="input_msg"></span>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	
	                                    <!-- 포인트/머니 정보 섹션 -->
	                                    <div class="col-12">
	                                        <div class="info-section">
	                                            <div class="info-title">포인트/머니 정보</div>
	                                            <div class="row">
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>보유 머니<span>*</span></label>
	                                                        <div class="point-input">
	                                                            <input type="text" id="money" name="money">
                                                                <button type="button" data-amount="1000">+1,000</button>
   																<button type="button" data-amount="-1000">-1,000</button>
	                                                        </div>
	                                                        <span class="input_msg"></span>
	                                                    </div>
	                                                </div>
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>보유 포인트<span>*</span></label>
	                                                        <div class="point-input">
	                                                            <input type="text" id="point" name="point">
                                                                <button type="button" data-amount="100">+100</button>
   																<button type="button" data-amount="-100">-100</button>
	                                                        </div>
	                                                        <span class="input_msg"></span>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	
	                                    <!-- 권한 정보 섹션 -->
	                                    <div class="col-12">
	                                        <div class="info-section">
	                                            <div class="info-title">권한 정보</div>
	                                            <div class="row">
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
		                                                <div class="form-group" style="margin-bottom: 0px;">
															<label>회원 구분<span>*</span></label>
														</div>
	                                                    <div class="form-group" style="margin-bottom: 0px;">
	                                                        <select id="adminCk" name="adminCk">
	                                                            <option value="USER">일반회원</option>
	                                                            <option value="ADMIN">관리자</option>
	                                                        </select>
	                                                        <span class="input_msg"></span>
	                                                    </div>
	                                                </div>
	                                                <div class="col-lg-6 col-12" style="margin-bottom: 20px;">
	                                                    <div class="form-group">
	                                                        <label>가입일<span>*</span></label>
	                                                        <input type="text" id="regDate" disabled>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	
	                                    <!-- 버튼 영역 -->
	                                    <div class="col-12" style="margin-top: 20px;">
	                                        <div class="form-group login-btn">
	                                            <button type="submit" class="btn">저장</button>
	                                            <button type="button" id="btn_detail" class="btn">취소</button>
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

	<!-- 다음 우편번호 팝업 -->
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:99;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>

<%@ include file="/WEB-INF/views/common/admin/commonFooter.jsp" %>	
<%@ include file="/WEB-INF/views/common/commonJs.jsp" %>
<!-- 다음 우편번호 API 적용 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
  // 우편번호 찾기 화면을 넣을 element
  var element_layer = document.getElementById('layer');

  function closeDaumPostcode() {
	  // iframe을 넣은 element를 안보이게 한다.
	  element_layer.style.display = 'none';
  }

  function execDaumPostcode() {
	  new daum.Postcode({
		  oncomplete: function(data) {
			  // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
			  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			  var addr = ''; // 주소 변수
			  var extraAddr = ''; // 참고항목 변수

			  //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				  addr = data.roadAddress;
			  } else { // 사용자가 지번 주소를 선택했을 경우(J)
				  addr = data.jibunAddress;
			  }

			  // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			  if(data.userSelectedType === 'R'){
				  // 법정동명이 있을 경우 추가한다. (법정리는 제외)
				  // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				  if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
// 					  extraAddr += data.bname;
				  }
				  // 건물명이 있고, 공동주택일 경우 추가한다.
				  if(data.buildingName !== '' && data.apartment === 'Y'){
					  extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				  }
				  // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				  if(extraAddr !== ''){
					  extraAddr = ' (' + extraAddr + ')';
				  }
				  // 조합된 참고항목을 해당 필드에 넣는다.
				  //document.getElementById("sample2_extraAddress").value = extraAddr;

			  } else {
				  //document.getElementById("sample2_extraAddress").value = '';
			  }

			  // 우편번호와 주소 정보를 해당 필드에 넣는다.
			  document.getElementById('postNo').value = data.zonecode;
			  document.getElementById("addr").value = addr;
			  // 커서를 상세주소 필드로 이동한다.
			  document.getElementById("addrDetail").focus();

			  // iframe을 넣은 element를 안보이게 한다.
			  // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
			  element_layer.style.display = 'none';
		  },
		  width : '100%',
		  height : '100%',
		  maxSuggestItems : 5
	  }).embed(element_layer);

	  // iframe을 넣은 element를 보이게 한다.
	  element_layer.style.display = 'block';

	  // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	  initLayerPosition();
  }

  // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
  // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
  // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
  function initLayerPosition(){
	  var width = 400; //우편번호서비스가 들어갈 element의 width
	  var height = 480; //우편번호서비스가 들어갈 element의 height
	  var borderWidth = 5; //샘플에서 사용하는 border의 두께

	  // 위에서 선언한 값들을 실제 element에 넣는다.
	  element_layer.style.width = width + 'px';
	  element_layer.style.height = height + 'px';
	  element_layer.style.border = borderWidth + 'px solid';
	  // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	  element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	  element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
  }
</script>
<script>
$(document).ready(function() {
	var user_id = '<c:out value= "${user_id}" />';
	
	/* 회원 상세 조회 시작 */
	memberDetail();
	
	/* 상품 상세 조회 */
	function memberDetail() {
	    $.ajax({
	        url: '/api/members/' + user_id,
	        method: 'GET',
	        dataType: "json",                     // 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
	        success: function(response) {
	        	$('#userId').val(response.user_id);
	            $('#userName').val(response.user_name);
	            $('#userEmail').val(response.user_email);
	            $('#postNo').val(response.post_no);
	            $('#addr').val(response.addr);
	            $('#addrDetail').val(response.addr_detail);
	            $('#money').val(response.money.toLocaleString());
	            $('#point').val(response.point.toLocaleString());
	            $('#useFlag').val(response.use_flag);
	            $('#adminCk').val(response.admin_ck);
	            $('#regDate').val(response.reg_date);
	            
				$('#useFlag, #adminCk').niceSelect('update');
    		},
			error: function(xhr, status, error) { // 실패 시 실행되는 함수
				console.error("회원 정보 조회 실패: " + status + ", " + error);     // 에러 처리
                // 서버에서 전달된 메시지 출력
                if (xhr.responseText) {
                    alert(xhr.responseText);
                } else {
                	alert("회원 정보 조회에 실패했습니다.");
                }
			}
	    });
	}
	
	/* 회원 수정 처리 */
    $('#updateForm').on('submit', function(e) {
        e.preventDefault();
        
        if(validateForm()) {
            if(confirm('회원 정보를 수정하시겠습니까?')) {
                var formData = {
                    user_id: $('#userId').val(),
                    user_name: $('#userName').val(),
                    user_email: $('#userEmail').val(),
                    post_no: $('#postNo').val(),
                    addr: $('#addr').val(),
                    addr_detail: $('#addrDetail').val(),
                    money: getNumericValue('#money'),
                    point: getNumericValue('#point'),
                    use_flag: $('#useFlag').val(),
                    admin_ck: $('#adminCk').val()
                };
                
                $.ajax({
                    url: '/api/members/' + user_id,
                    method: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                        alert('회원 정보가 수정되었습니다.');
                        goDetailPage();
                    },
                    error: function(xhr, status, error) {
                        // 서버에서 전달된 메시지 출력
                        if (xhr.responseText) {
                            alert(xhr.responseText);
                        } else {
                            alert('수정에 실패했습니다. 다시 시도해주세요.');
                        }
                    }
                });
            }
        }
    });
    
	$("#btn_detail").on('click', function() {
		goDetailPage();
	});
	
	/* 상품 상세페이지 이동 */
    function goDetailPage() {
    	// 브라우저의 현재 URL에서 쿼리스트링(쿼리 파라미터)를 가져옴
        var urlParams = new URLSearchParams(window.location.search);
        var page = urlParams.get('currentPage') || 1;
        var searchType = urlParams.get('searchType') || '';
        var keyword = urlParams.get('keyword') || '';
        var memberStatus = urlParams.get('memberStatus') || 'active';
        
		// URL 쿼리스트링 생성 - 빈 값은 제외
        var queryParams = [];
        if(page) {
            queryParams.push('currentPage=' + page);
        }
        if(memberStatus) {
            queryParams.push('memberStatus=' + memberStatus);
        }
        if(searchType && keyword) {
            queryParams.push('searchType=' + searchType);
            queryParams.push('keyword=' + encodeURIComponent(keyword)); // URI의 특정 부분을 안전하게 인코딩(특수문자, 공백)
        }
        
     	// 쿼리스트링 조합
        var newUrl = queryParams.length > 0 ? '?' + queryParams.join('&') : ''; // join() 배열의 요소들을 하나의 문자열로 합칠 때
        
        window.location.href = '/admin/member/detail/' + user_id + newUrl;
    }
	
 	// 전체 폼 유효성 검사
	function validateForm() {
		var isValid = true;
        
        isValid = validateUserName() && isValid;
        isValid = validateEmail() && isValid;
        isValid = validatePostNo() && isValid;
        isValid = validateAddr() && isValid;
        isValid = validateAddrDetail() && isValid;
        isValid = validateMoney() && isValid;
        isValid = validatePoint() && isValid;
        
        return isValid;
    }
	
    // 사용자명 유효성 검사
    function validateUserName() {
        var $username = $('#userName');
        var usernameValue = $username.val().trim();
        if(usernameValue === '') {
            setErrorFor($username, '사용자명을 입력해주세요.');
            return false;
        } else if(usernameValue.length < 2) {
            setErrorFor($username, '사용자명은 2자 이상이어야 합니다.');
            return false;
        } else{
            setSuccessFor($username);
            return true;
        }
    }

    // 이메일 유효성 검사
    function validateEmail() {
        var $email = $('#userEmail');
        var emailValue = $email.val().trim();
        if(emailValue === '') {
            setErrorFor($email, '이메일을 입력해주세요.');
            return false;
        } else if(!isValidEmail(emailValue)) {
            setErrorFor($email, '유효한 이메일 주소를 입력해주세요.');
            return false;
        } else{
            setSuccessFor($email);
            return true;
        }
    }
    
 	// 주소 유효성 검사
    function validatePostNo() {
        var $postNo = $('#postNo');
        var postNoValue = $postNo.val().trim();
        if(postNoValue === '') {
            setErrorFor($postNo, '우편번호를 입력해주세요.');
            return false;
        } else{
            setSuccessFor($postNo);
            return true;
        }
    }
 	
    function validateAddr() {
        var $addr = $('#addr');
        var addrValue = $addr.val().trim();
        if(addrValue === '') {
            setErrorFor($addr, '주소를 입력해주세요.');
            return false;
        } else{
            setSuccessFor($addr);
            return true;
        }
    }
    
    function validateAddrDetail() {
        var $addrDetail = $('#addrDetail');
        var addrDetailValue = $addrDetail.val().trim();
        if(addrDetailValue === '') {
            setErrorFor($addrDetail, '상세주소를 입력해주세요.');
            return false;
        } else{
            setSuccessFor($addrDetail);
            return true;
        }
    }
    
 	// 머니 유효성 검사
	function validateMoney() {
	    var $money = $('#money');
	    // 천단위 구분자 제거 후 검사
	    var value = $money.val().replace(/,/g, '');
	    if(value === '') {
	        setErrorFor($money, '보유 머니를 입력해주세요.');
	        return false;
	    } else if(isNaN(value) || parseInt(value) < 0) {
	        setErrorFor($money, '올바른 금액을 입력해주세요.');
	        return false;
	    } else {
	        setSuccessFor($money);
	        return true;
	    }
	}

    // 포인트 유효성 검사
	function validatePoint() {
	    var $point = $('#point');
	    // 천단위 구분자 제거 후 검사
	    var value = $point.val().replace(/,/g, '');
	    if(value === '') {
	        setErrorFor($point, '보유 포인트를 입력해주세요.');
	        return false;
	    } else if(isNaN(value) || parseInt(value) < 0) {
	        setErrorFor($point, '올바른 포인트를 입력해주세요.');
	        return false;
	    } else {
	        setSuccessFor($point);
	        return true;
	    }
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
	
    // 이메일 형식 검사 함수
    function isValidEmail(email) {
    	var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;  
        return regex.test(email);
    }
    
    // 포인트/머니 조정 버튼 클릭 이벤트
    $('.point-input button').on('click', function() {
        var $input = $(this).siblings('input');		// this의 형제 요소 중에서 <input> 태그를 선택
        var amount = parseInt($(this).data('amount'));
        
        // 현재 값에서 쉼표 제거 후 숫자로 변환
        var currentValue = parseInt($input.val().replace(/,/g, '')) || 0;
        var newValue = currentValue + amount;
        
        if(newValue >= 0) {
        	// 천단위 쉼표 추가하여 값 설정
            $input.val(newValue.toLocaleString());
        }
    });
    
 	// 직접 입력할 때도 천단위 구분 적용
    $('#money, #point').on('input', function() {
        // 현재 입력값에서 쉼표 제거
        var value = $(this).val().replace(/,/g, '');
        
        // 숫자가 아닌 문자 제거
        value = value.replace(/[^\d]/g, '');
        
        // 숫자로 변환
        var numValue = parseInt(value) || 0;
        
        // 천단위 쉼표 추가하여 다시 설정
        $(this).val(numValue.toLocaleString());
    });
    
 	// 천단위 구분자 제거 후 숫자로 변환
    function getNumericValue(selector) {
        var value = $(selector).val().replace(/,/g, '');
        var parsed = parseInt(value);
        return isNaN(parsed) ? 0 : parsed;
    }

	
});
</script>
</body>
</html>
