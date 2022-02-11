-- Project Hub 데이터베이스

-- 사용자 생성
CREATE USER ProjectHub
IDENTIFIED BY ph123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

-- 계정 권한 부여
GRANT CONNECT TO ProjectHub;
GRANT RESOURCE TO ProjectHub;
GRANT DBA TO ProjectHub;

-- 전체 테이블 삭제
drop table member CASCADE CONSTRAINTS;
drop table upload_profile CASCADE CONSTRAINTS;
drop table project CASCADE CONSTRAINTS;
drop table project_member CASCADE CONSTRAINTS;
drop table bookmark CASCADE CONSTRAINTS;
drop table board_like CASCADE CONSTRAINTS;
drop table board_file CASCADE CONSTRAINTS;
drop table board CASCADE CONSTRAINTS;
drop table task CASCADE CONSTRAINTS;
drop table task_manager CASCADE CONSTRAINTS;
drop table reply CASCADE CONSTRAINTS;
drop table reply_file CASCADE CONSTRAINTS;
drop table text CASCADE CONSTRAINTS;
drop table schedule CASCADE CONSTRAINTS;
drop table schedule_manager CASCADE CONSTRAINTS;

-- 전체 시퀀스 삭제
drop sequence bm_seq;
drop sequence board_seq;
drop sequence like_seq;
drop sequence pm_seq;
drop sequence project_seq;
drop sequence reply_seq;
drop sequence sa_seq;
drop sequence schedule_seq;
drop sequence task_seq;
drop sequence text_seq;
drop sequence tm_seq;
drop sequence bfile_seq;
drop sequence rfile_seq ;

-- 커밋
commit;

-- 테이블 생성
/* 회원 */
CREATE TABLE member (
	email VARCHAR2(4000) NOT NULL, /* 회원이메일 */
	password VARCHAR(50) NOT NULL, /* 회원비밀번호 */
	name VARCHAR(50) NOT NULL, /* 회원이름 */
    login_authstatus INTEGER DEFAULT 0 NOT NULL, /* 로그인권한 */
    authkey VARCHAR(50), /* 인증키 */
    tel_num VARCHAR(50) DEFAULT '-', /* 전화번호 */
    phone_num VARCHAR(50) DEFAULT '-', /* 휴대폰번호 */
    company_name VARCHAR(50) DEFAULT '-', /* 회사명 */
    job_position VARCHAR(50) DEFAULT '-' /* 직급 */
);

ALTER TABLE member
	ADD
		CONSTRAINT PK_member
		PRIMARY KEY (
			email
		);
        
/* 프로필업로드 */
CREATE TABLE upload_profile (
	profile_uuid VARCHAR2(4000) NOT NULL, /* 범용공유식별자 */
	profile_path VARCHAR2(4000) NOT NULL, /* 파일경로 */
	profile_name VARCHAR2(4000) NOT NULL, /* 파일명 */
	profile_type VARCHAR2(4000) NOT NULL, /* 파일유형 */
	profile_size VARCHAR2(4000) NOT NULL, /* 파일크기 */
	email VARCHAR2(4000) NOT NULL /* 회원이메일 */
);

ALTER TABLE upload_profile
	ADD
		CONSTRAINT PK_upload_profile
		PRIMARY KEY (
			profile_uuid
		);
        
/* 프로젝트 */
CREATE TABLE project (
	pno NUMBER(10,0) NOT NULL, /* 프로젝트번호 */
	pname VARCHAR2(100) NOT NULL, /* 프로젝트제목 */
	pdescription VARCHAR2(4000), /* 프로젝트설명 */
	pday DATE NOT NULL /* 프로젝트생성일 */
);

ALTER TABLE project
	ADD
		CONSTRAINT PK_project
		PRIMARY KEY (
			pno
		);
-- 프로젝트 테이블 시퀀스 pno
CREATE SEQUENCE project_seq INCREMENT BY 1;

/* 프로젝트회원 */
CREATE TABLE project_member (
	pmseq NUMBER(10,0) NOT NULL, /* 프로젝트seq */
	pmadmin_num INTEGER NOT NULL, /* 관리자식별 */
	pmcolor VARCHAR(100) NOT NULL, /* 프로젝트색상 */
	pmfavorite INTEGER NOT NULL, /* 즐겨찾기 */
    p_authstatus INTEGER DEFAULT 0 NOT NULL, /* 프로젝트권한 */
    p_authkey VARCHAR(50), /* 프로젝트인증키 */
	pno NUMBER(10,0) NOT NULL, /* 프로젝트번호 */
	email VARCHAR2(4000) NOT NULL /* 회원이메일 */
);

ALTER TABLE project_member
	ADD
		CONSTRAINT PK_project_member
		PRIMARY KEY (
			pmseq
		);        
        
