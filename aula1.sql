create database shopping;

use shopping;

create table shopping (
    Codigo_Shopping varchar(3) PRIMARY KEY,
    Nome_Shopping varchar(40) NOT NULL,
    Endereco_Shopping varchar(30) NOT NULL,
    Bairro_Shopping varchar(30),
    Cidade_Shopping varchar(30),
    Uf_Shopping varchar(2),
    Fone_Adminstrativo varchar(13)
);

create table TB_Lojas (
    Codigo_Loja varchar(3) PRIMARY KEY,
    Nome_Loja varchar(30) NOT NULL,
    Codigo_Shopping varchar(3),
    CNPJ_Loja varchar(17) UNIQUE,
    CONSTRAINT FK_CodigoShopping FOREIGN KEY (Codigo_Shopping) references shopping(Codigo_Shopping)
);

create table Tb_Cargo (
    Codigo_Cargo varchar(5) PRIMARY KEY,
    Nome_do_Cargo varchar(5) NOT NULL,
    Comissao_Cargo REAL
);

create table Tb_Funcionarios (
    Codigo_Funcionario varchar(3) PRIMARY KEY,
    Nome_do_Funcionario varchar(40) NOT NULL,
    Sexo char(1) CHECK (Sexo = 'F' OR Sexo = 'M'),
    Data_Nascimento DATE,
    cpf varchar(12) UNIQUE,
    Cod_Cargo varchar(5),
    Cod_loja varchar(3),
    Data_Admissao DATE,
    CONSTRAINT FK_CodCargo FOREIGN KEY (Cod_Cargo) references Tb_Cargo(Codigo_Cargo),
    CONSTRAINT FK_CodLoja FOREIGN KEY (Cod_loja) references TB_Lojas(Codigo_Loja)
);

