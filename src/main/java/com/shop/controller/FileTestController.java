package com.shop.controller;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FileTestController {
    
    @Value("${upload.path}")
    private String uploadPath;
    
    // properties 값 확인용 테스트
    @ResponseBody
    @GetMapping("/test/properties")
    public Map<String, Object> testProperties() {
    	System.out.println("test********** : " + uploadPath);
        Map<String, Object> result = new HashMap<>();
        
        // 1. @Value 주입값 확인
        result.put("uploadPath", uploadPath);
        
        // 2. 시스템 프로퍼티 확인
        Properties props = System.getProperties();
        result.put("systemProperties", props);
        
        // 3. 클래스패스 확인
        ClassLoader classLoader = getClass().getClassLoader();
        try {
            Enumeration<URL> resources = classLoader.getResources("");
            List<String> paths = new ArrayList<>();
            while (resources.hasMoreElements()) {
                paths.add(resources.nextElement().getPath());
            }
            result.put("classpath", paths);
        } catch (IOException e) {
            result.put("error", e.getMessage());
        }
        
        return result;
    }
}