ALTER TABLE project_member
ADD CONSTRAINT FK_PROJECT_TO_PROJECT_MEMBER
FOREIGN KEY (pno)
REFERENCES project (pno)
ON DELETE CASCADE;
        
-- 프로젝트회원 테이블 시퀀스 pmseq
CREATE SEQUENCE pm_seq INCREMENT BY 1;

/* 게시물 */
CREATE TABLE board (
	bno NUMBER(10,0) NOT NULL, /* 게시물번호 */
	bidentifier INTEGER NOT NULL, /* 식별번호 */
	pno NUMBER(10,0) NOT NULL, /* 프로젝트번호 */
	bwriter VARCHAR(50) NOT NULL, /* 작성자 */
	bwriter_email VARCHAR2(4000) NOT NULL, /* 작성자이메일 */
	bfix INTEGER /* 고정 */
);

ALTER TABLE board
	ADD
		CONSTRAINT PK_board
		PRIMARY KEY (
			bno
		);
-- 게시물 테이블 시퀀스 bno
CREATE SEQUENCE board_seq INCREMENT BY 1;        
        
/* 게시물파일 */
--CREATE TABLE board_file (
--	bfile_identifier VARCHAR2(4000) NOT NULL, /* 게시물파일식별자 */
--	bfile_path VARCHAR2(4000) NOT NULL, /* 파일경로 */
--	bfile_name VARCHAR2(4000) NOT NULL, /* 파일명 */
--	bfile_type VARCHAR2(4000) NOT NULL, /* 파일유형 */
--	bfile_size VARCHAR2(4000) NOT NULL, /* 파일크기 */
--	bno NUMBER(10,0) NOT NULL /* 게시물번호 */
--);
--
--ALTER TABLE board_file
--	ADD
--		CONSTRAINT PK_board_file
--		PRIMARY KEY (
--			bfile_identifier
--		);

CREATE TABLE board_file (
    bfile_no number(10,0) not null, -- 파일 번호
	org_bfile_name VARCHAR2(4000) NOT NULL, /* 원본 파일명 */
    stored_bfile_name VARCHAR2(4000) NOT NULL, /* 변경된 파일명 */
    bfile_size number NOT NULL, /* 파일크기 */
    DEL_GB VARCHAR2(1) DEFAULT 'N' NOT NULL, -- 삭제구분
    bno NUMBER(10,0) NOT NULL -- 게시물 번호
);

-- 파일 시퀀스
CREATE SEQUENCE bfile_seq INCREMENT BY 1 ;

-- 댓글 파일
CREATE TABLE reply_file (
    rfile_no number(10,0) not null, -- 파일 번호
	org_rfile_name VARCHAR2(4000) NOT NULL, /* 원본 파일명 */
    stored_rfile_name VARCHAR2(4000) NOT NULL, /* 변경된 파일명 */
    rfile_size number NOT NULL, /* 파일크기 */
    DEL_GB VARCHAR2(1) DEFAULT 'N' NOT NULL, -- 삭제구분
    reply_no NUMBER(10,0) NOT NULL -- 댓글 번호
);

-- 파일 시퀀스
CREATE SEQUENCE rfile_seq INCREMENT BY 1 ;


        
/* 게시물댓글 */
CREATE TABLE reply (
	reply_no NUMBER(10,0) NOT NULL, /* 게시물댓글번호 */
	reply_content VARCHAR2(1000) NOT NULL, /* 댓글내용 */
	reply_date DATE NOT NULL, /* 댓글작성일 */
	reply_writer VARCHAR2(4000) NOT NULL, /* 댓글작성자 */
	rwriter_email VARCHAR(50) NOT NULL, /* 댓글작성자 */
	bno NUMBER(10,0) NOT NULL /* 게시물번호 */
);

ALTER TABLE reply
	ADD
		CONSTRAINT PK_reply
		PRIMARY KEY (
			reply_no
		);
-- 게시물댓글 테이블 시퀀스 reply_no
CREATE SEQUENCE reply_seq INCREMENT BY 1;  
        
/* 게시물댓글파일 */
--CREATE TABLE reply_file (
--	replyfile_identifier VARCHAR2(4000) NOT NULL, /* 게시물댓글파일식별자 */
--	replyfile_path VARCHAR2(4000) NOT NULL, /* 파일경로 */
--	replyfile_name VARCHAR2(4000) NOT NULL, /* 파일명 */
--	replyfile_type VARCHAR2(4000) NOT NULL, /* 파일유형 */
--	replyfile_size VARCHAR2(4000) NOT NULL, /* 파일크기 */
--	reply_no NUMBER(10,0) NOT NULL /* 게시물댓글번호 */
--);
--
--ALTER TABLE reply_file
--	ADD
--		CONSTRAINT PK_reply_file
--		PRIMARY KEY (
--			replyfile_identifier
--		);

