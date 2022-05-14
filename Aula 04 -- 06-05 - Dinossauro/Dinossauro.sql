CREATE DATABASE Dinossauro;
USE Dinossauro;

CREATE TABLE [Grupo] (
  [id] int not null Identity,
  [nome] varchar (50) not null,
  PRIMARY KEY ([id])
);

CREATE TABLE [Pais] (
  [id] int not null Identity,
  [nome] varchar (50) not null,
  PRIMARY KEY ([id])
);

CREATE TABLE [Descobridor] (
  [id] int not null Identity,
  [nome] varchar (50) not null,
  PRIMARY KEY ([id])
);

CREATE TABLE [Era] (
  [id] int not null Identity,
  [nome] varchar(50) not null,
  [inicio] int not null,
  [fim] int not null,
  PRIMARY KEY ([id])
);

CREATE TABLE [Dinossauro] (
  [id] int not null Identity,
  [nome] varchar(50) not null,
  [tonelada] int not null,
  [ano_descoberta] int not null,
  [fk_grupo] int not null,
  [fk_pais] int not null,
  [fk_era] int not null,
  [fk_descoberta] int not null,
  PRIMARY KEY ([id]),
  CONSTRAINT [FK_Dinossauro.fk_grupo]
    FOREIGN KEY ([fk_grupo])
      REFERENCES [Grupo]([id]),
  CONSTRAINT [FK_Dinossauro.fk_pais]
    FOREIGN KEY ([fk_pais])
      REFERENCES [Pais]([id]),
  CONSTRAINT [FK_Dinossauro.fk_descoberta]
    FOREIGN KEY ([fk_descoberta])
      REFERENCES [Descobridor]([id]),
  CONSTRAINT [FK_Dinossauro.fk_era]
    FOREIGN KEY ([fk_era])
      REFERENCES [Era]([id])
);

/*Inserir os dados da tabela Grupo*/
INSERT INTO Grupo (nome) VALUES ('Anquilossauros');
INSERT INTO Grupo (nome) VALUES ('Ceratopsídeos');
INSERT INTO Grupo (nome) VALUES ('Estegossauros');
INSERT INTO Grupo (nome) VALUES ('Terápodes');

/*Inserir os dados da tabela Pais*/
INSERT INTO Pais (nome) VALUES ('Mongólia');
INSERT INTO Pais (nome) VALUES ('Canadá');
INSERT INTO Pais (nome) VALUES ('Tanzânia');
INSERT INTO Pais (nome) VALUES ('China');
INSERT INTO Pais (nome) VALUES ('América do Norte');
INSERT INTO Pais (nome) VALUES ('USA');

/*Inserir dados na Tabela Era*/
INSERT INTO Era(nome, inicio, fim) VALUES ('Cretácio', 145, 66);
INSERT INTO Era(nome, inicio, fim) VALUES ('Jurássico', 201, 145);

/*Inserir dados na Tabela Descobridor*/
INSERT INTO Descobridor(nome) VALUES ('Maryanska');
INSERT INTO Descobridor(nome) VALUES ('John Bell Hatcher');
INSERT INTO Descobridor(nome) VALUES ('Cientistas Alemães');
INSERT INTO Descobridor(nome) VALUES ('Museu Americano de História Natural');
INSERT INTO Descobridor(nome) VALUES ('Othniel Charles Marsh');
INSERT INTO Descobridor(nome) VALUES ('Barnum Brown');



/*Inserir os dados da tabela Dinossauros*/
INSERT INTO Dinossauro (nome, tonelada, ano_descoberta, fk_grupo, fk_pais, fk_era, fk_descoberta) VALUES ('Saichania', 4, 1977, 1, 1, 1, 1);
INSERT INTO Dinossauro (nome, tonelada, ano_descoberta, fk_grupo, fk_pais, fk_era, fk_descoberta) VALUES ('Tricerátops', 6, 1887, 2, 2, 1, 2);
INSERT INTO Dinossauro (nome, tonelada, ano_descoberta, fk_grupo, fk_pais, fk_era, fk_descoberta) VALUES ('Kentrossauro', 2, 1990, 3, 3, 2, 3);
INSERT INTO Dinossauro (nome, tonelada, ano_descoberta, fk_grupo, fk_pais, fk_era, fk_descoberta) VALUES ('Pinacossauro', 6, 1999, 1, 4, 1, 4);
INSERT INTO Dinossauro (nome, tonelada, ano_descoberta, fk_grupo, fk_pais, fk_era, fk_descoberta) VALUES ('Alossauro', 3, 1877, 4, 5, 2, 5);
INSERT INTO Dinossauro (nome, tonelada, ano_descoberta, fk_grupo, fk_pais, fk_era, fk_descoberta) VALUES ('Torossauro', 8, 1891, 2, 6, 1, 2);
INSERT INTO Dinossauro (nome, tonelada, ano_descoberta, fk_grupo, fk_pais, fk_era, fk_descoberta) VALUES ('Anquilossauro', 8, 1906, 1, 5, 1, 6);

select * from Dinossauro;
select * from Grupo;
select * from Pais;
select * from Era;
select * from Descobridor;

/*7- Crie uma consulta para relacionar todos os dados disponiveis de todos os dinossauros existentes em ordem alfabetica existentes no catalogo em 
ordem alfabetica por nome */
select
Dinossauro.nome as 'Dinossauro',
Grupo.nome as 'Grupo',
Dinossauro.tonelada as 'Toneladas',
Dinossauro.ano_descoberta as 'Ano de Descoberta',
Descobridor.nome as 'Descobridor',
Era.nome as 'Era',
Era.inicio as 'Inicio (Milhões)',
Era.fim as 'Fim (Milhões)',
Pais.nome as 'País'
FROM Dinossauro, Era, Descobridor, Grupo, Pais
WHERE Dinossauro.fk_grupo = Grupo.id
and Dinossauro.fk_pais = Pais.id
and Dinossauro.fk_era = Era.id
and Dinossauro.fk_descoberta = Descobridor.id
ORDER BY Dinossauro.nome;

/*8- Crie uma consulta para relacionar todos os dados disponiveis de todos os dinossauros existentes em ordem alfabetica de descobridor */

