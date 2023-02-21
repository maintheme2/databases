
-- task 1
select max(enrollment) as max_enrollment, min(enrollment) as min_enrollment 
from (
    select count(*) as enrollment 
    from takes 
    group by course_id, sec_id, semester, year 
    having count(*) > 0
) as enrollment_counts;

-- task 2
select course_id, sec_id, semester, year, count(*) as enrollment
from takes
group by course_id, sec_id, semester, year
having count(*) = (
    select max(enrollment)
    from (
        select count(*) as enrollment 
        from takes 
        group by course_id, sec_id, semester, year 
        having count(*) > 0
    ) as enrollment_counts
)

-- task 3
-- 1)
select max(enrollment) as max_enrollment, min(enrollment) as min_enrollment 
from (
    select 
        (select count(*) 
        from takes t 
        where s.course_id=t.course_id and s.sec_id=t.sec_id
        and s.semester=t.semester and s.year=t.year) as enrollment 
    from section s
) as enrollment_counts;

-- 2)
select max(coalesce(enrollment, 0)) as max_enrollment, min(coalesce(enrollment, 0)) as min_enrollment 
from (
    select s.course_id, s.sec_id, s.semester, s.year, count(t.ID) as enrollment 
    from section s left join takes t on s.course_id=t.course_id and s.sec_id=t.sec_id and s.semester=t.semester and s.year=t.year
    group by s.course_id, s.sec_id, s.semester, s.year
) as enrollment_counts;

-- task 4
select distinct course_id 
from course 
where course_id like 'CS-1%';

-- task 5
select distinct name 
from instructor 
where dept_name='Biology';

-- task 6
select sec_id, course_id, id as enrollment
from takes
where semester='Fall' and year=2022
group by sec_id, course_id, id;

-- task 7
select max(counts.enrollment) as max_enrollment
from (
    select count(id) as enrollment
    from takes
    where semester='Fall' and year=2022
    group by sec_id, course_id, semester, year
) as counts;


