package com.example.prjjsp2.service;

import com.example.prjjsp2.dto.Member;
import com.example.prjjsp2.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class MemberService {
    private final MemberMapper mapper;

    public void insertMember(Member member) {
        mapper.insert(member);
    }

    public List<Member> list() {
        return mapper.selectAll();
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
        return mapper.selectByIdAndPassword(id, password);
    }
}
