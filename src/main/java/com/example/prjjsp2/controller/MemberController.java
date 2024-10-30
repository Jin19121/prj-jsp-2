package com.example.prjjsp2.controller;

import com.example.prjjsp2.dto.Member;
import com.example.prjjsp2.service.MemberService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

            if (member.getId() == "" || member.getNickname() == "" || member.getEmail() == "") {
                rttr.addFlashAttribute("message", Map.of(
                        "type", "danger",
                        "text", "Something's missing. Please check and try again."
                ));
                return "redirect:/member/register";
            } else {
                service.insertMember(member);
                rttr.addFlashAttribute("message", Map.of(
                        "type", "success",
                        "text", "Registered! Welcome to the Crew!"
                ));

                return "redirect:/member/login";
            }
        } catch (DuplicateKeyException e) {
            String errorMessage;
            String exceptionMessage = e.getMessage();

            // 중복된 값을 추출하기 위한 정규 표현식
            Pattern pattern = Pattern.compile("Duplicate entry '(.+)' for key '(.+)'");
            Matcher matcher = pattern.matcher(exceptionMessage);

            if (matcher.find()) {
                String duplicateValue = matcher.group(1); // 중복된 값
                String key = matcher.group(2); // 중복된 필드명

                // 필드명에 따라 다른 메시지 설정
                switch (key) {
                    case "email":
                        errorMessage = "Email '" + duplicateValue + "' is already in use!";
                        break;
                    case "nickname":
                        errorMessage = "Nickname '" + duplicateValue + "' is already taken!";
                        break;
                    default:
                        errorMessage = "ID '" + duplicateValue + "' is already in use!";
                        break;
                }
            } else {
                errorMessage = "An unexpected error occurred.";
            }

            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", errorMessage
            ));

            return "redirect:/member/register";
        }
    }

    @GetMapping("list")
    public String list(@RequestParam(name = "page", defaultValue = "1") Integer page,
                       @RequestParam(required = false) String search,
                       @RequestParam(required = false) String keyword,
                       @SessionAttribute(value = "loggedIn", required = false) Member member,
                       Model model, RedirectAttributes rttr) {
        model.addAttribute("memberList", member);
        if (member != null && member.getAccess().contains("admin")) {
            //관리자 계정으로 로그인한 경우
            Map<String, Object> result = service.list(page, search, keyword);
            model.addAllAttributes(result);
            return null;
        } else {
            //관리자 계정이 아닌 경우
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "Member List limited to Server Administrators only!"
            ));
            return "redirect:/board/list";
        }
    }

    @GetMapping("view")
    public void info(String id, Model model) {
        Member member = service.view(id);
        model.addAttribute("member", member);
    }

    @PostMapping("delete")
    public String delete(String id, String password,
                         RedirectAttributes rttr, HttpSession session,
                         @SessionAttribute("loggedIn") Member member) {
        if (service.hasAccess(id, member)) {
            //본인일 경우 삭제 권한 있음
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
        } else {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "You cannot delete other Members!"
            ));
            rttr.addAttribute("id", id);
            return "redirect:/member/view";
        }
    }

    @GetMapping("edit")
    public String edit(String id, Model model, RedirectAttributes rttr,
                       @SessionAttribute("loggedIn") Member member) {
        if (service.hasAccess(id, member)) {
            model.addAttribute("member", service.view(id));
            return null;
        } else {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "You cannot edit other Members' profile!"
            ));
            rttr.addAttribute("id", id);
            return "redirect:/member/view";
        }
    }

    @PostMapping("edit")
    public String editProcess(Member member, RedirectAttributes rttr,
                              @SessionAttribute("loggedIn") Member loggedInMember) {
        if (service.hasAccess(member.getId(), loggedInMember)) {
            try {
                service.update(member);
                rttr.addFlashAttribute("message", Map.of(
                        "type", "success",
                        "text", "Profile edited successfully!"
                ));
            } catch (DuplicateKeyException e) {
                String errorMessage;
                String exceptionMessage = e.getMessage();

                // 중복된 값을 추출하기 위한 정규 표현식
                Pattern pattern = Pattern.compile("Duplicate entry '(.+)' for key '(.+)'");
                Matcher matcher = pattern.matcher(exceptionMessage);

                if (matcher.find()) {
                    String duplicateValue = matcher.group(1); // 중복된 값
                    String key = matcher.group(2); // 중복된 필드명

                    // 필드명에 따라 다른 메시지 설정
                    switch (key) {
                        case "email":
                            errorMessage = "Email '" + duplicateValue + "' is already in use!";
                            break;
                        case "nickname":
                            errorMessage = "Nickname '" + duplicateValue + "' is already taken!";
                            break;
                        default:
                            errorMessage = "ID '" + duplicateValue + "' is already in use!";
                            break;
                    }
                } else {
                    errorMessage = "An unexpected error occurred.";
                }

                rttr.addFlashAttribute("message", Map.of(
                        "type", "danger",
                        "text", errorMessage
                ));
            }
        } else {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "You cannot edit other Members' profile!"
            ));
        }
        rttr.addAttribute("id", member.getId());
        return "redirect:/member/view";
    }

    @GetMapping("edit-password")
    public String editPassword(String id, Model model, RedirectAttributes rttr,
                               @SessionAttribute("loggedIn") Member member) {
        if (service.hasAccess(id, member)) {
            model.addAttribute("id", id);
            return "/member/editPassword";
        } else {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "You cannot change other Members' password!"
            ));
            rttr.addAttribute("id", id);
            return "redirect:/member/view";
        }
    }

    @PostMapping("edit-password")
    public String editPasswordProcess(String id,
                                      String oldPassword,
                                      String newPassword,
                                      RedirectAttributes rttr,
                                      @SessionAttribute("loggedIn") Member member) {
        if (service.hasAccess(id, member)) {
            if (service.updatePassword(id, oldPassword, newPassword)) {
                rttr.addFlashAttribute("message", Map.of("type", "success",
                        "text", "Password edited successfully!"));
                rttr.addAttribute("id", id);
                return "redirect:/member/view";
            } else {
                rttr.addFlashAttribute("message", Map.of("type", "warning",
                        "text", "Incorrect Original Password!"));
                rttr.addAttribute("id", id);
                return "redirect:/member/edit-password";
            }
        } else {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "warning",
                    "text", "You cannot change other Members' password!"
            ));
            rttr.addAttribute("id", id);
            return "redirect:/member/view";
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
                    "text", "Welcome " + member.getNickname() + "!"
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
