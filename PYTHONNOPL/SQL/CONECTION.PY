import cx_oracle

#criando uma conexao com o banco 
conn = cx_oracle.connect("") #*  exemplo "xr/xr/localhost:1521/orcl"
#criando um cursor 
cursor = conn.cursor()
#implementando un comando 
create_table = """
    create table pessoa (
        nome varchar2(20),
        sobrenome varchar2(30),
        idade number
    )
"""
#executando a criacao da tabela
cur.execute(create_table)
