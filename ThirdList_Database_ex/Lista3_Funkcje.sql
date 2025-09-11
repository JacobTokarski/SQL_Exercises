-- Zadanie 4

DROP FUNCTION IF EXISTS dbo.LiczbaPracownikowWDziale;
GO

CREATE FUNCTION dbo.LiczbaPracownikowWDziale (
    @DzialKod CHAR(3)
)
RETURNS INT
AS
BEGIN
    DECLARE @Liczba INT;

    SELECT @Liczba = COUNT(*)
    FROM Pracownik
    WHERE DzialKod = @DzialKod

    RETURN @Liczba;
END;
GO

SELECT dbo.LiczbaPracownikowWDziale('HR1') AS LiczbaPracowników;

-- Zadanie 5

DROP FUNCTION IF EXISTS dbo.CzasTrwaniaProjektu;
GO

CREATE FUNCTION dbo.CzasTrwaniaProjektu (
    @ProjektKod CHAR(5)
)
RETURNS INT
AS
BEGIN
    DECLARE @Dni INT;

    SELECT @Dni = DATEDIFF(DAY, DataRoz, ISNULL(DataZak, GETDATE())) -- jeœli DataZak jest Nullem to zamiast tego zostanie u¿yta dzisiejsza Data i do tego momentu liczona bêdzie funkcja
    FROM Projekt
    WHERE Kod = @ProjektKod;

    RETURN @Dni;
END;
GO

SELECT dbo.CzasTrwaniaProjektu('ICR30') AS CzasTrwaniaWDniach -- projekty , które maj¹ zakoñczenie ( datê zakoñczenia ) to ICR30 , YW477


SELECT * FROM Projekt

-- Zadanie 6


DROP FUNCTION IF EXISTS dbo.EmployeeDatav2;
GO

CREATE FUNCTION dbo.EmployeeDatav2 (
	@Nazwisko VARCHAR(50)
)
RETURNS TABLE -- zadeklarowanie zwrócenia tablicy
AS
RETURN
( 
	SELECT Pracownik.Imie, Pracownik.Nazwisko, Adres.Ulica , Adres.Miejscowosc, Adres.KodPocztowy , Adres.KrajKod, Adres.Typ, Dzial.Nazwa AS NazwaDzia³u, Oddzial.Nazwa AS NazwaOddzia³u
	FROM Pracownik
	JOIN Adres ON Pracownik.AdresId = Adres.Id
	JOIN Dzial ON Pracownik.DzialKod = Dzial.Kod
	JOIN Oddzial ON Pracownik.OddzialId = Oddzial.Id

	WHERE Nazwisko = @Nazwisko
);
GO

SELECT * FROM dbo.EmployeeDatav2('Spencley') AS DaneOU¿ytkowniku;