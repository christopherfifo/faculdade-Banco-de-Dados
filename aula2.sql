
CREATE DATABASE loja;

USE loja;

CREATE TABLE clientes (
    CodidoDoCliente INT PRIMARY KEY,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    cidade VARCHAR(100),
    país VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(20),
    fax VARCHAR(20)
);

CREATE TABLE pedidos (
    numeroDoPedido INT PRIMARY KEY,
    CodigoDoCliente INT,
    dataDoPedido DATE,
    dataDeEntrega DATE,
    codigoDoVendedor INT,
    dataDeEnvio DATE,
    frete DECIMAL(10, 2),
    nomeDoDestinatario VARCHAR(255),
    enderecoDeEntrega VARCHAR(255),
    cidadeDeEntrega VARCHAR(100),
    cepDeEntrega VARCHAR(20),
    paisDeEntrega VARCHAR(100),
    FOREIGN KEY (CodigoDoCliente) REFERENCES clientes(CodidoDoCliente)
);

CREATE TABLE fornecedores (
    codigoDoFornecedor INT PRIMARY KEY,
    nomeDaEmpresa VARCHAR(255),
    contato VARCHAR(255),
    tituloDoContato VARCHAR(50),
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    UF VARCHAR(2),
    cep VARCHAR(20),
    pais VARCHAR(100),
    telefone VARCHAR(20),
    fax VARCHAR(20)
);

CREATE TABLE categorias (
    codigoDaCategoria INT PRIMARY KEY,
    nomeDaCategoria VARCHAR(255),
    descricaoDaCategoria TEXT,
    figura BLOB
);


CREATE TABLE produtos (
    codigoDoProduto INT PRIMARY KEY,
    nomeDoProduto VARCHAR(255),
    fornecedor INT,
    categoria INT,
    quantidadePorUnidade VARCHAR(50),
    precoPorUnidade DECIMAL(10, 2),
    unidadesEmEstoque INT,
    unidadesEmPedido INT,
    nivelDeEstoque INT,
    descontinuado BOOLEAN,
    FOREIGN KEY (fornecedor) REFERENCES fornecedores(codigoDoFornecedor),
    FOREIGN KEY (categoria) REFERENCES categorias(codigoDaCategoria)
);

CREATE TABLE itensDoPedido (
    numeroDoPedido INT,
    codigoDoProduto INT,
    quantidade INT,
    precoUnitario DECIMAL(10, 2),
    desconto DECIMAL(5, 2),
    PRIMARY KEY (numeroDoPedido, codigoDoProduto),
    FOREIGN KEY (numeroDoPedido) REFERENCES pedidos(numeroDoPedido),
    FOREIGN KEY (codigoDoProduto) REFERENCES produtos(codigoDoProduto)
);



SELECT * FROM clientes;
SELECT * FROM pedidos;
SELECT * FROM itensDoPedido;
SELECT * FROM produtos;
SELECT * FROM fornecedores;
SELECT * FROM categorias;
