create or replace function
	calc_comissao(data_ini timestamp, data_fim timestamp)
	returns void as
$fn$
declare 
	/*
	Declaração de variáveis que vamos utilizar. Já na
	declaração elas recebem o valor zero. Pois assim
	garante que elas estarão zeradas quando for 
	utilizá-las
	*/
	total_comissao real := 0;
	porc_comissao real := 0;

	-- declarando uma variável para armazenar os 
	-- registros dos loops
	reg	record;
	
	-- cursor para buscar a % de comissão do funcionários
	cr_porce cursor (func_id INT) is
		select rt_valor_comissao(func_id);
	
begin
	-- Realiza um loop e busca todas as vendas
	-- no período informado.
	
	for reg in (
		select vendas.id id, 
			funcionario_id, 
			venda_total
		from vendas
		where data_criacao >= data_ini
		and data_criacao <= data_fim
		and venda_situacao = 'A')
	loop
		-- abertura, utilização e fechamento do cursor
		open cr_porce(reg.funcionario_id);
		fetch cr_porce into porc_comissao;
		close cr_porce;
	
		total_comissao := 
			(reg.venda_total * porc_comissao)/100;
		
		/*
		 inserir na tabela de comissões o valor que
		 o funcionário irá receber de comissão
		 daquela venda
		 */
		insert into comissoes (
			funcionario_id,
			comissao_valor, 
			comissao_situacao, 
			data_criacao,
			data_atualizacao
		) values (
			reg.funcionario_id,
			total_comissao, 
			'A',
			now(),
			now()
		);
		
		-- update na situação da venda
		-- para que ela não seja comissionada
		update vendas set venda_situacao = 'C'
			where id = reg.id;
		
		-- Zerar as variáveis para reutilizá-las
		total_comissao := 0;
		porc_comissao := 0;
		
		-- termino do loop
		
	end loop;
end;	
$fn$
language plpgsql;