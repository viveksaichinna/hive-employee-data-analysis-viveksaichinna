import pandas as pd
import random
from faker import Faker

fake = Faker()

# Generate employee dataset
def generate_employees(num_records=1000):
    data = []
    departments = ['HR', 'IT', 'Finance', 'Marketing', 'Operations']
    job_roles = ['Analyst', 'Manager', 'Developer', 'Consultant', 'Engineer']
    projects = ['Alpha', 'Beta', 'Gamma', 'Delta', 'Omega','Project1','Project2','Project3','Project4','Project5','Project6']
    
    for emp_id in range(1, num_records + 1):
        name = fake.name()
        age = random.randint(22, 60)
        job_role = random.choice(job_roles)
        salary = round(random.uniform(40000, 150000), 2)
        project = random.choice(projects)
        join_date = fake.date()
        department = random.choice(departments)
        
        data.append([emp_id, name, age, job_role, salary, project, join_date, department])
    
    df = pd.DataFrame(data, columns=['emp_id', 'name', 'age', 'job_role', 'salary', 'project', 'join_date', 'department'])
    df.to_csv('employees.csv', index=False)
    print("employees.csv generated successfully!")

# Generate department dataset
def generate_departments():
    departments = [
        [1, 'HR', 'New York'],
        [2, 'IT', 'San Francisco'],
        [3, 'Finance', 'Chicago'],
        [4, 'Marketing', 'Los Angeles'],
        [5, 'Operations', 'Seattle']
    ]
    df = pd.DataFrame(departments, columns=['dept_id', 'department_name', 'location'])
    df.to_csv('departments.csv', index=False)
    print("departments.csv generated successfully!")

# Generate data files
generate_employees()
generate_departments()
