package com.example.pixelapi.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/api/testPages")
public class TestControllerPages {
    Logger logger = LoggerFactory.getLogger(TestControllerPages.class.getName());
    @GetMapping("/testPage")
    public String sendError(){

        return "TestPage";
    }
}
