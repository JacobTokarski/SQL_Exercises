-- Zadanie 1

DROP PROCEDURE IF EXISTS EmployeeData;
GO

CREATE PROCEDURE EmployeeData
	@Nazwisko NVARCHAR(50)
AS
BEGIN
    SELECT Pracownik.Imie, Pracownik.Nazwisko, Adres.Ulica, Adres.Miejscowosc, Dzial.Kod, Dzial.Nazwa, Oddzial.Nazwa FROM Pracownik
	JOIN Dzial ON Pracownik.DzialKod = Dzial.Kod
	JOIN Adres ON Pracownik.AdresId = Adres.Id
	JOIN Oddzial ON Pracownik.OddzialId = Oddzial.Id
    WHERE Pracownik.Nazwisko = @Nazwisko;
END;
GO

EXEC EmployeeData @Nazwisko = 'Lamport';

SELECT Pracownik.Nazwisko from Pracownik

-- Zadanie 2 

DROP PROCEDURE IF EXISTS InsertNewEmployee;
GO

CREATE PROCEDURE InsertNewEmployee
    @Imie NVARCHAR(50),
    @Nazwisko NVARCHAR(50),
    @Ulica NVARCHAR(50),
    @Miejscowosc NVARCHAR(50),
    @KodPocztowy CHAR(10),
    @KrajKod CHAR(2),
    @Typ CHAR(1)
AS
BEGIN

	DECLARE @AdresId INT; -- deklaracja adresuId jako integrara

    BEGIN TRANSACTION;-- owa linia wraz z begin powoduje przywo³anie stanu sprzed rozpoczêcia procedury jeœli jeden z insertów siê nie uda

	BEGIN TRY

    INSERT INTO Adres (Ulica, Miejscowosc, KodPocztowy, KrajKod, Typ)
    VALUES (@Ulica, @Miejscowosc, @KodPocztowy, @KrajKod, @Typ);

    SET @AdresId = SCOPE_IDENTITY(); -- zwaraca Id ostatnio wstawionego rekordu w bie¿¹cym zakresie

    INSERT INTO Pracownik (Imie, Nazwisko, AdresId)
    VALUES (@Imie, @Nazwisko, @AdresId);

    COMMIT TRANSACTION;-- owa linia wraz z begin powoduje przywo³anie stanu sprzed rozpoczêcia procedury jeœli jeden z insertów siê nie uda
	
	END TRY

	BEGIN CATCH

	ROLLBACK;

	PRINT 'Wyst¹pi³ b³¹d dodawania danych.';

	END CATCH
END;
GO
	
EXEC InsertNewEmployee
    @Imie = 'Czarek',
    @Nazwisko = NULL, -- musi byæ wartoœæ NULL
    @Ulica = 'Sosnowa',
    @Miejscowosc = 'Legnica',
	@KodPocztowy = '5140-060',
	@KrajKod = 'PL',
	@Typ = 'P' -- taki typ zadeklarowany by³ w tej tabeli 
GO

SELECT * FROM Adres
SELECT * From Pracownik

-- Zadanie 3

DROP PROCEDURE IF EXISTS DeleteEmployeeData;
GO

CREATE PROCEDURE DeleteEmployeeData
    @PracownikId INT
AS
BEGIN

    DECLARE @AdresId INT;

	BEGIN TRANSACTION;

	BEGIN TRY

    SELECT @AdresId = AdresId
    FROM Pracownik
    WHERE Id = @PracownikId;

    DELETE FROM Projekt_Pracownik
    WHERE PracownikId = @PracownikId;

    UPDATE Pracownik
    SET SamochodId = NULL
    WHERE Id = @PracownikId;

    DELETE FROM Pracownik
    WHERE Id = @PracownikId;

	DELETE FROM Adres
    WHERE Id = @AdresId;

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH

	ROLLBACK;

	PRINT 'Wyst¹pi³ b³¹d podczas usuwania danych';

	END CATCH

END;
GO

EXEC DeleteEmployeeData @PracownikId = '40'

SELECT * FROM Pracownik
SELECT * FROM Projekt