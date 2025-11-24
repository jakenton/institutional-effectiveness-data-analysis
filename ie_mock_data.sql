-- Institutional Effectiveness and Equity Dashboard
-- Purpose: Mock data set simulating aggregated cohort retention metrics

-- This script provides the necessary pre-aggregated data (Initial_N and Retained_Count) to calculate Retention Rate (%) and the Relative Risk Ratio (RRR) in Power BI.

-- 1. Drop the table if it exists to ensure a clean run
DROP TABLE IF EXISTS ie_program_evaluation_metrics;

-- 2. Create the table structure
CREATE TABLE ie_program_evaluation_metrics (
    Demographic_Group VARCHAR(50),
    Program_Participated VARCHAR(30),
    Initial_N INTEGER,
    Retained_Count INTEGER,
    Retention_Rate_P DECIMAL(4, 3)
);

-- Insert data for Hispanic/Latino Group (Target Group)
-- RRR calculation should be (75.0% / 60.0%) = 1.25
INSERT INTO ie_program_evaluation_metrics (Demographic_Group, Program_Participated, Initial_N, Retained_Count) VALUES
('Hispanic/Latino', 'Yes', 60, 45),    -- Retention Rate: 75.0%
('Hispanic/Latino', 'No', 240, 144);   -- Retention Rate: 60.0%

-- Insert data for Non-Hispanic Group (Control Group)
-- RRR calculation should be (75.0% / 65.0%) = 1.15
INSERT INTO ie_program_evaluation_metrics (Demographic_Group, Program_Participated, Initial_N, Retained_Count) VALUES
('Non-Hispanic', 'Yes', 40, 30),       -- Retention Rate: 75.0%
('Non-Hispanic', 'No', 160, 104);      -- Retention Rate: 65.0%

-- Insert Institutional Total (This represents the institutional average, not used in RRR calculation)
INSERT INTO ie_program_evaluation_metrics (Demographic_Group, Program_Participated, Initial_N, Retained_Count) VALUES
('INSTITUTIONAL TOTAL', 'Combined', 500, 323); -- Overall Retention Rate: 64.6%