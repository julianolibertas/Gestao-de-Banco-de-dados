-- Operadores lógicos AND, OR e NOT
-- Operadores de comparação
select id, funcionario_id, venda_total from vendas
	where data_criacao >= '2025-08-01'
	and data_criacao <= '2025-08-31'
	and venda_situacao = 'C';

insert into produtos (produto_codigo, produto_nome, produto_valor, produto_situacao, data_criacao, data_atualizacao)
values
('2832', 'SUCO DE LIMÃO', 15, 'C', CURRENT_DATE,CURRENT_DATE);

delete from produtos  where id = 4;

select * from produtos
	where produto_situacao= 'A'
	or produto_situacao = 'C';

select * from produtos
	where not produto_nome= 'SUCO DE LIMÃO';

select * from produtos
	where produto_situacao= 'A'
	or (produto_situacao = 'C' and data_criacao='2025-08-31');

-- operadores e funções matemáticas
select 5*15;

select 5%4;

--Funções matemáticas - livro

-- Funções de texto
-- || Concatenar

select funcionario_codigo ||' '|| funcionario_nome from funcionarios where id = 1;

-- conta a quantidade de caracteres char_length
select char_length(funcionario_nome) from funcionarios where id = 2;

-- letras maísculas e minúscula
select upper(funcionario_nome) from funcionarios;

select upper('livro postgresql');

select lower(funcionario_nome) from funcionarios;

update funcionarios set funcionario_nome = 'Juliano Caetano' where id = 1;
-- substitui por 000000 a posição indicada from 3 for 6
select overlay(funcionario_nome placing '000000' from 3 for 6) from funcionarios where id = 1;
-- retorna parte de uma string
select substring(funcionario_nome from 3 for 5) from funcionarios where id = 1;
-- retorna a posição que começa a string ano
select position('ano' in funcionario_nome) from funcionarios where id = 1;
--lista o formato da data default
show datestyle; -- ISO, MDY
-- muda o formato da data
set datestyle to iso, dmy;
-- calcula a idade em ano, mes e dia
select age(CURRENT_DATE, '23-12-1970');
-- Operadores lógicos AND, OR e NOT
-- Operadores de comparação
select id, funcionario_id, venda_total from vendas
	where data_criacao >= '2025-08-01'
	and data_criacao <= '2025-08-31'
	and venda_situacao = 'C';

insert into produtos (produto_codigo, produto_nome, produto_valor, produto_situacao, data_criacao, data_atualizacao)
values
('2832', 'SUCO DE LIMÃO', 15, 'C', CURRENT_DATE,CURRENT_DATE);

delete from produtos  where id = 4;

select * from produtos
	where produto_situacao= 'A'
	or produto_situacao = 'C';

select * from produtos
	where not produto_nome= 'SUCO DE LIMÃO';

select * from produtos
	where produto_situacao= 'A'
	or (produto_situacao = 'C' and data_criacao='2025-08-31');

-- operadores e funções matemáticas
select 5*15;

select 5%4;

--Funções matemáticas - livro

-- Funções de texto
-- || Concatenar

select funcionario_codigo ||' '|| funcionario_nome from funcionarios where id = 1;

-- letras maísculas e minúscula
select upper(funcionario_nome) from funcionarios;

select upper('livro postgresql');

select lower(funcionario_nome) from funcionarios;

update funcionarios set funcionario_nome = 'Juliano Caetano' where id = 1;
-- substitui por 000000 a posição indicada from 3 for 6
select overlay(funcionario_nome placing '000000' from 3 for 6) from funcionarios where id = 1;
-- retorna parte de uma string
select substring(funcionario_nome from 3 for 5) from funcionarios where id = 1;
-- retorna a posição que começa a string ano
select position('ano' in funcionario_nome) from funcionarios where id = 1;
--lista o formato da data default
show datestyle; -- ISO, MDY
-- muda o formato da data
set datestyle to iso, dmy;
-- calcula a idade em ano, mes e dia
select age(CURRENT_DATE, '23-12-1970');

--Retorna a data e a hora atuais do servidor, incluindo o fuso horário.
SELECT NOW();
--Retorna apenas a data atual, sem a hora.
SELECT CURRENT_DATE;
-- Retorna apenas a hora atual, sem a data.
SELECT CURRENT_TIME;
-- Retorna a data e a hora locais, sem o fuso horário.
SELECT LOCALTIMESTAMP;
-- Retorna a data e a hora como uma string de texto.
SELECT TIMEOFDAY();



