begin
dbms_output.put_line('Hello World');
end;

declare
ename varchar2(50);
begin
select (first_name|| ' '||last_name) into ename
        from employees
        where employee_id=105;
        dbms_output.put_line(ename);
end;

declare
    jdate date;
    months number;
    rmonths number;
begin
    select hire_date into jdate
    from employees
    where employee_id=100;
    months:=months_between(sysdate,jdate);
    rmonths:=round(months,2);
    dbms_output.put_line(rmonths);
end;

declare
    jdate date;
    wyear number;
begin
    select hire_date into jdate
    from employees
    where employee_id=100;
    wyear:=(months_between(sysdate,jdate)/12);
    if wyear>10 then
        dbms_output.put_line('working for more then 10 years');
    else 
        dbms_output.put_line('working for less then 10 years... Noob shit.');
    end if;
end;

declare
    jdate date;
    wyear number;
begin
    select hire_date into jdate
    from employees
    where employee_id=10005;
    wyear:=(months_between(sysdate,jdate)/12);
    if wyear>10 then
        dbms_output.put_line('working for more then 10 years');
    else 
        dbms_output.put_line('working for less then 10 years... Noob shit.');
    end if;
exception
    when no_data_found then
        dbms_output.put_line('Employee is not present!');
    when others then
        dbms_output.put_line('I dont know what the fuck just happened');    
end;

declare
enames varchar2(50);
begin
select first_name into enames
from employees;
dbms_output.put_line('enames');
exception
when too_many_rows then
dbms_output.put_line('Too many rows int the output');
when others then
dbms_output.put_line('What the fuck just happened?');
end;

declare
begin
    for i in 1..100
    loop
        dbms_output.put_line(i);
    end loop;
end;

declare 
    i number;
begin
    i:=1;
    while i<=100
    loop
        dbms_output.put_line(i);
        i:=i+1;
    end loop;
end;

declare
    i number;
begin
    i:=1;
    loop
        dbms_output.put_line(i);
        i:=i+1;
        exit when i>100;
    end loop;
end;

declare
    years number;
    counter number;
begin
    counter:=0;
    for R in (select hire_date from employees)
    loop
        years:=(months_between(sysdate,R.hire_date)/12);
        if years>10 then
            counter:=counter+1;
        end if;
    end loop;
    dbms_output.put_line('Number of employees that worked more then 10 years: '||counter);
end;


declare
    hdate date;
begin
    for R in (select * from employees)
    loop
        hdate:=R.hire_date;
        if ( to_char(hdate,'mm')=to_char(sysdate,'mm') and to_char(hdate,'dd')=to_char(sysdate,'dd')) then
            dbms_output.put_line('Happy birthday '||R.first_name || ' '||R.last_name || ' '|| hdate);
        end if;
    end loop;
end;

create or replace procedure is_senior_employee is
    jdate date;
    years number;
begin
    select hire_date into jdate
    from employees
    where employee_id=100;
    years:= (months_between(sysdate,jdate)/12);
    if years >10 then
        dbms_output.put_line('Is s senior employee');
    else
        dbms_output.put_line('Noob Fuck');
    end if;
end;

execute is_senior_employee;

begin
is_senior_employee;
end;

create or replace procedure is_senior_employee(eid in varchar2) is
--declare section
    jdate date;
    years number;
begin
    select hire_date into jdate
    from employees
    where employee_id=eid;
    years:=(months_between(sysdate,jdate)/12);
    if years > 10 then
        dbms_output.put_line('Is a fuckin senior employee');
    else dbms_output.put_line('You Noob');
    end if;
exception
    when no_data_found then
        dbms_output.put_line('That mf is not here');
    when others then
    dbms_output.put_line('I fuckin dont know wnaything');
end;

execute is_senior_employee(1005);

create or replace procedure is_senior_employee(eid in varchar2, msg out varchar2) is
    jdate date;
    years number;
begin
    select hire_date into jdate
    from employees
    where employee_id=eid;
    years:=(months_between(sysdate,jdate)/12);
    if years> 10 then
        msg:='he is a fuckin senior';
    else
        msg:='mf noob';
    end if;
exception
    when no_data_found then
        msg:='Fuckin nuts. He isnt here';
    when too_many_rows then
        msg:='He is a gay -_-';
    when others then
        msg:= 'Fuck you!';
end;

declare
msg varchar2(100);
begin
is_senior_employee(1005,msg);
dbms_output.put_line(msg);
end;

create or replace function count_employees(jobId in varchar2)
return varchar2 is
    jid varchar2(50);
    cnt number;
    msg varchar2(100);
begin
    begin
        select count(*) into cnt
        from employees
        where job_id=jobId;
    end;
    
    if cnt=0 then
        msg:='no employees';
    else
        msg:='many more are on';
    end if;
    return msg;
end;

declare
msg varchar2(100);
begin
msg:=count_employees('IT-PROG');
dbms_output.put_line(msg);
end;
