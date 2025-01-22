-- 1
SELECT nume, id_functie, salariul AS sal
FROM angajati;

-- 2
SELECT *
FROM departamente;

-- 3
SELECT *
FROM salariu;

-- 5
DESCRIBE Departamente;

SELECT *
FROM departamente;

-- 6
DESCRIBE Angajati;

-- 7
SELECT id_angajat, nume, id_functie, data_angajare AS "Lucrează din"
FROM angajati;

-- 8
SELECT id_angajat AS "Identificatorul", nume AS "Numele angajatului", id_functie AS "Funcția", data_angajare AS "Data angajarii"
FROM angajati;

-- 9
SELECT id_functie
FROM angajati;

SELECT DISTINCT id_functie
FROM angajati;

-- 10
SELECT CONCAT(nume, ', ', id_functie) AS `Angajat și funcție`
FROM Angajati;

-- 11
SELECT CONCAT_WS(', ', id_angajat, nume, prenume, email, telefon, data_angajare, id_functie, salariul, comision, id_manager, id_departament) AS `Informatii complete`
FROM angajati;

-- 12
SELECT *
FROM Angajati;

-- 13
SELECT id_angajat, nume, prenume, id_functie
FROM Angajati;

-- 14
SELECT nume, salariul
FROM Angajati
WHERE salariul > 12000;

-- 15
SELECT nume, id_departament
FROM Angajati
WHERE id_angajat = 176;

-- 16
SELECT nume, salariul
FROM Angajati
WHERE salariul NOT BETWEEN 5000 AND 12000;

-- 17
SELECT nume, id_functie, data_angajare
FROM Angajati
WHERE nume IN ('Matos', 'Taylor')
ORDER BY data_angajare;

-- 18
SELECT nume, id_departament
FROM Angajati
WHERE id_departament IN (20, 50)
ORDER BY nume;

-- 19
SELECT nume AS Angajat, salariul AS Salariu_lunar
FROM Angajati
WHERE salariul BETWEEN 5000 AND 12000 AND id_departament IN (20, 50);

-- 20
SELECT nume, id_functie, data_angajare
FROM Angajati
WHERE data_angajare BETWEEN '1987-02-20' AND '1989-05-01'
ORDER BY data_angajare;

-- 21
SELECT nume, data_angajare
FROM Angajati
WHERE data_angajare LIKE '1994%';

SELECT nume, data_angajare
FROM Angajati
WHERE YEAR(data_angajare) = 1994;

-- 22
SELECT nume, id_functie
FROM Angajati
WHERE id_manager IS NULL;

-- 23
SELECT nume, salariul, comision
FROM Angajati
WHERE comision IS NOT NULL
ORDER BY salariul DESC, comision DESC;

-- 24
SELECT nume, salariul, comision
FROM Angajati
ORDER BY salariul DESC, comision DESC;

-- 25
SELECT nume
FROM Angajati
WHERE nume LIKE '%a%' AND nume LIKE '%e%';

-- 26
SELECT nume
FROM Angajati
WHERE nume LIKE '__A%';

-- 27
SELECT nume
FROM Angajati
WHERE nume LIKE '%L%L%' AND (id_departament = 30 OR id_manager = 101);

-- 28
SELECT nume, id_functie, salariul
FROM Angajati
WHERE (id_functie LIKE '%clerk%' OR id_functie LIKE '%rep%') AND salariul NOT IN (2500, 3500, 7000);

-- 29
SELECT nume, salariul, comision
FROM Angajati
WHERE salariul > (salariul * comision * 5);

-- 30
SELECT *
FROM Angajati
WHERE id_functie LIKE '%CLERK%';

-- 31
SELECT *
FROM Comenzi
WHERE id_angajat = 161;

-- 32
SELECT *
FROM Comenzi
WHERE modalitate = 'online' AND data > '2000-01-01';

-- 33
SELECT a.id_angajat, a.nume, a.prenume, a.id_manager, a.id_departament, d.denumire_departament
FROM Angajati a
JOIN Departamente d ON a.id_departament = d.id_departament;

