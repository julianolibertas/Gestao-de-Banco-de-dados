-- Abra o database public@postgres

create database floricultura;

-- criando um usuário (USER) e definindo sua senha (PASSWORD).
CREATE USER flora WITH PASSWORD '1234';

-- Concedendo todos os privilégios no nível do banco de dados.
-- Isso permite a criação de objetos como schemas, tabelas, etc.
GRANT ALL PRIVILEGES ON DATABASE floricultura TO flora;

--***********************************
-- troque para public@floricultura
--***********************************

-- Concedendo todos os privilégios para o schema público.
-- Isso permite à role criar e manipular objetos dentro do schema.
GRANT ALL ON SCHEMA public TO flora;

-- Concedendo todos os privilégios em todas as tabelas, funções e sequências
-- que já existem no schema público.
GRANT ALL ON ALL TABLES IN SCHEMA public TO flora;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO flora;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO flora;

-- Concedendo privilégios padrão para todos os objetos que serão criados
-- futuramente no schema público.
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO flora;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO flora;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO flora;


-------------------
-- criando as tabelas
-- 1. Tabela de Clientes
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    rg VARCHAR(12) NOT NULL,
    nome VARCHAR(30) NOT NULL,
    sobrenome VARCHAR(40),
    telefone VARCHAR(12),
    rua VARCHAR(40),
    numero VARCHAR(10),
    bairro VARCHAR(25)
);

-- 2. Tabela de Produtos
CREATE TABLE produto (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    tipo VARCHAR(25) NOT NULL, -- flor, vaso, planta
    preco_atual NUMERIC(10,2) NOT NULL,
    qtde_estoque SMALLINT NOT NULL DEFAULT 0
);

-- 3. Tabela de Vendas (O Cabeçalho)
-- Armazena apenas O QUÊ é a transação, sem os itens.
CREATE TABLE venda (
    id_venda SERIAL PRIMARY KEY,
    nota_fiscal INTEGER NOT NULL,
    data_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_cliente INTEGER NOT NULL,
    CONSTRAINT fk_cliente_venda FOREIGN KEY (id_cliente) 
        REFERENCES cliente(id_cliente)
);

-- 4. Tabela de Itens da Venda (O Detalhe)
-- Aqui ficam os produtos. 
CREATE TABLE item_venda (
    id_item SERIAL PRIMARY KEY,
    id_venda INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade SMALLINT NOT NULL CHECK (quantidade > 0),
    preco_unitario_venda NUMERIC(10,2) NOT NULL, -- Grava o preço do dia da venda
    
    CONSTRAINT fk_venda_item FOREIGN KEY (id_venda) 
        REFERENCES venda(id_venda) ON DELETE CASCADE,
        
    CONSTRAINT fk_produto_item FOREIGN KEY (id_produto) 
        REFERENCES produto(id_produto)
);