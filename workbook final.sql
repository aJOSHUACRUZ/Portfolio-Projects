USE mydb;

/* ============================================================================ */
/* SECTION 1: SELECT statements                                                 */
/* ============================================================================ */

SELECT name, 
	   capital
FROM us_state
WHERE name = "California";

SELECT *
FROM us_state
WHERE area <= 1000;




/* ---- TASK 1 ---------------------------------------------------------------- */
/* Write an SQL statement to find out what is the state capital of Oregon       */
/* hint: the names of the columns you need are: name and capital                */
/* ---------------------------------------------------------------------------- */

SELECT name,
	   capital
FROM us_state
WHERE name = "Oregon";





/* ============================================================================ */
/* SECTION 2: SELECT statements with pattern matching and sorting               */
/* ============================================================================ */

SELECT *
FROM us_state
ORDER BY area_size DESC;

SELECT *
FROM us_state
WHERE name LIKE "M%"
ORDER BY name;




/* ---- TASK 2 ---------------------------------------------------------------- */
/* Write an SQL statement to display all the states with abbreviations that     */
/* start with the letter "N", sort your results by state capital                */
/* ---------------------------------------------------------------------------- */

SELECT name
FROM us_sate
WHERE abbreviation LIKE 'N%'
ORDER BY capital;

SELECT *
FROM us_state
WHERE LOWER(capital) LIKE "%a";




/* ============================================================================ */
/* SECTION 3: INSERT statements                                                 */
/* ============================================================================ */

INSERT INTO club_member
SET first_name = "Josh",
last_name = "Cruz",
phone_number = "09054257040";





/* ---- TASK 3 ---------------------------------------------------------------- */
/* Using the above example as a guide,                                          */
/* write an SQL statement to insert a new member into the table club_member     */
/* set first_name to "John", last_name to "Doe"                                 */
/* and phone_number to "9998887777"                                             */
/* ---------------------------------------------------------------------------- */


INSERT INTO club_member
SET first_name = "John",
last_name = "Doe",
phone_number = "9998887777";




/* ============================================================================ */
/* SECTION 4: DELETE statements                                                 */
/* ============================================================================ */

DELETE FROM club_member
WHERE first_name = "Josh"
AND last_name = "Cruz";




/* ---- TASK 4 ---------------------------------------------------------------- */
/* Using the above example as a guide,                                          */
/* write an SQL statement to delete the row in the table club_member            */
/* if the phone_number is "9998887777"                                          */  
/* ---------------------------------------------------------------------------- */


DELETE FROm club_member
WHERE phone_number = "9998887777";





/* ============================================================================ */
/* SECTION 5: Joining tables                                                    */
/* ============================================================================ */

SELECT c.member_id,
		first_name,
        last_name,
        description,
        amount,
        due_date
FROM club_member AS c
INNER JOIN invoice as i
ON c.member_id = i.member_id;




/* ---- TASK 5 ---------------------------------------------------------------- */
/* Using the above example as a guide,                                          */
/* write an SQL statement to:                                                   */
/*                                                                              */
/* 1. include these columns in your results:                                    */
/*    first_name, middle_name, last_name, professional_title, tier.description  */
/*                                                                              */
/* 2. your columns will come from the tables club_member and tier               */
/*                                                                              */
/* 3. linking the tier_code column of the table club_member                     */
/*    to the code column of the table tier                                      */                        
/*                                                                              */
/* 4. sort the results by last_name                                             */
/*                                                                              */
/* ---------------------------------------------------------------------------- */

SELECT  first_name,
		middle_name,
        last_name,
        professional_title,
        t.description AS description
FROM club_member AS c
INNER JOIN tier AS t
ON c.tier_code = t.code
WHERE middle_name IS NOT NULL
ORDER BY last_name;


USE writersdb;

SELECT title,
		author,
        pages,
        language_name
FROM submission AS s
INNER JOIN language AS l
ON s.language_code = l.language_code
WHERE pages > 150
ORDER BY title;






/* ============================================================================ */
/*                                                                              */
/* Congratulations, you have reached the end of the course!!                    */
/*                                                                              */
/* ============================================================================ */

