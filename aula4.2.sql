create database Bd_Instituto;

-- Abrir o Banco de Dados
use Bd_Instituto;

---------------------------------------------------------------------------------------
-- Tabela Instituto_Adm

Create table Instituto_Adm
(
  Cod_Inst         Varchar(3),
  Nome_Inst        Varchar(30) not null,
  End_Inst         Varchar(30),
  Bairro_Inst      Varchar(20),
  Contato_Inst     Varchar(30),
  CNPJ             Varchar(19) unique,                        
  Primary key(Cod_Inst)
);

-- Inserir dados na tabela Instituto_Adm
insert into Instituto_Adm (Cod_Inst, Nome_Inst, End_Inst, Bairro_Inst, Contato_Inst, CNPJ) values
('IES','Instituto Ensino Superior','Rua das Cruzes,233','Santa Isabel','Mario Bross','123.546.345/0001-54');

---------------------------------------------------------------------------------------
-- Tabela Cursos

Create Table Cursos
(
  Cod_Curso   Varchar(3),
  Nome_Curso  Varchar(90),
  Sigla_Curso Varchar(3),
  Tempo_Curso Varchar(2), -- Nº de semestres ou anos
  Duracao     Varchar(1) check (Duracao in ('S','A')),  -- Semestral / Anual
  Primary key (Cod_Curso)
);

-- Inserir dados na tabela Cursos
insert into Cursos (Cod_Curso, Nome_Curso, Sigla_Curso, Tempo_Curso, Duracao) values
('C01','Analise e Desenvolvimento Sistemas','ADS','4','S');
insert into Cursos (Cod_Curso, Nome_Curso, Sigla_Curso, Tempo_Curso, Duracao) values
('C02','Engenharia da Computação','ECO','10','S');

---------------------------------------------------------------------------------------
-- Tabela Unidades

Create Table Unidades
(
  Cod_Unidade    Varchar(3),
  Nome_Unidade   Varchar(90),
  End_Unidade    Varchar(90),
  Bairro_Unidade Varchar(30),
  Fone_Unidade   Varchar(20),
  Cod_Instituto  Varchar(3),
  Primary key (Cod_Unidade),
  Constraint Pk_Instituto_Unidade foreign key(Cod_Instituto) references Instituto_Adm(Cod_Inst)
);

-- Inserir dados na tabela Unidades
insert into Unidades (Cod_Unidade, Nome_Unidade, End_Unidade, Bairro_Unidade, Fone_Unidade, Cod_Instituto) values
('U01','UNED Liberdade','Rua dos Marianos,45','Bela Vista','(11)-1223453','IES');
insert into Unidades (Cod_Unidade, Nome_Unidade, End_Unidade, Bairro_Unidade, Fone_Unidade, Cod_Instituto) values
('U02','UNED Guarulhos','Rua Brasil,345','Vila Rio','(11)-3333333','IES');

---------------------------------------------------------------------------------------
-- Tabela Turmas

Create Table Turmas 
(
  Cod_Turma   Varchar(4),
  Cod_Unidade Varchar(3),
  Curso       Varchar(3),
  Periodo     Varchar(1) check (Periodo in('M','T','N')),
  Vagas       int check (Vagas > 0 and Vagas <= 40),
  Primary key (Cod_Turma),
  Constraint FK_Turma_Unidade foreign key (Cod_Unidade) references Unidades (Cod_Unidade)
);

-- Inserir dados na tabela Turmas
insert into Turmas (Cod_Turma, Cod_Unidade, Curso, Periodo, Vagas) values
('T01','U01','C01','M',40);  
insert into Turmas (Cod_Turma, Cod_Unidade, Curso, Periodo, Vagas) values
('T02','U01','C01','N',35);
insert into Turmas (Cod_Turma, Cod_Unidade, Curso, Periodo, Vagas) values
('T03','U02','C02','M',40);

---------------------------------------------------------------------------------------
-- Tabela Alunos

Create Table Alunos
(
  Cod_Aluno  Varchar(6),
  Nome_Aluno Varchar(90),
  Unidade    Varchar(3),
  Curso      Varchar(3),
  Turma      Varchar(4),
  Primary key (Cod_Aluno),
  Constraint FK_Alunos_Unid foreign key(Unidade) references Unidades(Cod_Unidade),
  Constraint FK_Alunos_Curso foreign key (Curso) references Cursos(Cod_Curso),
  Constraint FK_Alunos_Turma foreign key (Turma) references Turmas(Cod_Turma)
);

-- Inserir dados na tabela Alunos
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU001','Fabricio da Silva','U01','C01','T01');    
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU002','Maria Vitalina','U01','C01','T01');   
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU010','Carlos Oliveira','U02','C02','T03');  


