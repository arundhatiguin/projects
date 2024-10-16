CREATE DATABASE Healthcare
USE Healthcare
SELECT* FROM dbo.healthcare_dataset
sp_rename 'dbo.healthcare_dataset','healthcare'
SELECT COUNT(*) FROM healthcare;
SELECT MAX(age) as Maximum_Age from healthcare;
select round(avg(age),0) as Average_Age from healthcare;
SELECT age,COUNT(age) AS Total
FROM healthcare
GROUP BY age
ORDER BY Total DESC, age DESC;
SELECT age, COUNT(age), dense_RANK() OVER(ORDER BY COUNT(age) DESC, age DESC) as Ranking_Admitted 
FROM Healthcare
GROUP BY age
HAVING COUNT(age) > Avg(age);
SELECT Medical_Condition, COUNT(Medical_Condition) as Total_Patients 
FROM healthcare
GROUP BY Medical_Condition
ORDER BY Total_patients DESC;
SELECT Medical_Condition, Medication, COUNT(medication) as Total_Medications_to_Patients, RANK() OVER(PARTITION BY Medical_Condition ORDER BY COUNT(medication) DESC) as Rank_Medicine
FROM Healthcare
GROUP BY Medical_Condition, Medication
ORDER BY 1;
SELECT Insurance_Provider, COUNT(Insurance_Provider) AS Total 
FROM Healthcare
GROUP BY Insurance_Provider
ORDER BY Total DESC;
SELECT Hospital, COUNT(hospital) AS Total 
FROM Healthcare
GROUP BY Hospital
ORDER BY Total DESC;
SELECT Medical_Condition, Name, Hospital, DATEDIFF(day,Date_of_Admission,Discharge_date) as Number_of_Days, 
SUM(ROUND(Billing_Amount,2)) OVER(Partition by Hospital ORDER BY Hospital DESC) AS Total_Amount
FROM Healthcare
ORDER BY Medical_Condition;
SELECT Medical_Condition, Hospital, DATEDIFF(day,Date_of_Admission,Discharge_date) as Total_Hospitalized_days,Test_results
FROM Healthcare
WHERE Test_results LIKE 'Normal'
ORDER BY Medical_Condition, Hospital;
SELECT age, Blood_type, COUNT(Blood_Type) as Count_Blood_Type
FROM Healthcare
WHERE age BETWEEN 20 AND 45
GROUP BY age,Blood_type
ORDER BY Blood_Type DESC;
SELECT DISTINCT (SELECT Count(Blood_Type) FROM healthcare WHERE Blood_Type IN ('O-')) AS Universal_Blood_Donor, 
(SELECT Count(Blood_Type) FROM healthcare WHERE Blood_Type  IN ('AB+')) as Universal_Blood_reciever
FROM healthcare;
SELECT DISTINCT Hospital, Count(*) as Total_Admitted
FROM healthcare
WHERE YEAR(Date_of_Admission) IN (2024, 2025)
GROUP BY Hospital
ORDER by Total_Admitted DESC; 
SELECT Insurance_Provider, ROUND(AVG(Billing_Amount),0) as Average_Amount, ROUND(Min(Billing_Amount),0) as Minimum_Amount, ROUND(Max(Billing_Amount),0) as Maximum_Amount
FROM healthcare
GROUP BY Insurance_Provider;
SELECT Name, Medical_Condition, Test_Results,
CASE 
		WHEN Test_Results = 'Inconclusive' THEN 'Need More Checks / CANNOT be Discharged'
        WHEN Test_Results = 'Normal' THEN 'Can take discharge, But need to follow Prescribed medications timely' 
        WHEN Test_Results =  'Abnormal' THEN 'Needs more attention and more tests'
        END AS 'Status', Hospital, Doctor
FROM Healthcare;