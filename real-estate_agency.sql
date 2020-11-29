---------------------------------------------------------------- СОЗДАНИЕ ТАБЛИЦ, ПОЛЕЙ, ОГРАНИЧЕНИЙ, ПОСЛЕДОВАТЕЛЬНОСТЕЙ И ТД. ----------------------------------------------------------

CREATE TABLE consumer (consumers_key INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1 NOCACHE),
                      consumers_character VARCHAR2(9) NOT NULL,
                      second_name VARCHAR2(20) NOT NULL,
                      first_name VARCHAR2(20) NOT NULL,
                      middle_name VARCHAR2(20) NOT NULL,
                      registration VARCHAR2(300) NOT NULL,
                      telephone_number CHAR(17),
                      age INTEGER NOT NULL,
                      PRIMARY KEY(consumers_key),
                      CONSTRAINT check_consumers_character 
                                 CHECK (consumers_character IN('possessor','vendee')),
                      CONSTRAINT check_telephone_number_consumer
                                 CHECK (REGEXP_LIKE(telephone_number, '^\+375\(\d{2}\)\d{3}-\d{2}-\d{2}$')),
                      CONSTRAINT unique_telephone_number_consumer 
                                 UNIQUE (telephone_number),
                      CONSTRAINT check_age_consumer
                                 CHECK (age BETWEEN 18 and 125)
                      ); --Закинул в APEXOracle

CREATE TABLE vender (venders_key INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1 NOCACHE),
                    second_name VARCHAR2(20) NOT NULL,
                    first_name VARCHAR2(20) NOT NULL,
                    middle_name VARCHAR2(20) NOT NULL,
                    official_seat VARCHAR2(300) NOT NULL,
                    telephone_number CHAR(17) NOT NULL,
                    PRIMARY KEY(venders_key),
                    CONSTRAINT check_telephone_number_vender
                               CHECK (REGEXP_LIKE(telephone_number, '^\+375\(\d{2}\)\d{3}-\d{2}-\d{2}$'))
                    ); --Закинул в APEXOracle

CREATE TABLE tature_of_transactions (tature_of_transactions_key INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(MINVALUE 1 MAXVALUE 2 START WITH 1 INCREMENT BY 1 NOCACHE),
                                    article_tature VARCHAR2(8) NOT NULL,
                                    PRIMARY KEY(tature_of_transactions_key),
                                    CONSTRAINT check_arlicle_tature_tature_of_transactions
                                               CHECK (article_tature IN('purchase','selling'))
                                    ); --Закинул в APEXOracle

CREATE TABLE immovables_description (description_key INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(MINVALUE 1 MAXVALUE 2 START WITH 1 INCREMENT BY 1 NOCACHE),
                                    article_desc VARCHAR2(9) NOT NULL,
                                    PRIMARY KEY(description_key),
                                    CONSTRAINT check_arlicle_desc_immovables_description
                                               CHECK (article_desc IN('apartment','house'))
                                    ); --Закинул в APEXOracle

CREATE TABLE immovables (immovable_key INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1 NOCACHE),
                        article_immov VARCHAR2(20) NOT NULL,
                        date_built DATE NOT NULL,
                        description_key INTEGER NOT NULL,
                        purchase NUMBER(9,2),
                        address_ VARCHAR2(300) NOT NULL,
                        district VARCHAR2(12) NOT NULL,
                        status_ VARCHAR2(14) NOT NULL,
                        PRIMARY KEY(immovable_key),
                        CONSTRAINT description_key_fk_immovables
                                   FOREIGN KEY(description_key)
                                   REFERENCES immovables_description(description_key),
                        CONSTRAINT check_district
                                   CHECK (district IN('centralniy','sovetskiy','pervomayskiy','partisanskiy','zavodskoy','leninskiy','oktyabrskiy','moskovskiy','frunzenskiy')),
                        CONSTRAINT check_status_
                                   CHECK (status_ IN('sold','for_sale','off_the_market'))
                        ); --Закинул в APEXOracle

CREATE TABLE flows (flows_key INTEGER GENERATED BY DEFAULT ON NULL AS IDENTITY(START WITH 1 INCREMENT BY 1 NOCACHE),
                   tature_of_transaction_key INTEGER NOT NULL,
                   venders_key INTEGER NOT NULL,
                   vendee_key INTEGER NOT NULL,
                   immovable_key INTEGER NOT NULL,
                   bottom_line_price NUMBER(9,2),
                   transaction_date_and_time TIMESTAMP NOT NULL,
                   possessors_key INTEGER NOT NULL,
                   PRIMARY KEY(flows_key),
                   CONSTRAINT tature_of_transaction_key_fk_flows
                              FOREIGN KEY(tature_of_transaction_key)
                              REFERENCES tature_of_transactions(tature_of_transactions_key),
                    CONSTRAINT venders_key_fk_flows
                              FOREIGN KEY(venders_key)
                              REFERENCES vender(venders_key),
                    CONSTRAINT vendee_key_fk_flows
                              FOREIGN KEY(vendee_key)
                              REFERENCES consumer(consumers_key),
                    CONSTRAINT immovable_key_fk_flows
                              FOREIGN KEY(immovable_key)
                              REFERENCES immovables(immovable_key),
                    CONSTRAINT possessors_key_fk_flows
                              FOREIGN KEY(possessors_key)
                              REFERENCES consumer(consumers_key)
                    ); --Закинул в APEXOracle

