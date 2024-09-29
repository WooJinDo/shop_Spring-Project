package com.shop.front.service.impl;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.shop.front.dao.MemberMapper;
import com.shop.front.dto.MemberDto;
import com.shop.front.model.MemberVO;
import com.shop.front.service.MemberService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
    private JavaMailSender mailSender;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	/* 
	 * 로그인 
	 */
	@Override
	public MemberDto.MemberLoginResponse login(MemberDto.MemberLoginRequest request) throws Exception {
	  	MemberVO vo = memberMapper.login(request.getUser_id().trim());
	  	
	  	if(vo == null || !passwordEncoder.matches(request.getUser_pw().trim(), vo.getUser_pw())) {
	  		// 보안을 위해 사용자가 존재하지 않는 경우에도 비밀번호 검증을 수행
	  		passwordEncoder.matches("dummy", "$2a$10$dummyHash");
	  		return MemberDto.MemberLoginResponse.failure("아이디 혹은 비밀번호가 일치하지 않습니다.", false);
	  	}
	  	return MemberDto.MemberLoginResponse.success(vo, true);
	}
	
	/*
	 * 회원 등록
	 */	
	@Override
	public MemberDto.MemberResponse insert(MemberDto.MemberRequest request) throws Exception {
		// password 암호화
        String encPassword = passwordEncoder.encode(request.getUser_pw().trim());
        
		MemberVO vo = MemberVO.builder()
				.user_id(request.getUser_id().trim())
				.user_pw(encPassword)
				.user_name(request.getUser_name().trim())
				.user_email(request.getUser_email().trim())
				.post_no(request.getPost_no())
				.addr(request.getAddr())
				.addr_detail(request.getAddr_detail().trim())
				.admin_ck("USER")
				.money(100000)
				.point(5000)
				.build();
		memberMapper.insert(vo);
		return MemberDto.MemberResponse.from(true);
	}

	/*
	 * 회원 중복 확인
	 */	
	@Override
	public MemberDto.MemberIdChkResponse memberIdChk(String userId) throws Exception {
		int i = memberMapper.memberIdChk(userId);
		if(i > 0) {
			return MemberDto.MemberIdChkResponse.from("N");	//이미 존재하는 아이디
		}
		return MemberDto.MemberIdChkResponse.from("Y");	//사용가능한 아이디
	}
	
	/*
	 * 이메일 인증
	 */	
	@Override
	public MemberDto.MemberEmailChkResponse memberEmailChk(String email) {
		/* 인증번호 난수생성 */
		Random random = new Random();
		int min = 111111;
		int max = 999999;
		int chkNum = min + random.nextInt(max-min+1); //nextInt: 0부터 n-1까지의 정수를 반환
		log.info("인증번호 : " + chkNum);
		
		/* 이메일 보내기 */
        String setFrom = "발신자@naver.com";	//네이버 2단계 인증 x, root-context.xml파일 mailSender.username과 동일해야 됨, 발신자
        String toMail = email.trim(); 			//수신자
        String title = "회원가입 인증 이메일 입니다."; 
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + chkNum + " 입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            //Multipart 데이터 처리가능
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8"); // true는 멀티파트 메세지를 사용하겠다는 의미
            helper.setFrom(setFrom);//발신자
            helper.setTo(toMail);	//수신자
            helper.setSubject(title);
            helper.setText(content,true); // true는 html을 사용하겠다는 의미입니다.
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        String emailNum = String.valueOf(chkNum);
        
		return MemberDto.MemberEmailChkResponse.from(emailNum);
	}

}
