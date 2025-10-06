-- connect to SQL PLUS
connect sys/sys as sysdba

-- Create spool file
SPOOL C:\NRD_L11\NRD_L11.txt

-- clearwater
@ C:\NRD_L11\7clearwater.sql

-- Question #1
SELECT item_desc
FROM item
WHERE item_id IN (SELECT item_id
FROM inventory
WHERE inv_id IN(SELECT inv_id
FROM order_line
WHERE o_id IN(SELECT o_id 
FROM orders 
WHERE os_id = (SELECT os_id
FROM order_source
WHERE os_desc ='Web Site')))) UNION SELECT distinct item_desc
FROM inventory, item
WHERE item.item_id = inventory.item_id AND inv_id IN (SELECT inv_id
FROM shipment_line
WHERE sl_date_received is not NULL);

-- northwoods
@ C:\NRD_L11\7Northwoods.sql

-- Question #2
SELECT course_name
FROM course
WHERE course_id IN (SELECT course_id
FROM course_section
WHERE c_sec_id IN (SELECT c_sec_id
FROM enrollment
WHERE s_id = (SELECT s_id
FROM student
WHERE s_last = 'Miller' AND s_first = 'Sarah'))) INTERSECT SELECT course_name
FROM course
WHERE course_id IN (SELECT course_id
FROM course_section
WHERE c_sec_id IN (SELECT c_sec_id
FROM enrollment
WHERE s_id = (SELECT s_id
FROM student
WHERE s_last = 'Umato' AND s_first = 'Brian')));

-- Question #3
SELECT course_name
FROM course
WHERE course_id IN (SELECT course_id
FROM course_section
WHERE c_sec_id IN (SELECT c_sec_id
FROM enrollment
WHERE s_id = (SELECT s_id
FROM student
WHERE s_last = 'Miller' AND s_first = 'Sarah'))) MINUS SELECT course_name
FROM course
WHERE course_id IN (SELECT course_id
FROM course_section
WHERE c_sec_id IN (SELECT c_sec_id
FROM enrollment
WHERE s_id = (SELECT s_id
FROM student
WHERE s_last = 'Umato' AND s_first = 'Brian')));

-- Question #4
SELECT 'Faculty' AS source_table, s_first "First Name", s_last "Last Name"
FROM student 
UNION SELECT 'Student' AS source_table, f_first "First Name", f_last "Last Name"
FROM faculty;

-- software expert
@ C:\NRD_L11\7Software.sql

-- Question #5
SELECT skill_description
FROM skill
WHERE skill_id IN (SELECT skill_id
FROM consultant_skill
WHERE c_id = (SELECT c_id
FROM consultant
WHERE c_first = 'Sarah' AND c_last = 'Carlson')) MINUS
SELECT skill_description
FROM skill
WHERE skill_id IN (SELECT skill_id
FROM consultant_skill
WHERE c_id = (SELECT c_id
FROM consultant
WHERE c_first = 'Mark' AND c_last = 'Myers'));

-- Save spool
SPOOL OFF;