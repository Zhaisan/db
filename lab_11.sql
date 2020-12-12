
create table accounts                         --1
(
    id int generated by default as identity,
    name varchar(100) not null,
    balance dec(15, 2) not null,
    primary key (id)
);
begin;
insert into accounts(name, balance) values ('qwerty', 5700);
commit;

begin;
update accounts set name = 'Nqz', balance = 10000 where name = 'Qwerty';
commit;

create table table1
(
    id int                                    --2
);
begin;
insert into table1 values(1);
savepoint n1;
insert into table1 values(2);
rollback to savepoint n1;
insert into table1 values(3);
savepoint n3;
insert into table1 values(4);
insert into table1 values(5);
insert into table1 values(6);
rollback to savepoint n3;
commit;

create or replace function f3(i int)                      --3
    returns void as
$$
begin
        insert into accounts(name,balance) values ('abc',i);
        case when (select sum(balance) from accounts) < 17000 then commit;
        else rollback;
        end case;
end;
$$ language plpgsql;


begin;
savepoint res;                   --4
delete from table1;
rollback to res;
insert into table1 values(7);
savepoint n7;
insert into table1 values(8);
rollback to n7;
insert into table1 values(9);
savepoint n9;
insert into table1 values(9);
rollback to n9;
insert into table1 values(10);
rollback to n9;
insert into table1 values(11);
commit;