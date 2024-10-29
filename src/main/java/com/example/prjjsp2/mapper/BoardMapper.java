package com.example.prjjsp2.mapper;

import com.example.prjjsp2.dto.Board;
import com.example.prjjsp2.dto.Member;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BoardMapper {

    @Insert("""
            INSERT INTO board
            (title, content, writer)
            VALUES (#{board.title}, #{board.content}, #{member.id})""")
    @Options(useGeneratedKeys = true, keyProperty = "board.id")
    int insert(Board board, Member member);


    @Select("""
            SELECT * FROM board
            ORDER BY id DESC
            """)
    List<Board> selectAll();

    @Select("""
            SELECT b.id, b.title, b.content, b.date, b.writer, m.nickname writerName
            FROM board b JOIN member m
            ON b.writer = m.id
            WHERE b.id = #{m.id}
            """)
    Board selectById(Integer id);

    @Delete("""
            DELETE FROM board
            WHERE id = #{id}
            """)
    int deleteById(Integer id);

    @Update("""
            UPDATE board
            SET title=#{title}, 
                content=#{content}
            WHERE id=#{id}
            """)
    int update(Board board);

    @Select("""
            <script>
            SELECT b.id, b. title, b.date, m.nickname writerName
            FROM board b JOIN member m
              ON b.writer = m.id
            <trim prefix="WHERE" prefixOverrides="OR">
                <if test = "target=='all' or target=='title'">
                    title LIKE CONCAT('%', #{keyword}, '%')
                </if>
                <if test = "target=='all' or target=='content'">
                    OR content LIKE CONCAT('%', #{keyword}, '%')
                </if>
                <if test = "target=='all' or target=='writer'">
                    OR m.nickname LIKE CONCAT('%', #{keyword}, '%')
                </if>
            </trim>
            ORDER BY b.id DESC
            LIMIT #{offset}, 10
            </script>
            """)
    List<Board> selectAllPaging(Integer offset, String target, String keyword);

    @Select("""
            <script>
                SELECT COUNT(b.id) 
                FROM board b JOIN member m
                  ON b.writer = m.id
                <trim prefix="WHERE" prefixOverrides="OR">
                    <if test="target == 'all' or target == 'title'">
                        title LIKE CONCAT('%', #{keyword}, '%')
                    </if>
                    <if test="target == 'all' or target == 'content'">
                        OR content LIKE CONCAT('%', #{keyword}, '%')
                    </if>
                    <if test="target == 'all' or target == 'writer'">
                        OR m.nickname LIKE CONCAT('%', #{keyword}, '%')
                    </if>
                </trim>
            </script>
            """)
    Integer countAll(String target, String keyword);
}
