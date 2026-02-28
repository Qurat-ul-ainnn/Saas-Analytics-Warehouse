# SaaS Analytics Data Warehouse: Medallion Architecture with Snowflake & dbt

## 📌 Project Overview
This project implements a production-ready end-to-end data warehouse for a SaaS business. Using **Snowflake** as the cloud data platform and **dbt (data build tool)** for transformation, I engineered a scalable **Medallion Architecture** to track subscription lifecycles, financial KPIs, and customer retention.

The primary goal is to provide finance and growth teams with a "single source of truth" for critical metrics like **MRR, ARR, and Churn.**

---

## 🏗️ Architecture & Data Modeling



### 1. The Medallion Layers
* **Bronze (Raw):** Ingested raw JSON/CSV data from SaaS billing systems into Snowflake landing tables.
* **Silver (Cleaned/Normalized):** * Applied schema enforcement and data type casting.
    * Implemented **SCD Type 2** logic using **dbt Snapshots** to track historical subscription changes (e.g., plan upgrades, seat changes).
* **Gold (Business Ready):** * **Fact Models:** Incremental models for high-volume invoice and transaction data.
    * **Dimension Models:** Denormalized tables for Customers, Plans, and Dates.

### 2. Subscription Logic (The "Brain")
The core of this warehouse is the transformation of raw events into a continuous subscription state. 
* **SCD Type 2 Tracking:** Capturing `valid_from` and `valid_to` timestamps for every subscription state.
* **Incremental Materialization:** Optimized processing for massive invoice datasets to reduce Snowflake compute costs.

---

## 📊 Business Intelligence & KPIs
I developed specialized dbt models to calculate the "SaaS North Star" metrics:

| Metric | Logic Applied |
| :--- | :--- |
| **MRR / ARR** | Normalized monthly/yearly recurring revenue from active subscriptions. |
| **Revenue Churn** | Identified lost revenue from cancellations or downgrades. |
| **LTV** | Calculated Lifetime Value based on historical spend and churn rates. |
| **Cohort Retention** | Grouped customers by signup month to track 12-month retention curves. |

---

## 🛠️ Technical Implementation
* **Performance Optimization:** Applied **Clustering Keys** on large fact tables (e.g., `event_timestamp`) to improve query pruning.
* **Data Quality:** Implemented `dbt-tests` (unique, not_null, relationship, and accepted_values) to ensure financial reporting accuracy.
* **Documentation:** Automated data lineage and documentation using `dbt docs generate`.

---

## 🚀 How to Run This Project

### Prerequisites
* Snowflake Account
* Python 3.8+ & dbt-snowflake

### Setup
1. **Clone the repo:**
   ```bash
   git clone [https://github.com/your-username/saas-analytics-dbt.git](https://github.com/your-username/saas-analytics-dbt.git)
   cd saas-analytics-dbt
