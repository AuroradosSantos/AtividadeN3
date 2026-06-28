--
-- File generated with Letos v4.0.0 on Sun Jun 28 13:10:36 2026
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Cliente
CREATE TABLE IF NOT EXISTS "Cliente" (id_cliente INTEGER PRIMARY KEY, nome TEXT, telefone TEXT);
INSERT INTO Cliente (id_cliente, nome, telefone) VALUES (1, 'aurora', '9521278883');
INSERT INTO Cliente (id_cliente, nome, telefone) VALUES (2, 'marco', '6923353111');
INSERT INTO Cliente (id_cliente, nome, telefone) VALUES (3, 'kaique', '6137865178');
INSERT INTO Cliente (id_cliente, nome, telefone) VALUES (4, 'arthur', '9932635354');
INSERT INTO Cliente (id_cliente, nome, telefone) VALUES (5, 'gabriel', '6239417469');

-- Table: disco
CREATE TABLE IF NOT EXISTS "disco" (id_disco INTEGER PRIMARY KEY, titulo TEXT, artista TEXT, genero TEXT, preco TEXT, estoque INTEGER);
INSERT INTO disco (id_disco, titulo, artista, genero, preco, estoque) VALUES (1, 'disco1', 'artista1', 'rock', '100', 50);
INSERT INTO disco (id_disco, titulo, artista, genero, preco, estoque) VALUES (2, 'disco2', 'artista2', 'pop', '100', 23);
INSERT INTO disco (id_disco, titulo, artista, genero, preco, estoque) VALUES (3, 'disco3', 'artista3', 'hiphop', '100', 5);
INSERT INTO disco (id_disco, titulo, artista, genero, preco, estoque) VALUES (4, 'disco4', 'artista4', 'eletronica', '100', 57);
INSERT INTO disco (id_disco, titulo, artista, genero, preco, estoque) VALUES (5, 'disco5', 'artista5', 'folk', '100', 0);

-- Table: ItemVenda
CREATE TABLE IF NOT EXISTS "ItemVenda" (id_item INTEGER PRIMARY KEY, id_venda INTEGER REFERENCES Venda (id), id_disco INTEGER REFERENCES disco (id), quantidade INTEGER, valor_unitario REAL);
INSERT INTO ItemVenda (id_item, id_venda, id_disco, quantidade, valor_unitario) VALUES (1, 1, 1, 20, 100.0);
INSERT INTO ItemVenda (id_item, id_venda, id_disco, quantidade, valor_unitario) VALUES (2, 2, 2, 10, 100.0);
INSERT INTO ItemVenda (id_item, id_venda, id_disco, quantidade, valor_unitario) VALUES (3, 3, 5, 25, 100.0);
INSERT INTO ItemVenda (id_item, id_venda, id_disco, quantidade, valor_unitario) VALUES (4, 4, 3, 50, 100.0);
INSERT INTO ItemVenda (id_item, id_venda, id_disco, quantidade, valor_unitario) VALUES (5, 5, 4, 40, 100.0);

-- Table: Venda
CREATE TABLE IF NOT EXISTS "Venda" (id_venda INTEGER PRIMARY KEY, id_cliente INTEGER REFERENCES Cliente (id), data TEXT);
INSERT INTO Venda (id_venda, id_cliente, data) VALUES (1, 1, '10/09/2026');
INSERT INTO Venda (id_venda, id_cliente, data) VALUES (2, 3, '20/06/2028');
INSERT INTO Venda (id_venda, id_cliente, data) VALUES (3, 2, '05/02/2023');
INSERT INTO Venda (id_venda, id_cliente, data) VALUES (4, 5, '04/10/2025');
INSERT INTO Venda (id_venda, id_cliente, data) VALUES (5, 4, '10/10/2010');
INSERT INTO Venda (id_venda, id_cliente, data) VALUES (6, 1, '20/09/2009');

-- Trigger: AtualizarEstoque
CREATE TRIGGER IF NOT EXISTS AtualizarEstoque AFTER INSERT ON ItemVenda BEGIN UPDATE disco SET estoque = estoque - NEW.quantidade WHERE id_disco = NEW.id_disco; END;

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;

-- Relatório 1 - Vendas por Cliente
SELECT
    Venda.id_venda,
    Cliente.nome,
    Venda.data
FROM Venda
JOIN Cliente
ON Venda.id_cliente = Cliente.id_cliente;

-- Relatório 2 - Discos de Rock com estoque
SELECT *
FROM disco
WHERE genero = 'rock'
AND estoque > 0;


-- Relatório 3 - Discos de Rock ou Pop
SELECT *
FROM disco
WHERE genero = 'rock'
OR genero = 'pop';

-- Relatório 4 - Discos de Rock e Pop
SELECT titulo, genero
FROM disco
WHERE genero = 'rock'

UNION ALL

SELECT titulo, genero
FROM disco
WHERE genero = 'pop';

-- Relatório 5 - Quantidade de discos e valor do estoque
SELECT
    COUNT(*) AS total_discos,
    SUM(estoque * preco) AS valor_total_estoque
FROM disco;
