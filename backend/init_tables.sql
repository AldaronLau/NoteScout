-- Use this script to initialize tables within the database.

create table users (username text primary key);
alter table users add column password text;
alter table users add column pswdsalt int8;
