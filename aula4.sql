 /*       
        
                             Junções Interior de tabelas  - Inner Join


Um comando SELECT também pode fazer uma consulta que traz dados de duas ou mais tabelas. 
Esse é um processo chamado de junção [join].
Esse tipo de junção conecta duas ou mais  tabelas e retorna apenas as linhas que satisfazem 
a condição de junção.
As tabelas deve ter uma coluna em comum que é usado para fazer as junções.
Quando usamos várias tabelas, é necessário estarmos atentos à possibilidade de ambiguidade
entre o nome das colunas de tabelas.
Caso estejamos consultando dados de  tabelas que tenham campos com nomes  ambíguos (iguais)
   (por exemplo, Pessoa e Produto), é necessário especificar de qual tabelas queremos
   buscar o campo ambíguo
   
  Exemplo:     Pessoa.Nome e Produto.Nome)


INNER JOIN:
A palavra-chave INNER JOIN exibe os registros quando há, pelo menos, uma ocorrência 
em ambas as tabelas.

Sintaxe:

 Select Tabela1.Campo1,Tabela1.Campo2,...,Tabela2.Campo1,Tabela2.Campo2,....,Tabela3.Campo1,Tabela3.Campo1,....... 
 From Tabela1  Inner  Join Tabela2  on Tabela1.Campo = Tabela2.Campo
 Inner Join Tabela3  on Tabela1 [2].Campo = Tabela3.Campo  
 [Where  <Condição>  ]  [Group By   .. ]
 Order By  Campo Asc/Desc....


onde:   A condição de Junção é declarado com a cláusula  ON  (devendo ser do mesmo tipo),
 as colunas são comparadas usando o =  e as 
 colunas aparecem no resultado, mostrando dados redundantes, 
 já que elas têm o mesmo valor.

*/

drop database exemplojoin;

create database exemplojoin;

use exemplojoin;

---------------------------------------------------------------------------------------
 --- Tabela de Cargo
 
Create Table Cargo
(
 Cod_Cargo varchar(3),
 Nome      varchar(25),
 Data_admissao datetime,
 	Constraint PK_Cargo primary key (Cod_Cargo) 		
 );	

insert into Cargo values ('1','Gerente de Marketing','23/05/1991');
insert into Cargo values ('2','Gerente de Vendas','22/10/2001');
insert into Cargo values ('3','Encarregado de Vendas','20/11/2001');
insert into Cargo values ('4','Vendedor','27/12/2002');
--------------------------------------------------------------------------------------------
--- Tabela de Vendedor
Create table Vendedor
(
	Cod_Vendedor  varchar(3),
	Nome          varchar(30),
	Cod_Cargo     varchar(3),
	Constraint PK_Vendedor primary key (Cod_Vendedor) 		
);

insert into Vendedor values ('V1','Maria Morgato','1');
insert into Vendedor values ('V2','Marcio da Costa','2');
insert into Vendedor values ('V3','Antonio Maria da Paz','3');
insert into Vendedor values ('V4','Mario Broz','4');
insert into Vendedor values ('V5','Margarida da Matta','4');
insert into Vendedor values ('V6','Anny Angelica Juliana','4');
insert into Vendedor values ('V7','Antonio da Gerra Paz','5');

select cod_vendedor, vendedor.nome, cargo.nome from vendedor inner join cargo on vendedor.cod_cargo = cargo.cod_cargo;

-- -------------------------------------------------------------------------------------------
-- Tabela Tipo de Venda
Create table Tipo_Venda
(
	Cod_Tipo_Venda   varchar(1),
	Tipo_Venda       varchar(15),
	primary key (Cod_Tipo_Venda) 		
    );
    
  insert into Tipo_Venda values ('1','A Vista');
  Insert into Tipo_Venda Values ('2', 'A Prazo');
  ---------------------------------------------------------------------------
  -- Tabela Vendas
Create table Venda
(
	cod_venda  varchar(3),
	Nome       varchar(30),
	cod_Vendedor varchar(3),
	Vl_Venda     decimal(15,2),
    Cod_Tipo_Venda varchar(1),		
    primary key (Cod_Venda), 		
    constraint FK_Venda  foreign key (Cod_Vendedor) references Vendedor(Cod_vendedor), 
    constraint FK_TipoVenda  foreign key (Cod_Tipo_Venda) references Tipo_Venda(Cod_Tipo_Venda) 
    );
  
insert into Venda values ('1','Ana Maria da Cruz','v3',1500,1);
insert into Venda values ('2','Amelia da Paz','v3',1500,1);
insert into Venda values ('3','Americo Antonio','v3',2500,2);
insert into Venda values ('4', 'Bianca Souza','v4',5500,2);
insert into Venda values ('5', 'Maria de Sousa','v4',7500,1);
insert into Venda values ('6', 'Elizabeth Mangaduba','v5',3500,2);
insert into Venda values ('7', 'Catarina do Branco','v4',2500,2);
insert into Venda values ('8', 'Amalia Suzete da Costa','v5',2500,2);

