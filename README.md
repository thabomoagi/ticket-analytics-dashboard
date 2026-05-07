# Ticket Analytics Dashboard (End-to-End Data Pipeline)

## Project Overview

This project simulates a real-world IT support ticketing system and builds an end-to-end data pipeline for analytics and operational reporting.

It demonstrates how raw operational data can be transformed into actionable business insights using **Python, SQL, and PostgreSQL**. The goal is to replicate how companies track support performance, SLA compliance, and team efficiency.

---

## Tech Stack

- **Language:** Python (Pandas, Faker, SQLAlchemy)
- **Database:** PostgreSQL
- **Analytics:** SQL
- **Visualization:** Power BI
- **Version Control:** Git/GitHub

---

## System Architecture

1. **Data Generation:** Synthetic ticket data created via Python (Faker).
2. **Storage:** Data saved to CSV for auditability.
3. **Ingestion:** Automated pipeline loads CSV data into a PostgreSQL database.
4. **Analytics:** Structured SQL queries calculate business KPIs (SLA rates, Agent speed).
5. **Reporting:** (In Progress) Power BI dashboard for executive visualization.

---

## Key Business Metrics Analyzed

- **SLA Breach Rate:** Percentage of tickets missing their resolution deadline.
- **Workload Drivers:** Ticket volume categorized by priority and department.
- **Agent Efficiency:** Average resolution time per agent vs. breach counts.
- **Trend Analysis:** Daily ticket volume spikes and operational load.

---

## How to Run

1. **Install dependencies:**

   ```bash
   pip install -r requirements.txt

   ```

2. **Install dependencies:**

   ```bash
   python scripts/generate_data.py

   ```

3. **Load data into PostgreSQL:**

   ```bash
   python scripts/load_to_db.py

   ```

4. **Run SQL analytics:**
   ```bash
   Refer to scripts/analytics_queries.sql for KPI logic.
   ```
