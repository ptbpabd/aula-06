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

-- Slide 10
CREATE USER User_A WITH PASSWORD = 'PT23820x';

-- Slide 12
-- Criar uma Role
CREATE ROLE instructor;

-- Adicionar membros
ALTER ROLE instructor ADD MEMBER User_A; 

-- Adicionar permissões a uma Role
GRANT SELECT ON takes to instructor;

-- Roles podem ser concedidas para users, e também para outras roles
CREATE ROLE teaching_assistant;
ALTER ROLE instructor ADD MEMBER teaching_assistant;

-- Slide 13
-- Consultar Role criada
SELECT 
@@Servername as ServerName
,DB_NAME() AS DatabaseName
,d.name AS DatabaseUser
,ISNULL(dr.name, 'Public') AS DatabaseRole
,dp.permission_name as AdditionalPermission
,dp.state_desc AS PermissionState
,ISNULL(o.type_desc, 'N/A')  AS ObjectType
,ISNULL(o.name, 'N/A') AS ObjectName
FROM sys.database_principals d
    LEFT JOIN sys.database_role_members r
        ON d.principal_id = r.member_principal_id 
    LEFT JOIN sys.database_principals dr
        ON r.role_principal_id = dr.principal_id 
    left JOIN   sys.database_permissions dp
        ON d.principal_id = dp.grantee_principal_id
    LEFT JOIN sys.objects o
        ON dp.major_id = o.object_id 
WHERE d.name IN ('instructor', 'teaching_assistant' );

-- Slide 15
-- Autorização sobre Views
CREATE view aula06.geo_instructor as (select * from instructor where dept_name = 'Geology');

GRANT SELECT ON aula06.geo_instructor to instructor;

-- Slide 16
-- Transferência de privilégios
-- Conceder
GRANT SELECT ON department to User_A with grant option;

-- Revogar
REVOKE SELECT ON department from User_A cascade;

-- Slide 17 
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

