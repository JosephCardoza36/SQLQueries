
1. The firstname, lastname, and gender of all runners in the 2018 Palmer 10K (raceid = 1)

SELECT firstname, lastname, gender
FROM runnerstbl
JOIN genderstbl ON genderid = genderfk
JOIN resultstbl ON runnerid = runnerfk
JOIN racestbl ON raceid = racefk
WHERE raceid = 1;

2. The number of males and females who ran in the Mount Marathon Race

SELECT COUNT(*) AS gender, racename
FROM genderstbl
JOIN runnerstbl ON genderid = genderfk
JOIN resultstbl ON runnerid = runnerfk
JOIN racestbl ON raceid = racefk 
WHERE racename = 'Mount Marathon Race'
GROUP BY gender;

3. The three fastest times in the Great Valdez Road Race

SELECT firstname, lastname, racename, endtime, racedate
FROM genderstbl
JOIN runnerstbl ON genderid = genderfk
JOIN resultstbl ON runnerid = runnerfk
JOIN racestbl ON raceid = racefk 
WHERE racename = 'Great Valdez Road Race'
GROUP BY endtime DESC
LIMIT 3;

4. The average time to complete each race (by raceid, 2 listings for Palmer 10K)

SELECT racename, raceid, SUBTIME(endtime, starttime) AS average_time
FROM resultstbl
JOIN racestbl ON raceid = racefk
GROUP BY raceid;


5. A count of the number of races by race type

SELECT racetype, COUNT(raceid) AS races
FROM racetypestbl
JOIN racestbl ON racetypeid = racetypefk
GROUP BY racetype;

6. The number of men in each race

SELECT COUNT(gender) AS male_racers, racename
FROM genderstbl
JOIN runnerstbl ON genderid = genderfk
JOIN resultstbl ON runnerid = runnerfk
JOIN racestbl ON raceid = racefk
WHERE gender = 'Male'
GROUP BY racename;

7. All runners under the age of 23

SELECT firstname, lastname, FLOOR(DATEDIFF(NOW(), birthday)/365.25) AS age
FROM runnerstbl
WHERE FLOOR(DATEDIFF(NOW(), birthday)/365.25)<23;


8. The names of the three slowest runners in descending order

SELECT firstname, lastname, SUBTIME(endtime, starttime)
FROM resultstbl
JOIN runnerstbl ON runnerid = runnerfk
GROUP BY SUBTIME(endtime, starttime) DESC
LIMIT 3;


9. The fastest time for each race (by race name, time)

SELECT racename, MIN(SUBTIME(endtime, starttime)) AS fastest_time
FROM racestbl
JOIN resultstbl ON raceid = racefk
GROUP BY racename;


10. Delete all females who are over 25 years old

DELETE FROM runnerstbl WHERE FLOOR(DATEDIFF(NOW(), birthday)/365.25) > 25 AND genderfk = 1;

11. Update the age of all males have to be 24

UPDATE runnerstbl
SET birthday = DATE_FORMAT(birthday, '1998-%m-%d')
WHERE genderfk = 2;

