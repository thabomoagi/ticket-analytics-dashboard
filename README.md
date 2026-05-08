# Ticket Analytics Dashboard (End-to-End Data Pipeline)

## Project Overview

This project simulates a real-world IT support ticketing system and builds an end-to-end data pipeline for analytics and operational reporting.

It demonstrates how raw operational data can be transformed into actionable business insights using **Python, SQL, and PostgreSQL**. The goal is to replicate how companies track support performance, SLA compliance, and team efficiency.

---

## Tech Stack

- **Language:** Python (Pandas, Faker)
- **Database:** PostgreSQL
- **Analytics:** SQL
- **Visualization:** Excel (PivotTables, Dashboards)
- **Version Control:** Git/GitHub

---

## System Architecture

1. **Data Generation:** Synthetic ticket data created using Python (Faker)
2. **Storage Layer:** CSV used as intermediate structured dataset
3. **Database Ingestion:** Python script loads data into PostgreSQL
4. **Analytics Layer:** SQL queries generate KPIs and operational insights
5. **Reporting Layer:** Excel dashboard with PivotTables and slicers for analysis

---

## Key Business Metrics

- SLA Breach Rate (compliance monitoring)
- Ticket volume by priority and category
- Agent performance (resolution time and workload distribution)
- Operational trends over time (daily ticket volume)

---

## How to Run Project

### 1. Install dependencies

```bash
pip install -r requirements.txt
```

---

### 2. Generate synthetic dataset

```bash
python scripts/generate_data.py
```

---

### 3. Load data into PostgreSQL

```bash
python scripts/load_to_db.py
```

---

### 4. Run SQL analytics

See:

```
sql/analytics_queries.sql
```

---

### 5. Excel Dashboard

Open:

```
excel/ticket_analytics_dashboard.xlsx
```

---

## What This Project Demonstrates

- End-to-end data pipeline design
- SQL-based business analytics
- Database integration (PostgreSQL)
- Data cleaning and transformation
- KPI-driven reporting systems
- Excel-based operational dashboards
