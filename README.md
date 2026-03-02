# E-Truck-Scenario-Analysis
A Dijkstra-based multi-objective optimizer for mixed electric/conventional truck fleets. Includes scenario-based sensitivity analysis to compare logistics performance (cost, CO2, cargo damage) between dense downtown and dispersed suburban areas.

# Customer Path Planning and Sensitivity Analysis

This repository contains a set of R scripts for customer data preprocessing, path planning, sensitivity analysis, and visualization. The workflow is divided into four main stages, each implemented in separate scripts to ensure modularity and reproducibility.

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
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
- Producing plots for sensitivity analysis using individual plotting scripts (`code4.R` to `code10.R`)

## Requirements
- R version 3.6 or higher
- Required packages: `tidyverse` (for data manipulation and plotting), `ggplot2`, and any specific packages used for routing (e.g., `ompr`, `igraph`, etc. – adjust based on your actual implementation)
- Install dependencies with:
  ```r
  install.packages(c("tidyverse", "ggplot2"))
  ```

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
source("code4.R")
source("code5.R")
...
source("code10.R")
```
Each script produces a specific plot (e.g., parameter vs. total distance, parameter vs. computational time). Modify the scripts if you need to customize the appearance or select different parameters.

## File Descriptions
| File       | Description |
|------------|-------------|
| `code1.R`  | Data cleaning and preprocessing |
| `code2.R`  | Path planning for customer groups |
| `code3.R`  | Sensitivity analysis with parameter variation |
| `code4.R`  | Plot: [describe plot, e.g., parameter A vs. total cost] |
| `code5.R`  | Plot: [describe plot, e.g., parameter B vs. number of routes] |
| `code6.R`  | Plot: [describe plot, e.g., parameter C vs. computation time] |
| `code7.R`  | Plot: ... |
| `code8.R`  | Plot: ... |
| `code9.R`  | Plot: ... |
| `code10.R` | Plot: ... |

*(You may update the plot descriptions to match your actual figures.)*

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

For any questions or issues, please open an issue on GitHub.
