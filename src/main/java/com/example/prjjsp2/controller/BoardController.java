package com.example.prjjsp2.controller;

import com.example.prjjsp2.dto.Board;
import com.example.prjjsp2.dto.Member;
import com.example.prjjsp2.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("board")
public class BoardController {
    private final BoardService service;

    @GetMapping("new")
    public String newBoard(@SessionAttribute(value = "loggedIn", required = false)
                           Member member, RedirectAttributes rttr) {
        if (member == null) {
            //로그인 안 한 상태
            rttr.addFlashAttribute("message", Map.of(
                    "type", "warning",
                    "text", "You are not logged in! Please login first to post!"
            ));
            return "redirect:/member/login";
        } else {
            //로그인 완료
            return "board/new";
        }
    }

    @PostMapping("new")
    public String newBoard(Board board, RedirectAttributes rttr,
                           @SessionAttribute("loggedIn") Member member) {
        service.insert(board, member);

        rttr.addFlashAttribute("message", Map.of(
                "type", "success",
                "text", "#" + board.getId() + " Posted"
        ));
        rttr.addAttribute("id", board.getId());
        return "redirect:/board/view";
    }

    @GetMapping("list")
    public void listBoard(@RequestParam(name = "page", defaultValue = "1") Integer page,
                          @RequestParam(required = false) String target,
                          @RequestParam(defaultValue = "") String keyword,
                          Model model) {

        //한 페이지에 10개 게시물
        Map<String, Object> result = service.list(page, target, keyword);
        model.addAllAttributes(result);
    }

    @GetMapping("view")
    public void viewBoard(Model model, Integer id) {
        Board board = service.view(id);
        model.addAttribute("board", board);
    }

    @PostMapping("delete")
    public String deleteBoard(Integer id, RedirectAttributes rttr,
                              @SessionAttribute("loggedIn") Member member) {
        try {
            service.delete(id, member);

            rttr.addFlashAttribute("message", Map.of(
                    "type", "warning",
                    "text", "Post #" + id + " Deleted"
            ));
            return "redirect:/board/list";
        } catch (RuntimeException e) {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "You do not have permission to delete this post!"
            ));
            rttr.addAttribute("id", id);
            return "redirect:/board/view";
        }
    }

    @GetMapping("edit")
    public String editBoard(Integer id, Model model, RedirectAttributes rttr,
                            @SessionAttribute("loggedIn") Member member) {
        Board board = service.view(id);

        if (board.getWriter().equals(member.getId()) || board.getWriter().equals(member.getNickname())) {
            model.addAttribute("board", board);
            return null;
        } else {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "You do not have permission to edit this post!"
            ));
            return "redirect:/member/login";
        }
    }

    @PostMapping("edit")
    public String editBoard(Board board, RedirectAttributes rttr,
                            @SessionAttribute("loggedIn") Member member) {
        try {
            service.update(board, member);

            rttr.addFlashAttribute("message", Map.of(
                    "type", "success",
                    "text", "Post #" + board.getId() + " Edited"
            ));
        } catch (RuntimeException e) {
            rttr.addFlashAttribute("message", Map.of(
                    "type", "danger",
                    "text", "You do not have permission to edit this post!"
            ));
        }
        rttr.addAttribute("id", board.getId());
        return "redirect:/board/view";
    }

}
