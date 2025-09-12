-- Zadanie 1

SELECT CONCAT(LEFT(imie, 1), '.', Nazwisko) as Osoba
FROM Pracownik
ORDER BY Nazwisko ASC

-- Zadanie 2

SELECT Pracownik.Imie, Pracownik.Nazwisko, Adres.Miejscowosc
FROM Pracownik
JOIN Adres ON Pracownik.AdresId = Adres.Id
WHERE Miejscowosc LIKE 'B%'

-- Zadanie 3
 

 SELECT Pracownik.Imie ,Pracownik.Nazwisko, Pracownik.KierownikId , Dzial.Kod
 FROM Pracownik
 JOIN Dzial ON Pracownik.DzialKod = Dzial.Kod
 WHERE DzialKod = 'RD1'


-- Zadanie 4

SELECT Pracownik.Imie , Pracownik.Nazwisko, Samochod.NrRejestr
FROM Pracownik
JOIN Samochod ON Pracownik.Id = Samochod.PracownikId

-- Zadanie 5

SELECT Projekt.Nazwa AS 'Nazwa projektu', COUNT(Pracownik.Id) AS 'Iloœæ pracowników przypisanych do projektu'
FROM Projekt
JOIN Projekt_Pracownik ON Projekt.Kod = Projekt_Pracownik.ProjektKod
JOIN Pracownik ON Projekt_Pracownik.PracownikId = Pracownik.Id
GROUP BY Projekt.Nazwa

-- Zadanie 6

SELECT Kraj.Kod AS 'Kod kraju', COUNT(Pracownik.Id) AS 'Liczba pracowników zamieszkuj¹ycych w danym kraju' 
FROM Pracownik
JOIN Adres ON Pracownik.AdresId = Adres.Id
JOIN Kraj ON Adres.KrajKod = Kraj.Kod
GROUP BY Kraj.Kod

-- Zadanie 7

SELECT Pracownik.Imie, Pracownik.Nazwisko , Dzial.Nazwa , Pracownik.SamochodId
FROM Pracownik
JOIN Dzial ON Pracownik.DzialKod = Dzial.Kod
WHERE Pracownik.SamochodId IS NULL;



-- Zadanie 8

SELECT DISTINCT Projekt.Kod, Pracownik.Nazwisko
FROM Pracownik
JOIN Projekt_Pracownik ON Pracownik.Id = Projekt_Pracownik.PracownikId
JOIN Projekt ON Projekt_Pracownik.ProjektKod = Projekt.Kod

-- Zadanie 9

SELECT DISTINCT Dzial.Kod, Adres.Miejscowosc, Pracownik.Imie, Pracownik.Nazwisko 
FROM Pracownik
JOIN Dzial ON Pracownik.DzialKod = Dzial.Kod
JOIN Oddzial ON Pracownik.OddzialId = Oddzial.id
JOIN Adres ON Oddzial.AdresId = Adres.Id

-- Zadanie 10

SELECT Pracownik.Imie, Pracownik.Nazwisko, Oddzial.Nazwa, Samochod.Marka , Samochod.Model, Samochod.NrRejestr
FROM Pracownik
JOIN Samochod ON Pracownik.SamochodId = Samochod.Id
JOIN Oddzial ON Pracownik.OddzialId = Oddzial.Id