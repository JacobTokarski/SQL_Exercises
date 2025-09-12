CREATE DATABASE Car_rental_database_script;
GO

USE Car_rental_database_script;
GO

CREATE TABLE Employee (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(24) NOT NULL,
    surname VARCHAR(30) NOT NULL,
    position VARCHAR(30) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(30) NOT NULL
);

CREATE TABLE Client_grade (
    id INT IDENTITY(1,1) PRIMARY KEY,
    grade VARCHAR(4) NOT NULL,
    description VARCHAR(256)
);

CREATE TABLE Client (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NCHAR(15) NOT NULL,
    surname NCHAR(15) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    registration_number VARCHAR(18) NOT NULL,
    client_grade_id INT,
    FOREIGN KEY (client_grade_id) REFERENCES Client_grade(id)
);

CREATE TABLE Reservation (
    id INT IDENTITY(1,1) PRIMARY KEY,
    status VARCHAR(18) NOT NULL,
    describe VARCHAR(128)
);

CREATE TABLE Insurance (
    id INT IDENTITY(1,1) PRIMARY KEY,
    company VARCHAR(32) NOT NULL,
    number_of_policy VARCHAR(10) NOT NULL,
    insurance_start_date DATE NOT NULL,
    insurance_end_date DATE NOT NULL
);

CREATE TABLE Car_category (
    category VARCHAR(3) PRIMARY KEY,
    description VARCHAR(150)
);

CREATE TABLE Car_type (
    type VARCHAR(3) PRIMARY KEY,
    description VARCHAR(150)
);

CREATE TABLE Car (
    id INT IDENTITY(1,1) PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year_of_production CHAR(4) NOT NULL,
    registration_number VARCHAR(12) NOT NULL,
    description VARCHAR(256) NOT NULL,
    car_type_id VARCHAR(3) NOT NULL,
    car_category_id VARCHAR(3) NOT NULL,
    insurance_id INT,
    FOREIGN KEY (car_type_id) REFERENCES Car_type(type),
    FOREIGN KEY (car_category_id) REFERENCES Car_category(category),
    FOREIGN KEY (insurance_id) REFERENCES Insurance(id)
);

CREATE TABLE Maintenance (
    id INT IDENTITY(1,1) PRIMARY KEY,
    car_id INT,
    date DATE NOT NULL,
    description VARCHAR(255),
    cost MONEY NOT NULL,
    service_provider VARCHAR(64) NOT NULL,
    FOREIGN KEY (car_id) REFERENCES Car(id)
);

CREATE TABLE Equipment (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(250),
    price money NOT NULL
);

CREATE TABLE Rental (
    id INT IDENTITY(1,1) PRIMARY KEY,
    start_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    client_id INT,
    car_id INT,
    reservation_id INT,
    employee_id INT,
    FOREIGN KEY (client_id) REFERENCES Client(id),
    FOREIGN KEY (car_id) REFERENCES Car(id),
    FOREIGN KEY (reservation_id) REFERENCES Reservation(id),
    FOREIGN KEY (employee_id) REFERENCES Employee(id)
);

