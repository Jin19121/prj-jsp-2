package com.example.prjjsp2.controller;

import com.example.prjjsp2.dto.Board;
import com.example.prjjsp2.dto.Member;
import com.example.prjjsp2.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
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
                    "text", "You must login first!"
            ));
            return "redirect:/member/login";
        } else {
            //로그인 완료
            return "board/new";
        }
    }

    @PostMapping("new")
    public String newBoard(Board board, RedirectAttributes rttr) {
        service.insert(board);

        rttr.addFlashAttribute("message", Map.of(
                "type", "success",
                "text", "#" + board.getId() + " Posted"
        ));
        rttr.addAttribute("id", board.getId());
        return "redirect:/board/view";
    }

    @GetMapping("list")
    public void listBoard(Model model) {
        List<Board> list = service.list();
        model.addAttribute("boardList", list);
    }

    @GetMapping("view")
    public void viewBoard(Model model, Integer id) {
        Board board = service.view(id);
        model.addAttribute("board", board);
    }

    @PostMapping("delete")
    public String deleteBoard(Integer id, RedirectAttributes rttr) {
        service.delete(id);

        rttr.addFlashAttribute("message", Map.of(
                "type", "warning",
                "text", "Post #" + id + " Deleted"
        ));
        return "redirect:/board/list";
    }

    @GetMapping("edit")
    public void editBoard(Integer id, Model model) {
        Board board = service.view(id);
        model.addAttribute("board", board);
    }

    @PostMapping("edit")
    public String editBoard(Board board, RedirectAttributes rttr) {
        service.update(board);

        rttr.addFlashAttribute("message", Map.of(
                "type", "success",
                "text", "Post #" + board.getId() + " Edited"
        ));
        rttr.addAttribute("id", board.getId());
        return "redirect:/board/view";
    }

}
