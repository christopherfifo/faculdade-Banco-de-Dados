                                Views
                               
/*                                
As views nada mais são do que instruções SELECT já pré-definidas
e armazenadas no banco, também chamada de select virtuais 

Este conceito pode parecer simples, mas pode-se resolver muitos problemas 
com as views.

Para criar uma view, utilizamos o comando CREATE VIEW. 

Sua sintaxe:
       
        CREATE VIEW <view_name> AS
                 <instrução_SELECT>
                 
 */                
    -- Exemplo:
    
  drop database bd_views;
  
  create database bd_views;
      
	  use bd_views;
 
 drop table funcionarios;
  
      create table funcionarios
      (
        cod_func   int auto_increment,
        nome       varchar(60) not null,
		sexo       char(1) not null,
		CPF        char(11) not null,
		Salario    decimal(10,2),
		email      varchar(40) null,
		depto      varchar(2),
		primary key(cod_func)
    );
        
   insert into funcionarios (nome,sexo,cpf,salario,email,depto) values ('Bianca Lima','F','01189732511',5534.99,'bianca2007@hotmail.com','01');        
   insert into funcionarios (nome,sexo,cpf,salario,email,depto) values ('Branca Malta','F','01189732511',6784.99,'branca.malta@hotmail.com','01');        
   insert into funcionarios (nome,sexo,cpf,salario,email,depto) values ('Ana Lucia Silva','F','01189732511',12234.99,'ana2008@hotmail.com','02');        
   insert into funcionarios (nome,sexo,cpf,salario,email,depto) values ('Maria da Paz','F','01189732511',2234.99,'paz.maria07@hotmail.com','02');        

   select * from funcionarios;

   CREATE VIEW V_TAB1
   AS
   SELECT COD_func, NOME FROM funcionarios;

/*
     No exemplo acima, criamos uma view que somente retorna dois campos da tabela base (no caso a
      TABELA1) COD_func e NOME.

*/

-- Detalhe: no exemplo acima só poderíamos utilizar os dois campos da view, COD_func e NOME.
 
-- Mesmo que a tabela base (TABELA1) possua mais campos não poderíamos 
-- nos referir a eles, pois eles não constam na definição da view.

  
SELECT Nome FROM V_TAB1 WHERE cod_func = 1;
        
select * from v_tab1;
        

-- 2)  É importante também lembrar que todos os campos (calculados ou não) referenciados na view devem possuir um nome, 
--    que deve ser único na definição da view.

drop view vw_tab21;

create view vw_tab21
as
select depto,sum(salario) as Soma,avg(salario) as media 
from funcionarios where depto = '01'; 

select  depto, soma,media from  vw_tab21;

  
  SELECT cod_func, nome, email,  salario
  FROM funcionarios ORDER BY cod_func;


-- Para excluir um views utilizamos a instrução

drop view Nome_view;

--  Podemos usar a instrução LIMIT para limitar a quantidade de 
--  registros a serem visualizados.

Create View V_TAb3
as
SELECT  cod_func, nome, email,  salario
FROM funcionarios ORDER BY NOME;

drop view v_tab3;

select * from v_tab3;

drop view v_tab4;
    

CREATE VIEW V_TAB4
AS
SELECT  COD_func , NOME   FROM funcionarios  ORDER BY NOME;

select * from v_tab4;

CREATE VIEW V_TAB41
AS
SELECT  COD_func , NOME   FROM funcionarios  ORDER BY NOME desc,salario ;

select * from v_tab41;

select * from V_TAB4 LIMIT 2;

--- outro exemplo

DROP VIEW VW_func_OFFSET;

CREATE VIEW VW_func_OFFSET
AS
SELECT cod_func,nome,salario FROM funcionarios
ORDER BY cod_func
limit 3;
SELECT * FROM VW_func_OFFSET




 -- Pode-se  incluir dados em uma View 

drop view v_tab42;

 Create View V_Tab42
 as
 Select nome,sexo,CPF, Salario from funcionarios;
 
insert into V_Tab42 values ('Belinha de Melo','F','01345732532',15000.00);         

SELECT * FROM Funcionarios;
SELECT * FROM V_TAB4;

--  Isso nos possibilita fazer uma inserção em um view . 
-- Como é só uma view, podemos fazer uma instrução INSERT na view 
-- que colocará valores somente em alguns campos da tabela. 
-- Quando utilizarem essa prática, tomem cuidado com campos calculados 
-- e expressões de agregação feitos na definição da view, pois uma  View
-- criada com funções agregadas, por exemplo, não poderá receber atualizações,
-- pois os dados logicamente estão agregados ou agrupados e não teremos
-- correspondências diretas para uma exclusão ou atualização.


-- mais exemplos


Create Table Tab_Fone
(
 Cod_func  int,
 Telefone char(10) not null,
 Tipo     char
); 

insert into tab_fone values (1,'36458798','R');
insert into tab_fone values (1,'87458798','C');
insert into tab_fone values (2,'41458767','R');
insert into tab_fone values (2,'98456568','C');


-- Exemplo 1 - Crie uma View chamada V_CliSemFone que mostra os dados dos clientes que não tem telefone.

drop view v_clisemfone;

CREATE VIEW V_CliSemFone
AS
SELECT * FROM FUNCIONARIOS
WHERE COD_FUNC NOT IN(SELECT COD_FUNC FROM Tab_Fone) ;
-- -----------------------------------------------------------
select * from funcionarios;
select * from tab_fone;

select funcionarios.cod_func,Nome from Funcionarios 
inner join Tab_Fone on Funcionarios.cod_func = tab_fone.cod_func;

SELECT * FROM V_CliSemFone;


-- -----------------------------------------------------------
-- Desafios
 
 -- 1) Crie uma View chamada V_CliSolteiro que mostre todos
--     os clientes solteiros.

CREATE VIEW V_CliSolteiro
AS
SELECT * FROM CLIENTE
WHERE COD_CLI NOT IN(SELECT COD_CLI FROM CONJUGE);
-- -----------------------------------------------------------
SELECT * FROM V_CliSolteiro;
-- -----------------------------------------------------------

-- 2 Crie uma View chamada V_CliPedFunc que mostra o Codigo e nome 
--   dos cliente, o codigo e nome dos funcionários, o numero, a data 
--   e o valor todal dos pedidos.

CREATE VIEW V_CliPedFunc
AS
SELECT CLIENTE.COD_CLI,CLIENTE.NOME_CLI,
FUNCIONARIO.COD_FUNC,FUNCIONARIO.NOME_FUNC,
PEDIDO.NUM_PED,DATA_PED,VAL_PED
FROM FUNCIONARIO
INNER JOIN PEDIDO ON FUNCIONARIO.COD_FUNC = PEDIDO.COD_FUNC
INNER JOIN CLIENTE ON CLIENTE.COD_CLI = PEDIDO.COD_CLI
INNER JOIN ITENS ON ITENS.NUM_PED = PEDIDO.NUM_PED
INNER JOIN PRODUTO ON PRODUTO.COD_PROD = ITENS.COD_PROD;
-- -----------------------------------------------------------

SELECT * FROM V_CliPedFunc;
-- -----------------------------------------------------------