/* 글 */
CREATE TABLE text (
	text_no NUMBER(10,0) NOT NULL, /* 글번호 */
	text_title VARCHAR2(100) NOT NULL, /* 글제목 */
	text_content VARCHAR2(4000) NOT NULL, /* 글내용 */
	text_day DATE NOT NULL, /* 작성일 */
	bno NUMBER(10,0) NOT NULL /* 게시물번호 */
);

ALTER TABLE text
	ADD
		CONSTRAINT PK_text
		PRIMARY KEY (
			text_no
		);
-- 글 테이블 시퀀스 text_no
CREATE SEQUENCE text_seq INCREMENT BY 1; 

/* 일정 */
CREATE TABLE schedule (
	schedule_no NUMBER(10,0) NOT NULL, /* 일정번호 */
	schedule_title VARCHAR2(100) NOT NULL, /* 일정제목 */
	schedule_content VARCHAR2(4000) NOT NULL, /* 일정내용 */
	schedule_location VARCHAR2(1000), /* 일정장소 */
	schedule_start DATE, /* 시작일 */
	schedule_last DATE, /* 마감일 */
	schedule_day DATE NOT NULL, /* 작성일 */
	bno NUMBER(10,0) NOT NULL /* 게시물번호 */
);

ALTER TABLE schedule
	ADD
		CONSTRAINT PK_schedule
		PRIMARY KEY (
			schedule_no
		);
-- 일정 테이블 시퀀스 schedule_no
CREATE SEQUENCE schedule_seq INCREMENT BY 1; 
        
/* 일정참석자 */
CREATE TABLE schedule_manager (
	scheduleAttend_seq NUMBER(10,0) NOT NULL, /* 일정참석seq */
	schedule_no NUMBER(10,0) NOT NULL, /* 일정번호 */
	scheduleAttend_email VARCHAR2(4000) /* 참석자이메일 */
);

ALTER TABLE schedule_manager
	ADD
		CONSTRAINT PK_schedule_manager
		PRIMARY KEY (
			scheduleAttend_seq
		);
-- 일정참석자 테이블 시퀀스 scheduleAttend_seq
CREATE SEQUENCE sa_seq INCREMENT BY 1; 
        
/* 업무 */
CREATE TABLE task (
	task_no NUMBER(10,0) NOT NULL, /* 업무번호 */
	task_title VARCHAR2(100) NOT NULL, /* 업무제목 */
	task_content VARCHAR2(4000) NOT NULL, /* 업무내용 */
	task_status VARCHAR2(100), /* 업무상태 */
	task_priority INTEGER, /* 우선순위 */
	task_start DATE, /* 시작일 */
	task_last DATE, /* 마감일 */
	task_day DATE NOT NULL, /* 작성일 */
	bno NUMBER(10,0) NOT NULL /* 게시물번호 */
);

ALTER TABLE task
	ADD
		CONSTRAINT PK_task
		PRIMARY KEY (
			task_no
		);
-- 업무 테이블 시퀀스 task_no
CREATE SEQUENCE task_seq INCREMENT BY 1;

/* 업무담당자 */
CREATE TABLE task_manager (
	taskManager_seq NUMBER(10,0) NOT NULL, /* 업무담당seq */
	task_no NUMBER(10,0) NOT NULL, /* 업무번호 */
	manager_email VARCHAR2(100) /* 담당자이메일 */
);

ALTER TABLE task_manager
	ADD
		CONSTRAINT PK_task_manager
		PRIMARY KEY (
			taskManager_seq
		);
-- 업무담당자 테이블 시퀀스 taskManager_seq
CREATE SEQUENCE tm_seq INCREMENT BY 1;

/* 북마크 */
CREATE TABLE bookmark (
	bookmark_seq NUMBER(10,0) NOT NULL, /* 북마크번호seq */
	pno NUMBER(10,0) NOT NULL, /* 프로젝트번호 */
	bno NUMBER(10,0) NOT NULL, /* 게시물번호 */
	email VARCHAR2(4000) NOT NULL /* 회원이메일 */
);

ALTER TABLE bookmark
	ADD
		CONSTRAINT PK_bookmark
		PRIMARY KEY (
			bookmark_seq
		);
-- 북마크 테이블 시퀀스 bookmark_seq
CREATE SEQUENCE bm_seq INCREMENT BY 1;

/* 게시물좋아요 */
CREATE TABLE board_like (
	like_no NUMBER(10,0) NOT NULL, /* 좋아요번호 */
	bno NUMBER(10,0) NOT NULL, /* 게시물번호 */
	email VARCHAR2(4000) NOT NULL, /* 회원이메일 */
	like_check INTEGER /* 좋아요체크 */
);

ALTER TABLE board_like
	ADD
		CONSTRAINT PK_like
		PRIMARY KEY (
			like_no
		);
