# Data Analysis Project with Power BI

## Milestone 1: Set up the Environment

### 1. Repository Setup

- The project repository is available at: [Project Repository Link](https://github.com/neuscib/data-analytics-power-bi-report580)
  
### 2. Prerequisites

Before starting with this project, make sure you have the following installed:

- **Power BI**: Download and install Power BI Desktop from the [official site](https://powerbi.microsoft.com/).
- **Azure Account**: Set up an Azure account if you haven't already. Follow [this link](https://azure.microsoft.com/en-us/free/) for a free trial.
- **Git**: If you haven't installed Git, you can download it from [here](https://git-scm.com/).

### 3. Clone the Repository

To get started, clone the repository to your local machine:

```bash
git clone https://github.com/neuscib/data-analytics-power-bi-report580.git
```

## Milestone 2: Data Import and Transformation

### 1. Data Import

- **Azure SQL Database**: We connected Power BI to an Azure SQL database using the provided credentials. We imported the `orders_powerbi` table to work with the company's order data.
- **Azure Blob Storage**: We used the Azure Blob Storage connector to import the `Stores` table. The connection was established with the provided account credentials.
- **CSV Files**: We used the Folder connector in Power BI to import three CSV files from the `Customers` folder, each representing a different region where the company operates. Power BI automatically combined these files into a single table.

### 2. Transformations Performed

- **Removing Duplicates**: In the `Products` table, we removed duplicates from the `product_code` column to ensure that each product code is unique.
- **Creating the Full Name Column**: In the `Customers` table, we combined the `First Name` and `Last Name` columns into a new `Full Name` column for easier identification of customers.
- **Data Cleaning**:
  - We removed unnecessary columns (e.g., index columns) from the imported tables.
  - We used the **Replace Values** tool to correct and standardize values in the `Region` column of the `Stores` table.
- **Renaming Columns**: We renamed the columns to follow Power BI's naming conventions, improving clarity in the report.

### 3. Tools and Features Used

- **Power Query Editor**: Most of the transformations were done in the Power Query Editor in Power BI, using functions like **Remove Duplicates**, **Replace Values**, **Add Custom Columns**, and **Rename Columns**.
- **Power BI Connectors**: We used the **Azure SQL Database**, **Azure Blob Storage**, and **Folder** connectors to import data from different sources.

### 4. Results

All data was successfully imported and transformed as per the project requirements. The tables are now ready to be used for creating visualizations and analysis in Power BI.


## Milestone 3: Create a Data Model

### Overview  
In this milestone, we created a structured data model in Power BI, including a DataTable, key relationships, measures, and hierarchies. We also documented our progress and uploaded the latest version of the Power BI file.


### Data Table Creation  
We generated a **DataTable** using DAX, ensuring it contains essential time-based fields.  

```DAX
DataTable = 
VAR MinDate = DATE(YEAR(MIN(Orders[Order Date])), 1, 1)
VAR MaxDate = DATE(YEAR(MAX(Orders[Shipping Date])), 12, 31)

RETURN 
ADDCOLUMNS(
    CALENDAR(MinDate, MaxDate), 
    "Year", YEAR([Date]),
    "Quarter", "Q" & FORMAT([Date], "Q"),
    "Month Name", FORMAT([Date], "MMMM"),
    "Start of Year", DATE(YEAR([Date]), 1, 1),
    "Start of Quarter", DATE(YEAR([Date]), (QUOTIENT(MONTH([Date])-1, 3)*3) + 1, 1),
    "Start of Month", DATE(YEAR([Date]), MONTH([Date]), 1),
    "Start of Week", [Date] - WEEKDAY([Date], 2) + 1
)
```


### Data Model Relationships  
We created a **star schema** by defining **one-to-many** relationships with a single filter direction from the dimension tables to the fact table.  

| **Dimension Table** | **Fact Table** | **Relationship** |
|--------------------|--------------|------------------|
| `Products[product_code]`  | `Orders[product_code]`  | One-to-Many |
| `Stores[store_code]`  | `Orders[Store Code]`  | One-to-Many |
| `Customers[User UUID]`  | `Orders[User ID]`  | One-to-Many |
| `DataTable[date]`  | `Orders[Order Date]`  | One-to-Many (Active) |
| `DataTable[date]`  | `Orders[Shipping Date]`  | One-to-Many (Inactive) |



### Measure Creation  
We created several key measures in a separate **Measure's Table**:

- **Total Orders**: Counts the number of orders.  
- **Total Revenue**: `SUMX(Orders, Orders[Product Quantity] * Products[Sale_Price])`  
- **Total Profit**: `(Products[Sale_Price] - Products[Cost_Price]) * Orders[Product Quantity]`  
- **Total Customers**: `DISTINCTCOUNT(Orders[User ID])`  
- **Total Quantity**: `SUM(Orders[Product Quantity])`  
- **Profit YTD**: `TOTALYTD([Total Profit], DataTable[date])`  
- **Revenue YTD**: `TOTALYTD([Total Revenue], DataTable[date])`  

### Hierarchy Creation  
We created two hierarchies:

#### **Date Hierarchy**  
- Start of Year  (Year)
- Start of Quarter  (Quarter)
- Start of Month  (Month)
- Start of Week  (Day)


#### **Geography Hierarchy**  
- Region (Region)
- Country Region (Country Region)
- Country (Country)

## Milestone 4: Set Up the Report

### Report Pages Creation

In this milestone, we established the basic structure of the Power BI report by creating the necessary pages and setting up navigation. The following pages were created:
- Executive Summary
- Customer Detail
- Product Detail
- Stores Map
  
Each page serves a distinct purpose for data visualization and analysis.

### Selecting a Color Theme

A predefined color theme was selected in Power BI from the View tab to ensure consistency in the report's appearance.

### Adding a Navigation Sidebar

A rectangle was added on the left side of the Executive Summary page to act as a navigation sidebar.
The fill color was set to contrast with the report background.
This sidebar was duplicated across the other report pages (Customer Detail, Product Detail, and Stores Map) for a uniform design and ease of navigation.


## Milestone 5: Build the Customer Detail Page

### 1. Overview
The goal of this milestone was to build the **Customer Detail** page to provide insights into top customers by focusing on metrics like revenue, number of orders, and trends. This page allows users to drill down into specific customers for a detailed analysis.

### 2. Visuals Created
The **Customer Detail** page contains the following visuals:
- **Card Visuals**: 
  - Top Customer’s **Name**.
  - **Total Revenue** of the top customer.
  - **Total Orders** made by the top customer.
- **Customer Table**: Displays all customers with their **full name**, **total revenue**, and **number of orders**.
- **Bar Chart**: Shows which products were bought most frequently by the top customer.
- **Line Chart**: Displays the **purchasing trends over time** for the top customer.

### 3. Measures and Calculations
- Created new measures for:
  - **Total Revenue**: Total revenue for the top customer.
  - **Total Orders**: Total number of orders for the top customer.
  - **Average Revenue per Order**: The average revenue per order for the top customer.
- **Drill-through**: Set up a drill-through feature to allow users to right-click on a customer and see detailed insights.

### 4. Customization and Styling
- Styled the page with a **consistent color theme** to ensure a professional appearance.
- Duplicated the **navigation sidebar** from the **Executive Summary** page to maintain uniformity across all report pages.

### 5. Results
The **Customer Detail** page provides a comprehensive overview of the top customers, including detailed insights into their revenue trends, product preferences, and purchasing behavior. The drill-through feature enhances user interaction and allows deeper analysis of specific customer data.
