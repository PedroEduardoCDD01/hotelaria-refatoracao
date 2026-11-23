-- EXERCÍCIO 6 - TEMA 9: HOTELARIA E RESERVAS
-- Versão compatível com SQLite (SQLite Online)

-- No SQLite não é necessário usar CREATE DATABASE ou USE.
-- Execute este script em um banco SQLite vazio.

PRAGMA foreign_keys = ON;

CREATE TABLE Hospedes (
    id_hospede INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    telefone TEXT
);

CREATE TABLE Quartos (
    id_quarto INTEGER PRIMARY KEY AUTOINCREMENT,
    numero TEXT NOT NULL UNIQUE,
    tipo TEXT NOT NULL
);

CREATE TABLE Reservas (
    id_reserva INTEGER PRIMARY KEY AUTOINCREMENT,
    id_quarto INTEGER NOT NULL,
    data_entrada TEXT NOT NULL,
    data_saida TEXT NOT NULL,
    FOREIGN KEY (id_quarto) REFERENCES Quartos(id_quarto),
    CHECK (data_saida > data_entrada)
);

-- Tabela de ligação: permite vários hóspedes em uma reserva
CREATE TABLE Reserva_Hospede (
    id_reserva INTEGER NOT NULL,
    id_hospede INTEGER NOT NULL,
    titular INTEGER NOT NULL DEFAULT 0 CHECK (titular IN (0, 1)),
    PRIMARY KEY (id_reserva, id_hospede),
    FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva),
    FOREIGN KEY (id_hospede) REFERENCES Hospedes(id_hospede)
);

-- Índices para facilitar consultas
CREATE INDEX idx_reservas_entrada ON Reservas(data_entrada);
CREATE INDEX idx_reservas_saida ON Reservas(data_saida);
CREATE INDEX idx_reservas_quarto ON Reservas(id_quarto);
CREATE INDEX idx_reserva_hospede_hospede ON Reserva_Hospede(id_hospede);

-- Dados de exemplo
INSERT INTO Quartos (numero, tipo) VALUES
('101', 'Duplo'),
('202', 'Família');

INSERT INTO Hospedes (nome, documento, telefone) VALUES
('Ana Souza', 'DOC001', '11999990001'),
('Bruno Lima', 'DOC002', '11999990002'),
('Carla Mendes', 'DOC003', '11999990003'),
('Daniel Alves', 'DOC004', '11999990004'),
('Eduarda Costa', 'DOC005', '11999990005');

INSERT INTO Reservas (id_quarto, data_entrada, data_saida) VALUES
(1, '2026-12-10', '2026-12-13'),
(2, '2026-12-15', '2026-12-20');

-- Reserva 1: dois hóspedes
INSERT INTO Reserva_Hospede (id_reserva, id_hospede, titular) VALUES
(1, 1, 1),
(1, 2, 0);

-- Reserva 2: cinco hóspedes (sem limite fixo de três)
INSERT INTO Reserva_Hospede (id_reserva, id_hospede, titular) VALUES
(2, 1, 1),
(2, 2, 0),
(2, 3, 0),
(2, 4, 0),
(2, 5, 0);

-- Consulta: hóspedes de cada reserva
SELECT
    r.id_reserva,
    q.numero AS quarto,
    r.data_entrada,
    r.data_saida,
    h.nome AS hospede,
    rh.titular
FROM Reservas r
JOIN Quartos q ON q.id_quarto = r.id_quarto
JOIN Reserva_Hospede rh ON rh.id_reserva = r.id_reserva
JOIN Hospedes h ON h.id_hospede = rh.id_hospede
ORDER BY r.id_reserva, rh.titular DESC, h.nome;

-- Consulta: quantidade de hóspedes por reserva
SELECT
    id_reserva,
    COUNT(*) AS quantidade_hospedes
FROM Reserva_Hospede
GROUP BY id_reserva;
