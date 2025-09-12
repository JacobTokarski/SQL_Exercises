-- Widok 1 -> Szybki wgl¹d w aktualne wypo¿yczenia z informacjami o samochodzie i kliencie

DROP VIEW IF EXISTS ActiveRentalsWithCarAndClient;
GO

CREATE VIEW ActiveRentalsWithCarAndClient AS
SELECT 
    Rental.id,
    Rental.start_date,
    Rental.expiry_date,
    Car.brand,
    Car.model,
    Car.registration_number,
    Client.name,
    Client.surname,
    Client.phone_number
FROM Rental
JOIN Car ON Rental.Car_id = Car.id
JOIN Client ON Rental.Client_id = Client.id
WHERE Rental.expiry_date >= GETDATE();
GO

SELECT * FROM ActiveRentalsWithCarAndClient;
GO

-- Widok 2 -> Szybka filtracja ubezpieczeñ przypisanych do samochodu , jego typu nadwozia oraz jednostki napêdowej

DROP VIEW IF EXISTS CarDetailsWithCategoryAndInsurance;
GO

CREATE VIEW CarDetailsWithCategoryAndInsurance AS
SELECT 
    Car.id,
    Car.brand,
    Car.model,
    Car.year_of_production,
    Car.registration_number,
    Car_category.description AS CategoryDescription,
    Car_type.description AS TypeDescription,
    Insurance.company,
    Insurance.number_of_policy,
    Insurance.Insurance_start_date,
    Insurance.Insurance_end_date
FROM Car
LEFT JOIN Car_category ON Car.car_category_id = Car_category.category
LEFT JOIN Car_type ON Car.car_type_id = Car_type.type
LEFT JOIN Insurance ON Car.insurance_id = Insurance.id;
GO

SELECT * FROM CarDetailsWithCategoryAndInsurance;
GO

-- Widok 3 -> Historia wszystkich wypo¿yczeñ danego samochodu wraz z informacj¹ o kliencie

DROP VIEW IF EXISTS RentalHistoryForCars;
GO

CREATE VIEW RentalHistoryForCars AS
SELECT 
    Rental.id AS RentalID,
    Car.id AS CarID,
    Car.brand,
    Car.model,
    Rental.start_date,
    Rental.expiry_date,
    Client.name AS ClientName,
    Client.surname AS ClientSurname
FROM Rental
JOIN Car ON Rental.car_id = Car.id
JOIN Client ON Rental.client_id = Client.id;
GO

SELECT * FROM RentalHistoryForCars;
GO

-- Widok 4 -> Przedstawia dokonane p³atnoœci rozszerzone o informacje o kliencie oraz samochodzie z którego korzysta³

DROP VIEW IF EXISTS PaymentDetailsWithCarAndClient;
GO

CREATE VIEW PaymentDetailsWithCarAndClient AS
SELECT 
    Payment.id AS PaymentID,
    Payment.date AS PaymentDate,
    Payment.cost,
    Payment.payment_form,
    Car.brand AS CarBrand,
    Car.model AS CarModel,
    Client.name AS ClientName,
    Client.surname AS ClientSurname
FROM Payment
JOIN Rental ON Payment.rental_id = Rental.id
JOIN Car ON Rental.car_id = Car.id
JOIN Client ON Rental.client_id = Client.id;
GO

SELECT * FROM PaymentDetailsWithCarAndClient;
GO
