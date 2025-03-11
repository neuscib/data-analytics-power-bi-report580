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
