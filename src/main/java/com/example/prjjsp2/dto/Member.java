package com.example.prjjsp2.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Member {
    private String id;
    private String password;
    private String nickname;
    private String email;
    private LocalDateTime signed;
}
