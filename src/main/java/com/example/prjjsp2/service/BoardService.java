package com.example.prjjsp2.service;

import com.example.prjjsp2.dto.Board;
import com.example.prjjsp2.dto.Member;
import com.example.prjjsp2.mapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class BoardService {
    private final BoardMapper mapper;

    public void insert(Board board, Member member) {
        mapper.insert(board, member);
    }

    public List<Board> list() {
        List<Board> list = mapper.selectAll();
        return list;
    }

    public Board view(Integer id) {
        return mapper.selectById(id);
    }

    public void delete(Integer id, Member member) {
        Board board = mapper.selectById(id);
        if (board.getWriter().equals(member.getId()) || board.getWriter().equals(member.getNickname())) {
            mapper.deleteById(id);
        } else {
            throw new RuntimeException("You do not have permission to delete this board");
        }
    }

    public void update(Board board, Member member) {
        Board board1 = mapper.selectById(board.getId());
        if (board1.getWriter().equals(member.getId()) || board1.getWriter().equals(member.getNickname())) {
            mapper.update(board);
        } else {
            throw new RuntimeException("You do not have permission to update this board");
        }
    }
}
