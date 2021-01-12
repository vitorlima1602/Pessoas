CREATE DATABASE Cadastro_Pessoas
GO

USE Cadastro_Pessoas
GO

CREATE TABLE PESSOA(
	idPessoa int IDENTITY PRIMARY KEY  NOT NULL,
	nome varchar(60),
	cpf varchar(14),
	rg varchar(12),
	data_nascimento date
)

GO

CREATE TABLE ENDERECO(
	idEndereco int IDENTITY PRIMARY KEY  NOT NULL,
	logradouro varchar(60),
	numero int,
	cep varchar(10),
	bairro varchar(50),
	cidade varchar(60),
	uf varchar(2),
	idPessoa int FOREIGN KEY REFERENCES PESSOA(idPessoa)
)
GO

CREATE TABLE TELEFONE(
	idTelefone int IDENTITY PRIMARY KEY NOT NULL,
	ddd varchar(3),
	numero varchar(10),
	idPessoa int FOREIGN KEY REFERENCES PESSOA(idPessoa)
)
GO