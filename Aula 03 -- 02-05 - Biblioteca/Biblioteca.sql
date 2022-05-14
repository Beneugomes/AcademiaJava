CREATE DATABASE Biblioteca;
USE Biblioteca;

CREATE TABLE [Categoria] (
  [id] int not null Identity,
  [tipo_categoria] varchar(50),
  PRIMARY KEY ([id])
);

CREATE TABLE [Editora] (
  [id] int not null Identity,
  [nome] varchar(50),
  PRIMARY KEY ([id])
);

CREATE TABLE [Autor] (
  [id] int not null Identity,
  [nome] varchar(100),
  [nacionalidade] varchar(100),
  PRIMARY KEY ([id])
);

CREATE TABLE [Livro] (
  [ISBN] varchar(50) not null,
  [Titulo] varchar(100) not null,
  [ano] int not null,
  [fk_editora] int not null,
  [fk_categoria] int not null,
  PRIMARY KEY ([ISBN]),
  CONSTRAINT [FK_Livro.fk_editora]
    FOREIGN KEY ([fk_editora])
      REFERENCES [Editora]([id]),
  CONSTRAINT [FK_Livro.fk_categoria]
    FOREIGN KEY ([fk_categoria])
      REFERENCES [Categoria]([id])
);

CREATE TABLE [Livroautor] (
  [id] int not null Identity,
  [fk_autor] int not null,
  [fk_livro] varchar(50),
  PRIMARY KEY ([id]),
  CONSTRAINT [FK_Livroautor.fk_autor]
    FOREIGN KEY ([fk_autor])
      REFERENCES [Autor]([id]),
  CONSTRAINT [FK_Livroautor.fk_livro]
    FOREIGN KEY ([fk_livro])
      REFERENCES [Livro]([ISBN])
);


/* Comandos usado para inserir dados na tabela Categoria*/
insert into Categoria(tipo_categoria) Values ('Literatura Juvenil');
insert into Categoria(tipo_categoria) Values ('Ficção Científica');
insert into Categoria(tipo_categoria) Values ('Humor');
insert into Categoria(tipo_categoria) Values ('Ação');
insert into Categoria(tipo_categoria) Values ('Romance');

/* Comando para alterar um dado em um campo da tabela
UPDATE categoria 
SET tipo_categoria = 'Humor'
WHERE id = 3;
*/

/*Inserir dados na tabela Editora*/
insert into Editora(nome) values ('Rocco');
insert into Editora(nome) values ('Wmf Martins Fontes');
insert into Editora(nome) values ('Casa da Palavra');
insert into Editora(nome) values ('Belas Letras');
insert into Editora(nome) values ('Matrix');

/* Inserir os dados da tabela Livros*/
insert into Livro values ('8532511015','Harry Potter e A Pedra Filosofal','2000',1,1);
insert into Livro values ('9788578270698','As Crônicas de Nárnia','2009',2,1);
insert into Livro values ('9788577343348','O Espadachum de Carvão','2013',3,2);
insert into Livro values ('9788581742458','O Papai é POP','2015',4,3);
insert into Livro values ('9788582302026','Pior que tá não fica','2015',5,3);
insert into Livro values ('9788577345670','Garota Desdobrável','2015',3,1);
insert into Livro values ('8532512062','Harry Potter e o Prisioneiro de Azkaban','2000',1,1);

/*Inserir dados na tabela Autor*/

insert into Autor(nome) values ('J.K. Rowling');
insert into Autor(nome, nacionalidade) values ('Clive Staples Lewis', 'Inglaterra');
insert into Autor(nome, nacionalidade) values ('Affonso Solano', 'Brasil');
insert into Autor(nome, nacionalidade) values ('Marcos Piagers', 'Brasil');
insert into Autor(nome, nacionalidade) values ('Ciro Botelho - Tiririca', 'Brasil');
insert into Autor(nome, nacionalidade) values ('Bianca Mól', 'Brasil');

/*Inserir valores na tabela livroautor - relacionamento de cada livro com seu autor*/
insert into Livroautor(fk_livro, fk_autor) values ('9788578270698', 1);
insert into Livroautor(fk_livro, fk_autor) values ('8532511015', 2);
insert into Livroautor(fk_livro, fk_autor) values ('9788577343348', 3);
insert into Livroautor(fk_livro, fk_autor) values ('9788581742458', 4);
insert into Livroautor(fk_livro, fk_autor) values ('9788582302026', 5);
insert into Livroautor(fk_livro, fk_autor) values ('9788577345670', 6);
insert into Livroautor(fk_livro, fk_autor) values ('8532512062', 1);

/*Exemplo de inserção errada, aqui vinculamos 
o livro Harry Potter e o Prisioneiro de Azkabam ao autor Clive Staples*/
insert into livroautor (fk_livro, fk_autor) values('8532512062',5);
/*Exemplo de como removemos o registro que estava errado.*/
delete from livroautor where fk_livro = '8532512062' and fk_autor = 5;

