package com.example.prjjsp2.controller;

import com.example.prjjsp2.dto.Member;
import com.example.prjjsp2.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("member")
public class MemberController {
    private final MemberService service;

    @GetMapping("register")
    public void signup() {
    }

    @PostMapping("register")
    public String signupProcess(Member member, RedirectAttributes rttr) {
        service.insertMember(member);

        rttr.addFlashAttribute("message", Map.of(
                "type", "success",
                "text", "Registered! Welcome to the Crew!"
        ));

        return "redirect:/board/list";
    }
}
