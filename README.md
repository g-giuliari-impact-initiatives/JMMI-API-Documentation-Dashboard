# Shiny Dashboard

This repository contains the code for a Shiny dashboard developed in R. The dashboard utilizes various R packages to provide an interactive web application.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Features](#features)
5. [Code Structure](#code-structure)
6. [Contributing](#contributing)

## Prerequisites

To run this dashboard, you need to have R and RStudio installed on your machine. Additionally, you need to install the following R packages:

```r
list.of.packages <- c(
  "shiny",
  "shinythemes",
  "shinyjs",
  "DT",
  "shinyAce",
  "reticulate",
  "rvest",
  "dplyr",
  "geojsonio",
  "shinydashboard",
  "shinyBS",
  "stringr",
  "scales",
  "tidyr"
)
```
## Installation
Clone this repository to your local machine using:
```r
git clone https://github.com/your_username/your_repository.git
```
Navigate to the project directory and open app.R in RStudio. Run the following commands to install any missing packages:

```r
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, dependencies = TRUE)
```

## Usage
To start the Shiny app, run the following command in RStudio:

```{r}
shiny::runApp('app.R')
```

This will launch the dashboard in your default web browser.

## Features
- Interactive UI: The dashboard uses shiny, shinythemes, and shinydashboard to create an engaging user interface.
- Data Handling: Packages like dplyr, tidyr, and scales are used for data manipulation and visualization.
- Web Scraping: The rvest package is used for extracting data from web pages
- Python Integration: The reticulate package integrates Python functionality, allowing the use of requests and pandas modules.
- Custom Widgets: Custom widgets and interactivity are added using shinyjs, shinyBS, and shinyAce.

## Code Structure
- UI Definition: The UI of the dashboard is defined in the ui object, which includes various UI components like themes, scripts, and layout elements.
- Server Logic: The server logic is encapsulated in the server function, which handles data processing and dynamic content rendering.
- Helper Functions: Additional helper functions and scripts are included to support the main functionalities of the dashboard.

## UI Definition
The UI is built using bootstrapPage, useShinyjs, and other layout functions. Key components include:
- tags$head(includeHTML("gtag.html")): Includes custom HTML for Google Analytics tracking.
- dashboardPage: Defines the main layout of the dashboard with a header, sidebar, and body.

## Server Logic
The server function manages the reactive components of the app:
- Data Fetching: Data is fetched and processed using reactive expressions.
- Render Functions: Outputs like tables, plots, and text are rendered dynamically.

## Contributing
Contributions are welcome! Please follow these steps:
- Fork the repository.
- Create a new branch: git checkout -b feature-branch
- Make your changes and commit them: git commit -m 'Add new feature'
- Push to the branch: git push origin feature-branch
- Submit a pull request.
