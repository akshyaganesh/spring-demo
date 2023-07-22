package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DemoController {
    
    @GetMapping("/")
    @ResponseBody

    public String home(){
        return "Welcome to AD & AI team ";

    }

}
