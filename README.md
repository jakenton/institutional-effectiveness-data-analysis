# Institutional Effectiveness & Equity Dashboard (Accreditation-Ready)

This project details the development of a production-ready **Institutional Effectivess (IE) Dashboard** designed to meet rigorous regional accreditation standards. The solution moves beyond simple descriptive statistics to quantify **equity gaps** and program efficacy using advanced analytical metrics, transforming institutional data into auditable, actionable intelligence.

**The primary goal was to create a single source of truth for all student success metrics, focused on proving program value and justifying strategic resource reallocation.**

## Technical Stack & Artchitecture
| Layer               | Tool                          | Purpose in Proj                                                                                                             |
| ------------------- | ----------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Data Governance     | PostrgreSQL / SQL             | Schema definition, complex cohort estrablishment, and efficient aggregation using **Window Functions**.                     |
| Analysis & Modeling | Power BI / DAX                | Visualization, time intelligence, and calculation of high-stakes analytical metrics like the **Relative Risk Ratio (RRR)**. |
| Auditability        | Institutional Data Dictionary | Mandatory documentation and quality control to ensure data trail is verifiable for accreditation review                     |

## Strategic Pillars of the Dashboard

The solution is built on three strategic pillars, ensuring alignment with institutional priorities:

**Pillar 1: Regulatory Compliance and Core Performance (DFW Rates)**
This foundational layer provides a real-time health check on the institutions most vital academic metrics, fulfilling the core accreditation mandate to monitor student outcomes.
- **Objective:** Track academic success across all departmetns and courses to rapidly identify areas of risk (e.g., high failure/withdrawal rates).
- **Technical Execution:**
    1. **SQL:** Used to aggregate raw `FACT_COURSE_SUCCESS` data, calculating the total number of D, F, or W grades by Department ( `DFW Rates` ).
    2. **Visualization:** Uses simple, high-impact visuals (e.g., Bullet Charts or Heatmaps) to compare current performance against pre-defined internal or accreditor thresholds.
- **Strategic Value:** Provides an **early warning system** for department heads and deans, allowing immediate curriculum review or instructional intervention before academic non-compliance risks escalate.

**Pillar 2: Quantifying Equity Gaps and Program Efficacy (The RRR Metric)**
This is the central analytical innovation of the dashboard. It shifts the focus from simple rate comparison to quantifying disparity as an **effect size**, providing irrefutable evidence for program funding.
- **Objective:** Rigorously evaluate the effectiveness of student success programs and measure disparities in retention across demographic groups (the **Equity Gap**).
- **Technical Execution:**
    1. **SQL Preparation:** Data is aggregated based on two dimensions: `DemographicGroup` and `Program_Participated` to establish the necessary baseline baseline counts.
    - **Advanced DAX:** Calculation of the **Relative Risk Ratio (RRR)** is implemented via custom DAX measures ( `Target Rate (Participants)` / `Reference Rate (Non-Participants)` ).
- **Strategic Value:** The RRR provides quantifiable evidence to justify targeted resource allocation. It directly answers the question: "Is this program moving the needle on equity, and by how much?".

**Pillar 3: Data Governance and Auditability (Accreditation Mandate)**
Given the high-stakes nature of accreditation reporting, the project emphasizes data quality and a verifiable train from raw input to final output, reflecting best practices from regulatory environments.
- **Objective:** Ensure the dashboard is trusted, verifiable, and capable of withstanding a formal compliance audit.
- **Technical Execution:**
    1. **Data Dictionary:** A comprehensive dictionary was created, explicitly defining every variable, coding scheme (e.g., `1 = Retained, 0 = Not Retained` ), and source metadata. This documentation minimizes compliance risk.
    - **Power BI Certification:** The final dataset is formally **Certified** within the Power BI Service, designating it as the institutional "single source of truth" validated by a formal Quality Assurance (QA) protocol.
- **Strategic Value:** This layer operationalizes trust. Administrators can confidently use the report for high-stakes decisions, knowing the underlying data and calculation have been rigorously audited and documented.

This project showcases expertise in database architecture, advanced analytical modeling, and regulatory-compliant data governance.

---
---

# Update to SQL

Refactored the data ingestion and preprocessing workflow to include two new high-value features for the retention model:

1. **SQL (Extraction / Transformation):** Modified the CTE query to add two new columns at the database level: `term_gpa_risk_category` (conditional logic) and `avg_gpa_by_ethnicity` (window function).

2. **Python (Prepocessing):** Updated the pandas pipeline (`clean_and_prepare_data`) to handle missing values and perform one-hot encoding on the newly extracted categorical feature (`term_gpa_risk_category`).