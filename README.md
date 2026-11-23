# Hotelaria e Reservas – Tema 9

## Objetivo
Refatorar o banco de dados de um sistema de hotelaria, eliminando a limitação de três acompanhantes por reserva.

## Problema identificado
O banco antigo utilizava colunas fixas (`hospede_1`, `hospede_2` e `hospede_3`), gerando campos vazios e dificultando reservas de grupos maiores.

## Solução
Foram criadas tabelas separadas para hóspedes, quartos e reservas, além da tabela `Reserva_Hospede`, permitindo relacionar vários hóspedes a uma mesma reserva.

## Tecnologias
- SQL
- SQLite Online
- GitHub

## Arquivo
`hotelaria_tema9_SQLite.sql`

Contém a criação das tabelas, relacionamentos, índices, dados de exemplo e consultas.
