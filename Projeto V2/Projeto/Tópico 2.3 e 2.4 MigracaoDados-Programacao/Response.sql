-- Criação da tabela Response
CREATE TABLE Response
(
  ResponseID INT IDENTITY(1,1) NOT NULL,
  Response VARCHAR(255) NOT NULL,
  QuestionID INT
  PRIMARY KEY (ResponseID),
  FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);


-- Executar a inserção de um registo na tabela Response
INSERT INTO Response (Response, QuestionID)
VALUES ('Billy', 1);