-- 34
SELECT CURDATE() AS 'Data curentă',
       DATE_FORMAT(NOW(), '%Y-%m-%d') AS 'YYYY-MM-DD',
       DATE_FORMAT(NOW(), '%d-%m-%Y') AS 'DD-MM-YYYY',
       DATE_FORMAT(NOW(), '%M %d, %Y') AS 'Luna zi, anul';

-- 35
SELECT id_angajat, nume, salariul, 
       ROUND(salariul * 1.155) AS 'Salariu majorat'
FROM Angajati;

-- 36
SELECT id_angajat, nume, salariul, 
       ROUND(salariul * 1.155) AS 'Salariu majorat',
       ROUND(salariul * 1.155) - salariul AS 'Majorare'
FROM Angajati;

-- 37
SELECT UPPER(nume) AS 'Numele', 
       LENGTH(nume) AS 'Lungimea'
FROM Angajati
WHERE nume LIKE 'J%' OR nume LIKE 'A%' OR nume LIKE 'M%'
ORDER BY nume;

-- 38
SELECT CONCAT(prenume, ' ', nume, ' castiga ', salariul, ' lunar dar doreste ', salariul * 3) AS 'Salariu ideal'
FROM Angajati;

-- 39
SELECT CONCAT(UCASE(LEFT(prenume, 1)), LCASE(SUBSTRING(prenume, 2))) AS 'Prenume', 
       UPPER(nume) AS 'Nume',
       LENGTH(nume) AS 'Lungime Nume'
FROM Angajati
WHERE nume LIKE 'J%' OR nume LIKE 'M%' OR nume LIKE '__A%'
ORDER BY LENGTH(nume) DESC;

SELECT CONCAT(UCASE(LEFT(prenume, 1)), LCASE(SUBSTRING(prenume, 2))) AS 'Имя', 
       UPPER(nume) AS 'Фамилия',
       LENGTH(nume) AS 'Длина фамилии'
FROM Angajati
WHERE SUBSTR(nume, 1, 1) = 'J' OR SUBSTR(nume, 1, 1) = 'M' OR SUBSTR(nume, 3, 1) = 'A'
ORDER BY LENGTH(nume) DESC;

-- 40
SELECT id_angajat, nume, id_departament
FROM Angajati
WHERE TRIM(LOWER(prenume)) = 'steven';

-- 41
SELECT id_angajat AS 'Код', 
       nume AS 'Фамилия', 
       LENGTH(nume) AS 'Длина фамилии', 
       INSTR(nume, 'a') AS 'Позиция'
FROM Angajati
WHERE nume LIKE '%e';

-- 42
SELECT id_angajat, nume, salariul, FLOOR(DATEDIFF(CURDATE(), data_angajare) / 7) AS 'Недели'
FROM Angajati
WHERE DATEDIFF(CURDATE(), data_angajare) % 7 = 0;

-- 43
SELECT id_angajat, nume, salariul, 
       ROUND(salariul * 1.15, 2) AS 'Новая зарплата',
       ROUND(salariul * 1.15 / 100, 2) AS 'Количество сотен'
FROM Angajati
WHERE salariul % 1000 != 0;

-- 44
SELECT nume AS 'Фамилия сотрудника', 
       RPAD(DATE_FORMAT(data_angajare, '%Y-%m-%d'), 15, ' ') AS 'Дата найма'
FROM Angajati
WHERE comision IS NOT NULL;

-- 45
SELECT nume, 
       CEIL(TIMESTAMPDIFF(MONTH, data_angajare, CURDATE())) AS 'MONTHS_WORKED'
FROM Angajati
ORDER BY MONTHS_WORKED;

-- 46
SELECT DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 30 DAY), '%M %d, %Y %H:%i:%s') AS 'Дата через 30 дней';

-- 47
SELECT DATEDIFF(CONCAT(YEAR(CURDATE()), '-12-31'), CURDATE()) AS 'Осталось дней';

-- 48
SELECT DATE_ADD(NOW(), INTERVAL 12 HOUR) AS 'Дата через 12 часов';

SELECT DATE_ADD(NOW(), INTERVAL 5 MINUTE) AS 'Дата через 5 минут';

-- 49
SELECT CONCAT(prenume, ' ', nume) AS 'ФИО', 
       data_angajare AS 'Дата найма', 
       DATE_ADD(DATE_ADD(data_angajare, INTERVAL 6 MONTH), INTERVAL (7 - WEEKDAY(DATE_ADD(data_angajare, INTERVAL 6 MONTH))) DAY) AS 'Переговоры'
