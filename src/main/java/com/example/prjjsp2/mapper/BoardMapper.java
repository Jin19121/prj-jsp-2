package com.example.prjjsp2.mapper;

import com.example.prjjsp2.dto.Board;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface BoardMapper {

    @Insert("""
            INSERT INTO board
            (title, content, writer)
            VALUES (#{title}, #{content}, #{writer})""")
    int insert(Board board);


    @Select("""
            SELECT * FROM board
            ORDER BY id DESC
            """)
    List<Board> selectAll();

    @Select("""
            SELECT title, content, writer, date
            FROM board
            WHERE id = #{id}
            """)
    Board selectById(Integer id);

    @Delete("""
            DELETE FROM board
            WHERE id = #{id}
            """)
    int deleteById(Integer id);
}
