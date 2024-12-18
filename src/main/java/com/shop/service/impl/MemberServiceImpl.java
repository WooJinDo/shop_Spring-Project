package com.shop.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.dao.MemberMapper;
import com.shop.dto.MemberDto;
import com.shop.model.MemberVO;
import com.shop.service.MemberService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
    private JavaMailSender mailSender;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Value("${mail.username}")
    private String mailUsername;
	
	/**
	 *  사용자 - 로그인 
	 */
	@Override
	public MemberDto.MemberLoginResponse login(MemberDto.MemberLoginRequest request) throws Exception {
		try {
	        // 1. 입력값 검증
	        if (StringUtils.isBlank(request.getUser_id()) || StringUtils.isBlank(request.getUser_pw())) {
	            return MemberDto.MemberLoginResponse.failure("아이디와 비밀번호를 입력해주세요.", false);
	        }

	        // 2. 사용자 조회
	        MemberVO vo = memberMapper.login(request.getUser_id().trim());
	        
	        // 3. 계정 상태 확인
	        if (vo != null && "N".equals(vo.getUse_flag())) {
	            return MemberDto.MemberLoginResponse.failure("탈퇴한 회원입니다.", false);
	        }

	        // 4. 비밀번호 검증
	        if (vo == null || !passwordEncoder.matches(request.getUser_pw().trim(), vo.getUser_pw())) {
	            // 보안을 위해 사용자가 존재하지 않는 경우에도 비밀번호 검증을 수행
	            passwordEncoder.matches("dummy", "$2a$10$dummyHash");
	            return MemberDto.MemberLoginResponse.failure("아이디 혹은 비밀번호가 일치하지 않습니다.", false);
	        }

	        // 5. 로그인 성공 처리
	        log.info("로그인 성공 - userId: " + request.getUser_id());
	        return MemberDto.MemberLoginResponse.success(vo, true);
	        
	    } catch (Exception e) {
	        log.error("로그인 처리 실패 - userId: " + request.getUser_id(), e);
	        throw new RuntimeException("로그인 처리 중 오류가 발생했습니다.", e);
	    }
	}
	
	/**
	 *  사용자 - 회원 등록
	 */	
	@Transactional
	@Override
	public MemberDto.MemberResponse insert(MemberDto.MemberRequest request) throws Exception {
		try {
			// 1. 입력값 유효성 검사
	        validateRegistrationData(request);
	        
	        // 2. 아이디 중복 검사
	        if (memberMapper.memberIdChk(request.getUser_id().trim()) > 0) {
	            throw new RuntimeException("이미 사용 중인 아이디입니다.");
	        }
	        
	        // 3. 이메일 중복 검사
	        if (memberMapper.checkDuplicateEmailForRegister(request.getUser_email().trim()) > 0) {
	            throw new RuntimeException("이미 사용 중인 이메일입니다.");
	        }
	        
			// 4. password 암호화
	        String encPassword = passwordEncoder.encode(request.getUser_pw().trim());
	        
	        // 5. 회원 정보 생성
			MemberVO vo = MemberVO.builder()
					.user_id(request.getUser_id().trim())
					.user_pw(encPassword)
					.user_name(request.getUser_name().trim())
					.user_email(request.getUser_email().trim())
					.post_no(request.getPost_no())
					.addr(request.getAddr())
					.addr_detail(request.getAddr_detail().trim())
					.admin_ck("USER")
					.money(100000)  // 신규 회원 기본 머니
					.point(5000) 	// 신규 회원 기본 포인트
					.use_flag("Y")  // 사용 상태
					.build();
			
			// 6. DB 저장
			memberMapper.insert(vo);
			log.info("회원 가입 완료 - userId: " + request.getUser_id());
			
			return MemberDto.MemberResponse.from(true);
		
		} catch (RuntimeException e) {
	        log.error("회원 가입 실패 - message: " + e.getMessage());
	        throw e;
		} catch (Exception e) {
		    log.error("회원 가입 실패", e);
		    throw new RuntimeException("회원 가입 처리 중 오류가 발생했습니다.", e);
		}
	}

	/**
	 *  사용자 - 회원 중복 확인
	 */	
	@Override
	public MemberDto.MemberIdChkResponse memberIdChk(String userId) throws Exception {
		int i = memberMapper.memberIdChk(userId);
		if(i > 0) {
			return MemberDto.MemberIdChkResponse.from("N");	//이미 존재하는 아이디
		}
		return MemberDto.MemberIdChkResponse.from("Y");	//사용가능한 아이디
	}
	
	/**
	 *  사용자 - 이메일 인증
	 */	
	@Override
	public MemberDto.MemberEmailChkResponse memberEmailChk(String email) {
		try {
	        // 1. 이메일 유효성 검사
	        if (StringUtils.isBlank(email)) {
	            throw new RuntimeException("이메일을 입력해주세요.");
	        }
	        if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
	            throw new RuntimeException("유효하지 않은 이메일 형식입니다.");
	        }
	        // 1-1. 이메일 중복 검사
	        if (memberMapper.checkDuplicateEmailForRegister(email.trim()) > 0) {
	            throw new RuntimeException("이미 사용 중인 이메일입니다.");
	        }
	        
	        // 2. 인증번호 생성
			Random random = new Random();
			int min = 111111;
			int max = 999999;
			int chkNum = min + random.nextInt(max-min+1); //nextInt: 0부터 n-1까지의 정수를 반환
			log.info("인증번호 생성 - email: " + email.trim() + ", code: " + chkNum);
			
			// 3. 이메일 내용 구성
	        String setFrom = mailUsername;	//네이버 2단계 인증 x, root-context.xml파일 mailSender.username과 동일해야 됨, 발신자
	        log.info("mailUsername************ : " + mailUsername);
	        String toMail = email.trim(); 			//수신자
	        String title = "회원가입 인증 이메일 입니다."; 
	        String content = buildEmailContent(chkNum);  // 이메일 내용 생성
	        
	        // 4. 이메일 발송
	        try {
	            //Multipart 데이터 처리가능
	            MimeMessage message = mailSender.createMimeMessage();
	            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8"); // true는 멀티파트 메세지를 사용하겠다는 의미
	            helper.setFrom(setFrom);//발신자
	            helper.setTo(toMail);	//수신자
	            helper.setSubject(title);
	            helper.setText(content,true); // true는 html을 사용하겠다는 의미입니다.
	            mailSender.send(message);
	            
	            log.info("인증 메일 발송 성공 - email: " + email);
	            
	        }catch(Exception e) {
	        	 log.error("인증 메일 발송 실패 - email: " + email, e);
	             throw new RuntimeException("인증 메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요.");
	        }
	        
			return MemberDto.MemberEmailChkResponse.from(chkNum);
			
		} catch (RuntimeException e) {
	        log.error("이메일 인증 처리 실패 - email: " + email + ", message: " + e.getMessage());
	        throw e;
	    }
	}
	
	private String buildEmailContent(int authCode) {
	    return new StringBuilder()
	        .append("<div style='margin:20px;'>")
	        .append("<h1>회원가입 인증 코드</h1>")
	        .append("<p>안녕하세요. 회원가입을 위한 인증번호를 안내해드립니다.</p>")
	        .append("<p>아래의 인증번호를 입력해주세요:</p>")
	        .append("<div style='font-size:24px;padding:20px;background-color:#f8f9fa;'>")
	        .append(authCode)
	        .append("</div>")
//	        .append("<p>본 인증번호는 5분간 유효합니다.</p>")
	        .append("</div>")
	        .toString();
	}

	/**
	 * 관리자 - 회원 전체 수
	 */	
	@Override
	public int selectTotalCount(MemberDto.MemberSearchRequest request) throws Exception {
		return memberMapper.selectTotalCount(request);
	}
	
	/**
	 * 관리자 - 회원 리스트
	 */	
	@Override
	public List<MemberDto.MemberListResponse> selectMemberList(MemberDto.MemberSearchRequest request) throws Exception {
        try {
            List<MemberVO> voList = memberMapper.selectMemberList(request);
            List<MemberDto.MemberListResponse> dtoList = new ArrayList<>();
            
            for(MemberVO vo : voList) {
                dtoList.add(MemberDto.MemberListResponse.from(vo));
            }
            
            log.info("회원 목록 조회 성공 - totalCount: " + dtoList.size() + ", currentPage: " + request.getCurrentPage());
            
            return dtoList;
        } catch (Exception e) {
            log.error("회원 리스트 조회 실패", e);
            throw new RuntimeException("회원 리스트 조회 중 오류가 발생했습니다.", e);
        }
	}
	
	/**
	 * 관리자 - 회원 상세 조회
	 */	
	@Override
	public MemberDto.MemberDetailResponse selectMemberDetail(String userId) throws Exception {
        try {
			MemberVO vo = memberMapper.selectMemberDetail(userId);
			if(vo == null) {
				throw new RuntimeException("존재하지 않는 회원입니다.");
			}
            
            return MemberDto.MemberDetailResponse.from(vo);
            
        } catch (RuntimeException e) {
	        log.error("회원 상세 조회 실패 - userId: " + userId + ", message: " + e.getMessage());
	        throw e;
	        
	    } catch (Exception e) {
	    	log.error("회원 상세 조회 실패 - userId: " + userId, e);
	    	throw new RuntimeException("회원 상세 정보 조회 중 오류가 발생했습니다.", e);
	    }
	}
	
	/**
	 * 관리자 - 회원 정보 수정
	 */	
	@Transactional
	@Override
	public void updateMember(MemberDto.MemberUpdateRequest request) throws Exception {
	    try {
	        // 1. 존재하는 회원인지 확인
	        MemberVO member = memberMapper.selectMemberDetail(request.getUser_id());
	        if (member == null) {
	            throw new RuntimeException("존재하지 않는 회원입니다.");
	        }

	        // 2. 이메일 중복 체크 (본인 이메일 제외)
	        if (memberMapper.checkDuplicateEmailForUpdate(request.getUser_email().trim(), request.getUser_id() ) > 0) {
	            throw new RuntimeException("이미 사용 중인 이메일입니다.");
	        }
	        
	        // 3. 관리자 권한 체크
	        // 3-1. 관리자 -> 일반회원 변경 제한
//	        if ("ADMIN".equals(member.getAdmin_ck()) && !"ADMIN".equals(request.getAdmin_ck())) {
//	            throw new RuntimeException("관리자 계정의 권한은 변경할 수 없습니다.");
//	        }
//	        
//	        // 3-2. 일반회원 -> 관리자 변경 제한
//	        if (!"ADMIN".equals(member.getAdmin_ck()) && "ADMIN".equals(request.getAdmin_ck())) {
//	            throw new RuntimeException("관리자 권한으로 변경할 수 없습니다.");
//	        }
//	        
//	        // 3-3. 탈퇴회원 -> 정상회원 변경 제한
//	        if ("N".equals(member.getUse_flag()) && "Y".equals(request.getUse_flag())) {
//	            throw new RuntimeException("탈퇴한 회원은 정상 회원으로 변경할 수 없습니다.");
//	        }

	        // 4. 데이터 유효성 검증
	        validateUpdateData(request);

	        // 5. 업데이트할 데이터 생성
	        MemberVO memberVO = MemberVO.builder()
	                .user_id(request.getUser_id())
	                .user_name(request.getUser_name().trim())
	                .user_email(request.getUser_email().trim())
	                .post_no(request.getPost_no())
	                .addr(request.getAddr())
	                .addr_detail(request.getAddr_detail().trim())
	                .money(request.getMoney())
	                .point(request.getPoint())
	                .use_flag(request.getUse_flag())
	                .admin_ck(request.getAdmin_ck())
	                .build();

	        // 6. 회원 정보 수정
	        memberMapper.updateMember(memberVO);
	        log.info("회원 정보 수정 완료 - userId: " + request.getUser_id());

	    } catch (RuntimeException e) {
	        log.error("회원 정보 수정 실패 - userId: " + request.getUser_id() + ", message: " + e.getMessage());
	        throw e;
	    } catch (Exception e) {
	        log.error("회원 정보 수정 실패 - userId: " + request.getUser_id(), e);
	        throw new RuntimeException("회원 정보 수정 중 오류가 발생했습니다.", e);
	    }
	}
	
	/**
	 * 관리자 - 회원 탈퇴 처리 (논리적 삭제)
	 */	
	@Transactional
	@Override
	public void deleteMember(String userId) throws Exception {
		try {
			// 회원 존재 여부 확인 로직 추가
			MemberVO member = memberMapper.selectMemberDetail(userId);
			if(member == null) {
				throw new RuntimeException("존재하지 않는 회원입니다.");
			}
			
			// 이미 탈퇴한 회원인지 확인
	        if ("N".equals(member.getUse_flag())) {
	            throw new RuntimeException("이미 탈퇴 처리된 회원입니다.");
	        }
	        
			// 관리자 계정은 삭제 불가 처리
			if("ADMIN".equals(member.getAdmin_ck())) {
				throw new RuntimeException("관리자 계정은 삭제할 수 없습니다.");
			}
			
			// 회원 탈퇴 처리 (논리적 삭제)
			memberMapper.deleteMember(userId);
			log.info("회원 탈퇴 처리 완료 - userId: " + userId);
			
		} catch (RuntimeException e) {
	        // RuntimeException은 그대로 throw (우리가 발생시킨 검증 예외들)
	        log.error("회원 탈퇴 처리 실패 - userId: " + userId + ", message: " + e.getMessage());
	        throw e;  // 원래 예외를 그대로 전달
	    } catch (Exception e) {
	        // 그 외 예외는 일반적인 에러 메시지로 감싸서 throw
	        log.error("회원 탈퇴 처리 실패 - userId: " + userId, e);
	        throw new RuntimeException("회원 탈퇴 처리 중 오류가 발생했습니다.", e);
	    }
	}
	
	/**
	 * 회원가입 데이터 유효성 검사
	 */	
	private void validateRegistrationData(MemberDto.MemberRequest request) {
	    // ID 검증
	    if (StringUtils.isBlank(request.getUser_id())) {
	        throw new RuntimeException("아이디는 필수 입력값입니다.");
	    }
	    if (!request.getUser_id().matches("^(?=.*[a-zA-Z])(?=.*\\d)[a-zA-Z0-9]{4,20}$")) {
	        throw new RuntimeException("아이디는 영문, 숫자 4~20자로 입력해주세요.");
	    }

	    // 비밀번호 검증
	    if (StringUtils.isBlank(request.getUser_pw())) {
	        throw new RuntimeException("비밀번호는 필수 입력값입니다.");
	    }
	    if (!request.getUser_pw().matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")) {
	        throw new RuntimeException("비밀번호는 영문, 숫자, 특수문자를 포함하여 8자 이상이어야 합니다.");
	    }

	    // 이름 검증
	    if (StringUtils.isBlank(request.getUser_name())) {
	        throw new RuntimeException("이름은 필수 입력값입니다.");
	    }
	    if (request.getUser_name().length() < 2 || request.getUser_name().length() > 50) {
	        throw new RuntimeException("이름은 2자 이상 50자 이하여야 합니다.");
	    }

	    // 이메일 검증
	    if (StringUtils.isBlank(request.getUser_email())) {
	        throw new RuntimeException("이메일은 필수 입력값입니다.");
	    }
	    if (!request.getUser_email().matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
	        throw new RuntimeException("유효하지 않은 이메일 형식입니다.");
	    }

	    // 주소 검증
	    if (StringUtils.isBlank(request.getPost_no()) || 
	        StringUtils.isBlank(request.getAddr()) || 
	        StringUtils.isBlank(request.getAddr_detail())) {
	        throw new RuntimeException("주소 정보는 필수 입력값입니다.");
	    }
	}
	
	/**
	 * 회원 정보 수정 데이터 유효성 검증
	 */	
	private void validateUpdateData(MemberDto.MemberUpdateRequest request) {
	    // 필수 입력값 체크
	    if (StringUtils.isBlank(request.getUser_name())) {
	        throw new RuntimeException("이름은 필수 입력값입니다.");
	    }
	    if (request.getUser_name().length() < 2 || request.getUser_name().length() > 50) {
	        throw new RuntimeException("이름은 2자 이상 50자 이하여야 합니다.");
	    }
	    if (StringUtils.isBlank(request.getUser_email())) {
	        throw new RuntimeException("이메일은 필수 입력값입니다.");
	    }
	    String emailRegex = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
	    if (!request.getUser_email().matches(emailRegex)) {
	        throw new RuntimeException("유효하지 않은 이메일 형식입니다.");
	    }
	    if (StringUtils.isBlank(request.getPost_no())) {
	        throw new RuntimeException("우편번호는 필수 입력값입니다.");
	    }
	    if (StringUtils.isBlank(request.getAddr())) {
	        throw new RuntimeException("주소는 필수 입력값입니다.");
	    }
	    if (StringUtils.isBlank(request.getAddr_detail())) {
	        throw new RuntimeException("상세주소는 필수 입력값입니다.");
	    }

	    // 금액 유효성 체크
	    if (request.getMoney() < 0) {
	        throw new RuntimeException("머니는 0 이상이어야 합니다.");
	    }
	    if (request.getPoint() < 0) {
	        throw new RuntimeException("포인트는 0 이상이어야 합니다.");
	    }
	}
	
}
