# Ticket Analytics Data Pipeline

## Project Overview

An end-to-end analytics engineering project that transforms raw IT support ticket data into production-ready business intelligence models. Built to demonstrate modern data stack practices: data generation, transformation, testing, documentation, and operational reporting.

This project simulates a real-world support ticketing system and applies analytics engineering best practices using **dbt, PostgreSQL, and Python**.

## At a Glance

| | |
| --- | --- |
| dbt models | 1 staging view + 4 mart tables |
| Data quality | **23 built-in dbt tests + 1 custom SQL test** |
| Documentation | Auto-generated dbt docs with model lineage |
| Reusable logic | 1 macro (`calculate_sla_status`) shared across models |

---

## Tech Stack

| Layer           | Tool                                        |
| --------------- | ------------------------------------------- |
| Data Generation | Python (Faker, Pandas)                      |
| Database        | PostgreSQL                                  |
| Transformation  | dbt (data build tool)                       |
| Testing         | dbt built-in + custom SQL tests             |
| Documentation   | dbt auto-generated docs                     |
| Visualization   | Power BI / Tableau (connected to dbt marts) |
| Version Control | Git / GitHub                                |

---

## Data Architecture

raw.tickets (CSV → Postgres)
│
▼
stg_tickets (dbt view — cleaning & enrichment)
│
├──► fct_ticket_performance (fact table)
│ ├──► dim_agent_performance (agent KPIs)
│ ├──► dim_category_trends (category analysis)
│ └──► dim_daily_trends (time-series metrics)

---

## dbt Models

### Staging Layer

| Model         | Type | Description                                                                                                  |
| ------------- | ---- | ------------------------------------------------------------------------------------------------------------ |
| `stg_tickets` | View | Cleaned raw data with derived columns (priority order, day/hour extracts) and consistent SLA logic via macro |

### Mart Layer

| Model                    | Type  | Description                                                |
| ------------------------ | ----- | ---------------------------------------------------------- |
| `fct_ticket_performance` | Table | Core fact table with SLA status and time dimensions        |
| `dim_agent_performance`  | Table | Agent-level KPIs: volume, resolution time, SLA breach rate |
| `dim_category_trends`    | Table | Category × priority breakdown with breach analysis         |
| `dim_daily_trends`       | Table | Daily time-series for operational trend reporting          |

---

## Data Quality & Testing

- **23 built-in dbt tests:** uniqueness, not_null, accepted_values
- **1 custom SQL test:** `assert_sla_breach_rate_under_100`
- **1 reusable macro:** `calculate_sla_status` for consistent SLA logic across models
- **Auto-generated documentation** with model lineage (DAG)

---

## Key Business Metrics

| Metric                      | Source Model                                   |
| --------------------------- | ---------------------------------------------- |
| SLA Breach Rate             | `dim_agent_performance`, `dim_category_trends` |
| Avg Resolution Time         | All mart models                                |
| Ticket Volume by Priority   | `dim_category_trends`                          |
| Agent Workload Distribution | `dim_agent_performance`                        |
| Daily Ticket Trends         | `dim_daily_trends`                             |

---

## How to Run

### Prerequisites

- Python 3.10+
- PostgreSQL running locally

### 1. Install dependencies

```bash
pip install -r requirements.txt
```

### 2. Create the database

```bash
psql -U postgres -c "CREATE DATABASE ticket_db;"
```

### 3. Create the .env file

`scripts/load_to_db.py` reads the database password from the environment instead of hardcoding it. Create a `.env` file in the project root (it is gitignored):

```
DB_PASSWORD=your_password_here
```

### 4. Generate and load the data

```bash
python scripts/generate_data.py
python scripts/load_to_db.py
```

`generate_data.py` writes `data/tickets.csv`, and `load_to_db.py` loads that file into the `tickets` table, so run them in that order. Re-running the loader drops and recreates `tickets`, which also drops any dbt views built on it, so run `dbt build` (step 6) afterwards to rebuild them.

### 5. Configure the dbt profile

Create `~/.dbt/profiles.yml`:

```yaml
ticket_analytics:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      port: 5432
      user: postgres
      pass: "{{ env_var('DB_PASSWORD') }}"
      dbname: ticket_db
      schema: analytics
      threads: 4
```

The profile reads the password from `DB_PASSWORD`, so no credential is stored in it. Export that variable in the shell you run dbt from:

```bash
export DB_PASSWORD=your_password_here        # PowerShell: $env:DB_PASSWORD = "your_password_here"
```

### 6. Run the pipeline

```bash
cd dbt_ticket_analytics
dbt build
```

### 7. View the documentation

```bash
dbt docs generate
dbt docs serve
```

Navigate to http://localhost:8080 and click the lineage graph icon to explore the DAG.

## What This Project Demonstrates

- **Analytics Engineering:** dbt models with staging → mart architecture
- **Data Testing:** Built-in and custom SQL tests for data quality
- **Documentation:** Auto-generated docs with model lineage
- **SQL Proficiency:** Window functions, CTEs, aggregations, macros
- **Business Logic:** SLA calculations, time-series analysis, dimensional modeling
- **Production Thinking:** Reusable macros, schema enforcement, tested pipelines

---

## Project Structure

```
ticket-analytics-dashboard/
├── data/                      # Raw CSV data
├── scripts/                   # Python data generation & loading
│   ├── generate_data.py
│   └── load_to_db.py
├── dbt_ticket_analytics/      # dbt project
│   ├── models/
│   │   ├── staging/
│   │   │   ├── sources.yml
│   │   │   ├── schema.yml
│   │   │   └── stg_tickets.sql
│   │   └── marts/
│   │       ├── schema.yml
│   │       ├── fct_ticket_performance.sql
│   │       ├── dim_agent_performance.sql
│   │       ├── dim_category_trends.sql
│   │       └── dim_daily_trends.sql
│   ├── macros/
│   │   └── sla_status.sql
│   ├── tests/
│   │   └── assert_sla_breach_rate_under_100.sql
│   └── dbt_project.yml
├── sql/                       # Earlier iteration: standalone SQL queries
├── excel/                     # Earlier iteration: Excel dashboard (pivot charts and slicers)
└── README.md
```

## Project History

The `excel/` and `sql/` folders are an earlier iteration of this project, built before the dbt layer: a standalone Excel dashboard (pivot charts and slicers) and a set of hand-written analytical queries against the raw table. The dbt models supersede both, and they are kept here as a record of that work.
