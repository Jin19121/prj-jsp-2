USE jsp2;

CREATE TABLE member
(
    id       VARCHAR(50) PRIMARY KEY,
    password VARCHAR(100) NOT NULL,
    nickname VARCHAR(100) NOT NULL UNIQUE,
    email    VARCHAR(200) NOT NULL UNIQUE,
    signed   DATETIME     NOT NULL DEFAULT NOW()
);

SELECT *
FROM member;

#권한 테이블
CREATE TABLE access
(
    id   VARCHAR(50) REFERENCES member (id),
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id, name)
);

#관리자 계정 임명
INSERT INTO access
    (id, name)
VALUES ('admin', 'admin'),
       ('bdmin', 'admin');