------------------------------------------------------------------------------------- СОЗДАНИЕ СИНОНИМОВ -----------------------------------------------------------------

CREATE SYNONYM deal_type for tature_of_transactions; --Закинул в APEXOracle
CREATE SYNONYM employee for vender; --Закинул в APEXOracle

---------------------------------------------------------------------------------- ЗАПОЛНЕНИЕ ТАБЛИЦ ДАННЫМИ ------------------------------------------------------------

insert into tature_of_transactions values (1, 'purchase'); --Закинул в APEXOracle
insert into deal_type values (2, 'selling'); --Закинул в APEXOracle (через синоним, как пример)

insert into immovables_description values (1, 'apartment'); --Закинул в APEXOracle
insert into immovables_description values (2, 'house'); --Закинул в APEXOracle

insert into employee values (1, 'Karbisheva', 'Marina', 'Eduardovna', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 1', '+375(17)340-15-01'); --Закинул в APEXOracle (через синоним, как пример)
insert into vender values (2, 'Mishin', 'Valeriy', 'Petrovich', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 2', '+375(17)340-15-02'); --Закинул в APEXOracle
insert into vender values (3, 'Vanzevich', 'Olga', 'Sergeevna', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 3', '+375(17)340-15-03'); --Закинул в APEXOracle
insert into vender values (4, 'Krivichko', 'Sergey', 'Petrovich', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 4', '+375(17)340-15-04'); --Закинул в APEXOracle
insert into vender values (5, 'Manina', 'Nadejda', 'Olegovna', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 5', '+375(17)340-15-05'); --Закинул в APEXOracle
insert into vender values (6, 'Karamazov', 'Dmitriy', 'Olgerdovich', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 6', '+375(17)340-15-06'); --Закинул в APEXOracle
insert into vender values (7, 'Zinchenko', 'Varvara', 'Mihailovna', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 7', '+375(17)340-15-07'); --Закинул в APEXOracle
insert into vender values (8, 'Zubok', 'Anastasia', 'Valerievna', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 8', '+375(17)340-15-08'); --Закинул в APEXOracle
insert into vender values (9, 'Mihno', 'Mihail', 'Viktorovich', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 6', '+375(17)340-15-06'); --Закинул в APEXOracle
insert into vender values (10, 'Pischik', 'Vladislav', 'Ivanovich', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 3', '+375(17)340-15-03'); --Закинул в APEXOracle
insert into vender values (11, 'Kiriluk', 'Maksim', 'Vladimirivich', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 1', '+375(17)340-15-01'); --Закинул в APEXOracle
insert into vender values (12, 'Karluk', 'Vasiliy', 'Mihailovich', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 7', '+375(17)340-15-07'); --Закинул в APEXOracle
insert into vender values (13, 'Savickaya', 'Mihalina', 'Viktorovna', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 4', '+375(17)340-15-04'); --Закинул в APEXOracle
insert into vender values (14, 'Marshal', 'Vitaliy', 'Antipovich', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 2', '+375(17)340-15-02'); --Закинул в APEXOracle
insert into vender values (15, 'Naydin', 'Anjelika', 'Sultanovna', 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 5', '+375(17)340-15-05'); --Закинул в APEXOracle

insert into consumer values (1, 'vendee', 'Avanyasyan', 'Ashot', 'Magomedovich', 'Minsk city, Naklonnaya street, house 20', '+375(29)562-44-98', 39); --Закинул в APEXOracle
insert into consumer values (2, 'vendee', 'Andreeva', 'Anna', 'Svyatoslavovna', 'Minsk city, Matusevicha street, house 86, apartment 354', '+375(17)377-15-62', 37); --Закинул в APEXOracle
insert into consumer values (3, 'vendee', 'Antip', 'Anton', 'Viktorovich', 'Minsk city, Papanina street, house 15, apartment 14', '+375(17)328-97-43', 56); --Закинул в APEXOracle
insert into consumer values (4, 'possessor', 'Vashkevich', 'Sandra', 'Albertovna', 'Minsk city, Yanki Brilya street, house 26, apartment 66', '+375(17)324-12-56', 28); --Закинул в APEXOracle
insert into consumer values (5, 'vendee', 'Vezin', 'Anton', 'Dmitrievich', 'Minsk city, Koltsova second lane, house 39', '+375(44)891-73-36', 29); --Закинул в APEXOracle
insert into consumer values (6, 'possessor', 'Virutina', 'Stepanida', 'Vladimirovna', 'Bobruisk city, Maksima Gorkogo street, house 39, apartment 28', '+375(33)892-14-53', 44); --Закинул в APEXOracle
insert into consumer values (7, 'vendee', 'Didenok', 'Ilya', 'Olegovich', 'Minsk city, Sharangovicha street, house 48, apartment 389', '+375(17)388-17-19', 23); --Закинул в APEXOracle
insert into consumer values (8, 'possessor', 'Karamazov', 'Ignat', 'Denisovich', 'Minsk city, Lizi Chaikinoy street, house 13, apartment 3', '+375(17)382-98-17', 33); --Закинул в APEXOracle
insert into consumer values (9, 'vendee', 'Karkotko', 'Vladimir', 'Vladimirovich', 'Grodno city, Belusha street, house 2A, apartment 59', '+375(29)300-88-38', 57); --Закинул в APEXOracle
insert into consumer values (10, 'possessor', 'Karkotko', 'Nastasia', 'Stepanovna', 'Minsk city, Partizanskiy prospect, house 148, apartment 187', '+375(17)327-28-29', 20); --Закинул в APEXOracle
insert into consumer values (11, 'possessor', 'Kirienko', 'Volf', 'Ivanovich', 'Minsk city, Konstansii Buylo street, house 11', '+375(29)371-22-91', 39); --Закинул в APEXOracle
insert into consumer values (12, 'vendee', 'Korol', 'Marina', 'Genadevna', 'Minsk city, Nezavisimosti prospect, house 29, apartment 11', '+375(17)355-18-71', 88); --Закинул в APEXOracle
insert into consumer values (13, 'possessor', 'Kofman', 'Viktor', 'Iosifovish', 'Minsk city, Kalinovskogo street, house 83, apartment 73', '+375(44)111-98-22', 52); --Закинул в APEXOracle
insert into consumer values (14, 'possessor', 'Makovskaya', 'Mariya', 'Alekseevna', 'Minsk city, Rozi Luksemgurg street, house 162, apartment 32', '+375(17)302-47-37', 23); --Закинул в APEXOracle
insert into consumer values (15, 'vendee', 'Martinin', 'Vladimir', 'Vladimirovich', 'Minsk city, Pionerskaya street, house 3, apartment 11', '+375(44)157-89-11', 44); --Закинул в APEXOracle
insert into consumer values (16, 'vendee', 'Miroshnichenko', 'Vladislav', 'Markovish', 'Minsk city, Irkutskaya street, house 123', '+375(44)123-44-59', 23); --Закинул в APEXOracle
insert into consumer values (17, 'vendee', 'Miheeva', 'Margo', 'Andreevna', 'Minsk city, Kondrata Krapivi street, house 36', '+375(33)287-11-65', 52); --Закинул в APEXOracle
insert into consumer values (18, 'vendee', 'Norko', 'Pavel', 'Petrovich', 'Minsk city, First Brestskiy lane, house 2', '+375(44)576-23-85', 21); --Закинул в APEXOracle
insert into consumer values (19, 'possessor', 'Prishepova', 'Anastasia', 'Vsevolodovna', 'Minsk city, Kirilla Turovskogo street, house 18, apartment 355', '+375(17)378-22-56', 33); --Закинул в APEXOracle
insert into consumer values (20, 'possessor', 'Savchenko', 'Marina', 'Mihailovna', 'Minsk city, Partizanskiy street, house 152, apartment 22', '+375(29)216-88-92', 18); --Закинул в APEXOracle
insert into consumer values (21, 'possessor', 'Samohval', 'Oleg', 'Mirongovich', 'Minsk city, Kotovskogo street, house 27', '+375(17)340-11-21', 19); --Закинул в APEXOracle
insert into consumer values (22, 'possessor', 'Sapega', 'Stefan', 'Dmitrievich', 'Minsk city, Sofii Kovalevskoy lane, house 55, apartment 31', '+375(17)311-28-27', 56); --Закинул в APEXOracle
insert into consumer values (23, 'possessor', 'Sergeev', 'Mihail', 'Viktorovich', 'Minsk city, Tolbuhina street, house 3, apartment 44', '+375(33)360-13-89', 31); --Закинул в APEXOracle
insert into consumer values (24, 'vendee', 'Smetanina', 'Valeria', 'Ilinishna', 'Minsk city, Partizanskaya street, house 22B', '+375(33)151-04-62', 27); --Закинул в APEXOracle
insert into consumer values (25, 'possessor', 'Stavrida', 'Nikolai', 'Aristanhovich', 'Minsk city, Fourth Poligraficheskiy lane, house 74', '+375(29)360-14-77', 43); --Закинул в APEXOracle
insert into consumer values (26, 'vendee', 'Statkevich', 'Antonina', 'Vladimirovna', 'Minsk city, Nesterova street, house 19, apartment 67', '+375(17)327-28-25', 35); --Закинул в APEXOracle
insert into consumer values (27, 'vendee', 'Suvorov', 'Mihail', 'Mihailovich', 'Minsk city, Ponomarenko street, house 18, apartment 15', '+375(29)119-94-34', 65); --Закинул в APEXOracle
insert into consumer values (28, 'possessor', 'Surguch', 'Valentina', 'Svyatozarovna', 'Minsk city, Lesi Ukrainki street, house 14, apartment 133', '+375(33)182-88-62', 68); --Закинул в APEXOracle
insert into consumer values (29, 'vendee', 'Sushko', 'Vasilisa', 'Kazimirovna', 'Minsk city, Varvasheni street, house 82A', '+375(29)290-56-55', 72); --Закинул в APEXOracle
insert into consumer values (30, 'possessor', 'Ulman', 'Viktoria', 'Sergeevna', 'Minsk city, Dzerjinskogo prospect, house 24, apartment 23', '+375(33)111-87-66', 53); --Закинул в APEXOracle

insert into immovables values (1, 'Usadba Vyaselka', '10.18.2005', 2, '200000.00', 'Minsk city, Dneprovskaya street, house 14', 'zavodskoy', 'for_sale'); --Закинул в APEXOracle
insert into immovables values (2, 'Apartment number 6', '12.30.1999', 1, '151015.33', 'Minsk city, Varvasheni street, house 14, apartment 6', 'zavodskoy', 'sold'); --Закинул в APEXOracle
insert into immovables values (3, 'Apartment number 35', '09.13.1988', 1, '260150.01', 'Minsk city, Nezavisimosti prospect, house 69, apartment 35', 'pervomayskiy', 'sold'); --Закинул в APEXOracle
insert into immovables values (4, 'House number 8', '04.12.2005', 2, '300000.11', 'Minsk city, Aleksandrovskaya street, house 8', 'centralniy', 'for_sale'); --Закинул в APEXOracle
insert into immovables values (5, 'House number 14', '06.06.2008', 2, '180200.00', 'Minsk city, Yaroshevichskiy lane, house 14', 'centralniy', 'sold'); --Закинул в APEXOracle
insert into immovables values (6, 'Apartment number 58', '08.22.1990', 1, '130000.00', 'Minsk city, Pobediteley prospect, house 98, apartment 58', 'centralniy', 'off_the_market'); --Закинул в APEXOracle
insert into immovables values (7, 'Apartment number 102', '05.25.1992', 1, '340400.20', 'Minsk city, Partizanskiy prospect, house 149, apartment 102', 'zavodskoy', 'sold'); --Закинул в APEXOracle
insert into immovables values (8, 'Apartment number 220', '07.18.2006', 1, '520000.00', 'Minsk city, Filimonova street, house 35, apartment 220', 'partisanskiy', 'sold'); --Закинул в APEXOracle
insert into immovables values (9, 'House number 3', '08.12.2010', 2, '780000.30', 'Minsk city, Ignata Buynitskogo lane, house 3', 'partisanskiy', 'sold'); --Закинул в APEXOracle
insert into immovables values (10, 'House number 12', '11.05.2005', 2, '500000.38', 'Minsk city, Evgenia Glebova street, house 12', 'partisanskiy', 'off_the_market'); --Закинул в APEXOracle
insert into immovables values (11, 'House number 2A', '02.08.2001', 2, '600100.00', 'Minsk city, Jasminovaya street, house 2A', 'partisanskiy', 'sold'); --Закинул в APEXOracle
insert into immovables values (12, 'Apartment number 44', '05.20.1988', 1, '158000.01', 'Minsk city, Lazo street, house 8, apartment 44', 'zavodskoy', 'sold'); --Закинул в APEXOracle
insert into immovables values (13, 'Apartment number 158', '09.07.1992', 1, '201500.00', 'Minsk city, Odesskaya street, house 16, apartment 158', 'zavodskoy', 'sold'); --Закинул в APEXOracle
insert into immovables values (14, 'Apartment number 200', '12.08.2020', 1, '880180.70', 'Minsk city, Prititskogo street, house 77, apartment 200', 'frunzenskiy', 'for_sale'); --Закинул в APEXOracle
insert into immovables values (15, 'Apartment number 93', '03.11.2008', 1, '450000.99', 'Minsk city, Odoevskogo street, house 65, apartment 93', 'frunzenskiy', 'sold'); --Закинул в APEXOracle
insert into immovables values (16, 'House number 15', '09.17.2010', 2, '600000.12', 'Minsk city, Usadebnaya street, house 15', 'sovetskiy', 'sold'); --Закинул в APEXOracle
insert into immovables values (17, 'House number 36', '04.19.2012', 2, '990000.00', 'Minsk city, Luchayskaya street, house 36', 'sovetskiy', 'sold'); --Закинул в APEXOracle
insert into immovables values (18, 'Apartment number 58', '09.16.1899', 1, '130000.00', 'Minsk city, Kuleshova street, house 10, apartment 58', 'zavodskoy', 'sold'); --Закинул в APEXOracle
insert into immovables values (19, 'Usadba Vojik', '08.12.2013', 2, '1200000.38', 'Minsk city, Vesninka street, house 10', 'centralniy', 'sold'); --Закинул в APEXOracle
insert into immovables values (20, 'Apartment number 85', '06.23.1995', 1, '467000.00', 'Minsk city, Pushkona prospect, house 87, apartment 85', 'frunzenskiy', 'sold'); --Закинул в APEXOracle
insert into immovables values (21, 'Apartment number 99', '12.11.1888', 1, '888888.00', 'Minsk city, Pushkona prospect, house 77, apartment 99', 'frunzenskiy', 'for_sale'); --Закинул в APEXOracle
insert into immovables values (22, 'House number 16', '11.05.2005', 2, '660000.38', 'Minsk city, Evgenia Glebova street, house 16', 'partisanskiy', 'off_the_market'); --Закинул в APEXOracle
insert into immovables values (23, 'House number 22', '09.14.2008', 2, '780000.66', 'Minsk city, Evgenia Glebova street, house 22', 'partisanskiy', 'off_the_market'); --Закинул в APEXOracle

insert into flows values (1, 2, 5, 2, 2, '154035.64', '22-MAR-2004 01.14.00.410527 PM', 11); --Закинул в APEXOracle
insert into flows values (2, 1, 3, 5, 20, '476340.00', '14-AUG-2008 05.00.00.410989 PM', 13); --Закинул в APEXOracle
insert into flows values (3, 1, 4, 27, 3, '265353.01', '11-DEC-2009 11.23.00.410323 AM', 30); --Закинул в APEXOracle
insert into flows values (4, 2, 9, 15, 12, '161160.01', '16-JAN-2012 09.53.00.410313 AM', 23); --Закинул в APEXOracle
insert into flows values (5, 1, 12, 16, 15, '459001.01', '28-MAY-2013 03.15.00.323527 PM', 19); --Закинул в APEXOracle
insert into flows values (6, 1, 7, 24, 19, '1224000.39', '30-SEP-2014 05.02.00.432529 PM', 25); --Закинул в APEXOracle
insert into flows values (7, 2, 1, 1, 17, '1009800.00', '03-NOV-2014 03.17.00.132528 PM', 22); --Закинул в APEXOracle
insert into flows values (8, 2, 2, 3, 16, '612000.12', '22-OCT-2015 10.32.00.445527 AM', 20); --Закинул в APEXOracle 
insert into flows values (9, 2, 6, 9, 11, '612102.00', '15-FEB-2016 03.08.00.499522 PM', 10); --Закинул в APEXOracle
insert into flows values (10, 1, 10, 17, 7, '347208.20', '18-APR-2018 11.33.00.409521 AM', 4); --Закинул в APEXOracle
insert into flows values (11, 1, 8, 12, 5, '183804.00', '19-APR-2018 11.56.00.892527 AM', 6); --Закинул в APEXOracle
insert into flows values (12, 1, 11, 18, 8, '530400.00', '18-FEB-2019 04.44.00.100527 PM', 21); --Закинул в APEXOracle
insert into flows values (13, 2, 15, 7, 18, '132600.00', '03-JUL-2019 03.00.00.132526 PM', 14); --Закинул в APEXOracle
insert into flows values (14, 2, 13, 26, 9, '795600.31', '16-FEB-2020 12.02.00.967527 AM', 28); --Закинул в APEXOracle
insert into flows values (15, 1, 14, 29, 13, '205530.00', '24-MAR-2020 02.03.00.401527 PM', 8); --Закинул в APEXOracle

--------------------------------------------------------------------------------------------- ЗАПРОСЫ ---------------------------------------------------------------------------------------------

/* {ЗАДАНИЕ}
Создайте запросы: 
       «Список объектов, предлагаемых к продаже» (условная выборка); 
       «Сальдо по видам объектов» (итоговый запрос); 
       «Объекты задан-ной стоимости» (параметрический запрос);
       «Общий список покупателей и продавцов с количеством сделок» (запрос на объединение);
       «Количество сделок по районам и по годам» (запрос по полю с типом дата);
*/


-- 1. «Список объектов, предлагаемых к продаже» (условная выборка):

SELECT article_immov AS article, date_built, b.article_desc AS immov_type, (purchase*1.02) AS total_price, district
       FROM immovables s, immovables_description b
       WHERE s.description_key = b.description_key and status_ IN ('for_sale'); -- Зачтено!


-- 2. «Сальдо по видам объектов» (итоговый запрос):

SELECT s.article_desc AS article, COUNT (b.status_) AS value_of_sold_immov, SUM (n.bottom_line_price) AS additive_sum_of_flows, (SUM (n.bottom_line_price))*0.02 AS agency_consolidated_profit
       FROM immovables_description s, immovables b, flows n
       WHERE b.immovable_key = n.immovable_key and s.description_key = b.description_key and status_ IN ('sold')
             GROUP BY s.article_desc; -- Зачтено!


-- 3. «Объекты заданной стоимости» (параметрический запрос):

SELECT  article_immov AS article, date_built, b.article_desc AS immov_type, purchase,(purchase*1.02) AS total_price, district
        FROM immovables s, immovables_description b
        WHERE s.description_key = b.description_key and s.purchase = :intended_price; -- Зачтено!


-- 4. «Общий список покупателей и продавцов с количеством сделок» (запрос на объединение):

SELECT s.second_name || ' ' || s.first_name || ' ' || s.middle_name || ' -  consumer' "ФИО и СТАТУС", COUNT (b.vendee_key) "Количество участий в сделках:"
       FROM consumer s, flows b
       WHERE s.consumers_key = b.vendee_key
       GROUP BY s.second_name || ' ' || s.first_name || ' ' || s.middle_name || ' -  consumer'
UNION
SELECT s.second_name || ' ' || s.first_name || ' ' || s.middle_name || ' -  consumer' "ФИО и СТАТУС", COUNT (b.possessors_key) "Количество участий в сделках:"
       FROM consumer s, flows b
       WHERE s.consumers_key = b.possessors_key
       GROUP BY s.second_name || ' ' || s.first_name || ' ' || s.middle_name || ' -  consumer'
UNION
SELECT s.second_name || ' ' || s.first_name || ' ' || s.middle_name || ' -  vender' "ФИО и СТАТУС", COUNT (b.venders_key) "Количество участий в сделках:"
       FROM vender s, flows b
       WHERE s.venders_key = b.venders_key
       GROUP BY s.second_name || ' ' || s.first_name || ' ' || s.middle_name || ' -  vender'; -- Зачтено!

-- ИЛИ --

SELECT s.second_name || ' ' || s.first_name || ' ' || s.middle_name || ' -  consumer' "ФИО и СТАТУС", COUNT (s.consumers_key) "Количество участий в сделках:"
       FROM consumer s, flows b
       WHERE s.consumers_key = b.vendee_key or s.consumers_key = b.possessors_key
       GROUP BY s.second_name || ' ' || s.first_name || ' ' || s.middle_name || ' -  consumer'
UNION
SELECT s.second_name || ' ' || s.first_name || ' ' || s.middle_name || ' -  vender' "ФИО и СТАТУС", COUNT (b.venders_key) "Количество участий в сделках:"
       FROM vender s, flows b
       WHERE s.venders_key = b.venders_key
       GROUP BY s.second_name || ' ' || s.first_name || ' ' || s.middle_name || ' -  vender'; -- Зачтено!


-- 5. «Количество сделок по районам и по годам» (запрос по полю с типом дата):

SELECT TO_CHAR (transaction_date_and_time, 'YYYY') "ГОД", COUNT (flows_key) "КОЛИЧЕСТВО СДЕЛОК В ГОДУ"
       FROM flows
       GROUP BY TO_CHAR (transaction_date_and_time, 'YYYY')
       ORDER BY TO_CHAR (transaction_date_and_time, 'YYYY') DESC; -- Зачтено!


/* {ЗАДАНИЕ}
Придумать задание и реализовать следующие типы запросов:
       -	с внутренним соединением таблиц, используя стандартный синтаксис SQL (JOIN…ON, JOIN…USING или NATURAL JOIN), который не применялся в предыдущих запросах;
       -	с внешним соединением таблиц, используя FULL JOIN, LEFT JOIN или RIGHT JOIN, при этом обязательным является наличие в БД данных, которые будут выводиться именно с выбранным оператором внешнего соединения;
       -	с использованием предиката IN с подзапросом;
       -	с использованием предиката ANY/ALL с подзапросом;
       -	с использованием предиката EXISTS/NOT EXISTS с подзапросом.

*/


/*     6. -      с внутренним соединением таблиц, используя стандартный синтаксис SQL (JOIN…ON, JOIN…USING или NATURAL JOIN), который не применялся в предыдущих запросах:
                     «Вывести ФИО сотрудника и дату заключенной им сделки»:
*/

SELECT second_name || ' ' || first_name || ' ' || middle_name AS FIO, transaction_date_and_time
       FROM vender JOIN flows USING (venders_key); -- Зачтено!


/*     7. -      с внешним соединением таблиц, используя FULL JOIN, LEFT JOIN или RIGHT JOIN, при этом обязательным является наличие в БД данных, которые будут выводиться именно с выбранным оператором внешнего соединения:
                     «Вывести информацию по всем объектам недвижимости с датой и временем их дродажи»:
*/

SELECT article_immov, date_built, address_, district, status_, transaction_date_and_time -- Изменить
        FROM immovables LEFT JOIN flows USING (immovable_key); -- Исправить Работа с данными

SELECT article_immov, date_built, address_, district, status_, transaction_date_and_time
        FROM immovables LEFT JOIN flows USING (immovable_key)
        ORDER BY transaction_date_and_time; -- Зачтено!


/*     8. -      с использованием предиката IN с подзапросом:
                     «Вывести список и информацию о частных домах, когда-либо внесенных в БД агентства»:
*/

SELECT article_immov, date_built, address_, purchase, district, status_
       FROM immovables
       WHERE description_key IN (SELECT description_key 
                                        FROM immovables_description 
                                        WHERE article_desc = 'house'); -- Зачтено!


/*     9. -      с использованием предиката ANY/ALL с подзапросом:
                     «Вывести квартиры, год постройки которых больше, чем год постройки любого из домов»:
*/

SELECT article_immov, date_built
       FROM immovables
       WHERE description_key = 1 and TO_CHAR (date_built, 'YYYY') >= ALL (SELECT TO_CHAR (date_built, 'YYYY')
							                                FROM immovables
                                                                                 WHERE description_key = 2); -- Зачтено!


/*     10. -      с использованием предиката EXISTS/NOT EXISTS с подзапросом:
                     «Вывести информацию о клиентах агентства недвижимости, которые имели статус покупателя при совешении сделки»:
*/

SELECT second_name, first_name, middle_name, registration, telephone_number, age
       FROM consumer
       WHERE NOT EXISTS (SELECT * 
                                FROM flows 
                                WHERE possessors_key = consumers_key); -- Зачтено!



-------------------------------------------------------------------- ПРЕДСТАВЛЕНИЯ -------------------------------------------------------------------------



-- Горизонтальтное обновляемое представление:

CREATE OR REPLACE VIEW view_immovables_for_sale AS
                  SELECT *
                         FROM immovables
                         WHERE status_ IN ('for_sale')
                         WITH CHECK OPTION;

SELECT * FROM view_immovables_for_sale;

UPDATE view_immovables_for_sale
       SET purchase = 999999.99
       WHERE immovable_key = 21;

-- ИЛИ --

UPDATE view_immovables_for_sale
       SET purchase = 888888.00
       WHERE address_ = 'Minsk city, Pushkona prospect, house 77, apartment 99'

insert into view_immovables_for_sale values (21, 'Apartment number 99', '12.11.1888', 1, '888888.00', 'Minsk city, Pushkona prospect, house 77, apartment 99', 'frunzenskiy', 'for_sale');
insert into view_immovables_for_sale values (22, 'House number 16', '11.05.2005', 2, '660000.38', 'Minsk city, Evgenia Glebova street, house 16', 'partisanskiy', 'off_the_market');
insert into view_immovables_for_sale values (23, 'House number 22', '09.14.2008', 2, '780000.66', 'Minsk city, Evgenia Glebova street, house 22', 'partisanskiy', 'off_the_market');

-- Вертикальное или смешанное необновляемое представление, пред-назначенное для работы с основной задачей БД (в представлении должны содержаться сведения из главной таблицы, но вместо внешних ключей необ-ходимо использовать связанные данные из родительской таблицы)

CREATE OR REPLACE VIEW view_flows AS
                  SELECT p.article_tature "ТИП СДЕЛКИ", b.second_name ||' '|| b.first_name ||' '|| b.middle_name "ФИО ПРОДАВЦА", r.second_name ||' '|| r.first_name ||' '|| r.middle_name "ФИО ПОКУПАТЕЛЯ", f.article_immov "НАЗВАНИЕ ОБЪЕКТА НЕДВИЖИМОСТИ", bottom_line_price "СТОИМОСТЬ", transaction_date_and_time "ДАТА И ВРЕМЯ СДЕЛКИ", n.second_name ||' '|| n.first_name ||' '|| n.middle_name "ФИО ВЛАДЕЛЬЦА"
                         FROM flows s, tature_of_transactions p, vender b, consumer r, immovables f, consumer n
                         WHERE p.tature_of_transactions_key = s.tature_of_transaction_key and b.venders_key = s.venders_key and f.immovable_key = s.immovable_key and s.vendee_key = r.consumers_key and s.possessors_key = n.consumers_key;

SELECT * FROM view_flows;

UPDATE view_flows SET possessors_key = 10 WHERE flows_key = 15; -- Не применяется, выдает ошибку "FLOWS_KEY": invalid identifier
UPDATE view_flows SET bottom_line_price = 777777.77 WHERE flows_key = 15; -- Не применяется, выдает ошибку "FLOWS_KEY": invalid identifier


-- Создать обновляемое представление для работы с одной из родительских таблиц индивидуальной БД и через него разрешить работу с данными только в рабочие дни (с понедельника по пятницу) и в рабочие часы (с 9:00 до 17:00)

CREATE OR REPLACE VIEW view_consumer AS
                  SELECT *
                         FROM consumer
                         WHERE to_char(sysdate, 'dy') in('mon', 'tue', 'wed', 'thu', 'fri') and to_char(sysdate, 'hh24') BETWEEN 6 AND 14
                         WITH CHECK OPTION;

SELECT * FROM view_consumer;

UPDATE view_consumer
       SET second_name = 'Barshot'
       WHERE consumers_key = 1;





------------------------------------------------------------------------------------- ПРОЦЕДУРЫ И ФУНКЦИИ -----------------------------------------------------------------------------------------

/*

ЗАДАНИЕ:

1. Написать процедуру изменения мобильного номера продавца по указанной в качестве параметра фамилии. Контролировать, чтобы повторно не был введен тот же номер.

2. Создать функцию, подсчитывающую количество сделок, совершенных потенциальными покупателями за текущий день. В вызывающую среду возвращать объекты недвижимости, участвующие в этих сделках.

*/

-- 1. Написать процедуру изменения мобильного номера продавца по указанной в качестве параметра фамилии. Контролировать, чтобы повторно не был введен тот же номер.:

CREATE OR REPLACE PROCEDURE CHANGE_TELNUM (vend_second_name IN VARCHAR2, new_vender_tel IN CHAR) IS
vender_tel CHAR(17);

BEGIN
       SELECT telephone_number INTO vender_tel
              FROM vender 
              WHERE second_name = vend_second_name;

IF vender_tel <> new_vender_tel THEN
       UPDATE VENDER SET telephone_number = new_vender_tel WHERE second_name = vend_second_name;
COMMIT;
DBMS_OUTPUT.PUT_LINE ('Сотрудник '||vend_second_name||': старый номер телефона = '||vender_tel||', новый номер телефона = '||new_vender_tel);
ELSE
DBMS_OUTPUT.PUT_LINE ('Номер уже принадлежит данному сотруднику');
END IF;
              EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                            DBMS_OUTPUT.PUT_LINE ('Ошибка: проверьте введенные значения!');
END;
/


BEGIN
CHANGE_TELNUM (vend_second_name => 'Karbisheva', new_vender_tel => '+375(11)111-11-11');
END;

BEGIN
CHANGE_TELNUM (vend_second_name => 'Karbisheva', new_vender_tel => '+375(17)340-15-01');
END;

-- Применительно к моей структуре БД не нужно контролировать уникальность номера телефона принадлежащего продавцу, т.к. в соответствии с бизнес логикой за одним рабочим местом может быть закреплено долее одного продавца.












/*

********************************************************* ГОТОВЫЕ ПРЕСЕТЫ: ***********************************************************

SELECT SYSTIMESTAMP FROM DUAL;

DROP TABLE vender CASCADE CONSTRAINTS PURGE;


ALTER TABLE vender DROP CONSTRAINT check_telephone_number_vender;
ALTER TABLE vender ADD CONSTRAINT check_telephone_number_vender CHECK (REGEXP_LIKE(telephone_number, '^\+375\(\d{2}\)\d{3}-\d{2}-\d{2}$'));


UPDATE vender
       SET official_seat = 'Minsk city, Yakuba Kolasa street, 37 building, office 213, desk 6'
       WHERE venders_key = 6;


ALTER TABLE immovables
            MODIFY purchase NUMBER(9,2);


ALTER TABLE flows
            MODIFY transaction_date_and_time TIMESTAMP;


ALTER TABLE flows
            MODIFY bottom_line_price NUMBER(9,2);


select localtimestamp, dump(localtimestamp) ts_bytes from dual; --Дата и время в правильном формате для APEXOracle
select * from wwv_flow_months_month;


ALTER TABLE immovables
            RENAME COLUMN year_built TO date_built;


SELECT * FROM view_immovables_for_sale


SELECT OBJECT_NAME, OBJECT_TYPE, STATUS  -- просмотр существующих процедур и функций
FROM USER_OBJECTS 
WHERE OBJECT_TYPE IN ('PROCEDURE', 'FUNCTION');

DROP PROCEDURE FIND_VENDERS_PHONE; -- удаление процедуры










cd D:/GitHub/IOSU
git init
git add real-estate_agency.sql
git commit -m "Tables, synonyms, inserts"
git branch -M master
git remote add origin https://github.com/DaniilKotkovskiy/IOSU.git
git push -u origin master

*/