use library;

# （1） 检索读者“xxx”的读者号和地址

select id, address
from reader
where name = '虞佳焕';

# （2） 检索读者“xxx”所借阅读书（包括已还和未还图书）的图书名和借期

select book.name, borrow.borrow_date
from reader,
     book,
     borrow
where reader.id = borrow.reader_id
  and book.id = borrow.book_id
  and reader.name = '虞佳焕';

# （3） 检索未借阅图书的读者姓名（当前）

select name
from reader
where id not in (
    select reader_id
    from borrow
    where return_date is null
);

# （4） 检索Ullman所写的书的书名和单价

select name, price
from book
where author = 'Ullman';

# （5） 检索读者“李林”借阅未还的图书的图书号和书名

select book.id, book.name
from reader,
     book,
     borrow
where reader.name = '李林'
  and borrow.reader_id = reader.id
  and borrow.book_id = book.id
  and borrow.return_date is null;

# （6） 检索借阅图书数目超过3本的读者姓名（建馆以来）

select reader.name
from reader,
     borrow
where borrow.reader_id = reader.id
group by borrow.reader_id
having count(borrow.borrow_date) > 3;

# （7） 检索没有借阅读者“李林”所借的任何一本书的读者姓名和读者号（建馆以来

select distinct reader.name, reader.id
from reader,
     borrow
where reader.id = borrow.reader_id
  and borrow.book_id not in (
    select distinct book_id
    from borrow
    where reader_id = reader.id
      and name = '李林'
);

# （8） 检索书名中包含“MySQL”的图书书名及图书号（不区分大小写

select name, id
from book
where name like '%MySQL%';

# （9） 创建一个读者借书信息的视图，该视图包含读者号、姓名、所借图书号、图书名 和借期；并使用该视图查询最近一年所有读者的读者号以及所借阅的图书数（重复 借阅仍计入次数）

create view borrow_info (reader_id, reader_name, book_id, book_name, borrow_date) as
select borrow.reader_id, reader.name, borrow.book_id, book.name, borrow.borrow_date
from reader,
     book,
     borrow
where reader.id = borrow.reader_id
  and book.id = borrow.book_id;

select reader_id, count(book_id)
from borrow_info
where borrow_date > date_sub(current_date(), interval 1 year)
group by reader_id
having count(book_id) > 0;
