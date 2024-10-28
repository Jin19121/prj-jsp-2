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