--Identificação: 202100744_202100728
-- Criação da tabela Response
CREATE TABLE Response
(
  ResponseID INT IDENTITY(1,1) NOT NULL,
  Response VARCHAR(255) NOT NULL,
  QuestionID INT
  PRIMARY KEY (ResponseID),
  FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);


-- inserção de um registo na tabela Response
INSERT INTO Response (Response, QuestionID)
VALUES ('Billy', 1);




