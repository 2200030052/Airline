# Airline Customer Intelligence & Cancellation Prediction

## Project Overview

An end-to-end airline analytics project that analyzes customer booking behavior, pricing, route performance, cancellation patterns, and customer satisfaction.

The project combines SQL, Python, Machine Learning, and Power BI to generate business insights and predict booking cancellations.

## Business Problem

Airlines need to understand:

- Which booking channels have higher cancellation rates?
- Which traveler types are more likely to cancel?
- How does advance booking affect cancellations?
- Which routes generate higher revenue?
- How does ticket pricing compare with competitors?
- How does customer satisfaction vary across traveler types?
- Can machine learning help predict booking cancellations?

## Objectives

- Analyze airline booking data using SQL.
- Perform exploratory data analysis using Python.
- Identify cancellation patterns.
- Build machine learning models to predict cancellations.
- Compare airline and competitor ticket prices.
- Build an interactive Power BI dashboard.
- Generate actionable business insights.

## Dataset

The dataset contains 290 airline booking records with information about:

- Booking date
- Route
- Travel class
- Booking channel
- Traveler type
- Ticket price
- Advance booking days
- Miles redeemed
- Lounge access
- Flight load factor
- Competitor average price
- NPS score
- Cancellation status

## Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- SciPy
- Scikit-learn
- MySQL
- Power BI
- DAX
- Git & GitHub
- Jupyter Notebook

## SQL Analysis

MySQL was used to perform business analysis including:

- Total bookings
- Total revenue
- Average ticket price
- Cancellation rate
- Revenue by travel class
- Cancellation by booking channel
- Cancellation by traveler type
- Route performance
- Competitor price comparison
- High-value bookings
- Price segmentation
- CTE analysis
- RANK()
- ROW_NUMBER()
- LAG()
- Subqueries
- Window functions

SQL file:

`sql/airline_analysis.sql`

## Python EDA

Python was used for:

- Data inspection
- Data type analysis
- Missing value analysis
- Duplicate detection
- Cancellation distribution
- Cancellation analysis by travel class
- Cancellation analysis by booking channel
- Cancellation analysis by traveler type
- Ticket price analysis
- Advance booking analysis
- NPS analysis
- Correlation analysis
- Statistical testing

Notebook:

`notebooks/EDA.ipynb`

## Machine Learning

The target variable is:

`cancelled`

Three machine learning models were developed:

1. Logistic Regression
2. Decision Tree
3. Random Forest

### Preprocessing

- Missing value imputation
- Numerical feature scaling
- Categorical feature encoding
- Train-test split
- Class-weight balancing

### Evaluation

Models were evaluated using:

- Accuracy
- Precision
- Recall
- F1 Score
- Confusion Matrix

Random Forest feature importance was also analyzed.

Notebook:

`notebooks/Cancel.ipynb`

## Power BI Dashboard

An interactive Power BI dashboard was created to analyze airline performance.

### Key KPIs

- Total Bookings: 290
- Total Revenue: ₹5.29M
- Average Ticket Price: ₹18.24K
- Cancellation Rate: 12.76%
- Average NPS: 5.69

### Dashboard Analysis

- Cancellation by travel class
- Cancellation by booking channel
- Cancellation by traveler type
- Average ticket price by travel class
- Cancellation by booking window
- Route revenue
- Actual vs competitor pricing
- NPS by traveler type

### Filters

- Travel Class
- Booking Channel

Power BI file:

`dashboard/Airline_Customer_Intelligence_Dashboard.pbix`

## Key Insights

- Cancellation behavior differs across booking channels and traveler segments.
- Advance booking behavior provides useful information for understanding cancellations.
- Ticket prices vary across travel classes and routes.
- Competitor pricing can be compared with actual ticket prices to identify pricing differences.
- NPS varies across different traveler types.
- Machine learning can help identify patterns associated with booking cancellations.

## Project Structure

```text
Airline/
│
├── data/
│   └── airline_csv.csv
│
├── notebooks/
│   ├── EDA.ipynb
│   └── Cancel.ipynb
│
├── sql/
│   └── airline_analysis.sql
│
├── dashboard/
│   └── Airline_Customer_Intelligence_Dashboard.pbix
│
└── README.md