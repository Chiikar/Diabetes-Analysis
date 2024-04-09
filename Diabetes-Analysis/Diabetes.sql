--An analysis for diabetes patients
--First thing is to create the database and import flat file into the database

--Create hospital database for analysis 
CREATE DATABASE Hospital_DB;


--switch to the database and use it 
USE Hospital_DB;
 

--Select diabetes table 

SELECT *
FROM diabetes;


--Count the total patients

SELECT COUNT(*) AS total_patients
FROM diabetes;



--Check the average insulin per patient 

SELECT AVG(Insulin) AS average_insulin
FROM diabetes;


--Calculate the total amount of patients who are pregnant 

SELECT SUM(Pregnancies) AS Sum_pregnancies 
FROM diabetes;


--Check average blood pressure of patients

SELECT AVG(BloodPressure) AS average_bloodpressure
FROM diabetes;


--Check average BMI(Body Max Index) of patients

SELECT AVG(BMI) AS average_bmi
FROM diabetes;


--Check average age of patients

SELECT AVG (Age) AS average_Age
FROM diabetes;


--Check average glucose for patients

SELECT AVG(Glucose) AS average_glucose
FROM diabetes;

--check average skin thickness of patients

SELECT AVG(SkinThickness) AS average_skinthickness
FROM diabetes;


--Check diabetes status on skin thickness

SELECT
    CASE
        WHEN SkinThickness <= 20 THEN 'Non-Diabetic'
        WHEN SkinThickness > 20 THEN 'Diabetic'
        ELSE 'Unknown'
    END AS DiabetesStatus,
    COUNT(*) AS TotalPatients
FROM
     diabetes
GROUP BY
    CASE
        WHEN SkinThickness <= 20 THEN 'Non-Diabetic'
        WHEN SkinThickness > 20 THEN 'Diabetic'
        ELSE 'Unknown'
END;



--Check the distribution of cases by DiabetesPedigreeFunction(DPF)

SELECT DiabetesPedigreeFunction,
    CASE
        WHEN DiabetesPedigreeFunction >= 0.8 THEN 'High Risk'
        WHEN DiabetesPedigreeFunction >= 0.5 AND DiabetesPedigreeFunction < 0.8 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Category,
    COUNT(*) AS Cases_Count
FROM diabetes
GROUP BY DiabetesPedigreeFunction, 
    CASE
        WHEN DiabetesPedigreeFunction >= 0.8 THEN 'High Risk'
        WHEN DiabetesPedigreeFunction >= 0.5 AND DiabetesPedigreeFunction < 0.8 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END
ORDER BY DiabetesPedigreeFunction;



--Summary of diabetes cases with DiabetesPedigreeFunction(DPF) by Age group

SELECT Age_Group, Risk_Category, SUM(Cases_Count) AS Total_Cases
FROM (
    SELECT
        CASE
            WHEN Age < 30 THEN 'Under 30'
            WHEN Age >= 30 AND Age < 50 THEN '30-49'
            WHEN Age >= 50 THEN '50 and Above'
        END AS Age_Group,
        CASE
            WHEN DiabetesPedigreeFunction >= 0.8 THEN 'High Risk'
            WHEN DiabetesPedigreeFunction >= 0.5 AND DiabetesPedigreeFunction < 0.8 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS Risk_Category,
        COUNT(*) AS Cases_Count
    FROM diabetes
    GROUP BY
        CASE
            WHEN Age < 30 THEN 'Under 30'
            WHEN Age >= 30 AND Age < 50 THEN '30-49'
            WHEN Age >= 50 THEN '50 and Above'
        END,
        CASE
            WHEN DiabetesPedigreeFunction >= 0.8 THEN 'High Risk'
            WHEN DiabetesPedigreeFunction >= 0.5 AND DiabetesPedigreeFunction < 0.8 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END
) AS RiskSummary
GROUP BY Age_Group, Risk_Category
ORDER BY Total_Cases DESC;



--The distribution of diabetes cases by Age
SELECT Age, COUNT(*) AS Diabetes_Cases
FROM diabetes
GROUP BY Age
ORDER BY Age ASC;




--To categorize patients based on their BMI (Body Mass Index) into categories such as underweight, normal weight, overweight, and obese, we will use the following BMI ranges
--Underweight: BMI less than 18.5
--Normal weight: BMI 18.5 to 24.9
--Overweight: BMI 25 to 29.9
--Obese: BMI 30 or greater

SELECT 
    CASE 
        WHEN BMI < 18.5 THEN 'Underweight'
        WHEN BMI >= 18.5 AND BMI <= 24.9 THEN 'Normal weight'
        WHEN BMI >= 25 AND BMI <= 29.9 THEN 'Overweight'
        WHEN BMI >= 30 THEN 'Obese'
    END AS BMI_Category,
    COUNT(*) AS Patients_Count
FROM diabetes
GROUP BY 
    CASE 
        WHEN BMI < 18.5 THEN 'Underweight'
        WHEN BMI >= 18.5 AND BMI <= 24.9 THEN 'Normal weight'
        WHEN BMI >= 25 AND BMI <= 29.9 THEN 'Overweight'
        WHEN BMI >= 30 THEN 'Obese'
    END
	ORDER BY Patients_Count DESC;


--Analyze the distribution of diabetes patients by age and outcome

SELECT 
    Age_Group,
    Outcome,
    COUNT(*) AS Patient_Count
FROM (
    SELECT 
        Age,
        CASE
            WHEN Outcome = 1 THEN 'Diabetic'
            ELSE 'Non-Diabetic'
        END AS Outcome,
        CASE
            WHEN Age < 30 THEN 'Under 30'
            WHEN Age >= 30 AND Age < 50 THEN '30-49'
            WHEN Age >= 50 THEN '50 and Above'
        END AS Age_Group
    FROM diabetes
) AS AgeOutcome
GROUP BY Age_Group, Outcome
ORDER BY Age_Group, Outcome ASC;



