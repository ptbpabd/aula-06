-- Slide 4
create schema aula06;

create table aula06.estudante
(ID varchar (5), 
nome varchar (20) not null,
departamento varchar (20),
tot_cred numeric (3,0) default 0,
primary key (ID));

create index estudanteID_index on aula06.estudante(ID);

create index estudanteIDnome_index on aula06.estudante(ID, nome);


-- Slide 5
create type aula06.Dollars from numeric(12,2) not null;

create table aula06.departmento
(departamento varchar (20),
predio varchar (15),
orcamento aula06.Dollars);

-- Slide 14 
-- Listar usuários
SELECT * FROM sysusers;

-- Listar permissões dos usuários
select  princ.name
,       princ.type_desc
,       perm.permission_name
,       perm.state_desc
,       perm.class_desc
,       object_name(perm.major_id)
from    sys.database_principals princ
left join
        sys.database_permissions perm
on      perm.grantee_principal_id = princ.principal_id
where princ.type_desc = 'SQL_USER' 
order by princ.name;

