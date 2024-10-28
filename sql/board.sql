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

DROP TABLE board;