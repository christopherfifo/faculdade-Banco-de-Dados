       -- Comandos Seleção (Select)  BETWEEN - IN  - LIKE - AGRUPAMENTO
/*

Condições de pesquisa

Como vimos, a cláusula WHERE permite selecionar quais as linhas da tabela a serem
incluídas  no resultado.
Existem várias formas de montar uma cláusula WHERE, usando um dos seguintes elementos:

Operadores de comparação 	

=	igual a 
>	maior que 
<	menor que 
>= ou !<	maior ou igual (não menor) 
<= ou !>	menor ou igual (não maior) 
<> ou != 	diferente 


--Usando faixas   -- BETWEEN

Onde BETWEEN...AND... seleciona os registros cujos valores estão dentro de uma determinada faixa.
                      Para fazer o contrário, bastaria usar NOT BETWEEN 
-- (mas nesse caso a consulta não  é tão eficiente).


*/

-- Para buscarmos os preços dos produtos que custam 
-- entre 10 e 30 reais, poderíamos fazer o seguinte:

select valor_PRODUTO FROM PRODUTOS;

Select * from Produtos where preco >= 10 and preco <= 30;

-- OU

Select * from Produto where preco between 10 and 30;

-- -----------------------------------------------------------------------------------------

/*
Obs.: Os Extremos são inclusos na condição.


Usando listas -- IN (LISTA)


 Você pode selecionar valores de acordo com uma lista.
 Se o valor pertence à lista, a linha será incluída no resultado.

 Suponha que você precise selecionar as empresas que tenham código 1,3,4,5,6 e 9. 
 
 (Repare: isto não quer dizer que as empresas estão cadastradas, mas se elas estiverem, 
  elas serão inclusas no resultado final.)

select * from Empresa where codempresa in (1,3,4,5,6,9); 

  Esta consulta seria o equivalente a fazer:
   select * from Empresa where codempresa = 1 or codempresa=3 or codempresa = 4 or codempresa=5 or  
    codempresa=6 or codempresa=9

 Ou ainda:
 
    where (codempresa between 1 and 6) AND NOT (codempresa=2) OR codempresa = 9

  Nota :
 1)  Uma consulta SQL pode ser realizada de várias formas, basta observar que umas são mais eficientes 
     que as outras.

 2)   Para retornar os valores que não estão na lista, pode-se usar NOT IN.

-- Exemplo: IN 

SELECT * FROM FUNCIONARIOS WHERE COD_DEPTO = 2 OR COD_DEPTO = 3;

SELECT * FROM FUNCIONARIOS WHERE COD_DEPTO IN (2,3);

PADRÃO   LIKE
O operador LIKE [como] faz casamento de padrões. Um padrão é uma string contendo
caracteres que podem ser combinados com parte de outra string.
 
 OS CARACTERES:
    %  (PERCENTAGEM) : Representar qualquer quantidade de caracteres a partir do caraceter %. 
    _  (SUBLINHADO)  : Combinar com um único caractere na posição do _. 
   
   Obs.: O caractere ^ (not)  --> indica não).

 Exemplos:
 para obter todas as pessoas que tenham nome começando com 'Maria', podemos fazer:
*/

select * from pessoas where nome like 'Maria%';

 -- Para pegar todas as pessoas que tenham o nome 'Silva' no final, basta fazer:

select * from Pessoa where nome like '%Silva';

-- Note: que se você não colocar o espaço antes
-- do 'Silva', você trará resultados que não condizem 
-- com a consulta:
 
-- Por exemplo, se nos seus dados existem pessoas com nome 'Sousa' ou 'Souza', você pode usar: 
--   LIKE '%sou_a%'.
   
 -- Nota :
 --  Pessoas cadastradas com 'Soula', ou 
 -- qualquer outra letra no lugar do "_".
 
/*
  Exemplo:
  
  A instrução reconhece a busca com acento ou sem acento
  
  exemplo, LIKE 'camara' vai encontrar também 'Câmara'.
*/


-- Área Teste
  
DROP DATABASE TESTE1;
  
create database teste1;
  
use teste1;

-- Criar a tabela 

 Create Table Departamentos
 (
   Cod_Depto    int,
   Departamento char(25),
   Primary key (cod_Depto)
  );                 
        


