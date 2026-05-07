import os
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()

password = os.getenv("DB_PASSWORD")

df = pd.read_csv("data/tickets.csv")

df["created_date"] = pd.to_datetime(df["created_date"])
df["resolved_date"] = pd.to_datetime(df["resolved_date"])

engine = create_engine(f"postgresql+psycopg2://postgres:{password}@localhost:5432/ticket_db")

df.to_sql("tickets", engine, if_exists="replace", index=False)

print("Data loaded successfully into Postgresql")