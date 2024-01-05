USE murdermystery;

SHOW Tables;

DESCRIBE crime_scene_report;

DESCRIBE drivers_license;

DESCRIBE facebook_event_checkin;

DESCRIBE get_fit_now_check_in;

DESCRIBE get_fit_now_member;

DESCRIBE income;

DESCRIBE interview;

DESCRIBE person;

DESCRIBE solution;

----------------- Retriving Crime Scene Report -----------------------------------------------------
SELECT *
FROM crime_scene_report
WHERE date = 20180115 AND city = 'SQL City';  -- We found two witnesses one lives at the last house on Northwestern Dr and other named Annabel lives somewhere in franklin ave

----------------- Witness Personal details ----------------------------------------------------------
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;     -- Morty Schapiro lives at the last house on Northwestern Dr with id = 14887, license id =  118009, address no = 4919,ssn = 111564949

SELECT *
FROM person
WHERE address_street_name = 'Franklin Ave'
ORDER BY name;  -- Full name Annabel Miller,id = 16371, license id = 490173, address no = 103, ssn = 318771143

----------------- View Witness Interview ----------------------------------------------------------
SELECT *
FROM interview
WHERE person_id = '14887';  /*Morty Schapiro = I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z".
 Only gold members have those bags. The man got into a car with a plate that included "H42W".*/

SELECT *
FROM interview
WHERE person_id = '16371'; /*Annabel Miller = I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.*/

----------------------- Checking Gym Database---------------------------------------------------------

SELECT *
FROM get_fit_now_check_in
WHERE membership_id LIKE '%48Z%' AND check_in_date = 20180109; -- Two Members found with membership id = 48Z7A and 48Z55

----------------------------- Checking Car Details ----------------------------------------------------------
SELECT *
FROM drivers_license
WHERE plate_number LIKE '%H42W%';  -- Two men with id = 423327 and 664760 found

-------------------------------- Personal details------------------------------------------------------------
SELECT *
FROM person
WHERE license_id = 423327;  -- This one name Jeremy Bowers,license id = 423327, address no= 530, address street name = Washington Pl, Apt 3A, ssn = 871539279

SELECT *
FROM person
WHERE license_id = 664760;  -- This one named Tushar Chandra license id = 664760, address no = 312, address street name = Phi St, ssn = 137882671

-------------------------- Checking Membership status--------------------------------------------------------------

SELECT * 
FROM get_fit_now_member
WHERE name = 'Jeremy Bowers';

SELECT * 
FROM get_fit_now_member
WHERE person_id = 51739;
-------- All details are matching with Jeremy Bowers---------------------
/* So We can conclude that the murderer is Jeremy Bowers. But Wait there is a mastermind behind all this */ 

SELECT *
FROM interview
WHERE person_id = 67318; /* Jeremy transcript I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67").
She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.*/

----------------------- Checking her car details-----------------------------
SELECT *
FROM drivers_license
WHERE car_make = 'Tesla' AND car_model = 'Model S' AND hair_color = 'red' AND height BETWEEN 65 AND 67 ;
/* We got three suspects*/

-------------------------- Checking SQL symphony Concert-----------------------------------

SELECT *,count(person_id)
FROM facebook_event_checkin
group by person_id
having event_name = 'SQL Symphony Concert' AND date like '%201712%';
-- Two person id was found 24556 and 99716

----------------------------- Finding the mastermind---------------------------------------
SELECT *
FROM person
WHERE id = 24556;  ----- He's a male our culprit is female

SELECT *
FROM person
where id = 99716;
/* So mastermind behind the murder is Miranda Priestly */
