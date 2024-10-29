package com.example.prjjsp2.controller;

import com.example.prjjsp2.dto.Member;
import com.example.prjjsp2.service.MemberService;
import jakarta.servlet.http.HttpSession;
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
            rttr.addAttribute("id", member.getId());
            return "redirect:/member/view";
        } catch (DuplicateKeyException e) {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "Nickname or e-mail already exists!"
            ));
            rttr.addAttribute("id", member.getId());
            return "redirect:/member/edit";
        }
    }

    @GetMapping("edit-password")
    public String editPassword(String id, Model model) {
        model.addAttribute("id", id);
        return "/member/editPassword";
    }

    @PostMapping("edit-password")
    public String editPasswordProcess(String id,
                                      String oldPassword,
                                      String newPassword,
                                      RedirectAttributes rttr) {
        if (service.updatePassword(id, oldPassword, newPassword)) {
            rttr.addFlashAttribute("message", Map.of("type", "success",
                    "text", "Password edited successfully!"));
            rttr.addAttribute("id", id);
            return "redirect:/member/view";
        } else {
            rttr.addFlashAttribute("message", Map.of("type", "warning",
                    "text", "Unable to change password!"));
            rttr.addAttribute("id", id);
            return "redirect:/member/edit-password";
        }
    }

    @GetMapping("login")
    public void login() {
    }

    @PostMapping("login")
    public String loginProcess(String id, String password,
                               RedirectAttributes rttr,
                               HttpSession session) {
        Member member = service.view(id, password);
        if (member == null) {
            //로그인 실패
            rttr.addFlashAttribute("message", Map.of(
                    "type", "warning",
                    "text", "Incorrect ID or password!"
            ));
            return "redirect:/member/login";
        } else {
            //로그인 성공
            rttr.addFlashAttribute("message", Map.of(
                    "type", "success",
                    "text", "Welcome!"
            ));
            session.setAttribute("loggedIn", member);
            return "redirect:/board/list";
        }
    }

    @RequestMapping("logout")
    public String logout(HttpSession session, RedirectAttributes rttr) {
        session.invalidate();
        rttr.addFlashAttribute("message", Map.of(
                "type", "primary",
                "text", "See you again!"
        ));
        return "redirect:/member/login";
    }
}
