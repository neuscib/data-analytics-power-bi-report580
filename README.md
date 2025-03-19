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


## Milestone 6: Create an Executive Summary Page

In this stage of the project, several enhancements were made to the **Executive Summary** page, including new key visualizations and KPIs for better quarterly performance analysis.  

### Visuals Created on This Page:

1. **Key Metric Cards**  
   - **Three cards** were copied and configured to display:  
     - **Total Revenue**  
     - **Total Orders**  
     - **Total Profit**  
   - Formatting adjustments were made in **Format > Callout Value**:  
     - Revenue and Profit: **2 decimal places**  
     - Orders: **1 decimal place**  

2. **Revenue Line Chart by Date**  
   - The line chart from **Customer Detail** was copied and adjusted with:  
     - **X-Axis:** `DateTable[Date]` with **Start of Year, Start of Quarter, and Start of Month** levels.  
     - **Y-Axis:** `Total Revenue`.  
   - Positioned directly below the cards.  

3. **Donut Charts for Revenue Breakdown**  
   - **Two donut charts** were added to show `Total Revenue` breakdown by:  
     - **Store Country** (`Store[Country]`).  
     - **Store Type** (`Store[Store Type]`).  
   - Formatting was copied from **Customer Detail** for consistency.  

4. **Bar Chart for Orders by Product Category**  
   - The **Total Customers by Product Category** donut chart was copied.  
   - Changed the visual type to **Clustered Bar Chart**.  
   - Replaced the **X-axis** field from `Total Customers` to `Total Orders`.  
   - Adjusted colors to match the dashboard theme.  

5. **Quarterly KPIs for Revenue, Orders, and Profit**  
   - **New DAX measures** were created to calculate values from the previous quarter and set a 5% growth target:  
     - **Previous Quarter Profit, Revenue, and Orders**.  
     - **Target Profit, Revenue, and Orders**.  
   - **Three KPI visuals** were added to compare:  
     - **Total Revenue vs. Target Revenue**.  
     - **Total Profit vs. Target Profit**.  
     - **Total Orders vs. Target Orders**.  
   - Formatting configuration:  
     - **Trend Axis:** `DateTable[Date]`.  
     - **Bad Colour:** Red with **15% transparency**.  
     - **Callout Value:** 1 decimal place.  
   - Positioned directly below the revenue line chart.  

## Milestone 7 - Create a Product Detail Page

This document outlines the progress made in **Milestone 7**, including the implementation of new visualizations and data segmentation in Power BI.

### **Performance Gauges**
- Added three gauges to visualize the current quarter's performance for:
  - **Orders**
  - **Revenue**
  - **Profit**
- Defined DAX measures to calculate:
  - The current values of each metric.
  - Quarterly targets with a 10% growth rate.
  - The gap between actual performance and the target.
- Applied conditional formatting to gauge values:
  - **Red** if the target is not met.
  - **Black** if the target is achieved.
- Arranged the gauges at the top of the report, leaving space for slicers.

### **Filter State Placeholder**
- Added two rectangular shapes to the left of the gauges to display selected filter values.
- Defined two DAX measures:
  - **Category Selection**: Shows the selected product category or "No Selection" if no filter is applied.
  - **Country Selection**: Displays the selected country or "No Selection" if no filter is applied.
- Added two card visuals inside the rectangles to display these measures.

### **Area Chart - Revenue by Category Over Time**
- Added an area chart to visualize product category performance over time.
- Configuration:
  - **X-Axis**: Dates (Start of Quarter)
  - **Y-Axis**: Total Revenue
  - **Legend**: Product Category
- Positioned on the left side of the page, aligned with the second gauge visual.

### **Top 10 Products Table**
- Added a table displaying the **Top 10 Products** with the following fields:
  - **Product Description**
  - **Total Revenue**
  - **Total Customers**
  - **Total Orders**
  - **Profit per Order**
- Used the existing customer table formatting for consistency.

