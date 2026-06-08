CREATE DATABASE SupermercadoDB;

USE SupermercadoDB;

CREATE TABLE Categorias (
   id_categoria INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Fornecedores (
   id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   contato VARCHAR(100),
   endereco VARCHAR(200)
);

CREATE TABLE Filiais (
   id_filial INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   endereco VARCHAR(200) NOT NULL
);

CREATE TABLE Produtos (
   id_produto INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   descricao TEXT,
   preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
   quantidade_estoque INT NOT NULL CHECK (quantidade_estoque >= 0),
   id_categoria INT NOT NULL,
   id_fornecedor INT NOT NULL,
   id_filial INT NOT NULL,
   FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
   FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor),
   FOREIGN KEY (id_filial) REFERENCES Filiais(id_filial)
);

CREATE TABLE Funcionarios (
   id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   cargo VARCHAR(50) NOT NULL,
   salario DECIMAL(10,2) NOT NULL CHECK (salario >= 0),
   data_contratacao DATE NOT NULL,
   id_filial INT NOT NULL,
   FOREIGN KEY (id_filial) REFERENCES Filiais(id_filial)
);

CREATE TABLE Clientes (
   id_cliente INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   telefone CHAR(11) UNIQUE,
   endereco VARCHAR(200),
   pontos_fidelidade INT DEFAULT 0 CHECK (pontos_fidelidade >= 0)
);

CREATE TABLE Compras (
   id_compra INT PRIMARY KEY AUTO_INCREMENT,
   data DATE NOT NULL,
   total DECIMAL(10,2) NOT NULL CHECK (total >= 0),
   id_fornecedor INT NOT NULL,
   id_filial INT NOT NULL,
   FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor),
   FOREIGN KEY (id_filial) REFERENCES Filiais(id_filial)
);

CREATE TABLE ItensCompra (
   id_item_compra INT PRIMARY KEY AUTO_INCREMENT,
   id_compra INT NOT NULL,
   id_produto INT NOT NULL,
   quantidade INT NOT NULL CHECK (quantidade > 0),
   subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
   FOREIGN KEY (id_compra) REFERENCES Compras(id_compra),
   FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

CREATE TABLE Vendas (
   id_venda INT PRIMARY KEY AUTO_INCREMENT,
   data DATE NOT NULL,
   total DECIMAL(10,2) NOT NULL CHECK (total >= 0),
   id_cliente INT,
   id_funcionario INT NOT NULL,
   id_filial INT NOT NULL,
   FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
   FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario),
   FOREIGN KEY (id_filial) REFERENCES Filiais(id_filial)
);

