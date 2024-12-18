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
							<li class="active"><a href="/member/register">회원가입</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->
			
	<!-- Shop Login -->
	<section class="shop login section">
		<div class="container">
			<div class="row"> 
				<div class="col-lg-6 offset-lg-3 col-12">
					<div class="login-form">
						<h2>회원가입</h2>
						<p>보다 빠른 결제를 위해 회원가입을 해주세요</p>
						<!-- Form -->
						<form id="registerForm" class="form">
							<div class="row">
								<div class="col-12" style="margin-bottom: 20px;">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>아이디<span>*</span></label>
										<input type="text" id="user_id" class="id_input" name="user_id" placeholder="" >
									</div>
									<span class="id_input_msg"></span>
									<span class="input_msg"></span>
								</div>
							
								<div class="col-12" style="margin-bottom: 20px;">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>비밀번호<span>*</span></label>
										<input type="password" id="user_pw" name="user_pw" placeholder="" >
									</div>
									<span class="input_msg"></span>
								</div>
								
								<div class="col-12" style="margin-bottom: 20px;">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>비밀번호 확인<span>*</span></label>
										<input type="password" id="confirm_password" placeholder="" >
									</div>
									<span class="input_msg"></span>
								</div>
								
								<div class="col-12" style="margin-bottom: 20px;">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>이름<span>*</span></label>
										<input type="text" id="user_name" name="user_name" placeholder="" >
									</div>
									<span class="input_msg"></span>
								</div>
								
								<div class="col-12" style="margin-bottom: 20px;">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>Email<span>*</span></label>
										<br/>
										<input type="email" id="user_email" name="user_email" placeholder="" >
									</div>
									<span class="input_msg"></span>
								</div>
								
								<div class="col-12" style="margin-bottom: 20px;">
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" id="emailChk_input" placeholder="" style="width:65%; background-color: #cccccc38;" maxlength="6" disabled="disabled" >
										<button class="btn" id="emailChkBtn" type="button" style="width:30%; margin-left:10px;">인증번호 전송</button>
									</div>
									<span class="emailChk_input_msg"></span>
								</div>
								
								<div class="col-12" style="margin-bottom: 20px;">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>우편번호<span>*</span></label>
										<br/>
										<input type="text" id="post_no" name="post_no" placeholder="" style="width:65%;" disabled="disabled" >
										<button class="btn" onclick="execDaumPostcode()" type="button" style="width:30%; margin-left:10px;">우편번호 찾기</button>
									</div>
									<span class="input_msg"></span>
								</div>
								
								<div class="col-12" style="margin-bottom: 20px;">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>주소<span>*</span></label>
										<input type="text" id="addr" name="addr" placeholder="" disabled="disabled" >
									</div>
									<span class="input_msg"></span>
								</div>
								
								<div class="col-12" style="margin-bottom: 20px;">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>상세 주소<span>*</span></label>
										<input type="text" id="addr_detail" name="addr_detail" placeholder="" >
									</div>
									<span class="input_msg"></span>
								</div>
								
								<div class="col-12" style="margin-bottom: 20px;">
									<div class="form-group login-btn">
										<button class="btn" type="submit" style="width:100%;">가입하기</button>
									</div>
								</div>
							</div>
						</form>
						<!--/ End Form -->
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ End Login -->

	<!-- 다음 우편번호 팝업 -->
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:5;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>

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
					  extraAddr += data.bname;
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
			  document.getElementById('post_no').value = data.zonecode;
			  document.getElementById("addr").value = addr;
			  // 커서를 상세주소 필드로 이동한다.
			  document.getElementById("addr_detail").focus();

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
	
	/* 이메일 인증 */
	var emailCode = "";	// 이메일 인증번호 저장
	$('#emailChkBtn').on('click', function(){
		var email = $('#user_email').val(); 	// 입력한 이메일
		var $emailChk = $('#emailChk_input'); 	// 인증번호 입력란
		
		if(validateEmail()){					// 이메일 유효성 검사
			$.ajax({
				  url: "/api/members/verification-codes",  			// 요청을 보낼 URL
				  type: "POST",                          // HTTP 메서드 (GET, POST 등)
				  dataType: "json",                     // 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
				  data: {email : email},   				//쿼리 파라미터 형식
				  success: function(response) {         // 성공 시 실행되는 함수
					console.log(response);              // 응답 데이터 처리
					$emailChk.attr("disabled", false).css("background-color","#F6F7FB");
					emailCode = response.emailNum;		// Json 데이터 추출
					alert("해당 이메일로 인증번호가 전송되었습니다.");
				  },
				  error: function(xhr, status, error) { // 실패 시 실행되는 함수
					console.error('Error:', error);     // 에러 처리
	                // 서버에서 전달된 메시지 출력
	                if (xhr.responseText) {
	                    alert(xhr.responseText);
	                } else {
	                	alert("이메일 인증 호출이 실패했습니다.");
	                }
				}
			});
		}
	});
	
	/* 회원 중복 확인 */
	var debounceTimer;	// 함수 바깥에 선언하면, 입력 이벤트 간에 타이머를 공유할 수 있어 중복된 서버 요청을 방지
	$('.id_input').on("input", function(){
		clearTimeout(debounceTimer);  				// 이벤트가 다시 발생할 때 이전 타이머를 제거
		var user_id = $('#user_id').val();
		
		$('.id_input_msg').text('').removeAttr('style');	// text 초기화 및 모든 인라인 스타일 제거
		if(validateUserId()) {							// 아이디 유효성 검사
			debounceTimer = setTimeout(function() {		// 새로운 타이머 설정(지속적으로 이벤트를 발생시키는 상황에서 이벤트 호출을 지연)
				$.ajax({
					  url: "/api/members/" + user_id + "/exists",  		    // 요청을 보낼 URL
					  type: "GET",                         // HTTP 메서드 (GET, POST 등)
					  dataType: "json",                     // 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
					  success: function(response) {         // 성공 시 실행되는 함수
						console.log(response);              // 응답 데이터 처리
						if(response.idChk == 'Y'){
							$('.id_input_msg').text('사용 가능한 아이디입니다.').css("display","inline-block").css('color', 'green');
						}else{
							$('.id_input_msg').text('이미 존재하는 아이디입니다.').css("display", "inline-block").css('color', 'red');
						}
					  },
					  error: function(xhr, status, error) { // 실패 시 실행되는 함수
						console.error('Error:', error);     // 에러 처리
						alert("중복 확인을 실패했습니다.");
					  }
				});
			
			}, 800);  // 사용자가 800ms 동안 입력을 멈출 때만 서버로 요청
		}

	});

	/* 회원 등록 */
	$("#registerForm").on('submit',function(e) {
		e.preventDefault();  // 폼 제출이 기본적으로 새로고침을 유발하므로, 이를 방지하기 위해
		
		// 폼 제출 성공여부
		if(validateForm()) {
	       console.log('폼 제출 성공');
		       
			// 폼 데이터를 객체로 변환
			var formData = {
				user_id: $('#user_id').val()
				, user_pw: $('#user_pw').val()
				, user_name: $('#user_name').val()
				, user_email: $('#user_email').val()
				, post_no: $('#post_no').val()
				, addr: $('#addr').val()
				, addr_detail: $('#addr_detail').val()
			};
			
			$.ajax({
				  url: "/api/members",  				// 요청을 보낼 URL
				  type: "POST",                         // HTTP 메서드 (GET, POST 등)
				  dataType: "json",                     // 응답 데이터 타입 (json, xml 등) - 서버가 보내온 응답을 어떻게 처리할지를 정의
				  contentType: 'application/json; charset=utf-8',     // 콘텐츠 타입을 JSON으로 설정 - 클라이언트(브라우저)에서 서버로 보내는 데이터의 형식
				  data: JSON.stringify(formData),   	// 직렬화된 데이터를 JSON 형식으로 변환
				  success: function(response) {         // 성공 시 실행되는 함수
					console.log(response);              // 응답 데이터 처리
					alert('회원 가입을 완료했습니다. 로그인 후 이용해주세요.');
					location.href = '/member/login';
				  },
				  error: function(xhr, status, error) { // 실패 시 실행되는 함수
					console.error('Error:', error);     // 에러 처리
	                // 서버에서 전달된 메시지 출력
	                if (xhr.responseText) {
	                    alert(xhr.responseText);
	                } else {
	                	alert("회원 가입에 실패했습니다.");
	                }
				}
			}); 
		}
	});
	
	// 전체 폼 유효성 검사
	function validateForm() {
		var isValid = true;
        
		isValid = validateUserId() && isValid;
        isValid = validateUserName() && isValid;
        isValid = validateEmail() && isValid;
        isValid = validateEmailChk() && isValid;
        isValid = validatePassword() && isValid;
        isValid = validateConfirmPassword() && isValid;
        isValid = validatePostNo() && isValid;
        isValid = validateAddr() && isValid;
        isValid = validateAddrDetail() && isValid;
        
        return isValid;
    }
	
	// 사용자 아이디 유효성 검사
    function validateUserId() {
		var $userId = $('#user_id');				// jQuery로 선택한 요소라는 의미
		var userIdValue = $userId.val().trim();
		if(userIdValue === '') {
			setErrorFor($userId, '아이디를 입력해주세요.');
			return false;
		} else if(userIdValue.length < 4 || userIdValue.length > 20) {
			setErrorFor($userId, '아이디는 4자 이상 20자 이하이어야 합니다.'); //3-15자
			return false;
		} else if(!isValidUserId(userIdValue)) {
			setErrorFor($userId, '아이디는 영문, 숫자로 입력 가능합니다.');
			return false;
		} else {
			setSuccessFor($userId);
			return true;
		}
	}
	
	// 비밀번호 유효성 검사
    function validatePassword() {
        var $password = $('#user_pw');
        var passwordValue = $password.val().trim();
        if(passwordValue === '') {
            setErrorFor($password, '비밀번호를 입력해주세요.');
            return false;
        } else if(passwordValue.length < 8) {
            setErrorFor($password, '비밀번호는 8자 이상이어야 합니다.');
            return false;
        } else if(!isValidPassword(passwordValue)) {
            setErrorFor($password, '비밀번호는 영문, 숫자, 특수문자를 포함하여 8자 이상이어야 합니다.');
            return false;
        } else {
            setSuccessFor($password);
            return true;
        }
    }

    // 비밀번호 확인 유효성 검사
    function validateConfirmPassword() {
        var $password = $('#user_pw');
        var $confirmPassword = $('#confirm_password');
        var passwordValue = $password.val().trim();
        var confirmPasswordValue = $confirmPassword.val().trim();
        if(confirmPasswordValue === '') {
            setErrorFor($confirmPassword, '비밀번호 확인을 입력해주세요.');
            return false;
        } else if(confirmPasswordValue !== passwordValue) {
            setErrorFor($confirmPassword, '비밀번호가 일치하지 않습니다.');
            return false;
        } else{
            setSuccessFor($confirmPassword);
            return true;
        }
    }

    // 사용자명 유효성 검사
    function validateUserName() {
        var $username = $('#user_name');
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
        var $email = $('#user_email');
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
    
 	// 이메일 인증번호 비교 - blur 이벤트를 통해 실시간 인증번호 검사
	$('#emailChk_input').on('blur', function(){
		validateEmailChk();
	});
    
	// 이메일 인증번호 비교
	function validateEmailChk() {
		var emailChk = $('#emailChk_input').val().trim(); 	// 인증번호 값
		if(emailChk == ''){	// 인증번호 비교
			$('.emailChk_input_msg').text('인증번호를 입력해주세요.').css("display", "inline-block").css('color', 'red');
			return false;
		} else if(emailChk != emailCode){ 
			$('.emailChk_input_msg').text('인증번호를 다시 확인해주세요.').css("display", "inline-block").css('color', 'red');	
			return false;
		} else{
			$('.emailChk_input_msg').text('인증번호가 일치합니다.').css("display","inline-block").css('color', 'green');	
			return true;
		}
	}
 
 	// 주소 유효성 검사
    function validatePostNo() {
        var $postNo = $('#post_no');
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
        var $addrDetail = $('#addr_detail');
        var addrDetailValue = $addrDetail.val().trim();
        if(addrDetailValue === '') {
            setErrorFor($addrDetail, '상세주소를 입력해주세요.');
            return false;
        } else{
            setSuccessFor($addrDetail);
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
	
	// 아이디 유효성 검사 함수
    function isValidUserId(userId) {
        var regex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9]+$/; // 영문자, 숫자를 포함
        return regex.test(userId);	 // .test(): 정규표현식(RegExp) 객체에서 사용되는 메서드입니다. 이 메서드는 주어진 문자열이 정규표현식과 일치하는지 검사
    }
	
 	// 비밀번호 유효성 검사 함수
    function isValidPassword(password) {
    	var regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;  // 영문, 숫자, 특수문자를 포함
        return regex.test(password);
    }

    // 이메일 형식 검사 함수
    function isValidEmail(email) {
    	var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;  
        return regex.test(email);
    }
});
</script>

<%@ include file="/WEB-INF/views/common/commonFooter.jsp" %>
</body>
</html>