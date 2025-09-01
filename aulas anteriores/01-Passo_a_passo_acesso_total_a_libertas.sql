-- Conecte com o usuário postgres
-- para criar o banco de dados restaurante
CREATE DATABASE restaurante;
-- ainda com usuário postgres, abra o database restaurante

-- criando um usuário (USER) chamado aluno e define sua senha (PASSWORD).
CREATE USER aluno WITH PASSWORD '1234';

-- criando um role libertas
CREATE ROLE libertas;

-- Adicinonando o user aluno à role libertas
GRANT libertas TO aluno;

-- Concedendo todos os privilégios no nível do banco de dados.
-- Isso permite a criação de objetos como schemas, tabelas, etc.
GRANT ALL PRIVILEGES ON DATABASE restaurante TO libertas;

-- Concedendo todos os privilégios para o schema público.
-- Isso permite à role criar e manipular objetos dentro do schema.
GRANT ALL ON SCHEMA public TO libertas;

-- Concedendo todos os privilégios em todas as tabelas, funções e sequências
-- que já existem no schema público.
GRANT ALL ON ALL TABLES IN SCHEMA public TO libertas;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO libertas;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO libertas;

-- Concedendo privilégios padrão para todos os objetos que serão criados
-- futuramente no schema público.
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO libertas;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO libertas;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO libertas;
