package com.example.prjjsp2.service;

import com.example.prjjsp2.dto.Member;
import com.example.prjjsp2.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
@RequiredArgsConstructor
public class MemberService {
    private final MemberMapper mapper;

    public void insertMember(Member member) {
        mapper.insert(member);
    }

    public Map<String, Object> list(Integer page, String search, String keyword) {
        Integer offset = (page - 1) * 10;
        List<Member> list = mapper.selectAllPaging(offset, search, keyword);

        Map<String, Object> map = new HashMap<>();

        Integer countAll = mapper.countAll(search, keyword);
        Integer last = (countAll - 1) / 10 + 1;
        Integer right = ((page - 1) / 10 + 1) * 10;
        Integer left = right - 9;
        Integer next = page + 1;
        Integer prev = page - 1;

        Boolean hasNext = next <= last;
        Boolean hasPrev = prev > 0;

        right = Math.min(right, last);

        Map<String, Object> pageMap = new HashMap<>();

        pageMap.put("hasNext", hasNext);
        pageMap.put("hasPrev", hasPrev);
        pageMap.put("next", next);
        pageMap.put("prev", prev);
        pageMap.put("left", left);
        pageMap.put("right", right);
        pageMap.put("last", last);
        pageMap.put("current", page);

        map.put("pageMap", pageMap);
        map.put("memberList", list);

        return map;
    }

    public Member view(String id) {
        return mapper.selectById(id);
    }

    public boolean delete(String id, String password) {
        int count = mapper.deleteByIdAndPassword(id, password);
        return count == 1;
    }

    public void update(Member member) {
        mapper.update(member);
    }

    public boolean updatePassword(String id, String oldPassword, String newPassword) {
        int cnt = mapper.updatePassword(id, oldPassword, newPassword);
        return cnt == 1;
    }

    public Member view(String id, String password) {
        Member member = mapper.selectByIdAndPassword(id, password);
        if (member == null) {
            return null;
        } else {
            List<String> accessList = mapper.selectAccessById(id);
            member.setAccess(accessList);
            return member;
        }
    }

    public boolean hasAccess(String id, Member member) {
        return id.equals(member.getId());
    }
}
