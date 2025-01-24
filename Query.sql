
/*DROP TABLE IF EXISTS autori;
DROP TABLE IF EXISTS cercetatori;
DROP TABLE IF EXISTS Universitate;
DROP TABLE IF EXISTS articole;

CREATE TABLE articole (
    idarticol INT PRIMARY KEY,
    denarticol VARCHAR(100)
);

CREATE TABLE Universitate (
    iduniversitate INT PRIMARY KEY,
    denuniversitate VARCHAR(10)
);

CREATE TABLE cercetatori (
    idcercetator INT PRIMARY KEY,
    numecercetator VARCHAR(50) NOT NULL,
    iduniversitate INT,
    FOREIGN KEY (iduniversitate) REFERENCES Universitate(iduniversitate)
);

CREATE TABLE autori (
    idcercetator INT,
    idarticol INT,
    PRIMARY KEY (idcercetator, idarticol),
    FOREIGN KEY (idcercetator) REFERENCES cercetatori(idcercetator),
    FOREIGN KEY (idarticol) REFERENCES articole(idarticol)
);

INSERT INTO articole (idarticol, denarticol) VALUES
(1, 'Articol despre tehnologie'),
(2, 'Cercetare in inteligen?a artificiala'),
(3, 'Studii de fizica teoretica');

INSERT INTO Universitate (iduniversitate, denuniversitate) VALUES
(1, 'UPB'),      -- Universitatea Politehnica din Bucure?ti
(2, 'UBB'),      -- Universitatea Babe?-Bolyai din Cluj-Napoca
(3, 'UAIC');     -- Universitatea Alexandru Ioan Cuza din Iasi
INSERT INTO cercetatori (idcercetator, numecercetator, iduniversitate) VALUES
(1, 'Ion Popescu', 1),   -- Ion Popescu de la UPB
(2, 'Maria Ionescu', 2), -- Maria Ionescu de la UBB
(3, 'George Vasilescu', 3); -- George Vasilescu de la UAIC
INSERT INTO autori (idcercetator, idarticol) VALUES
(1, 1),   -- Ion Popescu a scris Articolul 1
(1, 2),   -- Ion Popescu a scris Articolul 2
(2, 1),   -- Maria Ionescu a scris Articolul 1
(3, 3);   -- George Vasilescu a scris Articolul 3


DELIMITER $$
CREATE PROCEDURE proc1(IN p_idcer INT)
BEGIN
    SELECT a.denarticol
    FROM articole a
    INNER JOIN autori au ON a.idarticol = au.idarticol
    WHERE au.idcercetator = p_idcer
    ORDER BY a.denarticol;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE proc2(IN p_idcer INT)
BEGIN
    SELECT c.numecercetator, a.denarticol
    FROM cercetatori c
    INNER JOIN autori au ON c.idcercetator = au.idcercetator
    INNER JOIN articole a ON a.idarticol = au.idarticol
    WHERE c.idcercetator = p_idcer
    ORDER BY a.denarticol;
END $$

DELIMITER ;




DELIMITER $$

CREATE OR REPLACE  FUNCTION func1 (p_idc INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE univ VARCHAR(10);

    -- Selectam denumirea universita?ii in variabila univ
    SELECT denuniversitate
    INTO univ
    FROM universitate AS u
    INNER JOIN cercetatori AS c ON u.idcercetatori = c.iduniversitate
    WHERE c.idcercetator = p_idc;  
    RETURN univ;
END $$
lipavel
DELIMITER ;

SELECT func1(1);*/

delimiter $$

CREATE TRIGGER trig_update 
BEFORE INSERT 
ON autori
FOR EACH ROW
BEGIN 
 UPDATE cercetatori SET numar_articole = numar_articole + 1 WHERE idcercetator = NEW.idcercetator;
END; $$

delimiter ;

delimiter $$

CREATE TRIGGER trig_delete
AFTER DELETE 
ON autori
FOR EACH ROW 
BEGIN
	UPDATE cercetatori SET numar_articole = numar_articole - 1 WHERE idcercetator = OLD.idcercetator;
END; $$	

delimiter ;

delimiter $$

CREATE TRIGGER trig_update2
AFTER UPDATE 
ON autori 
FOR EACH ROW 
BEGIN 
	if (NEW.idcercetator <>  OLD.idcercetator) then
		UPDATE cercetatori 
		SET numar_articole = numar_articole - 1 WHERE idcercetator = OLD.idcercetator;
		UPDATE cercetatori 
		SET numar_articole = numar_artciole + 1 WHERE idcercetator = NEW.idcercetator;
	endif;
END; $$

delimiter ; 

delimiter $$

CREATE or replace PROCEDURE get_articole_cercetatori1 (IN id_universitate INT)
BEGIN 
	SELECT c.idcercetator, c.numecercetator, art.idarticol, art.denarticol, iduniversitate
	FROM cercetatori c 
	JOIN autori a ON c.idcercetator = a.idcercetator
	JOIN articole art ON a.idarticol = art.idarticol
	WHERE c.iduniversitate = id_universitate;
END; $$ 

delimiter ; 

CALL get_articole_cercetatori1(2);

delimiter $$

CREATE or replace FUNCTION nr_cercetatori_univ (den_universitate VARCHAR(25))
RETURNS INT
BEGIN 
	DECLARE nr_cer INT;
	
	SELECT COUNT(*) INTO nr_cer
	FROM cercetatori AS c 
	JOIN universitate AS u 
	ON c.iduniversitate = u.iduniversitate 
	WHERE u.denuniversitate = den_universitate;

	RETURN nr_cer;
END; $$

delimiter ;

SELECT nr_cercetatori_univ('UBB')