CREATE TABLE Rental_equipment (
    rental_id INT,
    equipment_id INT,
    amount INT,
    PRIMARY KEY (rental_id, equipment_id),
    FOREIGN KEY (rental_id) REFERENCES Rental(id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(id)
);

CREATE TABLE Payment (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cost MONEY NOT NULL,
    status VARCHAR(30) NOT NULL,
    date DATE NOT NULL,
    rental_id INT,
    payment_form VARCHAR(30) NOT NULL,
    FOREIGN KEY (rental_id) REFERENCES Rental(id)
);

INSERT INTO Employee (name, surname, position, phone_number, email)
VALUES
('Micha³', 'Kowalski', 'Agent Wynajmu', '145687908', 'jkowalski@o2.pl'),
('Natalia', 'D¹browska', 'Agent Wynajmu', '456890321', 'nd¹browska@o2.pl'),
('Kacper', 'Kowal', 'Agent Wynajmu', '567932120', 'kkowal@o2.pl');

INSERT INTO Client_grade (grade, description)
VALUES
('1/5', 'Tragedia! Auto by³o w fatalnym stanie - brudne, z porysowan¹ karoseri¹ i œwiec¹cymi kontrolkami b³êdów. Obs³uga niemi³a , a kaucja zwracana z du¿ym opóŸnieniem. Nie polecam nikomu!'),
('2/5', 'Samochód dzia³a³ , ale mia³ kilka usterek, o których nie poinformowano mnie wczeœniej. Obs³uga by³a powolna, a formalnoœci trwa³y wieki. Ceny niezbyt konkurencyjne w porównaniu do innych firm.'),
('3/5', 'Œrednie doœwiadczenie - auto zgodne z opisem, ale nie by³o idealnie czyste. Proces odbioru i zwrotu auta móg³by byæ lepiej zorganizowany. W porz¹dku ale bez rewelacji.'),
('4/5', 'Bardzo dobra wypo¿yczalnia! Samochód w œwietnym stanie, obs³uga profesjonalna i pomocna. Ceny rozs¹dne, a formalnoœci za³atwione szybko. Na pewno skorzystam ponownie.'),
('5/5', 'Rewelacja! Auto nowe, czyste i zatankowane. Obs³uga przemi³a, zero ukrytych op³at, szybki proces wynajmu i zwrotu. Najlepsza wypo¿yczalnia z jakiej korzysta³em!.');

INSERT INTO Client (name, surname, phone_number, registration_number, client_grade_id)
VALUES
('Jakub', 'Kowalski', '456873214', '0983/22/877', 2),
('Alicja', 'D¹browska', '678765498', '0876/22/231', 3),
('Tomasz', 'Majewski', '981239764', '0745/22/141', 1),
('Kacper', 'Zieliñski', '567813914', '0781/22/453', 5),
('Natalia', 'Kowalska', '561832517', '0155/22/981', 4);

INSERT INTO Reservation (status, describe)
VALUES
('Wypo¿yczony', 'Status wypo¿yczony'),
('Zarezerwowany', 'Status zarezerwowany'),
('Wolny', 'Status wolny od wypo¿yczenia');

INSERT INTO Insurance (company, number_of_policy, insurance_start_date, insurance_end_date)
VALUES
('Allianz', '1489327598', '2025-03-31', '2028-04-28'),
('Lloyds', '6728319038', '2025-01-28', '2028-02-16'),
('Signal Iduna', '5623953487', '2025-02-18', '2028-03-26'),
('Tuz', '9324871087', '2025-04-30', '2028-05-27'),
('Warta', '5609238759', '2025-05-31', '2028-06-25');

INSERT INTO Car_category (category, description)
VALUES
('D', 'Diesel'),
('E', 'Electric'),
('H', 'Hybrid'),
('P', 'Petrol');

INSERT INTO Car_type (type, description)
VALUES
('COM', 'Combi'),
('CRO', 'Crossover'),
('HAT', 'Hatchback'),
('ROS', 'Roadster'),
('SED', 'Sedan'),
('SUV', 'Suv');

INSERT INTO Car (brand, model, year_of_production, registration_number, description, car_type_id, car_category_id, insurance_id)
VALUES
('Toyota', 'Corolla', '2020', 'DW-E456Z', 'Kompaktowy sedan o niezawodnoœci i oszczêdnym spalaniu.', 'SED', 'H', 3),
('Lexus', 'NX350', '2023', 'DDZ-0424U', 'Luksusowy Crossover o dynamicznym silniku i nowoczesnym wyposa¿eniu.', 'CRO', 'P', 2),
('Toyota', 'Yaris', '2019', 'ZS-UJ245', 'Ma³y hatchback , oszczêdny i zwrotny , idealny do miasta.', 'HAT', 'H', 4),
('Volkswagen', 'Passat', '2006', 'DWA-H765', 'Nowoczesne combi klasy œredniej o wysokim komforcie jazdy.', 'COM', 'H', 1),
('Hyundai', 'Tucson', '2021', 'GD-167YU', 'Nowoczesny SUV z zaawansowanymi systemami bezpieczeñstwa.', 'SUV', 'H', 3),
('Lexus', 'RX450', '2021', 'ZS-89R6C', 'Hybrydowy SUV premium z eleganckim designem i mocnym silnikiem.', 'SUV', 'P', 2),
('Mercedes', 'Class C', '2023', 'KR-456UY', 'Luksusowy combi o sportowym charakterze i zaawansowanych technologiach.', 'COM', 'P', 1),
('Tesla', 'Model S', '2022', 'BIA-GHB91', 'Elektryczny sedan o imponuj¹cym zasiêgu i osi¹gach.', 'SED', 'E', 5),
('BMW', 'Z4', '2023', 'KR-BN7U8', 'Sportowy roadster z dynamicznym silnikiem i agresywnym stylem.', 'ROS', 'P', 4),
('Volkswagen', 'Golf', '2015', 'DW-C8V91', 'Uniwersalny hatchback o solidnym wykonaniu i nowoczesnym wnêtrzu.', 'HAT', 'D', 1),
('Toyota', 'Camry', '2025', 'KR-TY567', 'Komfortowy sedan o oszczêdnym silniku i przestronnym wnêtrzu.', 'SED', 'H', 3),
('Peugot', '508', '2022', 'WE-D0981', 'Stylowy sedan klasy œredniej z nowoczesnym wnêtrzem.', 'SED', 'P', 2),
('BMW', 'X7', '2022', 'DW-NMJ75', 'Luksusowy SUV z przestronnym wnêtrzem i potê¿nym silnikiem.', 'SUV', 'P', 4),
('Cupra', 'Formentor', '2023', 'KR-D72C8', 'Sportowy Crossover o agresywnym wygl¹dzie i innowacyjnym wnêtrzu.', 'CRO', 'P', 3),
('KIA', 'Sportage', '2024', 'WD-XC893', 'Praktyczny SUV z nowoczesnym designem i ekonomicznym silnikiem.', 'SUV', 'H', 2);

INSERT INTO Maintenance (car_id, date, description, cost, service_provider)
VALUES
(13, '2025-03-30', 'Silnik nie uruchamia siê, mimo przekrêcenia kluczyka lub naciœniêcia przycisku start...', '2000.00', 'Autoryzowany serwis mechaniczny'),
(2, '2025-04-06', 'Skrzynia biegów dzia³a nieprawid³owo...', '5000.00', 'Warsztat specjalizuj¹cy siê w skrzyniach biegów'),
(4, '2025-05-05', 'Hamulce dzia³aj¹ nieefektywnie...', '2500.00', 'Serwis uk³adów hamulcowych'),
(3, '2025-02-04', 'Na panelu wskaŸników pojawiaj¹ siê nieoczekiwane kontrolki ostrzegawcze...', '6000.00', 'Elektronik samochodowy'),
(7, '2025-01-23', 'Œwiat³a mijania, drogowe, kierunkowskazy lub tylne nie dzia³aj¹...', '8000.00', 'Serwis oœwietlenia i instalacji elektrycznej');

INSERT INTO Equipment (name, description, price)
VALUES
('Box', 'Baga¿nik dachowy', '350.00'),
('Hak', 'Hak samochodowy', '150.00'),
('Box_rowerowy', 'Baga¿nik na dach na rower', '200.00'),
('Przyczepa', 'Przyczepa transportowa', '750.00'),
('Kemping', 'Przyczepa kempingowa', '1000.00'),
('Fotelik', 'Fotelik dla dziecka', '50.00'),
('Klatka', 'Klatka dla zwierzêcia', '35.00');

INSERT INTO Rental (start_date , expiry_date, client_id, car_id, reservation_id, employee_id)
VALUES
('2025-01-15', '2025-02-01', 1, 1, 1, 1),
('2025-02-03', '2025-03-07', 2, 5, 3, 2),
('2025-03-25', '2025-04-10', 4, 4, 1, 2),
('2025-05-26', '2025-06-28', 5, 11, 2, 3),
('2025-07-03', '2025-07-11', 3, 14, 3, 1);

INSERT INTO Rental_equipment ( rental_id, equipment_id, amount)
VALUES
(1, 3, 2),
(2, 4, 1),
(3, 5, 3),
(4, 2, 1),
(5, 7, 3);

INSERT INTO Payment (cost , status, date, rental_id, payment_form)
VALUES
('200.00', 'nieop³acone', '2025-04-26', 2, 'Karta p³atnicza'),
('500.00', 'op³acone', '2025-03-24', 1, 'BLIK'),
('1500.00', 'przetwarzanie transakcji', '2025-03-22', 3, 'Paypal'),
('2000.00', 'op³acone', '2025-06-13', 4, 'Gotówka'),
('300.00', 'nieop³acone', '2025-08-11', 5, 'Karta p³atnicza');



