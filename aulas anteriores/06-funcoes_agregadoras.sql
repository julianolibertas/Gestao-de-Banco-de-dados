
-- extrai o ano de um data
select funcionario_nome, extract(year from data_criacao) from funcionarios;

-- Funções agregadoras

-- Count() contar o resultado de um consulta
select count(id) from funcionarios

-- Somando as colunas utilizando sum()
select sum(venda_total) from vendas;

-- Calculando a média dos valores com avg()
select avg(produto_valor) from produtos;alter 

-- Valores máximo e mínimo de uma coluna
select max(produto_valor), min(produto_valor) from produtos;

--Agrupando registros iguais com group by

-- Insere uma nova vendas
insert into vendas (id, funcionario_id, mesa_id, venda_codigo, venda_valor, venda_total, venda_desconto, venda_situacao, data_criacao, data_atualizacao)
values 
(10000, 1, 1, '10201', '51', '51', '0', 'A', current_date, current_date);


-- Insere itens da venda inserida anteriormente.
insert into itens_vendas (produto_id, vendas_id, item_valor, item_quantidade, item_total, data_criacao, data_atualizacao)
values
(4, 10000, 15, 2, 30, current_date, current_date),
(3, 10000, 7, 3, 21, current_date, current_date);


-- Insere uma nova vendas
insert into vendas (id, funcionario_id, mesa_id, venda_codigo, venda_valor, venda_total, venda_desconto, venda_situacao, data_criacao, data_atualizacao)
values 
(10001, 1, 1, '10201', '20', '20', '0', 'A', current_date, current_date);


-- Insere itens da venda inserida anteriormente.
insert into itens_vendas (produto_id, vendas_id, item_valor, item_quantidade, item_total, data_criacao, data_atualizacao)
values
(1, 10001, 10, 2, 20, current_date, current_date);

-- Insere uma nova vendas
insert into vendas (id, funcionario_id, mesa_id, venda_codigo, venda_valor, venda_total, venda_desconto, venda_situacao, data_criacao, data_atualizacao)
values 
(10002, 1, 1, '10002', '45', '45', '0', 'A', current_date, current_date);


-- Insere itens da venda inserida anteriormente.
insert into itens_vendas (produto_id, vendas_id, item_valor, item_quantidade, item_total, data_criacao, data_atualizacao)
values
(4, 10002,15, 3, 45, current_date, current_date);

--
select produto_id, sum(item_total) from itens_vendas group by produto_id;
-- query buscando dados na tabela produtos;
select produto_id, produto_nome, sum(item_total) 
from itens_vendas i, produtos p  
where i.produto_id = p.id 
group by produto_id, produto_nome;


-- para facilitar novas consultas, crie um função.
create or replace function
	retorna_nome_produto(prod_id int)
	returns text as 
$f01$
declare
	nome text;
begin
	select produto_nome into nome
	from produtos
	where id = prod_id;
	return nome;

end
$f01$
language plpgsql;

-- Consulta usando a função criada
select retorna_nome_produto(produto_id), sum(item_total) 
from  itens_vendas
group by produto_id;

-- usando Alias para trocar o nome da Coluna
select retorna_nome_produto(produto_id) PRODUTO, sum(item_total) VLR_TOTAL_PRODUTO 
from  itens_vendas
group by produto_id
order by VLR_TOTAL_PRODUTO, PRODUTO;

-- Retorna a quantidade de vezes que houve venda do produto
select retorna_nome_produto(produto_id), count(id) QTDE_VENDAS 
from  itens_vendas
group by produto_id;

-- Retorna só os produtos que venderam mais de 2 vezes
select retorna_nome_produto(produto_id), count(id) QTDE_VENDAS 
from  itens_vendas
group by produto_id
having count(produto_id) >=2
order by qtde_vendas;

-- funções de formatação

-- lista data e hora atuais
select current_timestamp
-- lista hora formatada
SELECT TO_CHAR(current_timestamp, 'HH12:MI:SS');
-- lista data 
select to_char(current_date, 'DD/MM/YYYY');

-- converte texto em data
select to_date('04 Nov 1988', 'DD Mon YYYY');