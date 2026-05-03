# 📊 Credit Risk Analytics Dashboard  
[![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1mKAywe9_Qlh6-heqeMXI1-y8qAK105mT?usp=sharing)
> End-to-end credit risk analytics project on 307K+ loan applications — EDA, SQL, ML modeling with SHAP explainability, and an interactive Power BI dashboard aligned with Basel III / IFRS 9 risk frameworks.

**Dashboard Preview**
[<img width="1492" height="808" alt="image" src="https://github.com/user-attachments/assets/182b38c6-b08d-4b69-a5b0-ca1b7ab45985" />](https://drive.google.com/file/d/14SJ5R5Qe4aqw0-CZOxbqCFOdUXAZa9PO/view?usp=sharing)

---

## 🎯 Project Overview

This project analyzes credit default risk using the **Home Credit Default Risk** dataset (Kaggle). The goal is to identify high-risk borrower segments and surface actionable insights through a fully interactive Power BI dashboard — replicating the analytics workflow of a Risk Analytics or Decision Science team at a Tier-1 financial institution.

Under the **Basel III IRB framework**, lenders must estimate Probability of Default (PD) across borrower segments to maintain adequate capital buffers. This project operationalizes that requirement: segmenting 307,511 applicants by default risk, validating a PD model with SHAP explainability for ECOA/Reg B compliance, and staging borrowers in line with **IFRS 9 ECL** principles.

**Business Question:** Which borrower segments are most likely to default, and how can lenders use this to make better credit decisions?

---

## 🗂️ Project Phases

| Phase | Description | Tools |
|-------|-------------|-------|
| 1 — Data Cleaning | Null handling, outlier treatment, type fixes | Python, Pandas |
| 2 — EDA | Distribution analysis, correlation, risk patterns | Matplotlib, Seaborn |
| 3 — Feature Engineering | AGE_GROUP, INCOME_BRACKET, ANNUITY_INCOME_RATIO | Python, Pandas |
| 4 — SQL Analysis | Default rate segmentation queries | MySQL |
| 5 — ML Modeling | XGBoost, LightGBM, SHAP explainability | Scikit-learn, SHAP |
| 6 — Power BI Dashboard | Interactive KPI dashboard via ODBC connection | Power BI, DAX |

---

## 📈 Key Findings

- **Age risk:** Under-25 borrowers default at **11.74%** vs. **5.18%** for 55+ cohort
- **Income risk:** Low-income (<90K) borrowers default at **8.2%** vs. **6.1%** for higher brackets
- **Loan type:** Cash Loans make up **94.81%** of total portfolio exposure
- **Overall default rate:** **8.07%** across 307,511 applications

---

## 🖥️ Dashboard Visuals

| Visual | Description |
|--------|-------------|
| KPI Cards | Total Applicants (307K+) · Overall Default Rate (8.07%) |
| Bar Chart | Default Rate by Income Bracket |
| Bar Chart | Default Rate by Age Group |
| Donut Chart | Portfolio Exposure by Loan Type (₹ Millions) |
| Table | Top High-Risk Applicants |
| Slicer | Filter by Loan Type (Cash / Revolving) |

---

## 🛠️ Tech Stack

Python 3.x       — Data cleaning, EDA, feature engineering, ML modeling
MySQL            — Database storage, SQL analysis queries
Power BI Desktop — Dashboard, DAX measures, Power Query (ODBC)
XGBoost          — Gradient boosted classifier
LightGBM         — Fast gradient boosting with SHAP explainability
SHAP             — Model interpretability
Pandas / NumPy   — Data manipulation
Matplotlib / Seaborn — EDA visualizations

---

## 📁 Repository Structure

credit-risk-analytics/
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   ├── 02_eda.ipynb
│   ├── 03_feature_engineering.ipynb
│   ├── 04_sql_analysis.ipynb
│   └── 05_modeling_xgb_lgbm.ipynb
│
├── sql/
│   ├── create_tables.sql
│   ├── default_by_income.sql
│   ├── default_by_age.sql
│   └── portfolio_exposure.sql
│
├── dashboard/
│   └── credit_risk_dashboard.pdf
│
├── images/
│   └── dashboard_preview.png
│
└── README.md

---

## ⚙️ Setup & Reproduction

### 1. Clone the repo
```bash
git clone https://github.com/LokeshGaddam14/credit-risk-analytics.git
cd credit-risk-analytics
```

### 2. Install dependencies
```bash
pip install pandas numpy matplotlib seaborn scikit-learn xgboost lightgbm shap mysql-connector-python
```

### 3. Dataset
Download from [Kaggle — Home Credit Default Risk](https://www.kaggle.com/c/home-credit-default-risk/data)  
Place `application_train.csv` in the root directory.

### 4. Run notebooks in order
Execute notebooks 01 → 05 sequentially in Jupyter or Google Colab.

### 5. Power BI Dashboard
- Set up MySQL ODBC DSN (64-bit System DSN)
- Open `dashboard/credit_risk_dashboard.pbix`
- Refresh data source with your local MySQL credentials

---

## 📊 Model Performance

| Model | AUC-ROC | Notes |
|-------|---------|-------|
| XGBoost | 0.76 | Baseline tuned |
| LightGBM | 0.78 | Best performer |

---

## 🔍 SHAP Explainability

SHAP (SHapley Additive exPlanations) identifies exactly which borrower attributes drive default risk — essential for adverse action explainability under **ECOA / Regulation B**.

**Top 3 default predictors (SHAP-ranked):**
1. `EXT_SOURCE_2 / EXT_SOURCE_3` — external credit scores; low values strongly increase default probability
2. `AMT_CREDIT` — higher loan amounts relative to income push PD upward
3. `DAYS_BIRTH` — younger borrowers (fewer days since birth) carry significantly higher default risk

SHAP TreeExplainer was applied to the LightGBM model to produce global feature importance (beeswarm) and individual borrower explainability (waterfall) — enabling loan officers to cite specific risk factors when issuing adverse action notices.

---

## 💼 Business Recommendations

**1. Tighten income verification thresholds for under-25 applicants**
This cohort defaults at 11.74% — more than double the 55+ rate of 5.18%. A stricter annuity-to-income ratio cap for young borrowers would materially reduce portfolio ECL without excluding the segment entirely.

**2. Flag high AMT_CREDIT applications for manual review**
EXT_SOURCE scores and credit amount are the top two SHAP drivers. Applicants combining low external scores with high requested amounts should trigger an additional underwriting review step before approval.

**3. Introduce age-segmented risk pricing**
Rather than a flat rate structure, apply risk-based pricing tiers aligned to AGE_GROUP default rates. Under-25 borrowers pricing at the portfolio average rate (8.07%) are systematically underpriced relative to their actual 11.74% default risk.

---

## 🏷️ Dataset

- **Source:** [Home Credit Default Risk — Kaggle](https://www.kaggle.com/c/home-credit-default-risk)
- **Size:** 307,511 rows × 122 columns
- **Target:** Binary (1 = defaulted, 0 = repaid)
- **Class imbalance:** ~8% positive class

---

## 👤 Author

**Lokesh Gaddam**  
Data Analyst | Credit Risk & Fintech Specialist  
B.Tech ECE (Data Science) — KL University, 2026  
📧 lokeshgaddam2514@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/lokesh-gaddam-data-analyst) · [GitHub](https://github.com/LokeshGaddam14) · [Portfolio](https://lokeshgaddam14.github.io/Portofolio/index.html)
