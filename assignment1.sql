-- MySQL Class Quiz Assignment
-- Student:

-- Create Database
CREATE DATABASE school_db;
USE school_db;

-- Question 1: Create tables with constraints
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    teacher VARCHAR(50)
);

CREATE TABLE enrollment (
    student_id INT,
    course_id INT,
    grade CHAR(2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Add sample data
INSERT INTO students VALUES 
(1, 'John Smith', 'john@email.com', 20),
(2, 'Mary Johnson', 'mary@email.com', 19),
(3, 'Bob Wilson', 'bob@email.com', 21);

INSERT INTO courses VALUES 
(101, 'Math', 'Dr. Brown'),
(102, 'English', 'Ms. Davis'),
(103, 'History', 'Mr. Lee');

INSERT INTO enrollment VALUES 
(1, 101, 'A'),
(1, 102, 'B'),
(2, 101, 'B'),
(2, 103, 'A'),
(3, 102, 'C'),
(3, 103, 'B');

-- Question 2: Different types of joins

-- INNER JOIN
SELECT students.name, courses.course_name, enrollment.grade
FROM students
INNER JOIN enrollment ON students.student_id = enrollment.student_id
INNER JOIN courses ON enrollment.course_id = courses.course_id;

-- LEFT JOIN
SELECT students.name, courses.course_name, enrollment.grade
FROM students
LEFT JOIN enrollment ON students.student_id = enrollment.student_id
LEFT JOIN courses ON enrollment.course_id = courses.course_id;

-- RIGHT JOIN
SELECT students.name, courses.course_name, enrollment.grade
FROM students
RIGHT JOIN enrollment ON students.student_id = enrollment.student_id
RIGHT JOIN courses ON enrollment.course_id = courses.course_id;

-- FULL JOIN (MySQL version)
SELECT students.name, courses.course_name
FROM students
LEFT JOIN enrollment ON students.student_id = enrollment.student_id
LEFT JOIN courses ON enrollment.course_id = courses.course_id
UNION
SELECT students.name, courses.course_name
FROM students
RIGHT JOIN enrollment ON students.student_id = enrollment.student_id
RIGHT JOIN courses ON enrollment.course_id = courses.course_id;

-- Question 3: Create indexes
CREATE INDEX idx_email ON students(email);
CREATE INDEX idx_course_name ON courses(course_name);

-- Question 4: Create a view
CREATE VIEW student_grades AS
SELECT 
    students.name AS student_name,
    courses.course_name,
    courses.teacher,
    enrollment.grade
FROM students
INNER JOIN enrollment ON students.student_id = enrollment.student_id
INNER JOIN courses ON enrollment.course_id = courses.course_id;

-- Use the view
SELECT * FROM student_grades;