### **Scatter Plot - Profitability vs. Quantity Sold**
- Created a new calculated column in DAX **[Profit per Item]** in the Products table.
- Added a scatter chart configured with:
  - **Values**: Product Description
  - **X-Axis**: Profit per Item
  - **Y-Axis**: Total Quantity Sold
  - **Legend**: Product Category

### **Collapsible Slicer Toolbar**
- Implemented a sidebar for filters using **bookmarks and buttons**:
  - **Open Button**: Added a filter icon button in the navigation bar.
  - **Sliding Panel**: Added a rectangular shape matching the navigation bar color.
  - **Slicers Added**:
    - **Product Category** (vertical list, allows multiple selection).
    - **Country** (includes "Select All" option).
  - **Close Button**: Positioned at the top-right corner of the panel to hide it.
- Created two bookmarks in the **Bookmarks Pane**:
  - **Slicer Bar Open** (toolbar visible)
  - **Slicer Bar Closed** (toolbar hidden)
- Configured button actions to toggle between these bookmarks without affecting filter selections.

## Milestone 8: Create a Stores Map Page

### Overview
In this milestone, I have created the **Stores Map Page** in Power BI. This page includes a **map visualization** that shows store locations, and it allows users to easily analyze the **year-to-date profit performance** by region. The page also features interactive components like a **country slicer**, a **drillthrough page** for more detailed store performance analysis, and a **tooltip page** to provide a quick glance at a store's YTD profit against the target.
The goal of this milestone was to create an intuitive and interactive map that would help users explore store data, identify trends, and easily drill down into store-specific performance metrics.


### Tasks Accomplished

#### 1. **Stores Map Visual**
The core component of the Stores Map Page is the **map visualization**. The map visual uses geographic data to display the location of each store on a world map. The size of the bubbles on the map represents the **Profit YTD** (Year-to-Date), allowing users to see which stores are performing better or worse in terms of profitability.

**Settings for the Map Visual**:
- **Auto-Zoom**: Enabled. This ensures the map automatically zooms in to fit the store locations.
- **Zoom Buttons**: Disabled. To simplify the interface and avoid unnecessary zoom options.
- **Lasso Button**: Disabled. This feature was not needed for the current task.
- **Geography Hierarchy**: Assigned to the **Location** field. This allows the map to plot store locations accurately.
- **Profit YTD**: Assigned to the **Bubble Size** field. The bubble size is proportional to the profit of each store.

**Additional Customizations**:
- **Show Labels**: Enabled, so each store’s location is clearly labeled on the map.

The map allows users to visually compare the performance of stores across different geographical regions, making it easy to identify top-performing stores and areas that may need attention.


#### 2. **Country Slicer**
A **country slicer** was added above the map to give users the ability to filter stores by country. This helps users focus on specific regions or countries for analysis.

**Settings for the Country Slicer**:
- **Field**: `Stores[Country]` (the country data of each store).
- **Style**: Set to **Tile** for a clean, visually appealing layout.
- **Selection Settings**: 
  - Multi-select with **Ctrl/Cmd** enabled, allowing users to select multiple countries at once.
  - **Show "Select All"** option, so users can quickly select all countries if needed.

The slicer provides an interactive way to filter the map and analyze store performance by region.


#### 3. **Drillthrough Page**
A **drillthrough page** was created to provide users with more detailed performance data for a selected store. By right-clicking on any store bubble on the map, users can access a page that shows comprehensive performance metrics, including product information and profit data.

**Visuals on the Drillthrough Page**:
- **Top 5 Products Table**: Displays the top 5 products based on **Total Orders**, with columns for:
  - **Description**: Name or ID of the product.
  - **Profit YTD**: Year-to-date profit for the product.
  - **Total Orders**: The total number of orders for the product.
  - **Total Revenue**: Revenue generated by the product.
  
- **Column Chart of Total Orders by Product Category**: This chart shows how many orders were placed for each product category at the selected store.
  
- **Profit YTD Gauge**: A gauge visual showing the store’s **Profit YTD** performance compared to a target of **20% year-on-year growth**. The target uses the **Target** field, so it adjusts dynamically based on the time of year.
  
- **Card Visual**: A simple **card** displaying the name of the currently selected store, providing context for the data.

