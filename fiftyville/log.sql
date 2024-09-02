
-- Keep a log of any SQL queries you execute as you solve the mystery.

--Checking the crime scene reports
SELECT description FROM crime_scene_reports WHERE day=28 AND street='Humphrey Street';
--WE FIND
/*
Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.
*/


--Checking the interviews made on 28th
SELECT transcript FROM interviews WHERE day=28;
--WE FIND
/*
Interviews give us a lot of information to work on.
    1. The thief drove AWAY from the Bakery parking lot, within 10 MINS of the crime (10:15 to 10:25).
    2. Before arriving at the Bakery, the thief WITHDREW money from the atm at LEGGETT STREET.
    3. The thief made a phone call to the ACCOMPLICE that lasted for LESS THAN 60s. The ACCOMPLICE book the earliest flight OUT OF FIFTYVILLE on 29th.
*/



--Thief drove away from the bakery parking lot, within 10 minutes from the theft
SELECT license_plate FROM bakery_security_logs WHERE day=28 AND activity='exit' AND hour=10 AND minute>15 AND minute<25;
--WE FIND
/* The license plates of the possible culprits.
+---------------+
| license_plate |
+---------------+
| 5P2BI95       |
| 94KL13X       |
| 6P58WS2       |
| 4328GD8       |
| G412CB7       |
| L93JTIZ       |
| 322W7JE       |
| 0NTHK55       |
+---------------+
*/


--Lets get the names of these license plate owners.
SELECT name FROM people WHERE license_plate IN (
    SELECT license_plate FROM bakery_security_logs WHERE day=28 AND activity='exit' AND hour=10 AND minute>15 AND minute<25
);
--WE FIND
/* The names of all the people who meet the criteria presented in the above clue.
+---------+
|  name   |
+---------+
| Vanessa |
| Barry   |
| Iman    |
| Sofia   |
| Luca    |
| Diana   |
| Kelsey  |
| Bruce   |
+---------+
*/

/*
For the above example, we first attained the license plates and then queried for the name of these car's owners.
From now onward, we will directly get to the name of the suspects by nesting our queries or joining tables.
You are recommended to do the same, and if not comfortable, feel free to input each query one-by-one
*/

--The thief withdrew Money from the atm at Leggett Street
SELECT name FROM people WHERE id IN (
    SELECT person_id FROM bank_accounts WHERE account_number IN (
        SELECT account_number FROM atm_transactions WHERE transaction_type='withdraw' AND day=28 AND atm_location='Leggett Street'
    )
);
--WE FIND
/*
All the people who withdrew money at leggett street on the reported day.
+---------+
|  name   |
+---------+
| Kenny   |
| Iman    |
| Benista |
| Taylor  |
| Brooke  |
| Luca    |
| Diana   |
| Bruce   |
+---------+
*/



--The thief had a call with the accomplice for less than 60s
SELECT name FROM people WHERE phone_number IN (
    SELECT caller FROM phone_calls WHERE day=28 AND duration<60
);
--WE FIND
/*
The names of all the people who DIALED a call on 28th and talked less than 60s
+---------+
|  name   |
+---------+
| Kenny   |
| Sofia   |
| Benista |
| Taylor  |
| Diana   |
| Kelsey  |
| Bruce   |
| Carina  |
+---------+
*/


--The accomplice was on the receiving end of the call
SELECT name FROM people WHERE phone_number IN (
    SELECT receiver FROM phone_calls WHERE day=28 AND duration<60
);
--WE FIND
/*
All the people on the receiving end of such a call.
One of these people must be our accomplice
+------------+
|    name    |
+------------+
| James      |
| Larry      |
| Anna       |
| Jack       |
| Melissa    |
| Jacqueline |
| Philip     |
| Robin      |
| Doris      |
+------------+
*/


--Lets check the earlist flight out of fiftyville on 29
--We get the id's of all the flights out of fiftyville on 29th, order them earliest to latest, and select the first one
SELECT id FROM flights WHERE origin_airport_id= (SELECT id FROM airports WHERE city='Fiftyville') AND day=29
    ORDER BY hour, minute
        LIMIT 1;
--WE FIND
--The thief escaped fiftyville in flight_id=36


--Lets get all of the people in this flight.
SELECT name FROM people WHERE passport_number IN (
    SELECT passport_number FROM passengers WHERE flight_id=36
);
--WE FIND
/*
+--------+
|  name  |
+--------+
| Kenny  |
| Sofia  |
| Taylor |
| Luca   |
| Kelsey |
| Edward |
| Bruce  |
| Doris  |
+--------+
*/

--We can now find a common name between all the above lists of suspect. This person must be the criminal.
SELECT p.name FROM people p
INNER JOIN passengers ps ON p.passport_number = ps.passport_number AND ps.flight_id = 36
INNER JOIN phone_calls pc ON p.phone_number = pc.caller AND pc.day = 28 AND pc.duration < 60
INNER JOIN bakery_security_logs bsl ON p.license_plate = bsl.license_plate AND bsl.day = 28 AND bsl.activity = 'exit' AND bsl.hour = 10 AND bsl.minute > 15 AND bsl.minute < 25
INNER JOIN bank_accounts ba ON p.id = ba.person_id
INNER JOIN atm_transactions atm ON ba.account_number = atm.account_number AND atm.transaction_type = 'withdraw' AND atm.day = 28 AND atm.atm_location = 'Leggett Street';

--The only common person in all these lists is Bruce.
--We confirmed that Bruce is the criminal.


--To find the accomplice, lets check Bruce's call history on 28th

SELECT name FROM people WHERE phone_number IN (
    SELECT receiver FROM phone_calls WHERE day=28 AND duration<60 AND caller = (
        SELECT phone_number FROM people WHERE name='Bruce'
    )
);
--WE GET
/*
+-------+
| name  |
+-------+
| Robin |
+-------+
Thus, Robin is the accomplice
*/
