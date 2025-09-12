-- Procedura 1 -> Dodawanie klienta

DROP PROCEDURE IF EXISTS InsertClient;
GO

CREATE PROCEDURE InsertClient
    @Name nchar(15),
    @Surname nchar(15),
    @PhoneNumber VARCHAR(15),
    @RegistrationNumber VARCHAR(15),
    @Client_grade_Id INT
AS
BEGIN
    INSERT INTO Client (name, surname, phone_number, registration_number, client_grade_Id) 
    VALUES (@Name, @Surname, @PhoneNumber, @RegistrationNumber, @Client_grade_Id);
END;
GO

EXEC InsertClient
@Name = 'Jan',
@Surname = 'Zimnica',
@PhoneNumber = '456234871',
@RegistrationNumber = '0673/22/191',
@Client_grade_Id = 1;
GO

-- Procedura 2 -> Aktualizowanie klientów

DROP PROCEDURE IF EXISTS UpdateClient;
GO

CREATE PROCEDURE UpdateClient
    @Id INT,
    @Name nchar(15),
    @Surname nchar(100),
    @PhoneNumber VARCHAR(15),
    @RegistrationNumber VARCHAR(15),
    @Client_grade_Id INT
AS
BEGIN
    UPDATE Client
    SET 
        name = @Name,
        surname = @Surname,
        phone_number = @PhoneNumber,
        registration_number = @RegistrationNumber,
        client_grade_Id = @Client_grade_Id
    WHERE id = @Id;
END;
GO

EXEC UpdateClient
@Id = 6,
@Name = 'Jan',
@Surname = 'Marsza³ek',
@PhoneNumber = '456239871',
@RegistrationNumber = '0567/22/181',
@Client_grade_Id = 2;
GO

-- Procedura 3 -> Usuwanie klienta

DROP PROCEDURE IF EXISTS DeleteClient;
GO

CREATE PROCEDURE DeleteClient
    @ClientID INT
AS
BEGIN
    DELETE FROM Client
    WHERE id = @ClientID;
END;
GO

EXEC DeleteClient @ClientID = 6;
GO

-- Procedura 4 -> Wprowadzenie nowego wypo¿yczenia

DROP PROCEDURE IF EXISTS InsertRental;
GO

CREATE PROCEDURE InsertRental
    @Start_date DATE,
    @Expiry_date DATE,
    @Client_Id INT,
    @Car_Id INT,
    @Reservation_Id INT,
    @Employee_Id INT
AS
BEGIN
    INSERT INTO Rental (start_date, expiry_date, client_id, car_id, reservation_id, employee_id)
    VALUES (@Start_date, @Expiry_date, @Client_Id, @Car_Id, @Reservation_Id, @Employee_Id);
END;
GO

EXEC InsertRental
@Start_date = '2025-08-04',
@Expiry_date = '2025-08-15',
@Client_Id = 4,
@Car_Id =  13,
@Reservation_id = 2,
@Employee_Id = 3;
GO

-- Procedura 5 -> Aktualizowanie informacji dotycz¹cych wypo¿yczeñ

DROP PROCEDURE IF EXISTS UpdateRental;
GO

CREATE PROCEDURE UpdateRental
    @Id INT,
    @Start_date DATE,
    @Expiry_date DATE,
    @Client_Id INT,
    @Car_Id INT,
    @Reservation_Id INT,
    @Employee_Id INT
AS
BEGIN
    UPDATE Rental
    SET 
        start_date = @Start_date,
        expiry_date = @Expiry_date,
        client_id = @Client_Id,
        car_id = @Car_Id,
        reservation_id = @Reservation_Id,
        employee_id = @Employee_Id
    WHERE id = @Id;
END;
GO

EXEC UpdateRental
@Id = 6,
@Start_date = '2025-09-05',
@Expiry_date = '2025-09-17',
@Client_Id = 3,
@Car_Id =  11,
@Reservation_id = 1,
@Employee_Id = 2;
GO

-- Procedura 6 -> Usuwanie wypo¿yczenia

DROP PROCEDURE IF EXISTS DeleteRental;
GO

CREATE PROCEDURE DeleteRental
    @RentalID INT
AS
BEGIN
    DELETE FROM Rental
    WHERE id = @RentalID;
END;
GO

EXEC DeleteRental
@RentalID = 6;
GO

-- Procedura 7 -> Wprowadzenie nowego samochodu

DROP PROCEDURE IF EXISTS InsertCar;
GO

CREATE PROCEDURE InsertCar
    @Brand VARCHAR(50),
    @Model VARCHAR(50),
    @Year_of_production char(4),
    @Registration_Number VARCHAR(12),
    @Description VARCHAR(256),
    @Car_type_Id VARCHAR(3),
    @Car_category_Id VARCHAR(3),
    @Insurance_Id INT
AS
BEGIN
    INSERT INTO Car (brand, model, year_of_production, registration_number, description, car_type_id, car_category_id, insurance_id)
    VALUES (@Brand, @Model, @Year_of_production, @Registration_Number, @Description, @Car_type_Id, @Car_category_Id, @Insurance_Id);
END;
GO

EXEC InsertCar
@Brand = 'Mithsubishi',
@Model = 'Colt',
@Year_of_production = '2023',
@Registration_Number = 'DW-B89A3',
@Description = 'Zwinny crossover miejski o solidnym wykonaniu i niskim zu¿yciu paliwa.”',
@Car_type_Id = 'CRO',
@Car_category_Id = 'P',
@Insurance_Id = 5;
GO

-- Procedura 8 -> Aktualizacja informacji o samochodzie 

DROP PROCEDURE IF EXISTS UpdateCar;
GO

CREATE PROCEDURE UpdateCar
    @Id INT,
    @Brand VARCHAR(50),
    @Model VARCHAR(50),
    @Year_of_production char(4),
    @Registration_Number VARCHAR(12),
    @Description VARCHAR(256),
    @Car_type_Id VARCHAR(3),
    @Car_category_Id VARCHAR(3),
    @Insurance_Id INT
AS
BEGIN
    UPDATE Car
    SET 
        brand = @Brand,
        model = @Model,
        year_of_production = @Year_of_production,
        registration_number = @Registration_Number,
        description = @Description,
        car_type_id = @Car_type_Id,
        car_category_id = @Car_category_Id,
        insurance_id = @Insurance_Id
    WHERE id = @Id;
END;
GO

EXEC UpdateCar
@Id = 16,
@Brand = 'Volvo',
@Model = 'XC60',
@Year_of_production = '2022',
@Registration_Number = 'KR-MN871',
@Description = 'Nowoczesny SUV klasy premium z naciskiem na bezpieczeñstwo i komfort jazdy.',
@Car_type_Id = 'SUV',
@Car_category_Id = 'P',
@Insurance_Id = 3;
GO

-- Procedura 9 -> Usuniêcie samochodu

DROP PROCEDURE IF EXISTS DeleteCar;
GO

CREATE PROCEDURE DeleteCar
    @CarID INT
AS
BEGIN
    DELETE FROM Car
    WHERE id = @CarID;
END;
GO

EXEC DeleteCar
@CarID = 16;
GO
