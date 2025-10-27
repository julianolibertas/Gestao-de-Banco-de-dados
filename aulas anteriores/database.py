import psycopg2
from psycopg2 import OperationalError

#define os detalhes da conexão
DB_NAME = "biblioteca"
DB_USER = "biblio"
DB_PASS = "123456"
DB_HOST = "localhost"
DB_PORT = "5432"

def conectar():
  """
  Função para conectar ao banco de dados PostgreSQL.
  Retorna um objeto de conexão (conn) ou None se a conexão falhar.
  """
  try:
    conn = psycopg2.connect(
      database=DB_NAME,
      user= DB_USER,
      password = DB_PASS,
      host=DB_HOST,
      port=DB_PORT
    )
    print("Conexão com o banco de dados 'biblioteca' bem sucedida!")
    return conn
  except OperationalError as e:
    print(f"Erro ao conectar ao banco de dados: {e}")
    return None
  
  # Verificar se o módulo está funcionando.
  if __name__ == '__main__':
    conn=conectar()
    if conn:
      print("Conexão bem-sucedida!")
    else:
      print("Falha na conexão")



conectar()
