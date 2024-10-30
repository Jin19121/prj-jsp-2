package com.example.prjjsp2.service;

import com.example.prjjsp2.dto.Board;
import com.example.prjjsp2.dto.Member;
import com.example.prjjsp2.mapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
@RequiredArgsConstructor
public class BoardService {
    private final BoardMapper mapper;

    public void insert(Board board, Member member) {
        mapper.insert(board, member);
    }


//    public List<Board> list() {
//        List<Board> list = mapper.selectAll();
//        return list;
//    }

    public Map<String, Object> list(Integer page, String target, String keyword) {
        //한 페이지 10게
        Integer offset = (page - 1) * 10;
        List<Board> list = mapper.selectAllPaging(offset, target, keyword);

        //Controller에게 넘겨줄 정보를 담은 map
        Map<String, Object> map = new HashMap<>();

        Integer all = mapper.countAll(target, keyword);
        Integer lastPage = (all - 1) / 10 + 1; //마지막 페이지 번호
        Integer rightEnd = ((page - 1) / 10 + 1) * 10; //현재 페이지 기준 리스트의 오른쪽 끝 페이지 번호
        Integer leftEnd = rightEnd - 9; //현재 페이지 기준, 리스트의 왼쪽 끝 페이지 번호
        Integer next = page + 1; //다음 페이지로 이동 시 페이지 번호
        Integer prev = page - 1; //이전 페이지로 이동 시 페이지 번호

        Boolean hasNext = next <= lastPage; //다음 존재 유무
        Boolean hasPrev = prev > 0; // 이전 페이지 존재 유무

        rightEnd = Math.min(rightEnd, lastPage); //오른쪽 끝 페이지 번호는 마지막 페이지보다 작다.

        //page관련 정보를 담은 map
        Map<String, Object> pageInfo = new HashMap<>();

        pageInfo.put("hasNext", hasNext);
        pageInfo.put("hasPrev", hasPrev);
        pageInfo.put("next", next);
        pageInfo.put("prev", prev);
        pageInfo.put("leftEnd", leftEnd);
        pageInfo.put("rightEnd", rightEnd);
        pageInfo.put("lastPage", lastPage);
        pageInfo.put("currentPage", page);

        map.put("pageInfo", pageInfo);
        map.put("boardList", list);

        return map;
    }

    public Board view(Integer id) {
        Board board = mapper.selectById(id);
        return board;
    }

    public void delete(Integer id, Member member) {
        Board board = mapper.selectById(id);
        if (board.getWriter().equals(member.getId()) || board.getWriter().equals(member.getNickname())
                || member.getAccess().contains("admin")) {
            mapper.deleteById(id);
        } else {
            throw new RuntimeException("You do not have permission to delete this board");
        }
    }

    public void update(Board board, Member member) {
        Board board1 = mapper.selectById(board.getId());
        if (board1.getWriter().equals(member.getId()) || board1.getWriter().equals(member.getNickname())
                || member.getAccess().contains("admin")) {
            mapper.update(board);
        } else {
            throw new RuntimeException("You do not have permission to update this board");
        }
    }

}