/*Este select recupera todos os livros da categoria "Literaturo Juvenil"*/
select livro.titulo, categoria.tipo_categoria
from livro, categoria
where livro.fk_categoria = categoria.id
and categoria.tipo_categoria = 'Literatura Juvenil';

/*Este Select recupera todos os registros dos livros escritos por J.K Rowling*/
select livro.titulo, autor.nome
from livro, autor, livroautor
where livroautor.fk_autor = autor.id
and livroautor.fk_livro = livro.isbn
and autor.nome like '%Sol%'; /*Busca qualquer coisa cujo tenha a parte "Sol"*/

select * from Categoria;
select * from Editora;
select * from Livro;
select * from Autor;
select * from Livroautor;


/*Exercício 7:
Crie uma consulta para relacionar todos os dados disponíveis de todos os livros existêntes na biblioteca em 
ordem alfabética.*/
select * from Livro order by Titulo; /*ordenando pelo titulo*/

/*Comando 'as' utilizado para alterar a apresentação do nome da coluna*/
select 
livro.ISBN as 'ISBN', 
Livro.Titulo as 'Título', 
Livro.ano as 'Ano', 
Editora.nome as 'Editora', 
Categoria.tipo_categoria as 'Categoria'

from Livro, Editora, Categoria
where Livro.fk_editora = Editora.id
and Livro.fk_categoria = Categoria.id
order by Livro.Titulo


/*Este Select recupera todos os dados o "AS" é utilizado para modificar o nome da couna 
a funcção "CONCAT" é para concatenar (agrupar os valores coluna só). os valores que estão como nulos 
é devido a uma das colunas possuir valor nulo.
*/
select 
livro.isbn as 'ISBN', 
livro.titulo as 'Título', 
livro.ano as 'Ano', 
editora.nome as 'Editora', 

concat(autor.nome, '(' ,autor.nacionalidade,')') as  'Autor/Nascionalidade',
categoria.tipo_categoria as 'Categoria'

from livro, editora, categoria, autor, livroautor
where livro.fk_editora = editora.id
and livro.fk_categoria = categoria.id
and livroautor.fk_autor = autor.id
and livroautor.fk_livro = livro.isbn
order by livro.titulo;


/*adicionando uma nascionalidade ao Autor J.K. Roliwn.*/
update autor
set autor.nacionalidade = 'Inglaterra'
where autor.id = 2;
select * from Autor;

/*Exercício 8:
Crie uma consulta para relacionar todos os dados dos livros disponíveis na biblioteca em ordem alfabéticas de Autor*/
select 
livro.isbn as 'ISBN', 
livro.titulo as 'Título', 
livro.ano as 'Ano', 
editora.nome as 'Editora', 

concat(autor.nome, '(' ,autor.nacionalidade,')') as  'Autor/Nascionalidade',
categoria.tipo_categoria as 'Categoria'

from livro, editora, categoria, autor, livroautor
where livro.fk_editora = editora.id
and livro.fk_categoria = categoria.id
and livroautor.fk_autor = autor.id
and livroautor.fk_livro = livro.isbn
order by autor.nome;

/*Exercício 9:
Crie uma consulta para relacionar todos os dados disponíveis dos livros da categoria de literatura Juvenil em ordem de ano*/
select livro.isbn as 'ISBN', 
livro.titulo as 'Título', 
livro.ano as 'Ano', 
editora.nome as 'Editora', 

concat(autor.nome, '(' ,autor.nacionalidade, ')') as  'Autor/Nascionalidade',
categoria.tipo_categoria as 'Categoria'

from livro, editora, categoria, autor, livroautor
where livro.fk_editora = editora.id
and livro.fk_categoria = categoria.id
and livroautor.fk_autor = autor.id
and livroautor.fk_livro = livro.isbn
and categoria.tipo_categoria like '%Juve%'
order by livro.ano;

/*Exercício 10
Crie uma consulta para relacionar todos os dados disponíveis dos livros de humor ou ficção cientifica 
com ano entre 2000 e 2010
Altere a data máxima para 2015 para que possamos ter alguma informação recuperada.
*/
select 
livro.isbn as 'ISBN', 
livro.titulo as 'Título', 
livro.ano as 'Ano', 
editora.nome as 'Editora', 

concat(autor.nome, ' (' ,autor.nacionalidade, ')') as  'Autor/Nascionalidade',
categoria.tipo_categoria as 'Categoria'

from livro, editora, categoria, autor, livroautor
where livro.fk_editora = editora.id
and livro.fk_categoria = categoria.id
and livroautor.fk_autor = autor.id
and livroautor.fk_livro = livro.isbn
and categoria.tipo_categoria in ('Humor', 'Ficção Científica')
and livro.ano between 2000 and 2015
order by livro.ano;