USE jsp2;

CREATE TABLE board
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    title   VARCHAR(200) NOT NULL,
    content VARCHAR(5000),
    writer  VARCHAR(200) NOT NULL,
    date    DATETIME     NOT NULL DEFAULT NOW()
);

SELECT *
FROM board;

#board.writer -> member.id 외래키로 지정
ALTER TABLE board
    ADD FOREIGN KEY (writer) REFERENCES member (id);