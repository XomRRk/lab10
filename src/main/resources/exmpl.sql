Create table student(id_student serial not null primary key ,
                     name varchar(10) not null,
                     passport_series char(4) not null UNIQUE ,
                     passport_number char(6) not null unique
);
CREATE table subject(
                        id_subject serial not null primary key ,
                        name_subject varchar(50)not null
);

Create table progress(
                         id_progress serial not null primary key ,
                         id_student int not null,
                         foreign key (id_student)
                             references
                                 student(id_student)
                             on delete cascade
                             on update cascade,
                         id_subject int not null,
                         foreign key (id_subject)
                             references
                                 subject(id_subject)
                             on delete cascade
                             on update cascade,
                         mark smallint not null constraint check_mark check ( mark>1 and mark<6)

);
drop table student;
drop table subject;
drop table progress;

insert into student(passport_series, passport_number, name) values (3316, 112233,'Name1'),(2233,224433,'Name2'),(5533,553366,'Name3'),(1188,667788,'Name4'), (6677,448899,'Name5');
insert into subject(name_subject) values ('mathematics'), ('English'),('russian') , ('history');
insert into  progress(id_student, id_subject, mark) values (1,1,2),(2,1,3),(3,1,2),(4,1,5),(5,1,4),(1,2,4),(2,2,5),(3,2,4),(4,2,5),(5,2,2),(1,3,5),(2,3,2),(3,3,4),(4,3,5),(5,3,4), (1,4,5),(2,4,2),(3,4,4),(4,4,5),(5,4,4);

select *from student;
select *from subject;
select * from progress;

select distinct student.name, subject.name_subject, progress.mark from student, subject, progress where student.id_student=progress.id_student and progress.id_subject=subject.id_subject  and subject.name_subject = 'mathematics' and progress.mark>3 order by student.name;

delete from student
where name='Name1';
select distinct name, mark from progress join student on (progress.id_student=student.id_student) order by name;
select avg(mark) from progress, subject where progress.id_subject=subject.id_subject and subject.name_subject='English';

select avg(mark) from progress join student  on (progress.id_student=student.id_student) where student.name='Name2';

select name_subject, mark from progress join subject on( progress.id_subject=subject.id_subject) order by name_subject;

select distinct name_subject, count(mark) a from progress join subject on (progress.id_subject=subject.id_subject) where mark>2 group by name_subject order by a desc limit 3;
/*select name, name_subject, mark from progress, subject, student
                                where not exists(select name from student, progress where student.id_student=progress.id_student and progress.mark<4)
                                    and
                                    progress.id_subject=subject.id_subject ;*/
select name, name_subject,  mark from student join progress p on (student.id_student = p.id_student) join public.subject s on p.id_subject = s.id_subject
where mark>3 offset 1 limit 3;