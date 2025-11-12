import sqlite3
from sqlite3 import Error

DB_FILE = 'floricultura.db'

#criar tabelas
sql_clientes = """ 
  CREATE TABLE IF NOT EXISTS clientes(
  id_cliente integer primary key AUTOINCREMENT,
  rg varchar(12) not null, 
  nome varchar(30) not null,
  sobrenome varchar(40),
  telefone varchar(12),
  rua varchar(40),
  numero varchar(5),
  bairro varchar(25)
  );
"""
sql_produtos = """
  CREATE TABLE IF NOT EXISTS produtos(
  id_produto integer primary key AUTOINCREMENT,
  nome_produto varchar(30) not null,
  tipo varchar(25) not null,
  preco decimal(10,2) not null, 
  qtde_estoque smallint not null
  );
"""

sql_vendas = """
CREATE TABLE IF NOT EXISTS vendas(
id_transacao integer primary key AUTOINCREMENT,
nota_fiscal smallint not null, 
id_cliente integer not null, 
data_compra datetime, 
id_produto integer not null,
quantidade smallint not null, 
foreign key (id_cliente) references clientes(id_cliente),
foreign key (id_produto) references produtos(id_produtos)
);
"""
def conectar():
  """
  Função para conectar ao banco de dados SQLite.
  Retorna um objeto de conexão (conn) ou None se a conexão falhar.
  """
  try: 
    conn = sqlite3.connect(DB_FILE)

    conn.execute(sql_clientes)
    conn.execute(sql_produtos)
    conn.execute(sql_vendas)
    conn.commit()

    print("Conexão com o banco de dados 'floricultura.db' bem-sucedida!")
    return conn
  except Error as e:
    print(f"Erro ao conectar ao banco de dados: {e}")
    return None

# Um pequeno teste (opcional) para verificar se o módulo está funcionando
if __name__ == '__main__':
  conn=conectar()
  if conn:
    print("Conexão bem-sucedida!")
    conn.close()
  else:
    print("Falha na conexão")

# conectar() # testar se esta funcionando.
