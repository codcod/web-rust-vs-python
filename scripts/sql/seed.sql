-- Seed data.

--
--  Authors
--

insert into
    authors (first_name, last_name)
values
    ('David', 'Baldacci')
;

insert into
    authors (first_name, last_name)
values
    ('Laura', 'Dave')
;

insert into
    authors (first_name, last_name)
values
    ('Colleen', 'Hoover')
;

insert into
    authors (first_name, last_name)
values
    ('Bonnie', 'Garmus')
;

--
-- Books
--

-- Book 1

insert into
    books (title, summary, author_id, publication_date)
select
    'SIMPLY LIES',
    '<summary>',
    author_id,
    '2023-04-18'
from
    authors
where
    first_name = 'David'
    and last_name = 'Baldacci'
;

update books
set
    summary =
    'A former detective becomes the prime suspect in a murder case ' ||
    'involving a man with mob ties who was in witness protection.'
where
    title = 'SIMPLY LIES'
;

-- Book 2

insert into
    books (title, summary, author_id, publication_date)
select
    'THE LAST THING HE TOLD ME',
    '<summary>',
    author_id,
    '2021-05-04'
from
    authors
where
    first_name = 'Laura'
    and last_name = 'Dave'
;

update books
set
    summary =
    'Hannah Hall discovers truths about her missing husband and ' ||
    'bonds with his daughter from a previous relationship.'
where
    title = 'THE LAST THING HE TOLD ME'
;

-- Book 3

insert into
    books (title, summary, author_id, publication_date)
select
    'IT ENDS WITH US',
    '<summary>',
    author_id,
    '2016-09-02'
from
    authors
where
    first_name = 'Colleen'
    and last_name = 'Hoover'
;

update books
set
    summary =
    'A battered wife raised in a violent home attempts to halt ' ||
    'the cycle of abuse.'
where
    title = 'IT ENDS WITH US'
;

-- Book 4

insert into
    books (title, summary, author_id, publication_date)
select
    'LESSONS IN CHEMISTRY',
    '<summary>',
    author_id,
    '2022-04-05'
from
    authors
where
    first_name = 'Bonnie'
    and last_name = 'Garmus'
;

update books
set
    summary =
    'A scientist and single mother living in California in ' ||
    'the 1960s becomes a star on a TV cooking show.'
where
    title = 'LESSONS IN CHEMISTRY'
;

-- Book 5

insert into
    books (title, summary, author_id, publication_date)
select
    'IT STARTS WITH US',
    '<summary>',
    author_id,
    '2022-10-18'
from
    authors
where
    first_name = 'Colleen'
    and last_name = 'Hoover'
;

update books
set
    summary =
    'In the sequel to “It Ends With Us,” Lily deals with ' ||
    'her jealous ex-husband as she reconnects with her first boyfriend.'
where
    title = 'IT STARTS WITH US'
;

-- vim: sw=4:et:ai