insert into Departamentos values (1,'Relações Humanas');               
insert into Departamentos values (2,'Departamento Pessoal');               
insert into Departamentos values (3,'Informática');               
insert into Departamentos values (4,'Diretoria');               

Create table Funcionarios
(
 Cod_Matricula   Varchar(10),
 Nome_funcionario Varchar(35),
 Cod_Depto        Int,
 Salario          decimal(12,2),
 primary key (cod_matricula),
 Constraint FK_Depto  foreign key(cod_depto) references departamentos(cod_depto)
 );
 
 
 show tables;
 
 
insert into Funcionarios values ('902001','Felipe Lima',1,7700.00);
insert into Funcionarios values ('902002','Matheus Duarte Oliveira',1,7000.00);
insert into Funcionarios values ('902003','Margarida das Rosas Ono',1,7500.00);
insert into Funcionarios values ('902004','Graziella Anjos Oliveira',1,5000.00);
insert into Funcionarios values ('902005','Rogerio Farias Batiston',1,5500.00);
insert into Funcionarios values ('902006','Guilherme Miranda Campos',1,6500.00);
insert into Funcionarios values ('902007','Rodrigo Genery Pires',1,15000.00);
insert into Funcionarios values ('902008','Marcelo Marins Loopes',1,10000.00);
insert into Funcionarios values ('902009','Douglas Souto Lima',1,15000.00);
                        

insert into Funcionarios values ('90101','Andressa Duarte Reis',2,5700.00);
insert into Funcionarios values ('90102','Maria Alino Baluina da Costa',2,7000.00);
insert into Funcionarios values ('90103','Leonardo Gonçalves Araujo',2,7500.00);
insert into Funcionarios values ('90104','Estafane Salgado Pena',2,600.00);
insert into Funcionarios values ('90105','Ana Ribeiro Freitas',2,3000.00);
insert into Funcionarios values ('90106','Camila Mariano',2,3000.00);


insert into Funcionarios values ('90010','Alexandre Mello Junior',3,3500.00);
insert into Funcionarios values ('90020','Camila Lima da Costa',3,10500.00);
insert into Funcionarios values ('90030','Beth Carvalho',3,7500.00);
insert into Funcionarios values ('90040','Lucas Silva Ferreira',3,8500.00);
insert into Funcionarios values ('90050','Bela Izza Lopes da Cruz',3,2500.00);
insert into Funcionarios values ('90060','Clarice Sousa Mello ',3,3500.00);

            
insert into Funcionarios values ('90001','Marcio Santos',4,35700.00);
insert into Funcionarios values ('90002','Amanda de Souza Gagalhardi',4,37000.00);
insert into Funcionarios values ('90003','Bruno Santiago',4,17500.00);
insert into Funcionarios values ('90004','Ana Paula França',4,5000.00);
insert into Funcionarios values ('90005','Lorena Regina Paula da Silva',4,5000.00);
insert into Funcionarios values ('90006','Margarida Branca de Souza',4,5000.00);

select cod_matricula as 'codigo', nome_funcionario as 'nome', salario, Salario * 1.10 
as  'aumento' from funcionarios where salario > 9000 and Cod_Depto = '4';

select * from funcionarios;

 
 -- Teste Between
 

-- use teste1

select * from Funcionarios where Salario >= 30000 and Salario <= 60000;

