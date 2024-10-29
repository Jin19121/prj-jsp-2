package com.example.prjjsp2.controller;

import com.example.prjjsp2.dto.Member;
import com.example.prjjsp2.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
        try {
            service.insertMember(member);

            rttr.addFlashAttribute("message", Map.of(
                    "type", "success",
                    "text", "Registered! Welcome to the Crew!"
            ));

            return "redirect:/board/list";
        } catch (DuplicateKeyException e) {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "Nickname or e-mail already exists!"
            ));
            return "redirect:/member/register";
        }
    }

    @GetMapping("list")
    public void list(Model model) {
        model.addAttribute("memberList", service.list());
    }

    @GetMapping("view")
    public void info(String id, Model model) {
        Member member = service.view(id);
        model.addAttribute("member", member);
    }

    @PostMapping("delete")
    public String delete(String id, String password,
                         RedirectAttributes rttr) {
        if (service.delete(id, password)) {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "dark",
                    "text", "It was a pleasure to have you with us."
            ));
            return "redirect:/member/register";
        } else {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "Incorrect password"
            ));
            rttr.addAttribute("id", id);
            return "redirect:/member/view";
        }
    }

    @GetMapping("edit")
    public void edit(String id, Model model) {
        model.addAttribute("member", service.view(id));
    }

    @PostMapping("edit")
    public String editProcess(Member member, RedirectAttributes rttr) {
        try {
            service.update(member);
            rttr.addFlashAttribute("message", Map.of(
                    "type", "success",
                    "text", "Profile edited successfully!"
            ));
        } catch (DuplicateKeyException e) {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "Nickname or e-mail already exists!"
            ));
            rttr.addAttribute("id", member.getId());
            return "redirect:/member/edit";
        }
        rttr.addAttribute("id", member.getId());
        return "redirect:/member/view";
    }
}
