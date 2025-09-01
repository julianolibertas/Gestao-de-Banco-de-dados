create or replace function
	retorna_nome_funcionario(func_id INT)
	returns text as 
$fnc0$
declare
	nome		text;
	situacao	text;
begin
		
	select funcionario_nome,
			funcionario_situacao
	into nome, situacao
	from funcionarios
	where id = func_id;
		
		if situacao = 'A' then
			return nome || ' Usuário Ativo';
		else
			return nome || ' Usuário Inativo';
		end if;
			
end;
$fnc0$
language plpgsql;

-- select retorna_nome_funcionario(2);

-- drop function retorna_nome_funcionario;


create or replace function
	rt_valor_comissao(func_id INT)
	returns real as
$fnc1$
declare
	valor_comissao real;
begin
	select funcionario_comissao
	into valor_comissao
	from funcionarios
	where id = func_id;
	return valor_comissao;
end;
$fnc1$
language plpgsql;

-- select rt_valor_comissao(1);
-- select rt_valor_comissao(2);
-------------------------------------------