select * from Funcionarios where Salario between  30000 and  60000;

 
 -- Selecionar todos os dados dos funcionarios com salario de R$ 6000,00 até R$ 15000.00
 
 SELECT * FROM FUNCIONARIOS WHERE SALARIO >=6000 AND SALARIO <=15000 
 order by Salario asc; 
 
 select * from Funcionarios where salario between 6000 and 15000
 order by Salario ASC;
 
 -- Selecionar todos os dados dos funcionarios com salario de R$ 15000,00 até R$ 50000.00
 
 select * from Funcionarios where salario between 15000 and 50000; 
  
  -- teste In
  
  -- Selecionar os cod_matricula e nome e codigo do depto dos   funcionarios do depto 1, 2, e 4
  
   select cod_matricula, nome_funcionario, cod_depto from Funcionarios 
   where Cod_Depto  = 1 or cod_depto = 2 or cod_depto = 4 
   order by cod_depto;
  
  select cod_matricula, nome_funcionario, cod_depto from Funcionarios 
  where Cod_Depto in(1,2,4) order by cod_depto;   
 
  -- Selecionar os cod_matricula ,nome, codigo do depto e salario dos   funcionarios 
 --  do depto 1 e 4 com salario maior que R$ 7000.00
 
 select cod_matricula, nome_funcionario, cod_depto,Salario 
 from Funcionarios where Cod_Depto in(1,4) and Salario > 7000
 order by Cod_Depto; 
 
 -- selecionar nome dos funcionarios com salario entre R$ 1500.00 e R$ 4000.00 do Depto 2 e 3 
  
  select  nome_funcionario,Cod_Depto,salario from Funcionarios
  where (salario between 1500 and 4000) and (Cod_Depto in(2,3));
  
  -- teste like
  
   -- Selecionar todos os dados dos funcionarios que começam com o 'A'
   
   select  * from Funcionarios where nome_funcionario like 'A%';
   select  * from Funcionarios where nome_funcionario like '%A';

   -- Selecionar os funcionários que tenham '
   
   select * from Funcionarios where Nome_funcionario like '%Sou_a%';

   -- Selecionar todos os dados dos funcionarios que começam com o 'An'
   
   select  * from Funcionarios where nome_funcionario like 'An%';
  
  -- Selecionar todos os dados dos funcionarios que terminam com o 'A'
   
   select  * from Funcionarios where nome_funcionario like '%a';
  
  -- Selecionar os funcionarios que terminam com o 'S'
  
    select  * from Funcionarios where nome_funcionario like '%s';
    
  -- Selecionar os funcionarios que tenha  'S' em qualquer posição do nome
  
    select  * from Funcionarios where nome_funcionario like '%s%';
    
  -- Selecionar os funcionarios que tenha  'S' em qualquer posição do nome e iniciam com  'A'
  
    select  * from Funcionarios where nome_funcionario like 'A%s%';

-- Selecionar o nome, salario, salario com acréscimo de 15% e o depto dos funcionarios 

--    cujo nome comaçam com 'Mar' do depto  1 e 4  e salario maior ou 
-- igual a R$ 750.00 e menor ou igual R$ 15000.00 

 select nome_funcionario,salario, cod_depto from funcionarios 
 where nome_funcionario like 'mar%' and cod_depto in(1,4) and 
 salario between 750.00 and 15000.00 order by cod_depto desc;

--                cláusulas GROUP BY e HAVING:

-- A cláusula GROUP BY agrupa linhas(registros) baseado em semelhanças entre elas

/*
COUNT(expr) Conta quantos valores existem da expressão dada dentro do grupo 
 (se expr for NULL para uma linha, a linha não é incluída na contagem). 
COUNT(*) 	Conta quantas linhas existem dentro do grupo. 
MAX(expr) 	Retorna o máximo valor de expr dentro do grupo. 
MIN(expr) 	Retorna o mínimo valor de expr dentro do grupo. 
SUM(expr) 	Retorna o somatório da expressão dentro do grupo. 
AVG(EXPR)   Retorna a Média Aritmética da expressão dentro do grupo
*/
select count(*) as 'qtde' from funcionarios;
/*
 As funções AVG e SUM podem ser usadas apenas com dados numéricos.
 As outras podem ser usadas com qualquer tipo de coluna.
 As funções SUM, AVG e COUNT(expr) permitem  especificar também o operador DISTINCT, 
 que indica para considerar apenas os valores distintos.
*/

-- Sintaxe
/*
SELECT lista_de_colunas FROM lista_de_tabelas WHERE condições
GROUP BY lista_de_expressões HAVING condição

Condições 
A cláusula WHERE (se presente) separa as linhas que satisfazem 
as condições iniciais.
A cláusula GROUP BY organiza as linhas de resultado em grupos de
acordo com os valores das expressões informadas. 
A cláusula HAVING (opcional) seleciona os grupos de acordo
com os resultados.

O resultado do SELECT...GROUP BY... tem uma linha para cada grupo, 
que pode conter valores de resumo (somatório, média, contagem etc.) 
calculados dentro do grupo.

Quando o GROUP BY está presente, é possível usar funções agregadas, 
que calculam valores baseado nas linhas de um grupo e geram valores 
de resumo.

Funções agregadas
Além da função COUNT, existem outras funções agregadas que podem 
ser usadas para fazer operações sobre os elementos do grupo:
AVG (expr) 	Calcula o valor médio da expressão expr dentro do grupo. 
A expressão pode ser um nome de coluna ou calculada a partir de 
colunas e/ou constantes.

    (Por exemplo, AVG (salario*1.1)
*/
 
