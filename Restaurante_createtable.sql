DROP TABLE IF EXISTS comissoes;
DROP TABLE IF EXISTS itens_vendas;
DROP TABLE IF EXISTS vendas;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS mesas;


-- tabela para gravar registro das mesas
create table mesas (
	id	serial not null primary key, 
	mesa_codigo	varchar(20),
	mesa_situacao varchar(1) default 'A',
	data_criacao timestamp,
	data_atualizacao timestamp
);

--tabela para gravar registro dos funcionários
create table funcionarios(
	id serial not null primary key,
	funcionario_codigo varchar(20),
	funcionario_nome varchar(100),
	funcionario_situacao varchar(1) default 'A',
	funcionario_comissao real,
	funcionario_cargo varchar(30),
	data_criacao timestamp,
	data_atualizacao timestamp
);

-- tabela para gravar registro dos produtos
create table produtos(
	id serial not null primary key,
	produto_codigo varchar(20),
	produto_nome varchar(60),
	produto_valor real,
	produto_situacao varchar(1) default 'A',
	data_criacao timestamp,
	data_atualizacao timestamp
);


-- tabela para gravar registro das vendas
create table vendas(
	id serial not null primary key,
	funcionario_id int references funcionarios(id),
	mesa_id int references mesas(id),
	venda_codigo varchar(20),
	venda_valor real,
	venda_total real,
	venda_desconto real,
	venda_situacao varchar(1) default 'A',
	data_criacao timestamp,
	data_atualizacao timestamp
);

-- tabela para gravar registro dos itens das vendas
create table itens_vendas(
	id serial not null primary key,
	produto_id int not null references produtos(id),
	vendas_id int not null references vendas(id),
	item_valor real,
	item_quantidade int,
	item_total real,
	data_criacao timestamp,
	data_atualizacao timestamp
);


-- tabela para gravar registro do cálculo das comissões
create table comissoes(
	id serial not null primary key,
	funcionario_id int references funcionarios(id),
	comissao_valor real,
	comissao_situacao varchar(1) default 'A',
	data_criacao timestamp,
	data_atualizacao timestamp
);

insert into mesas (mesa_codigo, mesa_situacao, data_criacao, data_atualizacao) values
('00001','A', '2025-08-13', '2025-08-13'),
('00002','A', '2025-08-13', '2025-08-13');

insert into funcionarios(funcionario_codigo, funcionario_nome, funcionario_situacao, funcionario_comissao, funcionario_cargo,
 data_criacao) values
 ('0001', 'JARVIS', 'A', 5, 'GERENTE',  '2025-08-13'),
 ('0002', 'SOUZA', 'A', 2, 'GARÇOM', '2025-08-13');                                 
                                  
insert into produtos (produto_codigo, produto_nome, produto_valor, produto_situacao, data_criacao, data_atualizacao)
	values 
		('001', 'REFRIGERANTE', 10, 'A','2025-08-13', '2025-08-13'),
		('002', 'AGUA', 3, 'A', '2025-08-13', '2025-08-13'),
		('003', 'PASTEL', 7, 'A', '2025-08-13', '2025-08-13');

insert into vendas (funcionario_id, mesa_id, venda_codigo, venda_valor, venda_total, venda_desconto, venda_situacao, 
	data_criacao, data_atualizacao)
values 
	(2, 1, '0001', '20', '20', '0', 'A', '2025-08-13', '2025-08-13'),
	(2, 2, '0002', '21', '21', '0', 'A', '2025-08-13', '2025-08-13');

insert into itens_vendas (produto_id,  vendas_id, item_valor, item_quantidade, item_total, data_criacao, data_atualizacao)
	values 
	(1, 1, 10, 2, 20, '2025-08-13', '2025-08-13'),  
	(1, 2, 7, 3, 21, '2025-08-13', '2025-08-13');