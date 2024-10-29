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

    public void delete(Integer id) {
        mapper.deleteById(id);
    }

    public void update(Board board) {
        mapper.update(board);
    }
}
