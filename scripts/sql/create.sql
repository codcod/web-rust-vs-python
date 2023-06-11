-- Create schema.

create sequence author_id_seq
;

create table
    authors (
        author_id int default nextval('author_id_seq'),
        first_name varchar(255) not null,
        last_name varchar(255) not null,

        primary key (author_id)
    )
;

create sequence book_id_seq
;

create table
    books (
        book_id int default nextval('book_id_seq'),
        title varchar(255) not null,
        summary varchar(2000) not null,
        publication_date date,
        created_at timestamp default now(),

        author_id int,

        primary key (book_id),
        constraint fk_author_id
            foreign key (author_id)
            references authors (author_id)
            on delete no action
    )
;

-- vim: sw=4:et:ai
