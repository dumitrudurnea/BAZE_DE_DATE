-- Crearea tabelului firme
CREATE TABLE firme (
    codfirma INT PRIMARY KEY,
    denfirma VARCHAR(20) NOT NULL,
    loc VARCHAR(20),
    zona VARCHAR(15)
);

-- Crearea tabelului agenti
CREATE TABLE agenti (
    codagent VARCHAR(3) PRIMARY KEY,
    numeagent VARCHAR(25) NOT NULL,
    dataang DATE DEFAULT (CURRENT_DATE),
    datanast DATE,
    functia VARCHAR(20),
    codfirma INT,
    FOREIGN KEY (codfirma) REFERENCES firme(codfirma)
);

---------------------------------------------------

-- Creare tabel fosti_agenti
CREATE TABLE fosti_agenti AS
SELECT codagent, numeagent, functia, codfirma
FROM agenti;

-- Schimbarea numelui tabelului agenti în personal
RENAME TABLE agenti TO personal;

-- Adăugarea unei noi coloane pentru email și vârstă
ALTER TABLE personal
ADD COLUMN email VARCHAR(50),
ADD COLUMN varsta INT;

-- Modificarea tipului de date al coloanei email
ALTER TABLE personal
MODIFY COLUMN email TEXT;

-- Ștergerea coloanei email
ALTER TABLE personal
DROP COLUMN email;

-- Ștergerea coloanei functia
ALTER TABLE personal
DROP COLUMN functia;

-- Adăugarea unei constrângeri pentru vârstă
ALTER TABLE personal
ADD CONSTRAINT check_varsta CHECK (varsta >= 18 AND varsta <= 65);

-- Eliminarea constrângerii de vârstă
ALTER TABLE personal
DROP CHECK check_varsta;

-- Ștergerea tabelului fosti_agenti
DROP TABLE fosti_agenti;

-- Golirea conținutului tabelului personal
TRUNCATE TABLE personal;

-----------------------------------------------

-- Crearea tabelului salariati
CREATE TABLE salariati LIKE angajati;

-- Inserarea unui nou angajat
INSERT INTO salariati (codagent, numeagent, dataang, datanast, functia, codfirma)
VALUES ('001', 'Ion Popescu', CURDATE(), '1990-05-25', 'Manager', 1);

-- Copierea anumitor înregistrări din angajati în salariati
INSERT INTO salariati (ID_ANGAJAT, PRENUME, NUME, EMAIL, TELEFON, DATA_ANGAJARE, ID_FUNCTIE, SALARIUL, COMISION, ID_MANAGER, ID_DEPARTAMENT)
SELECT ID_ANGAJAT, PRENUME, NUME, EMAIL, TELEFON, DATA_ANGAJARE, ID_FUNCTIE, SALARIUL, COMISION, ID_MANAGER, ID_DEPARTAMENT
FROM angajati
WHERE ID_DEPARTAMENT IN (20, 30, 50);

-- Confirmarea modificărilor
COMMIT;

-- Creșterea salariilor mai mici de 3000
UPDATE salariati
SET SALARIUL = SALARIUL + 100
WHERE SALARIUL < 3000;

-- Sincronizarea salariului unui angajat
UPDATE salariati s
JOIN angajati a ON a.ID_ANGAJAT = 125
SET s.SALARIUL = a.SALARIUL
WHERE s.ID_MANAGER = 122;

-- Stocarea salariului unui angajat într-o variabilă
SELECT SALARIUL INTO @salary_173
FROM angajati
WHERE ID_ANGAJAT = 173;

-- Actualizarea salariilor și comisioanelor pentru anumiți angajați
UPDATE salariati s
JOIN angajati a ON a.ID_ANGAJAT = 167
SET s.SALARIUL = a.SALARIUL, s.COMISION = a.COMISION
WHERE s.SALARIUL < @salary_173
AND s.ID_DEPARTAMENT = 50;

-- Ștergerea angajaților cu ID_MANAGER 122 sau 123
DELETE FROM salariati
WHERE ID_MANAGER = 122 OR ID_MANAGER = 123;

-- Ștergerea angajaților angajați înainte de 2016
DELETE FROM salariati
WHERE YEAR(DATA_ANGAJARE) < 2016;
