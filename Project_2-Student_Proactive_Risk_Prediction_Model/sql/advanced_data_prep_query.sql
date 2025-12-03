-- ADVANCED SQL EXAMPLE: FEATURE ENGINEERING FOR RISK MODEL
-- This query joins data from multiple simulated source systems (Demographics, Academic Snapshot, Financial Aid) and uses conditional aggregation (CASE WHEN) to calculate a key derived feature (Term GPA Status).

WITH Joined_Data AS (
    -- Step 1: Combines data from the three distinct source tables (simulating ERP/RCM/etc. systems)
    SELECT
        s.student_id,
        s.cumulative_gpa,
        s.credit_hours_attempted,
        s.term_gpa,
        s.is_first_gen_student,
        s.age_at_enrollment,
        s.next_term_status,
        d.ethnicity_code,
        d.gender,
        f.received_financial_aid
    FROM
        student_academic_snapshot s
    LEFT JOIN
        student_demographics d ON s.student_id = d.student_id
    LEFT JOIN
        financial_aid_status f ON s.student_id = f.student_id
    WHERE
        s.term_code = '2024FA' 
        AND s.is_active = TRUE
)

-- Step 2: Performs feature engineering and select final columns
SELECT
    student_id,
    -- TARGET VARIABLE (1=retained, 0=not retained)
    CASE WHEN next_term_status = 'Enrolled' THEN 1 ELSE 0 END AS is_retained,
    
    -- PREDICTOR VARIABLES (Features)
    cumulative_gpa AS gpa_cumulative,
    credit_hours_attempted AS attempted_credits,
    is_first_gen_student AS first_gen,
    age_at_enrollment AS age,
    received_financial_aid AS financial_aid,
    ethnicity_code,
    gender,
    
    -- NEW ENGINEERED FEATURE 1: Conditional Logic (Risk Category)
    CASE
        WHEN term_gpa >= 3.50 THEN 'High_Performance'
        WHEN term_gpa >= 2.50 AND term_gpa < 3.50 THEN 'Mid_Performance'
        ELSE 'Low_Performance_Risk'
    END AS term_gpa_risk_category,

    -- NEW ENGINEERED FEATURE 2: Window Function (Cohort Metric)
    AVG(cumulative_gpa) OVER (PARTITION BY ethnicity_code) AS avg_gpa_by_ethnicity

FROM
    Joined_Data;