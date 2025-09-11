
-- Procedura 1 -> Poka¿e tylko samochody typu Combi

DROP PROCEDURE IF Exists GetCombiCars
GO


CREATE PROCEDURE GetCombiCars
AS
BEGIN
    SELECT 
        Car.id,
        Car.brand,
        Car.model,
        Car.year_of_production,
        Car.registration_number,
		Car.description,
		Car.car_type_id,
		Car.car_category_id,
		Car.insurance_id
    FROM Car
    JOIN Car_type ON Car.car_type_id = Car_type.type
    WHERE Car_type.description = 'Combi';
END;
GO

EXEC GetCombiCars;

-- Procedura 2 -> Poka¿e tylko i wy³¹cznie niezakoñczone wypo¿yczenia

DROP PROCEDURE IF Exists GetActiveRentals
GO

CREATE PROCEDURE GetActiveRentals
AS
BEGIN
    SELECT 
        Rental.id,
        Rental.start_date,
        Rental.expiry_date,
		Rental.client_id,
        Rental.car_id,
		Rental.reservation_id,
		Rental.employee_id
    FROM Rental
    WHERE expiry_date >= GETDATE();
END;
GO

EXEC GetActiveRentals;
GO

-- Procedura 3 -> Poka¿e tylko i wy³¹cznie klientów o podanej pierwszej literze imienia

DROP PROCEDURE IF Exists GetClientsByNameInitial
GO

CREATE PROCEDURE GetClientsByNameInitial
    @Initial NCHAR(1)
AS
BEGIN
    SELECT *
    FROM Client
    WHERE name LIKE @Initial + '%';
END;
GO

EXEC GetClientsByNameInitial @Initial = 'K';




