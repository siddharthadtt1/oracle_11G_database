SELECT * FROM TAB;

-- CREATE TABLE EMP WITH PRIMARY KEY AS (emp_id)
CREATE TABLE EMP(
    emp_id NUMBER(4, 0),
    emp_name VARCHAR2(26),
    emp_salary NUMBER(8,2),
    CONSTRAINT emp_col1_id_pk PRIMARY KEY (emp_id)
);

INSERT INTO EMP VALUES (1, 'Sid', 2000);
INSERT INTO EMP VALUES (2, 'Ramesh', 3000);
INSERT INTO EMP VALUES (3, 'Sachin', 1500);
INSERT INTO EMP VALUES (4, 'Suresh', 3500);
INSERT INTO EMP VALUES (5, 'Ajay', 1000);
INSERT INTO EMP VALUES (6, 'Ramesh', 3000);
INSERT INTO EMP VALUES (7, 'Sid', 2000);
INSERT INTO EMP VALUES (8, 'Sachin', 1500);
INSERT INTO EMP VALUES (9, 'Mike', 4000);

SELECT * FROM EMP;

-- QUERY TO FIND SECOND HIGHEST SALARY IN EMP TABLE
-- USING ROWNUM
SELECT E1.*
FROM EMP E1
WHERE 2 = (SELECT COUNT(DISTINCT E2.EMP_SALARY) FROM EMP E2 WHERE E1.EMP_SALARY <= E2.EMP_SALARY);

-- USING DENSE_RANK
SELECT E2.*
FROM (SELECT DENSE_RANK() OVER (ORDER BY E1.EMP_SALARY DESC) AS RNK, E1.*
FROM EMP E1) E2
WHERE E2.RNK = 2;


-- QUERY TO FIND DUPLICATE ROWS IN TABLE
SELECT E.*
FROM EMP E
WHERE E.ROWID != (SELECT MAX(E1.ROWID) FROM EMP E1 WHERE E1.EMP_NAME = E.EMP_NAME);

-- FETCH MONTHLY SALARY OF EMP TABLE
SELECT E.* , ROUND((E.EMP_SALARY/12)) AS MONTHLY_SALARY
FROM EMP E;

-- QUERY TO FETCH THE FIRST RECORD FROM EMP TABLE
SELECT E.*
FROM EMP E
WHERE ROWID = (SELECT MIN(ROWID) FROM EMP E1);

-- QUERY TO FETCH THE LAST RECORD FROM EMP TABLE
SELECT E.*
FROM EMP E
WHERE ROWID = (SELECT MAX(ROWID) FROM EMP E2);


-- DISPLAY FIRST 5 RECORDS FROM EMP
SELECT E.*
FROM EMP E
WHERE ROWNUM <= 5;

-- DISPLAY LAST 5 RECORDS FROM EMP
SELECT E1.*
FROM (SELECT E2.* FROM EMP E2 ORDER BY ROWID DESC) E1
WHERE ROWNUM <= 5;

-- DISPLAY ODD ROWS IN EMP
SELECT E1.*
FROM (SELECT E.*, ROWNUM AS RNO
FROM EMP E) E1
WHERE MOD(E1.RNO, 2) = 1;

-- DISTINCT RECORDS FROM TABLE EMP WITHOUT USING DISTINCT KEYWORD
SELECT E1.* 
FROM EMP E1
WHERE ROWID = (SELECT MIN(E2.ROWID) FROM EMP E2 WHERE E1.EMP_NAME = E2.EMP_NAME);

-- SELECT ALL RECORDS FROM EMP WHOSE NAME IS Ramesh, Ajay & Sid
SELECT E.*
FROM EMP E
WHERE E.EMP_NAME IN ('Ramesh', 'Ajay', 'Sid');

-- WRITE SQL TO PRINT ORACLE
SELECT SUBSTR('ORACLE', level, 1) FROM DUAL
CONNECT BY level <= LENGTH('ORACLE');

-- FETCH ALL RECORDS FROM EMPLOYEE WHOSE JOINING MONTH IS JAN
SELECT E.*
FROM EMPLOYEES E
WHERE TO_CHAR(E.HIRE_DATE, 'MM') = 1;


-- QUERY TO FIND MAXIMUM SALARY OF EACH DEPARTMENT
SELECT E1.*
FROM EMPLOYEES E1, 
(SELECT MAX(E.SALARY) SALARY, E.DEPARTMENT_ID DEPT_ID
FROM EMPLOYEES E
GROUP BY E.DEPARTMENT_ID) E2
WHERE E1.SALARY = E2.SALARY AND E1.DEPARTMENT_ID = E2.DEPT_ID;