-- Exemplos:
-- Para saber o número de pessoas que existem na tabela Pessoa, 
--   podemos fazer:
  
  Select count(*) from Pessoas;

-- Agora para sabermos o número de pessoas que cadastraram um telefone de fax, podemos fazer:
Select count(FAX) from Pessoas;

-- Ou seja, count(*) retorna todas as linhas, e count(fax) 
-- retorna somente as linhas não-nulas da coluna fax.

-- Para sabermos qual a média de preços dos produtos, podemos fazer:

Select avg(Preco) as "Média de Preços" from Produto;

-- Para sabermos qual é o produto mais caro e o produto mais barato,
-- podemos fazer:

Select Max(Preco) as "Mais Caro",Min(Preco) as "Mais Barato" from Produto;

-- Para sabermos qual a quantidade total de produtos em estoque,
-- podemos fazer:

Select SUM(QuantDisponivel) as "Total de Produtos" from Produto;

/*
   Detalhes do GROUP BY

   A cláusula GROUP BY agrupa valores baseado em uma ou mais colunas. 
   Geralmente quando usamos a GROUP BY, devemos utilizar uma das funções
   de agregação mostradas anteriormente.
 
   As colunas de resultado da cláusula SELECT (a lista de colunas após 
    o SELECT) podem ser apenas:
	Uma coluna presente na lista do GROUP BY OU
   Um valor gerado por uma função agregada
   Outras colunas não podem ser incluídas no resultado, porque teriam 
   valores diferentes para cada linha do  grupo.
*/

 -- Exemplos:
  -- Para sabermos quantas pessoas existem em cada categoria, 
  -- podemos fazer:

 Select codcategoria, count(*) as "Total de Pessoas" 
 from  RelPessoaCategoria   group by CodCategoria;


 -- Para sabermos quantas movimentações foram feitas para cada produto, 
 -- podemos fazer:
Select CodProduto, Count(*) as "Total"  
from MovimentacaoProduto Where TIPOMOV='S' 
group by Codproduto;

-- Para sabermos qual o última vez que cada produto foi vendido, podemos fazer:

Select CodProduto, max(datamov) from MovimentacaoProduto 
where TIPOMOV='S' group by codproduto;

-- Para sabermos a quantidade total comprada por produto, podemos fazer:
Select CodProduto, sum(quantidade) from MovimentacaoProduto where tipomov='S'
Group by CODPRODUTO;

-- Para obtermos a quantidade total vendida por produto no mês de maio de 2010, em ordem
-- crescente por quantidade, podemos fazer:

Select Codproduto, sum(quantidade) from MovimentacaoProduto 
where tipomov='s' and (datamov between '2021/05/01' and '2022/01/10') group by codproduto 
order by sum(quantidade);


-- Usando a cláusula HAVING
-- Após feito o agrupamento, pode-se usar a cláusula HAVING para selecionar quais os 
-- grupos a serem incluídos no resultado.

   -- Exemplo:
-- Para sabermos qual o total de saídas obtidas para cada produto, sendo que desejamos
--  visualizar apenas os totais de saídas maiores que 50 unidades, podemos fazer:
 
 Select CodProduto, sum(quantidade)
 from MovimentacaoProduto where tipomov='S'
 Group by CODPRODUTO having sum(quantidade)>50;

-- Note:
 -- 1)  As cláusulas WHERE e HAVING são semelhantes, mas WHERE seleciona as linhas da
 --   tabela que irão 
 --     participar da geração do resultado.
 --  Essas linhas serão agrupadas e depois HAVING é aplicado ao resultado de cada grupo, 
 --   para saber quais grupos vão aparecer no resultado.
 --  2)  Nas condições usadas por HAVING só podem aparecer valores que sejam os mesmos
 --      em todos os elementos do grupo.

