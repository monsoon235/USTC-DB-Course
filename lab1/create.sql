create database library;

use library;

create table book
(
    id     char(8) primary key,
    name   varchar(10) not null,
    author varchar(10),
    price  float check ( price >= 0 ),
    status int default 0 check ( status = 0 or status = 1 )
);

create table reader
(
    id      char(10) primary key,
    name    varchar(10),
    age     int check ( age >= 0 ),
    address varchar(20)
);

create table borrow
(
    book_id     char(8),
    reader_id   char(10),
    borrow_date date,
    return_date date check ( return_date >= borrow_date ),
    primary key (book_id, reader_id, borrow_date),
    foreign key (book_id) references book (id),
    foreign key (reader_id) references reader (id)
);

# 插入测试数据

insert into book (id, name, author, price)
values ('00000000', 'qwer', 'qwer', 0.00),
       ('00000001', 'asdf', 'Ullman', 1.11),
       ('00000002', 'zxcv', 'Ullman', 2.22),
       ('00000003', 'null', null, null),
       ('00000004', 'Mysql', 'Someone1', 9.99),
       ('00000005', 'MySQL', 'Someone2', 2.33),
       ('00000006', 'MySQL++', 'Someone3', 6.66);

insert into reader (id, name, age, address)
values ('PB00000000', 'aaa', 19, 'USTC'),
       ('PB00000001', 'bbb', null, 'USTC'),
       ('PB00000002', 'xxx', 20, null),
       ('PB17121687', '虞佳焕', null, 'USTC'),
       ('PB23333333', '李林', null, null);

insert into borrow (book_id, reader_id, borrow_date, return_date)
values ('00000000', 'PB00000000', date(19260817), null),
#        ('00000000', 'PB00000000', date(10260818), null),
#        ('00000000', 'PB00000000', date(10260819), null),
#        ('00000000', 'PB00000000', date(10260820), null),
       ('00000000', 'PB00000001', date(19260817), date(19260818)),
       ('00000006', 'PB17121687', date(20191212), date(20191230)),
       ('00000002', 'PB17121687', date(20200115), null),
       ('00000003', 'PB23333333', date(20000101), date(20020202)),
       ('00000003', 'PB23333333', date(20030303), null);
