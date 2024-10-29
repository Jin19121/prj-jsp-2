package com.example.prjjsp2.mapper;

import com.example.prjjsp2.dto.Member;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MemberMapper {

    @Insert("""
            INSERT INTO member
            (id, password, nickname, email)
            VALUES (#{id}, #{password}, #{nickname}, #{email})
            """)
    int insert(Member member);

    @Select("""
            SELECT *
            FROM member
            ORDER BY id
            """)
    List<Member> selectAll();

    @Select("""
            SELECT *
            FROM member
            WHERE id=#{id}""")
    Member selectById(String id);

    @Delete("""
            DELETE FROM member
            WHERE id=#{id}
            AND password=#{password}
            """)
    int deleteByIdAndPassword(String id, String password);

    @Update("""
            UPDATE member
            SET nickname=#{nickname},
                email=#{email}
            WHERE id=#{id}""")
    void update(Member member);

    @Update("""
            UPDATE member
            SET password = #{newPassword}
            WHERE id = #{id}
              AND password = #{oldPassword}
            """)
    int updatePassword(String id, String oldPassword, String newPassword);
}