-- TESTE DE AGRUPAMENTO

-- Selecionar a quantidade de funcionários da empresa

SELECT * FROM Funcionarios; 
 
select COUNT(*) as 'Qtde Funcionários' from 
funcionarios;
   
 select COUNT(Cod_matricula) from funcionarios;

-- Selecionar a quantidade de funcionários da empresa com salario  maior que R$ 5000.00
   
   select COUNT(*) as 'Qtde Funcionarios' from 
   funcionarios having Salario > 5000.00;
   
select COUNT(*) as 'Qtde Funcionarios' from 
funcionarios where Salario > 5000.00;


   -- Selecionar a média de salario da empresa
   
   select avg(salario) as 'Média de Salário' 
   from funcionarios;  
   
   -- Selecionar a média de salario da empresa do depto 4
   
   select avg(salario) as 'Média de Salário'
   from funcionarios where Cod_Depto = 4;
   
   -- Selecionar o maior salário da empresa 
   
   select max(salario) as 'Maior Salário' 
   from funcionarios;

   select nome_funcionario, MAX(salario)
   from  Funcionarios group by nome_funcionario;
   
   select MAX(salario),cod_depto  from  Funcionarios 
   group by cod_depto;
   
   -- Selecionar o menor salário da empresa 
   
   select min(salario) as 'Menor Salário'
   from funcionarios;
   
-- Selecionar o menor salário da empresa do depto 3
   
select min(salario) as 'Menor Salário' 
from funcionarios where cod_depto = 3;

-- Selecionar o maior salário da empresa de cada depto agrupando por depto
   
select max(salario) as 'Maior Salário',cod_depto 
from funcionarios group by cod_depto;
   
select max(salario) as 'Maior Salário',cod_depto 
from funcionarios where cod_depto =2 group by cod_depto;
   
select max(salario) as 'Maior Salário',cod_depto  
from funcionarios group by cod_depto 
having cod_depto = 2;
   
-- Selecionar o total de salarios pago por depto 
   
select sum(salario) as 'Total',cod_depto 
from funcionarios group by cod_depto;
   
-- Selecionar o total de  salarios pago
-- pelo depto 2
                                                                                
select sum(salario) as 'Total' ,cod_depto 
from funcionarios group by cod_depto
having cod_depto = 2;
      
select sum(salario) as 'Total'  from funcionarios 
WHERE cod_depto = 2;
      
select cod_depto, sum(salario) as 'Total' 
from funcionarios group by cod_depto 
having cod_depto = 2;
         
        
select cod_depto, sum(salario) as 'Total'  
from funcionarios WHERE cod_depto = 2;  
         
-- Selecionar a quantde de funcionário , 
-- o maior, o menor e a média de salario da empresa 
         
select count(*) as 'Funcionários' , max(salario) 
as 'Maior', min(salario) as 'Menor',avg(salario) 
as 'Média'  from funcionarios;      
     
-- Selecionar a quantde de funcionário , o maior, o menor e a média de salario da 
-- empresa do depto 1
     
select count(*) as 'Funcionários' , max(salario) as
'Maior', min(salario) as 'Menor' ,avg(salario) as 
'Média' from funcionarios  where Cod_Depto = 1;
     
select count(*) as 'Funcionários' , max(salario) as 
'Maior', min(salario) as 'Menor' ,avg(salario) as
 'Média' from funcionarios  group by cod_depto 
 having Cod_Depto = 1;
     
 select cod_depto, count(*) as 'Funcionários', 
 max(salario) as 'Maior', min(salario) as 'Menor',
 avg(salario) as 'Média' from funcionarios
 group by cod_depto having Cod_Depto = 1;
     
-- Selecionar a quantidade de de funcionário , o maior, o menor e a média de salario
--  da empresa por depto
     
select cod_depto, count(Cod_Matricula)  as 
'Funcionários' , max(salario) as 'Maior', 
min(salario) as 'Menor' ,avg(salario) as 'Média'  
from funcionarios  group by cod_depto;
     
-- obs.: pode-se usar * no cod_matricula     
     
select cod_depto, count(*)  as 'Funcionários', 
max(salario) as 'Maior', min(salario) as 'Menor',
avg(salario) as 'Média' from funcionarios 
group by cod_depto;
     
          
     

 