CREATE TABLE ItensVenda (
   id_item_venda INT PRIMARY KEY AUTO_INCREMENT,
   id_venda INT NOT NULL,
   id_produto INT NOT NULL,
   quantidade INT NOT NULL CHECK (quantidade > 0),
   subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
   FOREIGN KEY (id_venda) REFERENCES Vendas(id_venda),
   FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

CREATE INDEX idx_produto_nome ON Produtos(nome);

CREATE INDEX idx_venda_data ON Vendas(data);

INSERT INTO Categorias (nome) VALUES
('Bebidas'),
('Higiene'),
('Alimentos'),
('Limpeza'),
('Eletrônicos');

INSERT INTO Fornecedores (nome, contato, endereco) VALUES
('Coca-Cola Brasil', 'coca@coca.com', 'Av. Paulista, 1000 - SP'),
('Nestlé', 'contato@nestle.com', 'Rua das Indústrias, 200 - SP'),
('Unilever', 'suporte@unilever.com', 'Av. Central, 1500 - RJ'),
('LG Electronics', 'lg@lg.com', 'Rua Tech, 300 - SP');

INSERT INTO Filiais (nome, endereco) VALUES
('Filial Centro', 'Rua Principal, 123 - Centro - SP'),
('Filial Zona Sul', 'Av. Sul, 500 - SP');

INSERT INTO Produtos
(nome, descricao, preco, quantidade_estoque,
id_categoria, id_fornecedor, id_filial)
VALUES
('Coca-Cola Lata 350ml', 'Refrigerante em lata', 4.50, 200, 1, 1, 1),
('Nescau 400g', 'Achocolatado em pó', 7.99, 100, 3, 2, 1),
('Sabonete Dove', 'Sabonete hidratante', 3.20, 150, 2, 3, 2),
('Detergente Ypê 500ml', 'Detergente neutro', 2.50, 300, 4, 3, 1),
('TV LG 42"', 'Smart TV LED Full HD', 1800.00, 10, 5, 4, 2);

INSERT INTO Funcionarios
(nome, cargo, salario, data_contratacao, id_filial)
VALUES
('Carlos Silva', 'Caixa', 2000.00, '2022-01-15', 1),
('Ana Souza', 'Vendedora', 2200.00, '2021-05-10', 1),
('Marcos Lima', 'Gerente', 4500.00, '2020-03-01', 2);

INSERT INTO Clientes
(nome, telefone, endereco, pontos_fidelidade)
VALUES
('João Pedro', '11999999999', 'Rua das Flores, 45 - SP', 150),
('Maria Clara', '11888888888', 'Av. Paulista, 900 - SP', 300),
('Lucas Santos', '11777777777', 'Rua Verde, 12 - SP', 50);

INSERT INTO Compras
(data, total, id_fornecedor, id_filial)
VALUES
('2023-10-01', 900.00, 1, 1),
('2023-10-05', 500.00, 2, 1),
('2023-10-10', 200.00, 3, 2);

INSERT INTO ItensCompra
(id_compra, id_produto, quantidade, subtotal)
VALUES
(1, 1, 200, 900.00),
(2, 2, 100, 500.00),
(3, 3, 100, 320.00);

INSERT INTO Vendas
(data, total, id_cliente, id_funcionario, id_filial)
VALUES
('2023-11-01', 45.00, 1, 1, 1),
('2023-11-02', 1800.00, 2, 2, 2),
('2023-11-03', 6.40, 3, 1, 1);

INSERT INTO ItensVenda
(id_venda, id_produto, quantidade, subtotal)
VALUES
(1, 1, 10, 45.00),
(2, 5, 1, 1800.00),
(3, 3, 2, 6.40);

-- === Consultas com SELECT ===
SELECT * FROM Produtos;

SELECT nome, preco FROM Produtos;

SELECT nome, quantidade_estoque
FROM Produtos
WHERE quantidade_estoque < 50;

SELECT nome, pontos_fidelidade
FROM Clientes
WHERE pontos_fidelidade > 100;

SELECT nome, cargo, salario
FROM Funcionarios
ORDER BY salario DESC;

SELECT *
FROM Produtos
WHERE id_categoria = 5;

SELECT *
FROM Vendas
WHERE total > 100;

SELECT *
FROM Produtos
WHERE nome LIKE '%LG%';

SELECT *
FROM Clientes
ORDER BY nome;

SELECT nome, preco
FROM Produtos
WHERE preco BETWEEN 5 AND 100;

-- === Consultas com JOIN ===
SELECT Produtos.nome, Categorias.nome
FROM Produtos
JOIN Categorias
ON Produtos.id_categoria = Categorias.id_categoria;

SELECT Produtos.nome, Fornecedores.nome
FROM Produtos
JOIN Fornecedores
ON Produtos.id_fornecedor = Fornecedores.id_fornecedor;

SELECT Vendas.id_venda, Clientes.nome
FROM Vendas
JOIN Clientes
ON Vendas.id_cliente = Clientes.id_cliente;

SELECT Vendas.id_venda, Funcionarios.nome
FROM Vendas
JOIN Funcionarios
ON Vendas.id_funcionario = Funcionarios.id_funcionario;

SELECT Produtos.nome, Filiais.nome
FROM Produtos
JOIN Filiais
ON Produtos.id_filial = Filiais.id_filial;

SELECT ItensVenda.quantidade, Produtos.nome
FROM ItensVenda
JOIN Produtos
ON ItensVenda.id_produto = Produtos.id_produto;

SELECT Compras.id_compra, Fornecedores.nome
FROM Compras
JOIN Fornecedores
ON Compras.id_fornecedor = Fornecedores.id_fornecedor;

SELECT Funcionarios.nome, Filiais.nome
FROM Funcionarios
JOIN Filiais
ON Funcionarios.id_filial = Filiais.id_filial;

SELECT Clientes.nome, Vendas.total
FROM Clientes
JOIN Vendas
ON Clientes.id_cliente = Vendas.id_cliente;

SELECT Vendas.id_venda, Produtos.nome
FROM ItensVenda
JOIN Produtos
ON ItensVenda.id_produto = Produtos.id_produto
JOIN Vendas
ON ItensVenda.id_venda = Vendas.id_venda;

-- === Consultas com GROUP BY ===

SELECT id_categoria, COUNT(*)
FROM Produtos
GROUP BY id_categoria;

SELECT id_cliente, SUM(total)
FROM Vendas
GROUP BY id_cliente;

SELECT cargo, AVG(salario)
FROM Funcionarios
GROUP BY cargo;

SELECT id_filial, COUNT(*)
FROM Funcionarios
GROUP BY id_filial;

SELECT id_filial, SUM(total)
FROM Vendas
GROUP BY id_filial;

SELECT id_fornecedor, COUNT(*)
FROM Produtos
GROUP BY id_fornecedor;

SELECT id_fornecedor, SUM(total)
FROM Compras
GROUP BY id_fornecedor;

SELECT id_categoria, AVG(preco)
FROM Produtos
GROUP BY id_categoria;

SELECT nome, SUM(pontos_fidelidade)
FROM Clientes
GROUP BY nome;

SELECT id_produto, SUM(quantidade)
FROM ItensVenda
GROUP BY id_produto;

-- Funções de Agregação
SELECT COUNT(*) FROM Produtos;

SELECT SUM(quantidade_estoque)
FROM Produtos;

SELECT AVG(preco)
FROM Produtos;

SELECT MAX(preco)
FROM Produtos;

SELECT MIN(preco)
FROM Produtos;

SELECT COUNT(*)
FROM Vendas;

SELECT SUM(total)
FROM Vendas;

SELECT AVG(salario)
FROM Funcionarios;

SELECT MAX(salario)
FROM Funcionarios;

SELECT MIN(salario)
FROM Funcionarios;

-- Subqueries (Subconsultas)
SELECT *
FROM Produtos
WHERE preco = (
   SELECT MAX(preco)
   FROM Produtos
);

SELECT *
FROM Produtos
WHERE preco = (
   SELECT MIN(preco)
   FROM Produtos
);

SELECT *
FROM Clientes
WHERE pontos_fidelidade > (
   SELECT AVG(pontos_fidelidade)
   FROM Clientes
);

SELECT *
FROM Funcionarios
WHERE salario = (
   SELECT MAX(salario)
   FROM Funcionarios
);

SELECT *
FROM Produtos
WHERE quantidade_estoque < (
   SELECT AVG(quantidade_estoque)
   FROM Produtos
);

SELECT nome
FROM Clientes
WHERE id_cliente IN (
   SELECT id_cliente
   FROM Vendas
);

SELECT nome
FROM Produtos
WHERE id_produto IN (
   SELECT id_produto
   FROM ItensVenda
);

SELECT nome
FROM Produtos
WHERE id_produto NOT IN (
   SELECT id_produto
   FROM ItensVenda
);

SELECT *
FROM Filiais
WHERE id_filial = (
   SELECT id_filial
   FROM Vendas
   GROUP BY id_filial
   ORDER BY SUM(total) DESC
   LIMIT 1
);

SELECT nome, preco
FROM Produtos
WHERE preco > (
   SELECT AVG(preco)
   FROM Produtos
);