-- Inserir 8 novos alunos na turma T01 (Análise e Desenvolvimento de Sistemas)
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU003','Ana Pereira','U01','C01','T01');    
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU004','José Santos','U01','C01','T01');   
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU005','Mariana Lima','U01','C01','T01');  
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU006','Lucas Silva','U01','C01','T01');  
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU007','Fernanda Alves','U01','C01','T01');  
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU008','Ricardo Gomes','U01','C01','T01');  
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU009','Tatiane Costa','U01','C01','T01');  
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU011','André Martins','U01','C01','T01');  

-- Inserir 8 novos alunos na turma T03 (Engenharia da Computação)
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU012','Gabriel Rocha','U02','C02','T03');    
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU013','Carla Santos','U02','C02','T03');   
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU014','Fernando Lima','U02','C02','T03');  
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU015','Julia Martins','U02','C02','T03');  
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU016','Rafael Costa','U02','C02','T03');  
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU017','Mariana Ferreira','U02','C02','T03');  
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU018','Thiago Almeida','U02','C02','T03');  
insert into Alunos (Cod_Aluno, Nome_Aluno, Unidade, Curso, Turma) values
('GU019','Aline Oliveira','U02','C02','T03');  

---------------------------------------------------------------------------------------
-- Consultas

-- 1) Selecionar o código da Instituição, nome da Instituição, código da Unidade e nome da unidade
select Instituto_Adm.Cod_Inst, Instituto_Adm.Nome_Inst, Unidades.Cod_Unidade, Unidades.Nome_Unidade
from Instituto_Adm
join Unidades on Instituto_Adm.Cod_Inst = Unidades.Cod_Instituto;

-- 2) Selecionar o código da Unidade, nome da Unidade, código do curso, nome do curso em ordem alfabética
select Unidades.Cod_Unidade, Unidades.Nome_Unidade, Cursos.Cod_Curso, Cursos.Nome_Curso
from Unidades
join Turmas on Unidades.Cod_Unidade = Turmas.Cod_Unidade
join Cursos on Turmas.Curso = Cursos.Cod_Curso
order by Unidades.Nome_Unidade, Cursos.Nome_Curso;

-- 3) Selecionar o código da Unidade, nome do curso, tempo de curso e duração
select Unidades.Cod_Unidade, Cursos.Nome_Curso, Cursos.Tempo_Curso, Cursos.Duracao
from Unidades
join Turmas on Unidades.Cod_Unidade = Turmas.Cod_Unidade
join Cursos on Turmas.Curso = Cursos.Cod_Curso;

-- 4) Selecionar o nome da unidade, código do curso, nome do curso, código da turma, período e vagas
select Unidades.Nome_Unidade, Cursos.Cod_Curso, Cursos.Nome_Curso, Turmas.Cod_Turma, Turmas.Periodo, Turmas.Vagas
from Unidades
join Turmas on Unidades.Cod_Unidade = Turmas.Cod_Unidade
join Cursos on Turmas.Curso = Cursos.Cod_Curso;

-- 5) Selecionar o código e nome do curso, código da turma, código e nome da unidade, vagas para turmas do período da manhã
select Cursos.Cod_Curso, Cursos.Nome_Curso, Turmas.Cod_Turma, Unidades.Cod_Unidade, Unidades.Nome_Unidade, Turmas.Vagas
from Cursos
join Turmas on Cursos.Cod_Curso = Turmas.Curso
join Unidades on Turmas.Cod_Unidade = Unidades.Cod_Unidade
where Turmas.Periodo = 'M';

-- 6) Selecionar o código da turma, código e nome do aluno, código e nome do curso
select Turmas.Cod_Turma, Alunos.Cod_Aluno, Alunos.Nome_Aluno, Cursos.Cod_Curso, Cursos.Nome_Curso
from Alunos
join Turmas on Alunos.Turma = Turmas.Cod_Turma
join Cursos on Alunos.Curso = Cursos.Cod_Curso;

-- 7) Selecionar o código e nome do aluno, nome da unidade, nome do curso, código da turma do curso de Engenharia da Computação
select Alunos.Cod_Aluno, Alunos.Nome_Aluno, Unidades.Nome_Unidade, Cursos.Nome_Curso, Turmas.Cod_Turma
from Alunos
join Unidades on Alunos.Unidade = Unidades.Cod_Unidade
join Cursos on Alunos.Curso = Cursos.Cod_Curso
join Turmas on Alunos.Turma = Turmas.Cod_Turma
where Cursos.Nome_Curso = 'Engenharia da Computação';

-- 8) Selecionar o código e nome da unidade, código da turma, código e nome do curso, código da turma e nome dos alunos
select Unidades.Cod_Unidade, Unidades.Nome_Unidade, Turmas.Cod_Turma, Cursos.Cod_Curso, Cursos.Nome_Curso, Alunos.Cod_Aluno, Alunos.Nome_Aluno
from Unidades
join Turmas on Unidades.Cod_Unidade = Turmas.Cod_Unidade
join Cursos on Turmas.Curso = Cursos.Cod_Curso
join Alunos on Turmas.Cod_Turma = Alunos.Turma;
