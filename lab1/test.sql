use library;

###### 以下语句都将执行失败，用于验证各种完整性约束

# 实体完整性

## 主键不能为空
insert into book (id, name, author, price)
    value (null, 'Some Book', ' Someone', 2.33);
## 多列构成的主键，每一个都不能为空
insert into borrow (book_id, reader_id, borrow_date, return_date)
    value ('00000000', 'PB00000000', null, null);
# 不能插入主键重复的项
insert into book (id, name, author, price)
    value ('00000000', 'Some book', null, null);

update book
set id='00000000'
where id = '00000001';

# 参照完整性

## borrow 中插入不存在的 reader_id 或 book_id
insert into borrow (book_id, reader_id, borrow_date, return_date)
    value ('notexist', 'PB00000000', date(19260817), null);
insert into borrow (book_id, reader_id, borrow_date, return_date)
    value ('00000000', 'not exist_', date(19260817), null);
## book 或 reader 中删除 borrow 中正在引用的项
delete
from book
where id = '00000000';

delete
from reader
where id = 'PB00000000';

# 自定义完整性

## name not null
insert into book (id, name, author, price)
    value ('test0000', null, 'Someone', 2.33);
# price>=0
insert into book (id, name, author, price)
    value ('test0001', 'Some Book', 'Some One', -1);
## status=0/1
insert into book (id, name, author, price, status)
    value ('test0002', 'Some Book', 'Some One', 2.33, 2);
## age>=0
insert into reader (id, name, age, address)
    value ('PBtest0000', 'Someone', -1, 'USTC');
## return_date >= borrow_date
insert into borrow (book_id, reader_id, borrow_date, return_date)
    value ('00000000', 'PB00000000', date(99991231), date(88881231));
