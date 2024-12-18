# Walmart-Sales-Data-Analysis-Project-with Python, SQL, and PostgreSQL  
This project delivers a comprehensive end-to-end data analysis solution aimed at uncovering valuable business insights from Walmart sales data. By leveraging Python for data cleaning, processing, and analysis, and SQL for advanced data querying, we address essential business questions through a structured problem-solving approach. This project is perfect for data analysts seeking to enhance their expertise in data manipulation, SQL operations, and building efficient data pipelines.

# Project Workflow

## 1. Environment Setup
   Tools Used: Visual Studio Code (VS Code), Python, MySQL, PostgreSQL

   Objective: Create a well-organized workspace in VS Code with clear folder structures to streamline development and data handling processes.

## 2. Kaggle API Configuration
API Setup: Obtain the Kaggle API token (JSON file) from your Kaggle profile settings.

Configuration Steps:
Save the kaggle.json file in the .kaggle directory.

Use the command kaggle datasets download -d <dataset-path> to fetch the Walmart sales dataset directly into the project.

## 3. Data Acquisition
Source: Download Walmart Sales Data from Kaggle using the API.

Link: https://www.kaggle.com/datasets/najir0123/walmart-10k-sales-datasets 

Storage: Save the dataset in a designated folder (data/) for easy access and management.

## 4. Install Dependencies and Load Data
Required Libraries: Install necessary libraries using:

          pip install pandas numpy sqlalchemy mysql-connector-python psycopg2

Data Loading: Use Pandas to load the dataset into a DataFrame for exploration and processing.

## 5. Initial Data Exploration
Goal: Understand the dataset structure, column types, and key statistics.

Steps:

Use methods like .info(), .describe(), and .head() to analyze the data.

Identify patterns, missing values, and potential issues.

## 6. Data Cleaning

Tasks:

● Remove Duplicates: Eliminate duplicate rows to maintain data integrity.

● Handle Missing Values: Drop or fill null values depending on their significance.

● Data Type Correction: Ensure consistency in column types, such as converting dates to datetime and prices to float.

● Currency Standardization: Clean and format currency columns using .replace() for analysis readiness.

● Validation: Verify the cleaned data for any remaining inconsistencies.

## 7. Feature Engineering

● New Feature: Add a calculated column, Total Amount, by multiplying unit_price by quantity.

● Purpose: Enhance the dataset for more streamlined SQL queries and business insights.

## 8. Data Loading into Databases

● Setup: Establish connections to MySQL and PostgreSQL using SQLAlchemy.

Steps:

● Automate table creation and data insertion into both databases.

● Run basic queries to verify successful data transfer.

## 9. SQL Analysis and Business Insights

Objective: Solve critical business questions using SQL queries.

**Key Analyses:**

● Which product category generates the highest revenue?

    '''
      SELECT CATEGORY AS PRODUCT_CATEGORY , 
      SUM(TOTAL) AS TOTAL_REVENUE
      FROM WALMART
      GROUP BY PRODUCT_CATEGORY
      ORDER BY TOTAL_REVENUE
      LIMIT 1;
    '''

● Peak Sales Times:  During which hours of the day do most transactions occur?

      '''
     SELECT 
       CAST(SPLIT_PART(time, ':', 1) AS INTEGER) AS transaction_hour,
	    COUNT(*) AS transaction_count
     FROM 
       walmart
     GROUP BY 
       transaction_hour
     ORDER BY
       transaction_count DESC 
     LIMIT 1; 
    '''
● Analyze sales performance across time, locations, and payment methods.

● Analyze Payment Methods and Sales:  What are the different payment methods, and how many transactions and items were sold with each method?

● Conduct profit margin analysis by branch and category.

● Documentation: Record each query with its goal, approach, and results for clarity.

## 10. Project Documentation and Publishing

**Steps:**

Create clear project documentation using Markdown or Jupyter Notebook.

**Include:**

● README.md: Overview, steps, and findings.

● SQL Scripts: Organized queries for reference.

● Data Access Instructions: Steps to acquire or replicate the dataset.

● Publish the project on GitHub for visibility.

## Project Requirements

● Python Version: 3.8+

● Databases: MySQL, PostgreSQL

● Python Libraries:

pandas, numpy, sqlalchemy, mysql-connector-python, psycopg2

● Kaggle API Token

## How to Get Started

Clone the repository:

     git clone <repo-url>

## Set up the Kaggle API and download the data.

Follow the outlined steps to clean, load, and analyze the data.

## Project Structure
----

      |-- data/                     # Raw and cleaned datasets  

      |-- sql_queries/              # SQL scripts for analysis  

      |-- notebooks/                # Python and Jupyter Notebooks for analysis

      |-- README.md                 # Project documentation  
 
      |-- main.py                   # Main script for processing data  

*** 

## Results and Insights

● Sales Performance: Branches, categories, and payment methods driving the highest sales.

● Profitability Trends: Most profitable locations and product segments.

● Customer Patterns: Insights into customer behaviors, peak hours, and preferred payment methods.

## Future Enhancements

**Possible extensions to this project:**

● Integration with a dashboard tool (e.g., Power BI or Tableau) or AI for interactive visualization.

● Additional data sources to enhance analysis depth.

● Automation of the data pipeline for real-time data ingestion and analysis.

## Acknowledgments

● Data Source: Kaggle’s Walmart Sales Dataset

● Inspiration: Walmart’s business case studies on sales and supply chain optimization.