By using the drillthrough feature, users can access detailed insights into a specific store’s performance, helping managers make informed decisions.

#### 4. **Tooltip Page**
The **Tooltip Page** provides a brief overview of a store’s **Profit YTD** performance when users hover over a store’s bubble on the map. This allows for a quick glance at key performance indicators without needing to click or navigate away from the map.

**Steps to Create the Tooltip Page**:
- **Page Type**: Set the page type to **Tooltip** in the page information section.
- **Tooltip Visual**: I copied the **Profit Gauge Visual** from the drillthrough page to show the **Profit YTD** of the store in the tooltip.
- **Tooltip Settings**: 
  - The visual was configured to show only the **Profit YTD** gauge when hovering over a store location on the map.

This feature enhances the interactivity of the map, allowing users to easily view store performance just by hovering over the locations on the map.

### Visuals Created

#### **Stores Map Page**
1. **Map Visual**: The main visual, showing stores' locations with bubbles sized by **Profit YTD**.
2. **Country Slicer**: Positioned above the map for filtering by country.

#### **Drillthrough Page**
1. **Top 5 Products Table**: Lists the top products by total orders and their performance metrics.
2. **Column Chart of Orders by Product Category**: Displays the distribution of orders by category for the selected store.
3. **Profit YTD Gauge**: A gauge showing year-to-date profit vs. the target.
4. **Card Visual**: Displays the name of the selected store.

#### **Tooltip Page**
1. **Profit YTD Gauge**: A gauge showing the store's year-to-date profit when hovering over the store on the map.


### Conclusions
This milestone focused on creating a highly interactive and informative **Stores Map Page** in Power BI. The addition of slicers, drillthrough pages, and tooltips improves the user experience by making it easy to visualize and analyze store performance across different regions and product categories.

By completing this milestone, I have provided a functional and user-friendly map interface that allows users to quickly assess store performance and access detailed insights.


## Milestone 9: Cross Filtering and Navigation

### Overview
In this milestone, we implemented advanced **cross-filtering interactions** and created a **navigation sidebar** to enhance the usability and interactivity of the Power BI report. Below is a comprehensive breakdown of the tasks accomplished.


### 1. Cross Filtering Adjustments
We modified the interactions between visual elements to ensure that filtering behavior aligns with the report’s objectives. The following configurations were applied:

#### **Executive Summary Page**
- The **Product Category Bar Chart** and **Top 10 Products Table** were set to **not** filter the card visuals or KPIs.
  - **Steps:**
    1. Selected the bar chart/table.
    2. Opened **Format** > **Edit Interactions**.
    3. Set the interactions for the card visuals and KPIs to **None** (circle with a line through it).

#### **Customer Detail Page**
- The **Top 20 Customers Table** was set to **not** filter any other visuals.
- The **Total Customers by Product Category Donut Chart** was set to **not** affect the Customers Line Graph.
- The **Total Customers by Country Donut Chart** was configured to **cross-filter** the **Total Customers by Product Category Donut Chart**.
  - **Steps:**
    1. Selected the relevant visual.
    2. Opened **Format** > **Edit Interactions**.
    3. Set filtering behavior accordingly (None or Cross-filter as required).

#### **Product Detail Page**
- The **Orders vs. Profitability Scatter Graph** was set to **not** affect any other visuals.
- The **Top 10 Products Table** was set to **not** affect any other visuals.
  - **Steps:**
    1. Selected the scatter graph/table.
    2. Opened **Format** > **Edit Interactions**.
    3. Disabled filtering for other visuals by selecting **None**.


### 2. Navigation Sidebar Setup
To improve user experience, we created a **navigation bar** with interactive buttons that allow users to switch between report pages seamlessly.

#### **Button Creation and Icon Setup**
- **Added four blank buttons** in the sidebar of the **Executive Summary Page**.
- Configured **custom icons**:
  - **Default state:** White icon.
  - **On Hover state:** Cyan icon.
  - Adjusted icons using the **Format** > **Button Style** > **Icon** settings.

