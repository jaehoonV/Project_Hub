package org.ProjectHub.domain;

import lombok.Data;

@Data
public class BoardLikeDTO {
	
	private int like_no; // 좋아요번호
	private int bno; // 게시물번호
	private String email; // 회원 이메일
	private int like_check; // 좋아요 체크

}