----- Listar o Cód. Vendedor, nome do vendedor da tabela do vendedor  e cargo da tabela de cargo

select cod_Vendedor,vendedor.nome,vendedor.cod_cargo,cargo.nome 
from Vendedor inner join Cargo
on Vendedor.Cod_Cargo = Cargo.Cod_Cargo; 

----- Listar todos os campos da tabela de Vendedor e todos os campos da tabela de cargo
 
select Vendedor.*,Cargo.*  from vendedor join cargo on Vendedor.Cod_Cargo = Cargo.Cod_Cargo; 

---- Listar o Código , Nome ,Valor da venda  por vendedor  

select Vendedor.cod_Vendedor,Vendedor.Nome, Venda.Vl_Venda  
from Vendedor inner join Venda 
on Vendedor.Cod_Vendedor = Venda.cod_Vendedor ;    

--  Listar as vendas e o nome dos vendedores

select Venda.* ,Vendedor.Nome 
from Venda inner join Vendedor 
on Venda.cod_Vendedor = Vendedor.Cod_Vendedor; 

-- Listar o Código do Vendedor, Quantidade Vendas e Total de Vendas por Vendedor

select vendedor.Cod_Vendedor ,COUNT(*) as 'Qtde Vendas',SUM(VL_VENDA) as 'Total de Vendas'
FROM Venda INNER JOIN Vendedor 
on Venda.cod_Vendedor = Vendedor.Cod_Vendedor 
 GROUP BY vendedor.Cod_Vendedor; 
 
-- Listar o Código, Nome, Qtdade de Vendas e Total das Vendas por vendedor 
 
select Vendedor.Cod_Vendedor, Vendedor.nome ,COUNT(*) as 'Qtde Vendas' ,SUM(VL_VENDA) as 'Total de Vendas'
FROM Venda INNER JOIN Vendedor 
on Venda.cod_Vendedor = Vendedor.Cod_Vendedor 
GROUP BY Vendedor.Cod_Vendedor,Vendedor.nome;
 


-- Usando três tabelas ----

-- Listar Todos os Dados do Vendedor,Cargo do Vendedor e  Venda

select Vendedor.*, Cargo.* ,Venda.* 
from Vendedor inner join Venda 
on Vendedor.Cod_vendedor = venda.Cod_vendedor 
inner join Cargo 
on Vendedor.Cod_Cargo = Cargo.Cod_Cargo;



-- Listar o Código, Nome do Vendedor,Valor da venda e o tipo de Venda

select Vendedor.cod_Vendedor,Vendedor.Nome, Venda.Vl_Venda,Tipo_Venda.Tipo_Venda   
from Vendedor inner join Venda 
on Vendedor.Cod_Vendedor = Venda.cod_Vendedor   
Inner join Tipo_Venda 
 on Venda.Cod_Tipo_Venda = Tipo_Venda.Cod_Tipo_Venda;    

-- Listar o Código, Nome do Vendedor, Total da Vendas  por tipo  e o tipo de venda ordenando por vendedor


select Vendedor.cod_Vendedor, Vendedor.Nome, sum(Venda.Vl_Venda), Tipo_Venda.Tipo_Venda   
from Vendedor inner join Venda 
on Vendedor.Cod_Vendedor = Venda.cod_Vendedor   
Inner join Tipo_Venda 
on Venda.Cod_Tipo_Venda = Tipo_Venda.Cod_Tipo_Venda    
Group By  Vendedor.cod_Vendedor,Vendedor.Nome,Tipo_Venda.Tipo_Venda  
order by Vendedor.cod_Vendedor;


--- Listar o Código, Nome do Vendedor, Qtde de Vendas , Total da Vendas  por tipo  e o tipo de venda ordenando por vendedor para as 
---  vendas  'a vista'

select Vendedor.cod_Vendedor, Vendedor.Nome,COUNT(Venda.vl_Venda) as 'Qtde Vendas', sum(Venda.Vl_Venda) as 'Total de Vendas' , Tipo_Venda.Tipo_Venda   
from Vendedor inner join Venda 
on Vendedor.Cod_Vendedor = Venda.cod_Vendedor   
Inner join Tipo_Venda 
on Venda.Cod_Tipo_Venda = Tipo_Venda.Cod_Tipo_Venda    
Group By  Vendedor.cod_Vendedor,Vendedor.Nome,tipo_Venda.Cod_Tipo_Venda, Tipo_Venda.Tipo_Venda  
having Tipo_Venda.cod_Tipo_Venda = '2'
order by sum(venda.vl_Venda) asc; 