#### **Navigation Action Configuration**
- Enabled **Action** for each button.
- Set **Type** to **Page Navigation**.
- Assigned the correct **Destination** for each button.
- Grouped all buttons together and **copied them to all report pages** to maintain consistency.


### Conclusions
This milestone significantly improved the usability of the Power BI report by refining filtering interactions and implementing an intuitive navigation system. The report is now more **user-friendly**, **efficient**, and **professional**.


## Milestone 10: SQL Metrics for Users Outside the Company

### Overview

In this milestone, the goal was to connect to a PostgreSQL database hosted on **Microsoft Azure** and use **SQL** to create metrics based on data from users outside the company. I used **SQLTools** in **VSCode** to connect to the database, run queries, and extract relevant information. This section involved tasks like exploring the database schema, running SQL queries, and documenting the results in CSV files.

### Task 1: Connect to the SQL Server

We connected to the PostgreSQL server using **SQLTools** in Visual Studio Code. The connection details were as follows:

- **HOST**: [hidden]
- **PORT**: 5432
- **DATABASE**: postgres
- **USER**: [hidden]
- **PASSWORD**: [hidden]

We ensured that **SSL Encryption** was enabled in the connection settings to guarantee secure communication with the server.

### Task 2: Check the Tables and Column Names

The next step was to explore the structure of the database and check the tables and columns we needed for our queries. Since the table and column names were different from those we used in **Power BI**, we had to review them carefully.

To achieve this:

1. **Created a script called `import_columns.sql`.**
2. **Ran this script in Visual Studio Code, which queried the database and retrieved the list of tables and columns.**
3. **Saved the results for each table in separate CSV files.**

The script ensured that all tables and columns were extracted automatically, and the corresponding CSV files were saved in the selected directory. This step was crucial to familiarize ourselves with the database structure.

#### Example: Output Files

- **List of Tables**: A CSV file containing the list of all tables in the database.
- **Columns of the Orders Table**: A CSV file named `orders_columns.csv` with the list of all columns in the `orders` table.
- **Other Tables**: For each table in the database, a CSV file was created with the name of the table containing its columns.

### Task 3: Query the Database

For this task, we wrote SQL queries to answer the following business questions and exported the results to CSV files. Each SQL query was saved in a `.sql` file, and the result in a `.csv` file.

#### 1. How many staff are there in all UK stores?

The SQL query and result for this question are attached in the files `question_1.sql` and `question_1.csv`.

#### 2. Which month in 2022 had the highest revenue?

The SQL query and result for this question are attached in the files `question_2.sql` and `question_2.csv`.

#### 3. Which German store type had the highest revenue for 2022?

The SQL query and result for this question are attached in the files `question_3.sql` and `question_3.csv`.

#### 4. Create a View for Store Types and Total Sales

The SQL query to create the view and the result are attached in the files `question_4.sql` and `question_4.csv`.

#### 5. Which product category generated the most profit for the "Wiltshire, UK" region in 2021?

The SQL query and result for this question are attached in the files `question_5.sql` and `question_5.csv`.


### Achievements:
- Completed final analysis and reports.
- Optimized SQL queries for performance.
- Created interactive dashboards for stakeholders.

### Final Conclusion:

This milestone marked the last task in my project with **Power BI**, and it provided valuable experience in querying databases and using SQL for data analysis. Throughout this task, I learned how to effectively connect to a PostgreSQL database, retrieve data, and create SQL queries to extract meaningful insights. I also gained a deeper understanding of how to work with different database structures and how to automate some processes to save time and reduce errors.

I was able to generate and save multiple CSV files containing the results of the SQL queries, which were uploaded to my GitHub repository along with the corresponding SQL queries. This process not only improved my SQL skills but also provided me with hands-on experience in handling data extraction and database interaction in a real-world scenario.

As I complete this project, I feel more confident in my ability to use SQL for data analysis and to create actionable insights from large datasets. I look forward to continuing to develop these skills in future projects.

If you have any suggestions or feedback, they are always welcome as I continue to improve my skills and knowledge in data analysis and SQL.
