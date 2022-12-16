create table member(
    mid varchar2(20)
    , pwd varchar2(20) not null
    , primary key(mid)
);

insert into member values('abc', '123');
insert into member values('xyz', '1234');

select * from member;

commit;


create table board(
    b_no		number(9)
    -- 게시판 글 고유번호
    , subject	varchar2(50)	not null
    -- 글 제목
    , writer	varchar2(30)	not null
    -- 글쓴이 이름
    , content	varchar2(2000)	not null
    -- 글 내용
    , pwd		varchar2(12)	not null
    -- 암호
    , email		varchar2(30)
    -- 이메일
    , reg_date	date		default sysdate
    -- 등록일
    , readcount	number(5)	default 0
    -- 조회수
----------------------------------------------------------------------------------
    , group_no	number(9)	not null
    -- 게시판 글의 소속 그룹번호, 정렬 시 사용.
    , print_no	number(9)	not null
    -- 같은 그룹번호 내에서 화면 출력 순서 번호, 정렬 시 사용.
    , print_level	number(9)	not null
    -- 같은 그룹번호 내에서 댓글 들여쓰기 레벨 단계 번호.
    -- 부모 자식 관계를 알 수 있다.
----------------------------------------------------------------------------------
    , primary key(b_no)
);


insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (1,'����1','���� 1','�ۿ���','1111','abc1@kh.com',0,to_date('1969-05-23_11:04:52', 'YYYY-MM-DD_HH:MI:SS'),1,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (2,'����2','���� 2','��öõ','1111','abc2@kh.com',1,to_date('1971-06-08_08:56:20', 'YYYY-MM-DD_HH:MI:SS'),2,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (3,'����3','���� 3','�۴���','1111','abc3@kh.com',3,to_date('1972-02-22_07:29:57', 'YYYY-MM-DD_HH:MI:SS'),3,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (4,'����4','���� 4','������','1111','abc4@kh.com',1,to_date('1972-02-26_06:30:08', 'YYYY-MM-DD_HH:MI:SS'),4,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (5,'����5','���� 5','������','1111','abc5@kh.com',0,to_date('1973-05-05_12:51:05', 'YYYY-MM-DD_HH:MI:SS'),5,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (6,'����6','���� 6','��õ��','1111','abc6@kh.com',0,to_date('1974-02-08_08:47:08', 'YYYY-MM-DD_HH:MI:SS'),6,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (7,'����7','���� 7','����ȣ','1111','abc7@kh.com',0,to_date('1974-09-07_01:34:14', 'YYYY-MM-DD_HH:MI:SS'),7,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (8,'����8','���� 8','�ۿ���','1111','abc8@kh.com',0,to_date('1975-01-12_09:12:01', 'YYYY-MM-DD_HH:MI:SS'),8,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (9,'����9','���� 9','���μ�','1111','abc9@kh.com',3,to_date('1975-04-27_09:32:02', 'YYYY-MM-DD_HH:MI:SS'),9,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (10,'����10','���� 10','������','1111','abc10@kh.com',3,to_date('1976-04-13_05:43:48', 'YYYY-MM-DD_HH:MI:SS'),10,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (11,'����11','���� 11','��ö��','1111','abc11@kh.com',3,to_date('1976-08-07_07:54:30', 'YYYY-MM-DD_HH:MI:SS'),11,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (12,'����12','���� 12','���忹','1111','abc12@kh.com',2,to_date('1976-08-19_09:36:42', 'YYYY-MM-DD_HH:MI:SS'),12,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (13,'����13','���� 13','�̿���','1111','abc13@kh.com',2,to_date('1976-11-13_06:17:52', 'YYYY-MM-DD_HH:MI:SS'),13,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (14,'����14','���� 14','��ȣ��','1111','abc14@kh.com',1,to_date('1977-03-22_08:26:03', 'YYYY-MM-DD_HH:MI:SS'),14,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (15,'����15','���� 15','����','1111','abc15@kh.com',1,to_date('1977-03-25_12:10:37', 'YYYY-MM-DD_HH:MI:SS'),15,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (16,'����16','���� 16','������','1111','abc16@kh.com',0,to_date('1978-07-19_02:57:52', 'YYYY-MM-DD_HH:MI:SS'),16,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (17,'����17','���� 17','������','1111','abc17@kh.com',3,to_date('1979-03-24_01:15:31', 'YYYY-MM-DD_HH:MI:SS'),17,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (18,'����18','���� 18','�ں���','1111','abc18@kh.com',2,to_date('1981-02-26_09:10:15', 'YYYY-MM-DD_HH:MI:SS'),18,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (19,'����19','���� 19','������','1111','abc19@kh.com',0,to_date('1981-06-22_07:00:53', 'YYYY-MM-DD_HH:MI:SS'),19,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (20,'����20','���� 20','������','1111','abc20@kh.com',3,to_date('1981-09-29_11:19:54', 'YYYY-MM-DD_HH:MI:SS'),20,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (21,'����21','���� 21','�մ���','1111','abc21@kh.com',1,to_date('1983-01-21_08:59:22', 'YYYY-MM-DD_HH:MI:SS'),21,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (22,'����22','���� 22','������','1111','abc22@kh.com',3,to_date('1983-01-29_01:03:26', 'YYYY-MM-DD_HH:MI:SS'),22,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (23,'����23','���� 23','�㼺��','1111','abc23@kh.com',0,to_date('1983-02-20_08:57:10', 'YYYY-MM-DD_HH:MI:SS'),23,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (24,'����24','���� 24','������','1111','abc24@kh.com',1,to_date('1983-09-30_01:44:18', 'YYYY-MM-DD_HH:MI:SS'),24,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (25,'����25','���� 25','������','1111','abc25@kh.com',3,to_date('1983-10-28_02:01:52', 'YYYY-MM-DD_HH:MI:SS'),25,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (26,'����26','���� 26','������','1111','abc26@kh.com',0,to_date('1983-12-02_07:47:37', 'YYYY-MM-DD_HH:MI:SS'),26,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (27,'����27','���� 27','�žƻ�','1111','abc27@kh.com',3,to_date('1984-07-04_11:20:28', 'YYYY-MM-DD_HH:MI:SS'),27,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (28,'����28','���� 28','������','1111','abc28@kh.com',1,to_date('1984-10-29_04:22:44', 'YYYY-MM-DD_HH:MI:SS'),28,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (29,'����29','���� 29','���γ�','1111','abc29@kh.com',0,to_date('1984-11-08_05:19:09', 'YYYY-MM-DD_HH:MI:SS'),29,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (30,'����30','���� 30','������','1111','abc30@kh.com',0,to_date('1985-01-20_09:12:24', 'YYYY-MM-DD_HH:MI:SS'),30,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (31,'����31','���� 31','������','1111','abc31@kh.com',2,to_date('1985-02-10_05:58:11', 'YYYY-MM-DD_HH:MI:SS'),31,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (32,'����32','���� 32','���缺','1111','abc32@kh.com',2,to_date('1986-01-13_06:15:06', 'YYYY-MM-DD_HH:MI:SS'),32,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (33,'����33','���� 33','��̰�','1111','abc33@kh.com',0,to_date('1986-04-15_11:18:52', 'YYYY-MM-DD_HH:MI:SS'),33,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (34,'����34','���� 34','������','1111','abc34@kh.com',0,to_date('1986-09-28_04:30:13', 'YYYY-MM-DD_HH:MI:SS'),34,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (35,'����35','���� 35','������','1111','abc35@kh.com',2,to_date('1988-01-24_07:14:26', 'YYYY-MM-DD_HH:MI:SS'),35,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (36,'����36','���� 36','�����','1111','abc36@kh.com',2,to_date('1988-02-14_10:38:55', 'YYYY-MM-DD_HH:MI:SS'),36,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (37,'����37','���� 37','������','1111','abc37@kh.com',1,to_date('1989-02-12_00:08:20', 'YYYY-MM-DD_HH:MI:SS'),37,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (38,'����38','���� 38','�챸��','1111','abc38@kh.com',0,to_date('1989-02-13_02:39:35', 'YYYY-MM-DD_HH:MI:SS'),38,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (39,'����39','���� 39','�ӱ���','1111','abc39@kh.com',3,to_date('1989-05-02_06:27:25', 'YYYY-MM-DD_HH:MI:SS'),39,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (40,'����40','���� 40','������','1111','abc40@kh.com',2,to_date('1989-08-23_02:51:32', 'YYYY-MM-DD_HH:MI:SS'),40,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (41,'����41','���� 41','����õ','1111','abc41@kh.com',1,to_date('1990-01-22_05:51:30', 'YYYY-MM-DD_HH:MI:SS'),41,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (42,'����42','���� 42','������','1111','abc42@kh.com',0,to_date('1990-07-23_05:04:30', 'YYYY-MM-DD_HH:MI:SS'),42,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (43,'����43','���� 43','������','1111','abc43@kh.com',3,to_date('1990-07-27_08:17:30', 'YYYY-MM-DD_HH:MI:SS'),43,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (44,'����44','���� 44','����ȣ','1111','abc44@kh.com',0,to_date('1990-08-01_02:34:39', 'YYYY-MM-DD_HH:MI:SS'),44,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (45,'����45','���� 45','������','1111','abc45@kh.com',1,to_date('1990-08-06_10:24:26', 'YYYY-MM-DD_HH:MI:SS'),45,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (46,'����46','���� 46','���ֿ�','1111','abc46@kh.com',2,to_date('1990-11-22_08:56:28', 'YYYY-MM-DD_HH:MI:SS'),46,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (47,'����47','���� 47','��ö��','1111','abc47@kh.com',3,to_date('1991-02-21_09:07:37', 'YYYY-MM-DD_HH:MI:SS'),47,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (48,'����48','���� 48','����ȣ','1111','abc48@kh.com',1,to_date('1992-05-22_07:37:47', 'YYYY-MM-DD_HH:MI:SS'),48,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (49,'����49','���� 49','�����','1111','abc49@kh.com',0,to_date('1992-07-02_09:19:07', 'YYYY-MM-DD_HH:MI:SS'),49,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (50,'����50','���� 50','�ݹ���','1111','abc50@kh.com',1,to_date('1992-07-06_01:12:31', 'YYYY-MM-DD_HH:MI:SS'),50,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (51,'����51','���� 51','������','1111','abc51@kh.com',3,to_date('1992-10-17_01:31:01', 'YYYY-MM-DD_HH:MI:SS'),51,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (52,'����52','���� 52','�ڿ��','1111','abc52@kh.com',3,to_date('1994-04-03_04:23:32', 'YYYY-MM-DD_HH:MI:SS'),52,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (53,'����53','���� 53','���漺','1111','abc53@kh.com',0,to_date('1994-09-07_10:31:02', 'YYYY-MM-DD_HH:MI:SS'),53,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (54,'����54','���� 54','������','1111','abc54@kh.com',3,to_date('1995-04-30_03:49:42', 'YYYY-MM-DD_HH:MI:SS'),54,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (55,'����55','���� 55','�̱���','1111','abc55@kh.com',0,to_date('1995-08-07_04:32:55', 'YYYY-MM-DD_HH:MI:SS'),55,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (56,'����56','���� 56','������','1111','abc56@kh.com',1,to_date('1995-12-09_02:39:47', 'YYYY-MM-DD_HH:MI:SS'),56,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (57,'����57','���� 57','�ŵ���','1111','abc57@kh.com',3,to_date('1996-03-28_02:34:29', 'YYYY-MM-DD_HH:MI:SS'),57,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (58,'����58','���� 58','��ȣ��','1111','abc58@kh.com',3,to_date('1996-07-25_02:48:21', 'YYYY-MM-DD_HH:MI:SS'),58,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (59,'����59','���� 59','������','1111','abc59@kh.com',0,to_date('1996-08-05_02:04:31', 'YYYY-MM-DD_HH:MI:SS'),59,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (60,'����60','���� 60','�󺹸�','1111','abc60@kh.com',0,to_date('1996-08-06_03:35:51', 'YYYY-MM-DD_HH:MI:SS'),60,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (61,'����61','���� 61','������','1111','abc61@kh.com',0,to_date('1997-09-28_04:03:40', 'YYYY-MM-DD_HH:MI:SS'),61,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (62,'����62','���� 62','������','1111','abc62@kh.com',0,to_date('1998-02-24_10:18:21', 'YYYY-MM-DD_HH:MI:SS'),62,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (63,'����63','���� 63','�ǿ���','1111','abc63@kh.com',1,to_date('1998-08-06_02:59:45', 'YYYY-MM-DD_HH:MI:SS'),63,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (64,'����64','���� 64','���ܹ�','1111','abc64@kh.com',0,to_date('1999-08-11_01:06:39', 'YYYY-MM-DD_HH:MI:SS'),64,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (65,'����65','���� 65','����ö','1111','abc65@kh.com',3,to_date('1999-10-12_04:02:11', 'YYYY-MM-DD_HH:MI:SS'),65,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (66,'����66','���� 66','������','1111','abc66@kh.com',3,to_date('2000-04-10_08:41:33', 'YYYY-MM-DD_HH:MI:SS'),66,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (67,'����67','���� 67','�ݵ���','1111','abc67@kh.com',3,to_date('2000-06-16_06:51:14', 'YYYY-MM-DD_HH:MI:SS'),67,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (68,'����68','���� 68','�念��','1111','abc68@kh.com',1,to_date('2001-07-26_11:24:55', 'YYYY-MM-DD_HH:MI:SS'),68,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (69,'����69','���� 69','�߾ƿ�','1111','abc69@kh.com',1,to_date('2003-03-28_00:23:06', 'YYYY-MM-DD_HH:MI:SS'),69,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (70,'����70','���� 70','������','1111','abc70@kh.com',2,to_date('2003-06-07_08:53:03', 'YYYY-MM-DD_HH:MI:SS'),70,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (71,'����71','���� 71','�Ǹ���','1111','abc71@kh.com',3,to_date('2003-10-17_11:04:47', 'YYYY-MM-DD_HH:MI:SS'),71,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (72,'����72','���� 72','������','1111','abc72@kh.com',3,to_date('2004-01-15_05:08:06', 'YYYY-MM-DD_HH:MI:SS'),72,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (73,'����73','���� 73','�߿��','1111','abc73@kh.com',2,to_date('2004-12-04_09:38:46', 'YYYY-MM-DD_HH:MI:SS'),73,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (74,'����74','���� 74','������','1111','abc74@kh.com',2,to_date('2005-01-17_03:32:47', 'YYYY-MM-DD_HH:MI:SS'),74,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (75,'����75','���� 75','������','1111','abc75@kh.com',1,to_date('2005-04-03_05:44:13', 'YYYY-MM-DD_HH:MI:SS'),75,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (76,'����76','���� 76','�嵵��','1111','abc76@kh.com',0,to_date('2006-11-25_08:17:50', 'YYYY-MM-DD_HH:MI:SS'),76,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (77,'����77','���� 77','�ۻ���','1111','abc77@kh.com',1,to_date('2006-12-16_02:12:25', 'YYYY-MM-DD_HH:MI:SS'),77,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (78,'����78','���� 78','�ǿ��','1111','abc78@kh.com',3,to_date('2006-12-31_01:39:36', 'YYYY-MM-DD_HH:MI:SS'),78,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (79,'����79','���� 79','�����','1111','abc79@kh.com',2,to_date('2008-05-27_03:43:32', 'YYYY-MM-DD_HH:MI:SS'),79,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (80,'����80','���� 80','������','1111','abc80@kh.com',1,to_date('2009-05-16_11:08:48', 'YYYY-MM-DD_HH:MI:SS'),80,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (81,'����81','���� 81','�ſ��','1111','abc81@kh.com',0,to_date('2009-05-22_10:44:30', 'YYYY-MM-DD_HH:MI:SS'),81,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (82,'����82','���� 82','�߼���','1111','abc82@kh.com',2,to_date('2009-06-15_07:10:50', 'YYYY-MM-DD_HH:MI:SS'),82,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (83,'����83','���� 83','��泪','1111','abc83@kh.com',0,to_date('2009-09-17_01:30:40', 'YYYY-MM-DD_HH:MI:SS'),83,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (84,'����84','���� 84','������','1111','abc84@kh.com',3,to_date('2010-09-09_05:42:28', 'YYYY-MM-DD_HH:MI:SS'),84,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (85,'����85','���� 85','��ö��','1111','abc85@kh.com',0,to_date('2012-03-13_11:12:44', 'YYYY-MM-DD_HH:MI:SS'),85,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (86,'����86','���� 86','�忬��','1111','abc86@kh.com',0,to_date('2012-04-22_05:48:04', 'YYYY-MM-DD_HH:MI:SS'),86,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (87,'����87','���� 87','�����','1111','abc87@kh.com',2,to_date('2012-09-01_05:04:26', 'YYYY-MM-DD_HH:MI:SS'),87,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (88,'����88','���� 88','�嵵��','1111','abc88@kh.com',3,to_date('2012-10-28_01:34:22', 'YYYY-MM-DD_HH:MI:SS'),88,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (89,'����89','���� 89','�ڽü�','1111','abc89@kh.com',2,to_date('2014-12-15_11:51:06', 'YYYY-MM-DD_HH:MI:SS'),89,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (90,'����90','���� 90','�߿¿�','1111','abc90@kh.com',1,to_date('2015-08-26_09:26:44', 'YYYY-MM-DD_HH:MI:SS'),90,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (91,'����91','���� 91','���ӻ�','1111','abc91@kh.com',1,to_date('2015-08-27_08:01:48', 'YYYY-MM-DD_HH:MI:SS'),91,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (92,'����92','���� 92','�ߺ��','1111','abc92@kh.com',1,to_date('2015-10-21_01:38:08', 'YYYY-MM-DD_HH:MI:SS'),92,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (93,'����93','���� 93','�����','1111','abc93@kh.com',2,to_date('2016-01-31_03:36:36', 'YYYY-MM-DD_HH:MI:SS'),93,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (94,'����94','���� 94','������','1111','abc94@kh.com',2,to_date('2016-02-05_03:20:25', 'YYYY-MM-DD_HH:MI:SS'),94,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (95,'����95','���� 95','��μ�','1111','abc95@kh.com',1,to_date('2016-04-29_12:16:28', 'YYYY-MM-DD_HH:MI:SS'),95,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (96,'����96','���� 96','�ǿ�ȣ','1111','abc96@kh.com',0,to_date('2016-06-04_05:47:11', 'YYYY-MM-DD_HH:MI:SS'),96,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (97,'����97','���� 97','������','1111','abc97@kh.com',0,to_date('2017-03-15_04:04:54', 'YYYY-MM-DD_HH:MI:SS'),97,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (98,'����98','���� 98','�۽���','1111','abc98@kh.com',0,to_date('2017-08-31_09:38:45', 'YYYY-MM-DD_HH:MI:SS'),98,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (99,'����99','���� 99','�쿹��','1111','abc99@kh.com',1,to_date('2017-09-21_12:06:42', 'YYYY-MM-DD_HH:MI:SS'),99,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (100,'����100','���� 100','������','1111','abc100@kh.com',2,to_date('2018-09-21_11:38:12', 'YYYY-MM-DD_HH:MI:SS'),100,0,0);
insert into board(b_no,subject,content,writer,pwd,email,readcount,reg_date,group_no,print_no,print_level) values (101,'����101','���� 101','������','1111','abc101@kh.com',0,to_date('2019-02-17_06:56:45', 'YYYY-MM-DD_HH:MI:SS'),101,0,0);

commit;

select * from board;

delete from board;