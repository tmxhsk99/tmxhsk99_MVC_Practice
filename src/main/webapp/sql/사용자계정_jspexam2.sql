create sequence seq_board;

create table tbl_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

alter table tbl_board add constraint pk_board
primary key (bno);

insert into tbl_board(bno,title,content,writer)
values (seq_board.nextval,'�׽�Ʈ ����','�׽�Ʈ ����','user00');

commit;
select * from tbl_board;
select * from tbl_board where bno > 0;
select seq_board.nextval from dual;
select * from tbl_board order by bno desc;--order by �� ���
select /*+index_desc (tbl_board pk_board)*/* from tbl_board;
insert into tbl_board(bno,title,content,writer)
(select seq_board.nextval,title,content,writer from tbl_board);