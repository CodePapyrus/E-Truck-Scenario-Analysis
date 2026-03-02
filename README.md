# E-Truck-Scenario-Analysis
A Dijkstra-based multi-objective optimizer for mixed electric/conventional truck fleets. Includes scenario-based sensitivity analysis to compare logistics performance (cost, CO2, cargo damage) between dense downtown and dispersed suburban areas.

# Customer Path Planning and Sensitivity Analysis

This repository contains a set of R scripts for customer data preprocessing, path planning, sensitivity analysis, and visualization. The workflow is divided into four main stages, each implemented in separate scripts to ensure modularity and reproducibility.

## Table of Contents
- [Overview](#overview)
- [Usage](#usage)
  - [Step 1: Data Cleaning](#step-1-data-cleaning)
  - [Step 2: Path Planning per Customer Group](#step-2-path-planning-per-customer-group)
  - [Step 3: Sensitivity Analysis](#step-3-sensitivity-analysis)
  - [Step 4: Visualization of Results](#step-4-visualization-of-results)
- [File Descriptions](#file-descriptions)
- [License](#license)

## Overview
The project processes customer data to generate optimized routes and examines how changes in key parameters affect the planning outcomes. The pipeline consists of:
- Cleaning raw data (`code1.R`)
- Performing path planning for distinct customer groups (`code2.R`)
- Conducting sensitivity analysis by varying parameters and aggregating results (`code3.R`)
- Producing plots for sensitivity analysis using individual plotting scripts (`code4.R`)

## Usage
Run the scripts in the following order. Ensure that the input data files are placed in the appropriate directories as expected by each script. Scripts can be executed in an R session using `source()` or from the command line with `Rscript`.

### Step 1: Data Cleaning
```r
source("code1.R")
```
This script reads raw customer data, performs necessary cleaning (e.g., handling missing values, formatting), and outputs a cleaned dataset.

### Step 2: Path Planning per Customer Group
```r
source("code2.R")
source("downtown_1.csv" to "downtown_8.csv")
source("suburbs_1.csv" to "suburbs_9.csv")
```
Using the cleaned data, this script segments customers into groups and generates optimal paths for each group. Results are saved for subsequent analysis.

### Step 3: Sensitivity Analysis
```r
source("code3.R")
```
The script iterates over a range of parameter values (e.g., time windows, vehicle capacity) and runs the path planning logic for each combination. It then aggregates the results (e.g., total distance, number of routes) into a summary file.

### Step 4: Visualization of Results
Run any of the plotting scripts to generate figures from the sensitivity analysis summary:
```r
source("code4forFig6.R")
source("code4forFig7A.R")
...
source("code4forFig11.R")
```
Each script produces a specific plot (e.g., parameter vs. total distance, parameter vs. computational time). Modify the scripts if you need to customize the appearance or select different parameters.

## File Descriptions
| File       | Description |
|------------|-------------|
| `code1.R`  | Data cleaning and preprocessing |
| `code2.R`  | Path planning for customer groups |
| `code3.R`  | Sensitivity analysis with parameter variation |
| `code4forFig6.R`  | Plot: [Comparison of Algorithm Results] |
| `code4forFig7A.R`  | Plot: [Comparison of carbon emissions under different proportions of BETs] |
| `code4forFig7B.R`  | Plot: [Comparison of cargo damage under different proportion of BETs] |
| `code4forFig7C.R`  | Plot: [Total cost comparison under different proportion of BETs] |
| `code4forFig8.R` | Plot: [The impact of different outsourcing ratio on total transportation cost] |
| `code4forFig9.R` | Plot: [Comparison of different loading capacities] |
| `code4forFig10.R` | Plot: [Comparison of different mileage durations] |
| `code4forFig11.R` | Plot: [Comparison of different cargo failure rates] |

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

For any questions or issues, please open an issue on GitHub.