FROM Angajati;

-- 50
SELECT nume, 
       ROUND(TIMESTAMPDIFF(MONTH, data_angajare, CURDATE())) AS 'Отработанные месяцы'
FROM Angajati
ORDER BY 'Отработанные месяцы';

-- 51
SELECT nume, 
       data_angajare AS 'Дата найма', 
       CASE
           WHEN DAYOFWEEK(data_angajare) = 1 THEN 'Воскресенье'
           WHEN DAYOFWEEK(data_angajare) = 2 THEN 'Понедельник'
           WHEN DAYOFWEEK(data_angajare) = 3 THEN 'Вторник'
           WHEN DAYOFWEEK(data_angajare) = 4 THEN 'Среда'
           WHEN DAYOFWEEK(data_angajare) = 5 THEN 'Четверг'
           WHEN DAYOFWEEK(data_angajare) = 6 THEN 'Пятница'
           WHEN DAYOFWEEK(data_angajare) = 7 THEN 'Суббота'
       END AS 'День'
FROM Angajati
ORDER BY FIELD(DAYOFWEEK(data_angajare), 2, 3, 4, 5, 6, 7, 1);

-- 52
SELECT nume, 
       IFNULL(CONCAT(comision, ''), 'Без комиссионных') AS 'Комиссионные'
FROM Angajati;

-- 53
SELECT nume, salariul, comision
FROM Angajati
WHERE (salariul + IFNULL(comision, 0)) > 10000;

-- 54
SELECT nume, 
       id_functie, 
       salariul, 
       CASE 
           WHEN id_functie = 'IT_PROG' THEN salariul * 1.20
           WHEN id_functie = 'SA_REP' THEN salariul * 1.25
           WHEN id_functie = 'SA_MAN' THEN salariul * 1.35
           ELSE salariul
       END AS 'Пересмотренная зарплата'
FROM Angajati;

-- 55
SELECT id_angajat, prenume, id_functie, salariul
FROM Angajati
WHERE id_functie != 'IT_PROG'
AND salariul < (SELECT MIN(salariul) FROM Angajati WHERE id_functie = 'IT_PROG');

-- 57
SELECT * 
FROM comenzi 
WHERE ID_ANGAJAT IS NOT NULL;

-- 58
SELECT c.* 
FROM comenzi c
JOIN angajati a ON c.ID_ANGAJAT = a.ID_ANGAJAT
WHERE a.NUME = 'Greene' AND MONTH(c.DATA) = 11;

-- 59
SELECT p.DENUMIRE_PRODUS, r.PRET, r.CANTITATE, (r.CANTITATE * r.PRET) AS VALOARE
FROM rand_comenzi r
JOIN produse p ON r.ID_PRODUS = p.ID_PRODUS;

-- 60
SELECT p.DENUMIRE_PRODUS, r.PRET, r.CANTITATE, (r.CANTITATE * r.PRET) AS VALOARE
FROM rand_comenzi r
JOIN produse p ON r.ID_PRODUS = p.ID_PRODUS
HAVING VALOARE BETWEEN 1000 AND 2000;

-- 61
SELECT p.ID_PRODUS, p.DENUMIRE_PRODUS, COALESCE(COUNT(c.ID_PRODUS), 0) AS NUMAR_CUMPARARI
FROM produse p
LEFT JOIN rand_comenzi c ON p.ID_PRODUS = c.ID_PRODUS
GROUP BY p.DENUMIRE_PRODUS, p.ID_PRODUS
ORDER BY NUMAR_CUMPARARI DESC;

-- 62 
SELECT a.NUME AS 'Angajat', 
             (SELECT b.NUME 
              FROM angajati b 
              WHERE b.ID_ANGAJAT = a.ID_MANAGER) AS 'Seful direct superior'
FROM angajati a;

-- 63 
SELECT a1.*
FROM angajati a1
WHERE a1.ID_DEPARTAMENT = (SELECT a2.ID_DEPARTAMENT 
                            FROM angajati a2 
                            WHERE a2.NUME = 'Smith' 
                            LIMIT 1);

