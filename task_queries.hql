-- task1
SELECT * FROM employees WHERE year(TO_DATE(join_date, 'yyyy-MM-dd')) > 2015;
-- task2
SELECT department, AVG(salary) AS avg_salary 
FROM employees 
GROUP BY department;

-- task3
SELECT * FROM employees WHERE project = 'Alpha';

-- task4
SELECT job_role, COUNT(*) AS employee_count 
FROM employees 
GROUP BY job_role;

-- task5
SELECT e.* 
FROM employees e 
JOIN (SELECT department, AVG(salary) AS avg_salary FROM employees GROUP BY department) d
ON e.department = d.department
WHERE e.salary > d.avg_salary;

-- task6
SELECT department FROM ( SELECT department, COUNT(*) AS emp_count FROM employees GROUP BY department ORDER BY emp_count DESC LIMIT 1 ) subquery;
-- task7
SELECT * FROM employees 
WHERE emp_id IS NOT NULL 
AND name IS NOT NULL 
AND age IS NOT NULL 
AND job_role IS NOT NULL 
AND salary IS NOT NULL 
AND project IS NOT NULL 
AND join_date IS NOT NULL 
AND department IS NOT NULL;

-- task8
SELECT e.*, d.location 
FROM employees e 
JOIN departments d 
ON e.department = d.department_name;

-- task9
SELECT emp_id, name, department, salary, 
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank 
FROM employees;

-- task10
SELECT emp_id, name, department, salary, salary_rank 
FROM (
    SELECT emp_id, name, department, salary, 
           RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank 
    FROM employees
) ranked_employees
WHERE salary_rank <= 3;