-- 게시물좋아요 테이블 시퀀스 like_no
CREATE SEQUENCE like_seq INCREMENT BY 1;

-- view 생성
-- 프로젝트 pno별 count view 생성
CREATE OR REPLACE VIEW project_count 
AS SELECT pno, count(*) as pcount FROM project_member group by pno;

-- 게시물, 업무 board_task view 생성
CREATE OR REPLACE VIEW board_task 
AS select b.bno as bno,b.pno as pno,p.pname as pname,b.bidentifier as bidentifier,b.bwriter as bwriter,ts.task_title as title,ts.task_day as day
from  project p,board b,task ts 
where p.pno = b.pno and b.bno = ts.bno; 

-- 게시물, 글 board_text view 생성
CREATE OR REPLACE VIEW board_text 
AS select b.bno as bno,b.pno as pno,p.pname as pname,b.bidentifier as bidentifier,b.bwriter as bwriter,tx.text_title as title,tx.text_day as day
from project p,board b,text tx 
where p.pno = b.pno and b.bno = tx.bno; 

-- 게시물, 일정 board_schedule view 생성
CREATE OR REPLACE VIEW board_schedule 
AS select b.bno as bno,b.pno as pno,p.pname as pname,b.bidentifier as bidentifier,b.bwriter as bwriter,sc.schedule_title as title,sc.schedule_day as day
from project p,board b,schedule sc
where p.pno = b.pno and b.bno = sc.bno; 
        
-- foreign key 설정
ALTER TABLE reply_file
	ADD
		CONSTRAINT FK_reply_TO_reply_file
		FOREIGN KEY (
			reply_no
		)
		REFERENCES reply (
			reply_no
		)on delete cascade;

ALTER TABLE board_file
	ADD
		CONSTRAINT FK_board_TO_board_file
		FOREIGN KEY (
			bno
		)
		REFERENCES board (
			bno
		)on delete cascade;

ALTER TABLE upload_profile
	ADD
		CONSTRAINT FK_member_TO_upload_profile
		FOREIGN KEY (
			email
		)
		REFERENCES member (
			email
		)on delete cascade;

ALTER TABLE schedule
	ADD
		CONSTRAINT FK_board_TO_schedule
		FOREIGN KEY (
			bno
		)
		REFERENCES board (
			bno
		)on delete cascade;

ALTER TABLE text
	ADD
		CONSTRAINT FK_board_TO_text
		FOREIGN KEY (
			bno
		)
		REFERENCES board (
			bno
		)on delete cascade;

ALTER TABLE project_member
	ADD
		CONSTRAINT FK_member_TO_project_member
		FOREIGN KEY (
			email
		)
		REFERENCES member (
			email
		)on delete cascade;

ALTER TABLE task
	ADD
		CONSTRAINT FK_board_TO_task
		FOREIGN KEY (
			bno
		)
		REFERENCES board (
			bno
		)on delete cascade;

ALTER TABLE board
	ADD
		CONSTRAINT FK_project_TO_board
		FOREIGN KEY (
			pno
		)
		REFERENCES project (
			pno
		)on delete cascade;

ALTER TABLE reply
	ADD
		CONSTRAINT FK_board_TO_reply
		FOREIGN KEY (
			bno
		)
		REFERENCES board (
			bno
		)on delete cascade;

ALTER TABLE bookmark
	ADD
		CONSTRAINT FK_project_TO_bookmark
		FOREIGN KEY (
			pno
		)
		REFERENCES project (
			pno
		)on delete cascade;

ALTER TABLE bookmark
	ADD
		CONSTRAINT FK_board_TO_bookmark
		FOREIGN KEY (
			bno
		)
		REFERENCES board (
			bno
		)on delete cascade;

ALTER TABLE bookmark
	ADD
		CONSTRAINT FK_member_TO_bookmark
		FOREIGN KEY (
			email
		)
		REFERENCES member (
			email
		)on delete cascade;

ALTER TABLE task_manager
	ADD
		CONSTRAINT FK_task_TO_task_manager
		FOREIGN KEY (
			task_no
		)
		REFERENCES task (
			task_no
		)on delete cascade;

ALTER TABLE schedule_manager
	ADD
		CONSTRAINT FK_schedule_manager
		FOREIGN KEY (
			schedule_no
		)
		REFERENCES schedule (
			schedule_no
		)on delete cascade;

ALTER TABLE board_like
	ADD
		CONSTRAINT FK_member_TO_like
		FOREIGN KEY (
			email
		)
		REFERENCES member (
			email
		)on delete cascade;

ALTER TABLE board_like
	ADD
		CONSTRAINT FK_board_TO_like
		FOREIGN KEY (
			bno
		)
		REFERENCES board (
			bno
		)on delete cascade;