-- 64
SELECT * 
FROM produse 
WHERE PRET_LISTA = (SELECT MIN(PRET_LISTA) 
                    FROM produse);

-- 65
SELECT a.NUME AS Nume_Angajat, 
       a.ID_DEPARTAMENT, 
       d.DENUMIRE_DEPARTAMENT
FROM angajati a
JOIN departamente d ON a.ID_DEPARTAMENT = d.ID_DEPARTAMENT;

-- 66
SELECT DISTINCT f.DENUMIRE_FUNCTIE
FROM functii f
JOIN angajati a ON f.ID_FUNCTIE = a.ID_FUNCTIE
WHERE a.ID_DEPARTAMENT = 30;

-- 67
SELECT a.NUME AS Nume_Angajat, 
       d.DENUMIRE_DEPARTAMENT, 
       l.ORAS
FROM angajati a
JOIN departamente d ON a.ID_DEPARTAMENT = d.ID_DEPARTAMENT
JOIN locatii l ON d.ID_LOCATIE = l.ID_LOCATIE
WHERE a.COMISION > 0;

-- 68
SELECT a.NUME AS Nume_Angajat, 
       d.DENUMIRE_DEPARTAMENT
FROM angajati a
JOIN departamente d ON a.ID_DEPARTAMENT = d.ID_DEPARTAMENT
WHERE a.NUME LIKE '%A%';

-- 69
SELECT a.NUME AS Nume_Angajat, 
       f.DENUMIRE_FUNCTIE AS Job, 
       d.ID_DEPARTAMENT, 
       d.DENUMIRE_DEPARTAMENT
FROM angajati a
JOIN functii f ON a.ID_FUNCTIE = f.ID_FUNCTIE
JOIN departamente d ON a.ID_DEPARTAMENT = d.ID_DEPARTAMENT
JOIN locatii l ON d.ID_LOCATIE = l.ID_LOCATIE
WHERE l.ORAS = 'Oxford';

-- 70
SELECT a1.ID_ANGAJAT AS "Ang#", 
       a1.NUME AS Angajat, 
       a2.ID_ANGAJAT AS "Mgr#", 
       a2.NUME AS Manager
FROM angajati a1
LEFT JOIN angajati a2 ON a1.ID_MANAGER = a2.ID_ANGAJAT;

-- 71
SELECT a1.ID_ANGAJAT AS "Ang#", 
            a1.NUME AS Angajat, 
            a2.ID_ANGAJAT AS "Mgr#", 
            a2.NUME AS Manager
FROM angajati a1
LEFT JOIN angajati a2 ON a1.ID_MANAGER = a2.ID_ANGAJAT;

-- 72 
SELECT e1.NUME AS Nume_Angajat, 
            e1.ID_DEPARTAMENT AS Cod_Departament, 
            e2.NUME AS Coleg_Angajat
FROM angajati e1
JOIN angajati e2 ON e1.ID_DEPARTAMENT = e2.ID_DEPARTAMENT
WHERE e1.ID_ANGAJAT <> e2.ID_ANGAJAT;

-- 73
SELECT a.NUME AS Nume_Angajat, 
            a.ID_FUNCTIE AS Cod_Functie, 
            f.DENUMIRE_FUNCTIE AS Titlu_Functie, 
            d.DENUMIRE_DEPARTAMENT, 
            a.SALARIUL
FROM angajati a
JOIN functii f ON a.ID_FUNCTIE = f.ID_FUNCTIE
JOIN departamente d ON a.ID_DEPARTAMENT = d.ID_DEPARTAMENT;

-- 74
SELECT a.NUME, 
            a.DATA_ANGAJARE
FROM angajati a
WHERE a.DATA_ANGAJARE > (SELECT DATA_ANGAJARE FROM angajati WHERE NUME = 'Gates');

-- 75 
SELECT a1.NUME AS Angajat, a1.DATA_ANGAJARE AS Data_ang, 
       a2.NUME AS Manager, a2.DATA_ANGAJARE AS Data_mgr
FROM angajati a1
JOIN angajati a2 ON a1.ID_MANAGER = a2.ID_ANGAJAT
WHERE a1.DATA_ANGAJARE < a2.DATA_ANGAJARE;
