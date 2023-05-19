/*Find all the topics and tasks taught in the month of October:*/
SELECT t.name AS topic_name, ts.description AS task_description
FROM Topics t
JOIN Tasks ts ON t.topic_id = ts.topic_id
WHERE MONTH(ts.date) = 10;

/*Find all the company drives that appeared between 15th October 2020 and 31st October 2020:*/
SELECT cd.name AS company_drive_name
FROM CompanyDrives cd
WHERE cd.date BETWEEN '2020-10-15' AND '2020-10-31';

/*Find all the company drives and students who appeared for the placement:*/
SELECT cd.name AS company_drive_name, u.name AS student_name
FROM CompanyDrives cd
JOIN Attendance a ON cd.company_drive_id = a.company_drive_id
JOIN Users u ON a.user_id = u.user_id;

/*Find the number of problems solved by the user in CodeKata:*/
SELECT u.name AS user_name, COUNT(*) AS problems_solved
FROM Users u
JOIN Attendance a ON u.user_id = a.user_id
WHERE a.status = 'Present' AND a.codekata_id = [codekata_id]
GROUP BY u.user_id;

/*Find all the mentors who have more than 15 mentees:*/
SELECT m.name AS mentor_name, COUNT(*) AS mentee_count
FROM Mentors m
JOIN Users u ON m.mentor_id = u.mentor_id
GROUP BY m.mentor_id
HAVING COUNT(*) > 15;

/*Find the number of users who were absent and task not submitted between 15th October 2020 and 31st October 2020:*/
SELECT COUNT(*) AS count
FROM Attendance a
WHERE a.status = 'Absent' AND a.task_submitted = false AND a.date BETWEEN '2020-10-15' AND '2020-10-31';
