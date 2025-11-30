-- SIMULATED DATA SETUP: Student Proactive Risk Prediction Model

--
-- Instructions: Copy and paste the entire script into a single query window
-- in pgAdmin (connected to 'institutional_effectiveness_db') and execute it.
-- This will create the three required tables and populate them with 10 sample records.

-- DROPs existing tables if they exist to allow for clean re-run
DROP TABLE IF EXISTS financial_aid_status;
DROP TABLE IF EXISTS student_academic_snapshot;
DROP TABLE IF EXISTS student_demographics;

-- 1. student_demographics Table

CREATE TABLE student_demographics (
student_id VARCHAR(10) PRIMARY KEY,
ethnicity_code VARCHAR(50),
gender VARCHAR(10)
);

INSERT INTO student_demographics (student_id, ethnicity_code, gender) VALUES
('S1001', 'Hispanic', 'Male'),
('S1002', 'White', 'Female'),
('S1003', 'Asian', 'Female'),
('S1004', 'Black', 'Male'),
('S1005', 'White', 'Female'),
('S1006', 'Hispanic', 'Male'),
('S1007', 'Asian', 'Male'),
('S1008', 'Black', 'Female'),
('S1009', 'White', 'Male'),
('S1010', 'Hispanic', 'Female');

-- 2. financial_aid_status Table

CREATE TABLE financial_aid_status (
student_id VARCHAR(10) PRIMARY KEY,
received_financial_aid BOOLEAN
);

INSERT INTO financial_aid_status (student_id, received_financial_aid) VALUES
('S1001', TRUE),  -- High aid, retained
('S1002', TRUE),  -- High aid, retained
('S1003', FALSE), -- No aid, retained
('S1004', FALSE), -- No aid, high risk
('S1005', TRUE),  -- High aid, high risk
('S1006', TRUE),
('S1007', FALSE),
('S1008', TRUE),
('S1009', FALSE),
('S1010', TRUE);

-- 3. student_academic_snapshot Table

-- Note: '2024FA' and 'TRUE' for term_code and is_active are required for the Python query.
-- Students 1, 2, 3, 6, 7 are retained (Enrolled).
-- Students 4, 5, 8, 9, 10 are not retained (Dropped, Graduated, or Withdrawn).

CREATE TABLE student_academic_snapshot (
student_id VARCHAR(10) PRIMARY KEY,
term_code VARCHAR(10),
is_active BOOLEAN,
next_term_status VARCHAR(50),
term_gpa DECIMAL(3, 2),
cumulative_gpa DECIMAL(3, 2),
credit_hours_attempted INT,
is_first_gen_student BOOLEAN,
age_at_enrollment INT
);

INSERT INTO student_academic_snapshot (student_id, term_code, is_active, next_term_status, term_gpa, cumulative_gpa, credit_hours_attempted, is_first_gen_student, age_at_enrollment) VALUES
-- HIGH RETENTION / LOW RISK EXAMPLES
('S1001', '2024FA', TRUE, 'Enrolled', 3.85, 3.70, 15, FALSE, 19),
('S1002', '2024FA', TRUE, 'Enrolled', 3.50, 3.45, 12, TRUE, 22),
('S1003', '2024FA', TRUE, 'Enrolled', 4.00, 3.98, 16, FALSE, 20),
-- HIGH RISK / DROPOUT EXAMPLES
('S1004', '2024FA', TRUE, 'Dropped', 1.50, 1.75, 9, TRUE, 25),
('S1005', '2024FA', TRUE, 'Withdrawn', 2.10, 2.05, 12, FALSE, 18),
-- MIXED EXAMPLES
('S1006', '2024FA', TRUE, 'Enrolled', 2.90, 2.70, 15, TRUE, 21),
('S1007', '2024FA', TRUE, 'Enrolled', 2.80, 2.95, 12, FALSE, 28),
('S1008', '2024FA', TRUE, 'Dropped', 1.95, 2.15, 15, TRUE, 23),
('S1009', '2024FA', TRUE, 'Withdrawn', 2.25, 2.20, 9, FALSE, 20),
('S1010', '2024FA', TRUE, 'Graduated', 3.10, 3.05, 12, TRUE, 30);