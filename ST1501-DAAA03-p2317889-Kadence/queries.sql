use SPAI2317889

-- Qn 1
 SELECT 
   COUNT(CASE WHEN ParentModelID IS NULL THEN 1 END) AS FreshModel,
   COUNT(CASE WHEN ParentModelID IS NOT NULL THEN 1 END) AS FinetunedModel
 FROM Model;

-- Qn 2
SELECT
    MT.Model_Type AS ModelType,
    UnassignedModels.NumberUnassigned,
    CAST(AVG(M.Accuracy) AS DECIMAL(4, 1)) AS MeanAccuracy,
    MAX(M.Accuracy) AS MaxAccuracy
FROM
    ModelType MT
LEFT JOIN
    Model M ON MT.ModelCode = M.ModelCode
LEFT JOIN
    (
        SELECT 
            M.ModelCode, 
            COUNT(M.ModelID) AS NumberUnassigned
        FROM 
            Model M
        LEFT JOIN 
            Solution S ON M.ModelID = S.ModelID
        WHERE 
            S.ModelID IS NULL
        GROUP BY 
            M.ModelCode
    ) UnassignedModels ON MT.ModelCode = UnassignedModels.ModelCode
WHERE 
    UnassignedModels.NumberUnassigned > 0
GROUP BY
    MT.Model_Type, 
    UnassignedModels.NumberUnassigned
ORDER BY 
    MT.Model_Type;



-- Qn 3

SELECT 
    CONCAT(e.First_Name, ' ', e.Last_Name) AS FullName,
    e.Contact,
    e.Gender
FROM 
    Employee e
JOIN 
    (
        SELECT 
            EmployeeID
        FROM 
            Solution
        GROUP BY 
            EmployeeID, OrderID
        HAVING 
            COUNT(ModelID) > 1
    ) AS sub
ON 
    e.EmployeeID = sub.EmployeeID
ORDER BY 
    FullName;

-- Qn 4

SELECT COUNT(*) AS NumberOfAcceptedModels 
FROM Solution AS S
JOIN Model AS M ON S.ModelID = M.ModelID
JOIN Orders AS O ON S.OrderID = O.OrderID
JOIN ModelType AS MT ON M.ModelCode = MT.ModelCode

WHERE S.AssignmentDate <= O.Completion_Date 
  AND (O.Model_Type IS NULL 
       OR MT.Model_Type IN (SELECT TRIM(value) FROM STRING_SPLIT(O.Model_Type, ','))) 
  AND M.Accuracy >= (CASE WHEN O.ReqAccu = 1 THEN 75 ELSE 0 END); 


