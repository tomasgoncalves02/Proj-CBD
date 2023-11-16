-- Criação da tabela Questions
CREATE TABLE Questions
(
  QuestionID INT IDENTITY(1,1) NOT NULL,
  Question VARCHAR(255) NOT NULL,
  PRIMARY KEY (QuestionID),
);


-- Executar a inserção de um registo na tabela Questions
INSERT INTO Questions (Question)
VALUES ('Qual é o nome do teu cão?');