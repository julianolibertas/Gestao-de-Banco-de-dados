-- CONSULTAS UTILIZANDO LIKE


insert into funcionarios (
	funcionario_codigo,
	funcionario_nome, 
	funcionario_situacao,
	funcionario_comissao,
	funcionario_cargo,
	data_criacao
) values
('0100', 'Vinicius Souza', 'A', 2, 'GARÇOM', current_date),
('0101', 'Vinicius Souza Molin', 'A', 2, 'GARÇOM', current_date),
('0102', 'Vinicius RANKEL C', 'A', 2, 'GARÇOM', current_date),
('0103', 'Batista Souza Luiz', 'A', 2, 'GARÇOM', current_date),
('0104', 'Alberto Souza Cardoso', 'A', 2, 'GARÇOM', current_date),
('0105', 'Carlos Gabriel Almeida', 'A', 2, 'GARÇOM', current_date),
('0106', 'Renan Simões Souza', 'A', 2, 'GARÇOM', current_date);

select funcionario_nome from funcionarios;

-- filtra os vinicius
select funcionario_nome from funcionarios where funcionario_nome like 'Vinicius%';
-- filtra os vinicius
select funcionario_nome from funcionarios where funcionario_nome like 'Vinicius%';
-- filtra todos que tem Souza no nome
select funcionario_nome from funcionarios where funcionario_nome like '%So%';

/*
Podemos dizer que triggers, ou gatilhos, são procedimentos
armazenados no banco de dados, que utilizamos para disparar ações
automaticamente ou realizar uma tarefa automática, como por
exemplo, gravar logs de alterações de uma tabela. Podemos pedir
para o banco de dados gravar em uma tabela de logs todas as
alterações que houver em determinada tabela.

Vamos imaginar uma máquina de lavar roupa, dessas
automáticas que lavam, enxaguam e secam. Você apenas a
programa uma vez e ela faz uma operação assim que a outra
termina. É exatamente assim que as triggers funcionam:
disparam automaticamente uma função quando uma outra termina.

Existem três eventos em que usamos as triggers: de inserção
(insert), na alteração (update) e na exclusão de registros (delete).
Cada um desses eventos pode ocorrer em dois momentos: antes da
execução do evento (before) ou depois da execução do evento
(after). Algo muito legal é que podemos incluir mais de um
momento para executar uma trigger. Isso facilita para não termos de
repetir o mesmo código várias vezes.

 */


--drop table logs_produtos;

create table logs_produtos (
	id serial primary key,
	data_alteracao timestamp, 
	alteracao varchar(10),
	id_old int, 
	produto_codigo_old varchar(20), 
	produto_nome_old varchar(60),
	produto_valor_old real,
	produto_situacao_old varchar (1) default 'A', 
	data_criacao_old timestamp,
	data_atualizacao_old timestamp,
	id_new int, 
	produto_codigo_new varchar(20), 
	produto_nome_new varchar(60),
	produto_valor_new real,
	produto_situacao_new varchar (1) default 'A', 
	data_criacao_new timestamp,
	data_atualizacao_new timestamp
	);


create or replace function
	gera_log_produtos()
	returns trigger as
$f07$
begin
	if TG_OP = 'INSERT' then
	
		insert into logs_produtos (
			alteracao, 
			data_alteracao,
			id_new, 
			produto_codigo_new,
			produto_nome_new,
			produto_valor_new, 
			produto_situacao_new,
			data_criacao_new,
			data_atualizacao_new
		) values (
			TG_OP,
			now(),
			new.id, 
			new.produto_codigo,
			new.produto_nome,
			new.produto_valor, 
			new.produto_situacao,
			new.data_criacao,
			new.data_atualizacao
		);
		return new;
		
	elseif TG_OP = 'UPDATE' then
	
		insert into logs_produtos(
			alteracao, 
			data_alteracao,
			id_old, 
			produto_codigo_old,
			produto_nome_old,
			produto_valor_old, 
			produto_situacao_old,
			data_criacao_old,
			data_atualizacao_old,
			id_new, 
			produto_codigo_new,
			produto_nome_new,
			produto_valor_new, 
			produto_situacao_new,
			data_criacao_new,
			data_atualizacao_new
		) values (
			TG_OP,
			now(),
			old.id, 
			old.produto_codigo,
			old.produto_nome,
			old.produto_valor, 
			old.produto_situacao,
			old.data_criacao,
			old.data_atualizacao,
			new.id, 
			new.produto_codigo,
			new.produto_nome,
			new.produto_valor, 
			new.produto_situacao,
			new.data_criacao,
			new.data_atualizacao
		
		); 
		return new;
		
	elseif TG_OP = 'DELETE' then
		insert into logs_produtos (
			alteracao, 
			data_alteracao,
			id_new, 
			produto_codigo_new,
			produto_nome_new,
			produto_valor_new, 
			produto_situacao_new,
			data_criacao_new,
			data_atualizacao_new
		) values (
			TG_OP,
			now(),
			old.id, 
			old.produto_codigo,
			old.produto_nome,
			old.produto_valor, 
			old.produto_situacao,
			old.data_criacao,
			old.data_atualizacao
		);
	
		return new;
	end if;
end;
$f07$
language 'plpgsql';

-- create a trigger na tabela produtos
create or replace trigger tri_log_produtos
	after insert or update or delete on produtos
for each row execute
	procedure gera_log_produtos();


insert into produtos (
	produto_codigo, 
	produto_nome,
	produto_valor,
	produto_situacao, 
	data_criacao
) values 
	
	('1613', 'PANQUECA', 38, 'A', current_date);


	('1512', 'LAZANHA', 46, 'A', current_date),
	('1613', 'PANQUECA', 38, 'A', current_date),
	('733', 'CHURRASCO', 72, 'A', current_date);

select * from logs_produtos;

select * from produtos;

update produtos set produto_valor = 99  where produto_nome='CHURRASCO';

--update produtos set produto_valor = 99, produto_nome='CHURRASCO' where id = 19;

delete from produtos where produto_nome = 'PANQUECA';

alter table produtos disable trigger tri_log_produtos;

