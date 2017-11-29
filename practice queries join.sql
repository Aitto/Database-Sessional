SELECT department_id  FROM DEPARTMENTS, LOCATIONS WHERE CITY='Roma';

select e.employee_id as id ,e.first_name as name,d.department_id as "department id",d.department_name as "department name",l.city
from employees e,departments d,locations l
where ((d.department_id=e.department_id) and (d.location_id=l.location_id))
order by id;

select city, count(d.department_id)
from departments d,locations l
where d.location_id=l.location_id
group by city;

select city, count(d.department_id)
from departments d right outer join locations l
on d.location_id=l.location_id
group by city;

select city, d.department_id
from departments d right outer join locations l
on d.location_id=l.location_id;

select e.first_name,count(ee.employee_id)  total
from employees e,employees ee
where e.salary>ee.salary
group by (e.employee_id),e.first_name
order by total;

select e1.last_name, count(e2.employee_id) total,e1.salary
from employees e1
left outer join employees e2
on e1.salary>e2.salary
group by e1.employee_id,e1.last_name,e1.salary
order by total;

select e1.last_name, (count(e2.employee_id) +1) rank,e1.salary
from employees e1
left outer join employees e2
on e1.salary<e2.salary
group by e1.employee_id,e1.last_name,e1.salary
order by rank;

select last_name, rank() over (order by salary)
from employees;

select e1.last_name as manager,e1.employee_id as "manager id"  , count(e2.employee_id) as employees
from employees e1,employees e2
where e1.employee_id=e2.manager_id
group by e1.employee_id,e1.last_name
order by e1.employee_id;

select d.department_name as department,c.country_name as country
from departments d 
join locations l on d.location_id=l.location_id
join countries c on c.country_id=l.country_id;

select e.employee_id, count(j.employee_id) as switch
from employees e
left outer join job_history j
on(e.employee_id=j.employee_id)
group by e.employee_id
order by switch;
