# Hive Queries and Execution Commands

## **1. Setup and Load Data**
### **Start Docker Containers**
Before running queries, ensure that your Docker containers are up and running:
```bash
docker compose up -d
```

### **Access the Hive Server**
```bash
docker exec -it hive-server /bin/bash
beeline -u jdbc:hive2://localhost:9083
```

### **Load Data into Hive Tables**
Assuming the CSV files are already uploaded to HDFS:
```sql
LOAD DATA INPATH '/user/hive/warehouse/employees.csv' INTO TABLE employees;
LOAD DATA INPATH '/user/hive/warehouse/departments.csv' INTO TABLE departments;
```

---

## **2. Hive Queries**
### **Task 1: Retrieve Employees Who Joined After 2015**
```sql
SELECT * FROM employees WHERE year(TO_DATE(join_date, 'yyyy-MM-dd')) > 2015;
```

### **Task 2: Find the Average Salary in Each Department**
```sql
SELECT department, AVG(salary) AS avg_salary FROM employees GROUP BY department;
```

### **Task 3: Identify Employees Working on the 'Alpha' Project**
```sql
SELECT * FROM employees WHERE project = 'Alpha';
```

### **Task 4: Count the Number of Employees in Each Job Role**
```sql
SELECT job_role, COUNT(*) AS employee_count FROM employees GROUP BY job_role;
```

### **Task 5: Retrieve Employees Earning Above the Average Salary in Their Department**
```sql
SELECT e.*
FROM employees e
JOIN (SELECT department, AVG(salary) AS avg_salary FROM employees GROUP BY department) d
ON e.department = d.department
WHERE e.salary > d.avg_salary;
```

### **Task 6: Find the Department with the Highest Number of Employees**
```sql
SELECT department FROM (
    SELECT department, COUNT(*) AS emp_count FROM employees
    GROUP BY department
    ORDER BY emp_count DESC LIMIT 1
) subquery;
```

### **Task 7: Exclude Employees with Null Values in Any Column**
```sql
SELECT * FROM employees
WHERE emp_id IS NOT NULL
AND name IS NOT NULL
AND age IS NOT NULL
AND job_role IS NOT NULL
AND salary IS NOT NULL
AND project IS NOT NULL
AND join_date IS NOT NULL
AND department IS NOT NULL;
```

### **Task 8: Join Employees and Departments Tables to Display Employee Details with Location**
```sql
SELECT e.*, d.location FROM employees e
JOIN departments d
ON e.department = d.department_name;
```

### **Task 9: Rank Employees Within Each Department Based on Salary**
```sql
SELECT emp_id, name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
FROM employees;
```

### **Task 10: Find the Top 3 Highest-Paid Employees in Each Department**
```sql
SELECT emp_id, name, department, salary, salary_rank FROM (
    SELECT emp_id, name, department, salary,
           RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
    FROM employees
) ranked_employees
WHERE salary_rank <= 3;
```

---

## **3. Export Query Results**
Redirect query outputs to HDFS:
```sql
INSERT OVERWRITE DIRECTORY '/user/hive/output/task1' ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT * FROM employees WHERE year(TO_DATE(join_date, 'yyyy-MM-dd')) > 2015;
```
*(Repeat for all queries, changing the output directory accordingly.)*


## **4. Copy Hive Output from HDFS to Local Machine (GitHub Codespace)**
### **Step 1: Copy from HDFS to Namenode Local Filesystem**
```bash
docker exec -it namenode /bin/bash
hdfs dfs -get /user/hive/output/ ~/output_local/
exit
```

### **Step 2: Copy from Namenode to Codespace Filesystem**
```bash
docker cp namenode:/root/output_local/ ~/output_local/
```

### **Step 3: Move Files to the Workspace (for GitHub Commit)**
```bash
mv ~/output_local/ /workspaces/{your-repo-name}/output/
```
Replace `{your-repo-name}` with your actual repository name.




