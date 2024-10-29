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
            ORDER BY signed
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

    @Select("""
            SELECT *
            FROM member
            WHERE id=#{id}
              AND password=#{password}""")
    Member selectByIdAndPassword(String id, String password);

    @Select("""
            SELECT name
            FROM access
            WHERE id = #{id}
            """)
    List<String> selectAccessById(String id);

    @Select("""
            <script>
                SELECT *
                FROM member
                <trim prefix="WHERE" prefixOverrides="OR">
                    <if test="search =='all' or search =='id'">
                        id LIKE CONCAT('%', #{keyword}, '%')
                    </if>
                    <if test="search =='all' or search =='nickname'">
                        OR nickname LIKE CONCAT('%', #{keyword}, '%')
                    </if>
                    <if test="search =='all' or search =='email'">
                        OR email LIKE CONCAT('%', #{keyword}, '%')
                    </if>
                </trim>
                ORDER BY signed
                LIMIT #{offset}, 10
            </script>
            """)
    List<Member> selectAllPaging(Integer offset, String search, String keyword);

    @Select("""
            SELECT COUNT(id) FROM member""")
    Integer countAll(String search, String keyword);
}
