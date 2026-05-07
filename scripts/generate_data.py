from faker import Faker
import pandas as pd
import random
from datetime import datetime, timedelta

fake = Faker()

priorities = ["Low", "Medium", "High", "Critical"]

statuses = ["Open", "In progress", "Resolved", "Closed"]

categories = [
    "Password Reset",
    "Network issue",
    "Billing",
    "Software bug",
    "Hardware failure",
    "Email problem"
]

agents = [
    "Alice Lane",
    "William Nicole",
    "Wit Koppen",
    "Walt Sizulu"
]

data = []

for i in range(1000):
    created_date = fake.date_time_between(start_date="-6M", end_date="now")

    resolution_hours = random.randint(1, 72)

    resolved_date = created_date + timedelta(hours=resolution_hours)

    priority = random.choice(priorities)

    if priority == "Critical":
        is_it_late = resolution_hours > 4
    elif priority == "High":
        is_it_late = resolution_hours > 12
    elif priority == "Medium":
        is_it_late = resolution_hours > 24
    elif priority == "Low":
        is_it_late = resolution_hours > 48

    data.append({
        "ticket_id": i + 1,
        "created_date": created_date,
        "resolved_date": resolved_date,
        "priority": priority,
        "status": random.choice(statuses),
        "category": random.choice(categories),
        "assigned_agent": random.choice(agents),
        "resolution_hours": resolution_hours,
        "is_it_late": is_it_late
    })

pf = pd.DataFrame(data)

pf.to_csv("data/tickets.csv", index=False)

print("Successfully created and stored dataset into CSV")