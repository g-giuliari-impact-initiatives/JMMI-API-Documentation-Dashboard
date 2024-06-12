# Comprehensive list of packages required
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

#checking missing packages from list
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

#install missing ones
if(length(new.packages)) install.packages(new.packages, dependencies = TRUE)  

# load all packages
library(shiny)
library(shinythemes)
library(shinyjs)
library(DT)
library(shinyAce)
library(reticulate)
library(rvest)
library(dplyr)
library(geojsonio)
library(shinydashboard)
library(shinyBS)
library(stringr)
library(scales)
library(tidyr)

# Ensure the 'requests' and 'pandas' modules are installed
reticulate::py_install(c("requests", "pandas"))
pandas <- import("pandas")
requests <- import("requests")

# UI definition
ui <- bootstrapPage(
  useShinyjs(),
  tags$head(includeHTML("gtag.html")),
  tags$head(tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css")),
  tags$head(tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css")),
  tags$head(tags$style(HTML("
      .content-wrapper {
        margin: 0 auto;
        max-width: 1200px;
        padding: 20px;
      }
      body {
        overflow-y: scroll;
        overflow-x: hidden;
      }
      .shiny-text-output {
        font-size: 20px;
        line-height: 2.0;
      }
      .red-row {
        color: red;
      }
      .red-row a {
        color: inherit; /* Inherit color from parent */
        font-weight: bold;
        text-decoration: none; /* Optional: Remove underline */
      }
      .navbar-static-top,
      .navbar-fixed-top {
        background-color: #000000 !important;
      }
      .navbar-default {
        height: 70px; /* Adjust the height as needed */
      }
      
      .navbar-default .navbar-nav>.active>a {
        background-color: #FFFFFF !important;
        color: #000000 !important;
        border-radius: 20px !important;
        padding: 10px 15px !important;
        transition: background-color 0.3s, color 0.3s;
        font-weight: bold !important;
      }
      
      .navbar-default .navbar-nav>li>a {
        color: #FFFFFF !important;
        padding: 10px 15px !important;
        transition: color 0.3s;
        margin-top: 16px; /* Aligns panel titles with the main title */
      }
      .navbar-default .navbar-nav>li>a:hover {
        color: #DDDDDD !important;
      }
      .navbar-nav {
        display: flex;
        align-items: center;
        height: 100%;
      }
      .navbar-header, .navbar-collapse {
        display: flex;
        align-items: center;
        height: 100%;
      }
      .navbar-brand {
        padding: 0 15px !important; /* Adjusted padding */
        font-size: 18px;
        line-height: 70px; /* Ensure proper line height */
        margin: 0; /* No additional margin */
        height: 70px; /* Match the navbar height */
        display: flex;
        align-items: center;
        position: relative;
        top: 7px; /* Adjust this value to move it lower */
      }
      .navbar-brand a {
        color: #FFFFFF !important;
        text-decoration: none;
      }
      .navbar-header, .navbar-collapse {
        flex: 1; /* Ensure the brand centers within the available space */
        justify-content: center; /* Center the brand */
      }
      .navbar-header {
        position: relative;
      }
      .navbar-header:before {
        content: '';
        flex: 1; /* Creates space to the left of the brand */
      }
      .navbar-header:after {
        content: '';
        flex: 1; /* Creates space to the right of the brand */
      }
      .navbar-nav {
        margin-left: auto; /* Align nav items to the right */
      }
      ::-webkit-scrollbar {
        width: 12px;
      }
      ::-webkit-scrollbar-track {
        background: #f1f1f1; 
      }
      ::-webkit-scrollbar-thumb {
        background: #000000; 
      }
      ::-webkit-scrollbar-thumb:hover {
        background: #555; 
      }
      .center-content {
        text-align: center;
      }
      .custom-table {
        width: 100%;
        margin-bottom: 1rem;
        color: #212529;
        border-collapse: collapse;
      }
      .custom-table th,
      .custom-table td {
        padding: 0.75rem;
        vertical-align: top;
        border: 1px solid #dee2e6;
      }
      .custom-table thead th {
        vertical-align: bottom;
        border-bottom: 2px solid #dee2e6;
      }
      .custom-table tbody + tbody {
        border-top: 2px solid #dee2e6;
      }
      .social-icons {
      position: fixed;
      bottom: 20px;
      right: 20px;
      z-index: 1000;
      display: flex;
      flex-direction: column;
    }
    .social-icons a {
      display: inline-block;
      width: 40px;
      height: 40px;
      margin: 5px 0;
      border-radius: 50%;
      background-color: #000;
      color: #fff;
      text-align: center;
      line-height: 40px;
      font-size: 20px;
      position: relative;
    }
    .social-icons a img.overlay {
      position: absolute;
      width: 600%;  /* Scale image to 10% of its actual size */
      height: auto;
      bottom: 130px; /* Position it 5 pixels above the email logo */
      left: 50%;
      transform: translateX(-50%) rotate(270deg); /* Center the image horizontally and rotate 270 degrees */
      z-index: 2000;
    }
      .grey-box {
        background-color: #f0f0f0;
        padding: 5px;
        border: none;
        font-family: monospace;
        margin-bottom: 10px;
        border-radius: 8px;
      }
      .info-box {
        background-color: #e6f2ff;
        padding: 15px;
        border-radius: 8px;
        border: none;
        width: 45%;
        margin: 10px;
        display: inline-block;
        vertical-align: top;
      }
      .info-title {
        color: #0059b3;
        font-weight: bold;
        margin-bottom: 10px;
        font-size: 18px;
      }
      .info-row {
        color: #0059b3;
        margin-bottom: 10px;
      }
      .blue-line {
        background-color: #cce0ff;
        height: 1px;
        border: none;
        margin: 10px 0;
      }
      body, .content-wrapper, .shiny-text-output, .info-box, .red-box, p, div, span, table, td, th {
        text-align: justify;
      }
      .red-box {
        background-color: #ffe6e6;
        padding: 15px;
        border-radius: 8px;
        border: none;
        width: 45%;
        margin: 10px;
        display: inline-block;
        vertical-align: top;
      }
      .red-title {
        color: #b30000;
        font-weight: bold;
        margin-bottom: 10px;
        font-size: 18px;
      }
      .red-row {
        color: #b30000;
        margin-bottom: 10px;
      }
      .red-line {
        background-color: #ffcccc;
        height: 1px;
        border: none;
        margin: 10px 0;
      }
      .param-box .description {
        display: inline-block;
        opacity: 0; 
        transition: opacity 2s ease-in-out; 
      }
      @keyframes fadeIn {
        from {
          opacity: 0;
        }
        to {
          opacity: 1;
        }
      }
      @keyframes fadeOut {
        from {
          opacity: 1;
        }
        to {
          opacity: 0;
        }
      }
      .param-box {
        border-radius: 15px;
        padding: 10px;
        margin: 10px 0;
        position: relative;
        cursor: pointer;
        transition: background-color 0.3s;
      }
      .param-box.green {
        background-color: #e0f7e0;
      }
      .param-box.green:hover {
        background-color: #c6ecc6;
      }
      .param-box.blue {
        background-color: #e0e7f7;
      }
      .param-box.blue:hover {
        background-color: #c6d7ec;
      }
      .param-box.violet {
        background-color: #f3e5f5;
      }
      .param-box.violet:hover {
        background-color: #e1bee7;
      }
      .param-box.red {
        background-color: #ffebee;
      }
      .param-box.red:hover {
        background-color: #ffcdd2;
      }
      .param-box.orange {
        background-color: #fff3e0;
      }
      .param-box.orange:hover {
        background-color: #ffe0b2;
      }
      .param-box.yellow {
        background-color: #fffde7;
      }
      .param-box.yellow:hover {
        background-color: #fff9c4;
      }
      .param-box .title {
        font-weight: bold;
        display: inline-block;
        margin-right: 20px;
        min-width: 120px;
      }
      .param-box .description {
        display: inline-block;
      }
      .param-box .toggle {
        position: absolute;
        right: 10px;
        top: 10px;
        font-weight: bold;
        font-size: 18px;
        transition: transform 0.3s;
      }
      .param-box.green .title,
      .param-box.green .description,
      .param-box.green .toggle {
        color: #1b5e20;
      }
      .param-box.blue .title,
      .param-box.blue .description,
      .param-box.blue .toggle {
        color: #0d47a1;
      }
      .param-box.violet .title,
      .param-box.violet .description,
      .param-box.violet .toggle {
        color: #6a1b9a;
      }
      .param-box.red .title,
      .param-box.red .description,
      .param-box.red .toggle {
        color: #b71c1c;
      }
      .param-box.orange .title,
      .param-box.orange .description,
      .param-box.orange .toggle {
        color: #e65100;
      }
      .param-box.yellow .title,
      .param-box.yellow .description,
      .param-box.yellow .toggle {
        color: #f57f17;
      }
      .param-box .content {
        display: none;
        background-color: rgba(224, 224, 224, 0.8);
        border-radius: 0 0 15px 15px;
        padding: 10px;
        margin-top: 10px;
      }
      .param-box.green .content {
        background-color: rgba(224, 247, 224, 0.8);
      }
      .param-box.blue .content {
        background-color: rgba(224, 231, 247, 0.8);
      }
      .param-box.violet .content {
        background-color: rgba(243, 229, 245, 0.8);
      }
      .param-box.red .content {
        background-color: rgba(255, 235, 238, 0.8);
      }
      .param-box.orange .content {
        background-color: rgba(255, 243, 224, 0.8);
      }
      .param-box.yellow .content {
        background-color: rgba(255, 253, 231, 0.8);
      }
      .param-box.open .content {
        display: block;
      }
      .param-box.open .toggle {
        transform: rotate(180deg);
      }
      .param-box.grey {
        background-color: #e0e0e0;
      }
      .param-box.grey:hover {
        background-color: #bdbdbd;
      }
      .param-box.grey .title,
      .param-box.grey .description,
      .param-box.grey .toggle {
        color: #424242;
      }
      .param-box.grey .title {
        font-weight: normal; /* Ensure the title is not bold */
      }
      .param-box.grey .content {
        background-color: rgba(224, 224, 224, 0.8);
      }
      .param-box.open .toggle {
        transform: rotate(180deg);
      }
      
    table.dataTable thead th {
          font-size: 12px; /* Font size for headers */
        }
        table.dataTable tbody td {
          font-size: 16px; /* Font size for table content */
        }
        .dataTables_length, .dataTables_filter, .dataTables_info, .dataTables_paginate {
          font-size: 10px; /* Font size for control elements */
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button {
          padding: 0.2em 1em; /* Padding for pagination buttons */
        }
        table.dataTable tbody td:first-child {
          font-size: 10px; /* Font size for row numbers */
        }
      "))),
  tags$head(
    tags$script(HTML("
      document.addEventListener('DOMContentLoaded', function() {
        var observerOptions = {
          root: null,
          rootMargin: '0px',
          threshold: 0.1
        };

        $(document).on('click', '#contact-us-link', function() {
          Shiny.setInputValue('open_email', true);
        });

        function handleIntersection(entries, observer) {
          entries.forEach(function(entry) {
            var descriptions = entry.target.querySelectorAll('.description');
            if (entry.isIntersecting) {
              descriptions.forEach(function(description, index) {
                description.style.animation = 'fadeIn 2s forwards';
                description.style.animationDelay = (index * 0.5) + 's';
                description.style.opacity = 1;
              });
            } else {
              descriptions.forEach(function(description, index) {
                description.style.animation = 'fadeOut 2s forwards';
                description.style.animationDelay = (index * 0.5) + 's';
                description.style.opacity = 0;
              });
            }
          });
        }

        var observer = new IntersectionObserver(handleIntersection, observerOptions);

        document.querySelectorAll('.param-box').forEach(function(box) {
          observer.observe(box);
        });
      });

      $(document).on('click', '.param-box', function(event){
        if(!$(event.target).closest('.content').length) {
          $(this).toggleClass('open');
        }
      });

    Shiny.addCustomMessageHandler('openMail', function(message) {
        window.location.href = message;
      });

      $(document).on('click', '#contact-us-link, .email', function() {
        Shiny.setInputValue('open_email', Math.random());
      });
    "))
  ),
  navbarPage(
    theme = shinytheme("flatly"),
    collapsible = TRUE,
    title = div(HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">IMPACT Initiatives JMMI API</a>')),
    windowTitle = "IMPACT JMMI Dashboard",
    position = "fixed-top",
    
    
    tabPanel("Introduction",
             div(class = "content-wrapper",
                 tags$head(includeCSS("styles.css")),
                 fluidRow(
                   box(
                     status = "primary",
                     solidHeader = TRUE,
                     width = 11,
                     br(),
                     br(),
                     br(),
                     br(),
                     tags$h2(tags$b("About the Joint Market Monitoring Initiative (JMMI) API")),
                     br(),
                     fluidRow(
                       column(6, img(src = "image3.jpg", height = "100%", width = "100%")),  # Replace with the actual image path
                       column(6,
                              tags$h3(tags$b("1. Introducing the JMMI")),
                              br(),
                              p(tagList(
                                "The Joint Market Monitoring Initiative (JMMI) is a recurring market assessment developed by ",
                                a("REACH Initiatives", href = "https://www.impact-initiatives.org/"),
                                " and its partners, and implemented globally to collect reliable data on market prices and functionality. 
                                It focuses on calculating key indices such as the Minimum Expenditure Basket (MEB) and the Market Functionality Score (MFS), 
                                which help humanitarian actors understand financial burdens and market conditions for vulnerable households."
                              )),
                              p("The JMMI model, established in Syria in 2014-15, has been adapted and rolled out in 21 countries by 2024, 
                                ensuring comprehensive local market data collection to support market-based programming and cash assistance interventions."),
                              p("The primary purpose of the JMMI is to provide consistent, localized market data that can be used to inform 
                                and harmonize cash and voucher assistance programs. This data helps humanitarian organizations track the stability
                                and functionality of markets, assess the impact of their interventions, and make informed decisions to support vulnerable populations."),
                              p("By standardizing data collection and facilitating collaboration among various actors, the JMMI reduces duplication 
                                of efforts and provides a broad, integrated understanding of market conditions across different contexts."),
                              p("REACH strives to make its JMMI database accessible to the widest range of actors and stakeholders. 
                              With the JMMI API, humanitarian, nexus, and development actors, as well as researchers and students, 
                              can easily access the JMMI database. This allows them to conduct their own analyses using the consistent 
                              and reliable market data.")
                              
                       )
                     ),
                     br(),
                     br(),
                     br(),
                     fluidRow(
                       column(6,
                              tags$h3(tags$b("2. The Content of the JMMI")),
                              br(),
                              tags$p(tags$b("Vendor data:"), " Basic metadata about the vendor and the interview itself."),
                              tags$p(tags$b("Availability:"), " Establishes which monitored items are present in the market and the shop."),
                              tags$p(tags$b("Price & stock loop:"), " The core of any JMMI, including questions on prices, units, and restocking times that must be repeated for every commodity or every item category being monitored."),
                              tags$p(tags$b("Market functionality:"), " Another core module assessing how well markets are functioning and whether they are freely accessible to everyone. This module aims at computing the Market Functionality Score (MFS) index."),
                              tags$p(tags$b("Supply chains:"), " Establishes the locations of the main suppliers working with vendors in this location, as well as soliciting further information about why certain items are unavailable or difficult to find."),
                              tags$p(tags$b("Expectations:"), " An optional module collecting the vendor's predictions about how prices are likely to change in the future."),
                              tags$p(tags$b("Exchange rates:"), " An optional module for directly monitoring parallel-market exchange rates in contexts where this is relevant, either through standalone exchange shops or through vendors who may offer currency exchange services on the side.")
                       ),
                       column(6, img(src = "image4.png", height = "110%", width = "110%"))  # Replace with the actual image path
                     ),
                     br(),
                     br(),
                     br(),
                     fluidRow(column(8,
                                     tags$h3(tags$b("3. Data Availability")),
                                     br(),
                                     tags$table(class = "custom-table",
                                                tags$thead(
                                                  tags$tr(
                                                    tags$th("ISO3"),
                                                    tags$th("Country"),
                                                    tags$th("Frequency"),
                                                    tags$th("Start Date"),
                                                    tags$th("End Date")
                                                  )
                                                ),
                                                tags$tbody(
                                                  tags$tr(
                                                    tags$td("AFG"),
                                                    tags$td("Afghanistan"),
                                                    tags$td("Monthly"),
                                                    tags$td("2020 April"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("BFA"),
                                                    tags$td("Burkina Faso"),
                                                    tags$td("Monthly"),
                                                    tags$td("2022 November"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("BGD"),
                                                    tags$td("Bangladesh"),
                                                    tags$td("Bi-weekly"),
                                                    tags$td("2020 April"),
                                                    tags$td("2020 July")
                                                  ),
                                                  tags$tr(
                                                    tags$td("CAR"),
                                                    tags$td("Central African Republic"),
                                                    tags$td("Monthly"),
                                                    tags$td("2019 June"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("COL"),
                                                    tags$td("Colombia"),
                                                    tags$td("Monthly"),
                                                    tags$td("2020 November"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("DRC"),
                                                    tags$td("Democratic Republic of Congo"),
                                                    tags$td("Monthly"),
                                                    tags$td("2021 June"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("ETH"),
                                                    tags$td("Ethiopia"),
                                                    tags$td("Monthly"),
                                                    tags$td("2020 November"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("HTI"),
                                                    tags$td("Haiti"),
                                                    tags$td("Monthly + Irregular"),
                                                    tags$td("2021 January"),
                                                    tags$td("2022 April")
                                                  ),
                                                  tags$tr(
                                                    tags$td("IRQ"),
                                                    tags$td("Iraq"),
                                                    tags$td("Monthly"),
                                                    tags$td("2017 January"),
                                                    tags$td("2023 February")
                                                  ),
                                                  tags$tr(
                                                    tags$td("KEN"),
                                                    tags$td("Kenya"),
                                                    tags$td("Bi-weekly"),
                                                    tags$td("2020 June"),
                                                    tags$td("2022 October")
                                                  ),
                                                  tags$tr(
                                                    tags$td("LBY"),
                                                    tags$td("Libya"),
                                                    tags$td("Monthly + Irregular"),
                                                    tags$td("2017 June"),
                                                    tags$td("2023 June")
                                                  ),
                                                  tags$tr(
                                                    tags$td("NER"),
                                                    tags$td("Niger"),
                                                    tags$td("Every 2 months"),
                                                    tags$td("2022 August"),
                                                    tags$td("2023 February")
                                                  ),
                                                  tags$tr(
                                                    tags$td("NGA"),
                                                    tags$td("Nigeria"),
                                                    tags$td("Bi-weekly"),
                                                    tags$td("2020 May"),
                                                    tags$td("2020 July")
                                                  ),
                                                  tags$tr(
                                                    tags$td("SOM"),
                                                    tags$td("Somalia"),
                                                    tags$td("Quarterly"),
                                                    tags$td("2021 November"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("SSD"),
                                                    tags$td("South Sudan"),
                                                    tags$td("Monthly"),
                                                    tags$td("2018 August"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("SYR"),
                                                    tags$td("Syria"),
                                                    tags$td("Monthly"),
                                                    tags$td("2015 March"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("SDN"),
                                                    tags$td("Sudan"),
                                                    tags$td("Monthly"),
                                                    tags$td("2024 January"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("UGA"),
                                                    tags$td("Uganda"),
                                                    tags$td("Monthly"),
                                                    tags$td("2020 November"),
                                                    tags$td("2021 November")
                                                  ),
                                                  tags$tr(
                                                    tags$td("UKR"),
                                                    tags$td("Ukraine"),
                                                    tags$td("Monthly"),
                                                    tags$td("2022 April"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("VEN"),
                                                    tags$td("Venezuela"),
                                                    tags$td("Every six months"),
                                                    tags$td("2021 November"),
                                                    tags$td("Ongoing")
                                                  ),
                                                  tags$tr(
                                                    tags$td("YEM"),
                                                    tags$td("Yemen"),
                                                    tags$td("Monthly"),
                                                    tags$td("2018 April"),
                                                    tags$td("Ongoing")
                                                  )
                                                  
                                                )
                                     )
                     ),
                     column(4,
                            div(style = "display: flex; align-items: flex-start; height: 100%; padding-top: 170px;",  # Adjust padding-top as needed
                                img(src = "image21.jpg", style = "width: 100%; height: auto;")
                            )
                     )
                     ),
                     br(),
                     br(),
                     br(),
                     fluidRow(
                       tags$h3(tags$b("4. The JMMI Master Database Project")),
                       br(),
                       column(12, img(src = "image5.png", height = "100%", width = "100%"))  # Replace with the actual image path
                     ),
                     br(),
                     br(),
                     fluidRow(
                       column(12,
                              p("The JMMI Master Database project was first conceptualized in July 2023 by IMPACT's Global Cash & Markets Team. The main objectives of the project are the following:"),
                              tags$ol(
                                tags$li(
                                  tags$b("Retrieving, standardizing, aggregating every JMMI ever produced"),tags$em ( "(completed)"), 
                                  tags$ul(
                                    tags$li("Renaming, relabelling, rescaling variables to have comparable units and names across countries")
                                  )
                                ),
                                br(),
                                tags$li(
                                  tags$b("Have a centralized, comprehensive JMMI resource for internal and external stakeholders "), 
                                  tags$ul(
                                    tags$li("Publish a Dashboard where stakeholders can access and download datasets, reports, visualizations",tags$em ("(conceptualization stage)")),
                                    tags$li("Launch a JMMI API for R that will allow access to JMMI data on terminal",tags$em ("(finalization)"))
                                  )
                                ),
                                br(),
                                tags$li(
                                  tags$b("Drive further cross-country standardization"),tags$em ( "(piloting stage)"), 
                                  tags$ul(
                                    tags$li("A set of data standardization guidelines have been rolled out across country missions to standardize variable naming and units of measurement.")
                                  )
                                ),
                                br(),
                                tags$li(
                                  tags$b("Develop an integrated Data Pipeline for JMMIs"),tags$em ( "(development stage)"),
                                  tags$ul(
                                    tags$li("Work on integrating every step of the JMMI process from conceptualization to analysis.")
                                  )
                                ),
                                br(),
                                tags$li(tags$b("Allow any researcher to freely conduct cross-country analysis"))
                              )
                       )
                     ),
                     br(),
                     br(),
                     fluidRow(
                       column(12,
                              tags$h3(tags$b("5. The JMMI API")),
                              br(),
                              p("The JMMI API is used to access & download disaggregated survey data. 
                                The first two functions are used to explore the datasets' metadata such as the name of items", tags$i("get_item_names"), 
                                "and variables", tags$i("get_variable_names"), ". The other two main functions constitute the core of the API: (1) ", 
                                tags$i("full_data"), "contains the entirety of the data collected via JMMI surveys. Each row contains the full information 
                                collected in a single key informant (KI) questionnaire. (2) The second main function is", tags$i("price_data"), ". It returns 
                                the dataset in a format most suitable to conduct price analysis. Each row of the dataset contains the information relative to 
                                a specific price collected. Most qualitative information is removed in this format of the dataset.", tags$b("Please head to the API Documentation page
                                for a technical introduction to the JMMI API."))
                       )
                     ),
                     br(),
                     fluidRow(
                       column(12,
                              tags$ul(
                                tags$li(tags$b("Get_item_names:"),
                                        tags$ul(
                                          tags$li("Description: Returns a JSON text with all item names available in specified country and time period."),
                                          tags$li("Parameters: country, start_date, end_date, subscription_key", tags$i("(if institutional API)"))
                                        )
                                ),
                                br(),
                                tags$li(tags$b("Get_variable_names:"),
                                        tags$ul(
                                          tags$li("Description: Returns a JSON text with all variable names and labels available for a specific country and time period in either long or wide format."),
                                          tags$li("Parameters: country, format, subscription_key", tags$i("(if institutional API)"))
                                        )
                                ),
                                br(),
                                tags$li(tags$b("price_data:"),
                                        tags$ul(
                                          tags$li("Description: Returns a JSON text with survey data in a format most suitable for price analysis."),
                                          tags$li("Parameters: country, start_date, end_date, items, subscription_key", tags$i("(if institutional API)"))
                                        )
                                ),
                                br(),
                                tags$li(tags$b("full_data:"),
                                        tags$ul(
                                          tags$li("Description: Returns the full datasets with survey data in standard JMMI format (one key informant per row)."),
                                          tags$li("Parameters: country, start_date, end_date, subscription_key", tags$i("(if institutional API)"))
                                        )
                                )
                              )
                       )
                     )
                   )
                 )
             )
    ),

tabPanel("API Documentation",
         div(class = "content-wrapper",
             fluidRow(
               box(
                 status = "primary",
                 solidHeader = TRUE,
                 width = 12,
                 
                 br(),
                 br(),
                 br(),
                 br(),
                 
                 tags$h2(tags$b("The JMMI API Documentation")),
                 
                 br(),
                 
                 
                 tags$h3(tags$b("1. Open vs Institutional API")),
                 
                 br(),
                 
                 p("The JMMI API has been designed with two main user categories in mind. 
                     The first category includes independent researchers and organizations 
                     engaged in academic and/or humanitarian research. These users are granted 
                     limited access to the API, with a maximum of 100 calls per month.
                     The second category consists of IMPACT staff and partner organizations who will utilize 
                     the API extensively for product development and humanitarian planning. These users will 
                     have virtually unlimited access to the API."),
                 
                 
                 fluidRow(
                   div(style = "display: flex; justify-content: center; align-items: flex-start;",
                       div(class = "info-box", style = "margin-right: 20px;",
                           div(class = "info-title", "Open API"),
                           div(class = "info-row", "Max 100 calls per month"),
                           div(class = "blue-line"),
                           div(class = "info-row", "No subscription key required"),
                           div(class = "blue-line"),
                           div(class = "info-row", "Target Audience: Independent research organizations and users conducting academic or humanitarian research."),
                           div(class = "blue-line"),
                           div(class = "info-row", "https://jmmi-db-2024-108.azure-api.net/impact-jmmi-api-open/")
                       ),
                       div(class = "red-box",
                           div(class = "red-title", "Institutional API"),
                           div(class = "red-row", "Max 200,000 calls per month"),
                           div(class = "red-line"),
                           div(class = "red-row", "Subscription key required"),
                           div(class = "red-line"),
                           div(class = "red-row", HTML("Target Audience: Internal use and qualifying partner organizations upon valid request (<a id='contact-us-link' href='#'>contact us</a>).")),
                           div(class = "red-line"),
                           div(class = "red-row", "https://jmmi-db-2024-108.azure-api.net/impact-jmmi-api-institutional/")
                       )
                   )
                 ),
                 
                 br(),
                 
                 p("For testing purposes, the Python programming interfaces below will allow you to execute example GET requests. Please bear in mind that to test the Institutional API, the subscription key has to be included as a header and the root url must be adjusted from ", 
                   em("'/impact-jmmi-api-open/'"), 
                   " to ", 
                   em("'/impact-jmmi-api-institutional/'"), 
                   ". Find below an example on how to set up an open and institutional request (please insert your subscription key otherwise the code will not run)."),
                 br(),
                 
                 fluidRow(
                   column(width = 6,
                          tags$h5(tags$b("Open API Test")),
                          aceEditor("code_editor0", 
                                    mode = "python", 
                                    theme = "tomorrow_night_bright", 
                                    height = "320px",
                                    value = "
## Python 3.11                    
  
import requests
import pandas as pd
    
url ='https://jmmi-db-2024-108.azure-api.net/impact-jmmi-api-open/full_data'
    
json_body = {
  'country': 'CAR',
  'start_date': '2020-04-01',
  'end_date': '2020-04-27',
  'heading_format': 'names',
}

response = requests.get(url, params=json_body)
df = pd.DataFrame(response.json()['data'])  
"),
              fluidRow(
                column(2,
                       tags$div(
                         style = "position: relative;",  # Add a relative positioning container
                         actionButton("send_request0", "Send Request", style = "background-color: black; color: white; font-size: 12px; padding: 5px 10px;"),
                         tags$div(
                           id = "loading-spinner0",
                           style = "display: none; position: absolute; left: 200%; top: 50%; transform: translate(10px, -50%);",  # Adjust left and transform values for positioning
                           tags$img(src = "https://i.gifer.com/ZZ5H.gif", height = "20px", width = "20px")
                         )
                       )
                )
)
         ),
       column(width = 6,
              tags$h5(tags$b("Institutional API Test")),
              aceEditor("code_editor9", 
                        mode = "python", 
                        theme = "tomorrow_night_bright", 
                        height = "320px",
                        value = "
## Python 3.11                    
  
import requests
import pandas as pd
    
url ='https://jmmi-db-2024-108.azure-api.net/impact-jmmi-api-institutional/full_data'
    
json_body = {
  'country': 'CAR',
  'start_date': '2020-04-01',
  'end_date': '2020-04-27',
  'format': 'names',
}

## Input your subscription code before sendind the request
headers = {'Ocp-Apim-Subscription-Key': 'your_subscription_key'}
    
response = requests.get(url, params=json_body, headers=headers)
df = pd.DataFrame(response.json()['data'])
"),fluidRow(
  column(2,
         tags$div(
           style = "position: relative;",  # Add a relative positioning container
           actionButton("send_request9", "Send Request", style = "background-color: black; color: white; font-size: 12px; padding: 5px 10px;"),
           tags$div(
             id = "loading-spinner9",
             style = "display: none; position: absolute; left: 200%; top: 50%; transform: translate(10px, -50%);",  # Adjust left and transform values for positioning
             tags$img(src = "https://i.gifer.com/ZZ5H.gif", height = "20px", width = "20px")
           )
         )
  )
)
))
,
fluidRow(column(width = 6,
                DTOutput("table_output0")),
        (column(width = 6,
                DTOutput("table_output9")))
        ),

   br(),
br(),

  p("You can also access the API data using via CURL request or any programming interface able to execute GET requests. 
                     An R package to easily forward API requests to download and query data will be made available soon."),
                 
  p("Here is an example of CURL request that can be executed from your browser of choice:"),
                 
  div(class = "param-box grey", id = "param1",
      div(class = "title", "https://jmmi-db-2024-108.azure-api.net/impact-jmmi-api-open/full_data?country=AFG&start_date=2020-11-01&end_date=2021-01-27&heading_format=labels"),
      div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
      div(class = "content", 
          
          "The URL can be broken down in the following sections", 
          
          br(),
          
          tags$ul(
            tags$li(tags$b("'https://jmmi-db-2024-108.azure-api.net/impact-jmmi-api-open/'"), " — The root URL for the Open API."),
            tags$li(tags$b("'full_data?'"), " — The selected function name followed by '?'."),
            tags$li(tags$b("'country=AFG&start_date=2020-11-01&end_date=2021-01-27&heading_format=labels'"), " — The functions' parameters separated by '&'."),
  ))),
                 

                 


br(), br(),                   
tags$h3(tags$b("3. API Main Functions")),
br(),
p("The JMMI API is designed to provide access to disaggregated survey data. 
                     It features several functions to explore datasets' metadata and retrieve core data for analysis."),
br(),               
tags$h5(tags$b("Exploring Metadata")),
tags$ol(
  tags$li(tags$b("'get_item_names'"), " — Retrieves the names of items in the dataset."),
  tags$li(tags$b("'get_variable_names'"), " — Retrieves the names of variables in the dataset.")),

br(), 
tags$h5(tags$b("Core Data Functions")),

tags$ol(
  tags$li(tags$b("'full_data'"), " — This function returns the complete dataset collected from JMMI surveys. 
                             Each row represents the full information gathered from a single key informant (KI) questionnaire."),
  tags$li(tags$b("'price_data'"), " — This function provides the dataset in a format optimized for price analysis. 
                             Each row contains detailed information about a specific price collected, including price, stock, and geo-location. 
                             Most qualitative information is excluded in this dataset.")),




br(),
tags$hr(style="border-color: lightgrey; border-width: 3px; width: 300px; border-radius: 10px; margin-left: 0;"),
tags$h4(tags$b("A) Get Item Names")), #### A. GET ITEM NAMES ####

br(),
p("The get_item_names function retrieves the names of items for which prices have 
                     been collected for a specified country and time period. It is essential 
                     to call this function before setting the 'items' parameter in the price_data 
                     function to ensure accuracy. 
                     Specifying incorrect item names will cause the price_data function to fail."),

br(),
div(class = "param-box green", id = "param1",
    div(class = "title", "country"),
    div(class = "description", "The country for which the function needs to be executed. It must be in ISO-3 code format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        
        "The input ISO-codes and respective countries available in the JMMI are the following:", 
        
        br(),
        
        tags$ul(
          tags$li(tags$b("'AFG'"), " — Afghanistan"),
          tags$li(tags$b("'BFA'"), " — Burkina Faso"),
          tags$li(tags$b("'BGD'"), " — Bangladesh"),
          tags$li(tags$b("'CAR'"), " — Central African Republic"),
          tags$li(tags$b("'COL'"), " — Colombia"),
          tags$li(tags$b("'DRC'"), " — Democratic Republic of Congo"),
          tags$li(tags$b("'ETH'"), " — Ethiopia"),
          tags$li(tags$b("'HTI'"), " — Haiti"),
          tags$li(tags$b("'IRQ'"), " — Iraq"),
          tags$li(tags$b("'KEN'"), " — Kenya"),
          tags$li(tags$b("'LBY'"), " — Libya"),
          tags$li(tags$b("'NER'"), " — Niger"),
          tags$li(tags$b("'NGA'"), " — Nigeria"),
          tags$li(tags$b("'SOM'"), " — Somalia"),
          tags$li(tags$b("'SDN'"), " — Somalia"),
          tags$li(tags$b("'SSD'"), " — South Sudan"),
          tags$li(tags$b("'SYR'"), " — North-West and North-East Syria"),
          tags$li(tags$b("'UGA'"), " — Uganda"),
          tags$li(tags$b("'UKR'"), " — Ukraine"),
          tags$li(tags$b("'VEN'"), " — Venezuela"),
          tags$li(tags$b("'YEM'"), " — Yemen")
        ))),

div(class = "param-box blue", id = "param2",
    div(class = "title", "start_date"),
    div(class = "description", "The date when we want the dataset to begin. It must be in yyyy-mm-dd format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"), 
        br(), 
        br(),
        
        "Please look at the 'Introduction page', section '3. Data Availability', 
                           column 'Last Date' for a list of available dates for each country.",
        br(),
        tags$ul(
          tags$li(tags$b("'2016-01-31'"), " — for data about Syria (where data collection efforts began in early 2015)"),
          tags$li(tags$b("'2022-11-01'"), " — for the starting round of data collection in Burkina Faso"),
        ),
        br(),
        "Please mind that if data is not available from the inputted start_date, the first available date will be returned.",
        
        "Moreover, it is important to note that even if the frequency of the data is reported to be monthly, there might be gaps in specific periods and countries."
    )),
div(class = "param-box violet", id = "param3",
    div(class = "title", "end_date"),
    div(class = "description", "The date when we want the dataset to end. It must be in yyyy-mm-dd format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        
        "Please look at the 'Introduction page', section '3. Data Availability', 
                           column 'Last Date' for a list of available dates for each country. 
                           Example end dates could be:",
        br(),
        tags$ul(
          tags$li(tags$b("'2024-02-27'"), " — for data about Syria (where data collection efforts are ongoing)"),
          tags$li(tags$b("'2020-06-30'"), " — for the last round of data collection in Nigeria"),
        ),
        br(),
        "Please mind that if data is not available from the inputted end_date, the last available date will be returned.",
        
        "Moreover, it is important to note that even if the frequency of the data is reported to be monthly, 
                           there might be gaps in specific periods and countries."
    )),
br(),

fluidRow(
  column(width = 6,
         aceEditor("code_editor1", 
                   mode = "python", 
                   theme = "tomorrow_night_bright", 
                   height = "280px",
                   value = "
## Python 3.11                    
  
import requests
import pandas as pd
    
url ='https://jmmi-db-2024-108.azure-api.net/impact-jmmi-api-open/get_item_names'
    
json_body = {
  'country': 'IRQ',
  'start_date': '2021-04-01',
  'end_date': '2021-04-27',
}
    
response = requests.get(url, params=json_body)
df = pd.DataFrame(response.json()['data'])
"),
fluidRow(
  column(2,
         tags$div(
           style = "position: relative;",  # Add a relative positioning container
           actionButton("send_request1", "Send Request", style = "background-color: black; color: white; font-size: 12px; padding: 5px 10px;"),
           tags$div(
             id = "loading-spinner1",
             style = "display: none; position: absolute; left: 200%; top: 50%; transform: translate(10px, -50%);",  # Adjust left and transform values for positioning
             tags$img(src = "https://i.gifer.com/ZZ5H.gif", height = "20px", width = "20px")
           )
         )
  )
)
  ),
column(width = 6,
       DTOutput("table_output1")
)),

br(),
br(),
tags$hr(style="border-color: lightgrey; border-width: 3px; width: 300px; border-radius: 10px; margin-left: 0;"),


tags$h4(tags$b("B) Get Variable Names")),
br(),
p("The get_variable_names function retrieves the variable names and labels 
  of the surveys collected for a specified country and time period. 
    Each row contains information about the content and naming of one column in price_data or full_data: 
  'names' is a style of column heading with 
  no spaces and concise text (eg. price_rice); on the other hand, 'labels' are column headings with spaces 
  and extensive information about the variable (Price of 1 kg of rice)."),


br(),

div(class = "param-box green", id = "param1",
    div(class = "title", "country"),
    div(class = "description", "The country for which the function needs to be executed. It must be in ISO-3 code format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        
        "The input ISO-codes and respective countries available in the JMMI are the following:",
        br(),
        tags$ul(
          tags$li(tags$b("'AFG'"), " — Afghanistan"),
          tags$li(tags$b("'BFA'"), " — Burkina Faso"),
          tags$li(tags$b("'BGD'"), " — Bangladesh"),
          tags$li(tags$b("'CAR'"), " — Central African Republic"),
          tags$li(tags$b("'COL'"), " — Colombia"),
          tags$li(tags$b("'DRC'"), " — Democratic Republic of Congo"),
          tags$li(tags$b("'ETH'"), " — Ethiopia"),
          tags$li(tags$b("'HTI'"), " — Haiti"),
          tags$li(tags$b("'IRQ'"), " — Iraq"),
          tags$li(tags$b("'KEN'"), " — Kenya"),
          tags$li(tags$b("'LBY'"), " — Libya"),
          tags$li(tags$b("'NER'"), " — Niger"),
          tags$li(tags$b("'NGA'"), " — Nigeria"),
          tags$li(tags$b("'SOM'"), " — Somalia"),
          tags$li(tags$b("'SDN'"), " — Somalia"),
          tags$li(tags$b("'SSD'"), " — South Sudan"),
          tags$li(tags$b("'SYR'"), " — North-West and North-East Syria"),
          tags$li(tags$b("'UGA'"), " — Uganda"),
          tags$li(tags$b("'UKR'"), " — Ukraine"),
          tags$li(tags$b("'VEN'"), " — Venezuela"),
          tags$li(tags$b("'YEM'"), " — Yemen")
        ))),

div(class = "param-box blue", id = "param2",
    div(class = "title", "start_date"),
    div(class = "description", "The date when we want the dataset to begin. It must be in yyyy-mm-dd format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"), 
        br(), 
        br(),
        
        "Please look at the 'Introduction page', section '3. Data Availability', 
    column 'Last Date' for a list of available dates for each country.",
    br(),
    tags$ul(
      tags$li(tags$b("'2016-01-31'"), " — for data about Syria (where data collection efforts began in early 2015)"),
      tags$li(tags$b("'2022-11-01'"), " — for the starting round of data collection in Burkina Faso"),
    ),
    br(),
    "Please mind that if data is not available from the inputted start_date, the first available date will be returned.",
    br(),  br(),
    "Moreover, it is important to note that even if the frequency of the data is reported to be monthly, there might be gaps in specific periods and countries."
    )),
div(class = "param-box violet", id = "param3",
    div(class = "title", "end_date"),
    div(class = "description", "The date when we want the dataset to end. It must be in yyyy-mm-dd format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        
        "Please look at the 'Introduction page', section '3. Data Availability', 
    column 'Last Date' for a list of available dates for each country. 
    Example end dates could be:",
    br(),
    tags$ul(
      tags$li(tags$b("'2024-02-28'"), " — for data about Syria (where data collection efforts are ongoing)"),
      tags$li(tags$b("'2020-06-30'"), " — for the last round of data collection in Nigeria"),
    ),
    br(),
    "Please mind that if data is not available from the inputted end_date, the last available date will be returned.",
    br(),
    br(),
    "Moreover, it is important to note that even if the frequency of the data is reported to be monthly, 
    there might be gaps in specific periods and countries."
    )),
div(class = "param-box yellow", id = "param6",
    div(class = "title", "format"),
    div(class = "description", "The type of dataset we want the column headings for ('full_data' or 'price_data')"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        "Format must be equal to one of:",
        br(),
        tags$ul(
          tags$li(tags$b("'full_data'"), " — it will return the column headings for full_data datasets"),
          tags$li(tags$b("'price_data'"), " — it will return the column headings for price_data datasets"),
        )
    )),

br(),

br(),
fluidRow(
  column(width = 6,
         aceEditor("code_editor2", 
                   mode = "python", 
                   theme = "tomorrow_night_bright", 
                   height = "270px",
                   value = "
## Python 3.11                    
  
import requests
import pandas as pd

url = 'https://jmmi-db-2024-108.azure-api.net/impact-jmmi-api-open/get_variable_names'
  
json_body = {
'country': 'CAR',
'start_date': '2020-04-01',
'end_date': '2020-04-27',
'format': 'full_data'
}
  
response = requests.get(url, params=json_body)
df = pd.DataFrame(response.json()['data'])
"),
fluidRow(
  column(2,
         tags$div(
           style = "position: relative;",  # Add a relative positioning container
           actionButton("send_request2", "Send Request", style = "background-color: black; color: white; font-size: 12px; padding: 5px 10px;"),
           tags$div(
             id = "loading-spinner2",
             style = "display: none; position: absolute; left: 200%; top: 50%; transform: translate(10px, -50%);",  # Adjust left and transform values for positioning
             tags$img(src = "https://i.gifer.com/ZZ5H.gif", height = "20px", width = "20px")
           )
         )
  )
)
  ),
column(width = 6,
       DTOutput("table_output2")
)
),

br(),
br(),
tags$hr(style="border-color: lightgrey; border-width: 3px; width: 300px; border-radius: 10px; margin-left: 0;"),


tags$h4(tags$b("C) Full Data")),
br(),
p("The full_data function retrieves the complete survey data collected for a specified country and time period. 
    Each row contains the entire survey content for one key informant (KI). Unlike the price_data datasets, 
    the full_data datasets also include qualitative information about the KI (e.g., age, credit) and the marketplace
    (e.g., market functionality indicators, marketplace size)."),

p("For users who are already accustomed to JMMI outputs, this format is of comparable nature."),

fluidRow(
  column(12,
         div(style = "color: black;",
             tags$span(icon("exclamation-triangle"), style = "color: black; font-size: 20px;"),
             " Beware! This function might take several minutes to run. In case the function times out, consider selecting a smaller time period."
         )
  )),

br(),

div(class = "param-box green", id = "param1",
    div(class = "title", "country"),
    div(class = "description", "The country for which the function needs to be executed. It must be in ISO-3 code format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        
        "The input ISO-codes and respective countries available in the JMMI are the following:",
        br(),
        tags$ul(
          tags$li(tags$b("'AFG'"), " — Afghanistan"),
          tags$li(tags$b("'BFA'"), " — Burkina Faso"),
          tags$li(tags$b("'BGD'"), " — Bangladesh"),
          tags$li(tags$b("'CAR'"), " — Central African Republic"),
          tags$li(tags$b("'COL'"), " — Colombia"),
          tags$li(tags$b("'DRC'"), " — Democratic Republic of Congo"),
          tags$li(tags$b("'ETH'"), " — Ethiopia"),
          tags$li(tags$b("'HTI'"), " — Haiti"),
          tags$li(tags$b("'IRQ'"), " — Iraq"),
          tags$li(tags$b("'KEN'"), " — Kenya"),
          tags$li(tags$b("'LBY'"), " — Libya"),
          tags$li(tags$b("'NER'"), " — Niger"),
          tags$li(tags$b("'NGA'"), " — Nigeria"),
          tags$li(tags$b("'SOM'"), " — Somalia"),
          tags$li(tags$b("'SDN'"), " — Somalia"),
          tags$li(tags$b("'SSD'"), " — South Sudan"),
          tags$li(tags$b("'SYR'"), " — North-West and North-East Syria"),
          tags$li(tags$b("'UGA'"), " — Uganda"),
          tags$li(tags$b("'UKR'"), " — Ukraine"),
          tags$li(tags$b("'VEN'"), " — Venezuela"),
          tags$li(tags$b("'YEM'"), " — Yemen")
        ))),

div(class = "param-box blue", id = "param2",
    div(class = "title", "start_date"),
    div(class = "description", "The date when we want the dataset to begin. It must be in yyyy-mm-dd format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"), 
        br(), 
        br(),
        
        "Please look at the 'Introduction page', section '3. Data Availability', 
    column 'Last Date' for a list of available dates for each country.",
    br(),
    tags$ul(
      tags$li(tags$b("'2016-01-31'"), " — for data about Syria (where data collection efforts began in early 2015)"),
      tags$li(tags$b("'2022-11-01'"), " — for the starting round of data collection in Burkina Faso"),
    ),
    br(),
    "Please mind that if data is not available from the inputted start_date, the first available date will be returned.",
    br(),  br(),
    "Moreover, it is important to note that even if the frequency of the data is reported to be monthly, there might be gaps in specific periods and countries."
    )),
div(class = "param-box violet", id = "param3",
    div(class = "title", "end_date"),
    div(class = "description", "The date when we want the dataset to end. It must be in yyyy-mm-dd format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        
        "Please look at the 'Introduction page', section '3. Data Availability', 
    column 'Last Date' for a list of available dates for each country. 
    Example end dates could be:",
    br(),
    tags$ul(
      tags$li(tags$b("'2024-02-28'"), " — for data about Syria (where data collection efforts are ongoing)"),
      tags$li(tags$b("'2020-06-30'"), " — for the last round of data collection in Nigeria"),
    ),
    br(),
    "Please mind that if data is not available from the inputted end_date, the last available date will be returned.",
    br(),
    br(),
    "Moreover, it is important to note that even if the frequency of the data is reported to be monthly, 
    there might be gaps in specific periods and countries."
    )),
div(class = "param-box red", id = "param4",
    div(class = "title", "heading_format"),
    div(class = "description", "The format of the column headings of the returned dataset ('names' or 'labels')"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        "Heading format must be equal one of:",
        br(),
        tags$ul(
          tags$li(tags$b("'names'"), " — it will return the column headings in a 
                  format with no spaces and concise text (e.g., 'price_rice','AFG_employees_number_nt')"),
          tags$li(tags$b("'labels'"), " — it will return the column headings in a format 
                  with spaces and extensive information about the variable 
                  (e.g., 'Price of 1 kg of rice', 'How many employees work in your company/workshop (including yourself)'?)"),
        )
    )),

br(),

br(),
fluidRow(
  column(width = 6,
         aceEditor("code_editor3", 
                   mode = "python", 
                   theme = "tomorrow_night_bright", 
                   height = "270px",
                   value = "
## Python 3.11                    
  
import requests
import pandas as pd

url = 'https://jmmi-db-2024-108.azure-api.net/impact-jmmi-api-open/full_data'
  
json_body = {
'country': 'BGD',
'start_date': '2020-04-01',
'end_date': '2020-04-27',
'heading_format': 'names'
}
  
response = requests.get(url, params=json_body)
df = pd.DataFrame(response.json()['data'])
"),
fluidRow(
  column(2,
         tags$div(
           style = "position: relative;",  # Add a relative positioning container
           actionButton("send_request3", "Send Request", style = "background-color: black; color: white; font-size: 12px; padding: 5px 10px;"),
           tags$div(
             id = "loading-spinner3",
             style = "display: none; position: absolute; left: 200%; top: 50%; transform: translate(10px, -50%);",  # Adjust left and transform values for positioning
             tags$img(src = "https://i.gifer.com/ZZ5H.gif", height = "20px", width = "20px")
           )
         )
  )
)
  ),
column(width = 6,
       DTOutput("table_output3")
)
),
br(),

br(),
tags$hr(style="border-color: lightgrey; border-width: 3px; width: 300px; border-radius: 10px; margin-left: 0;"),

tags$h4(tags$b("D) Price Data")),

p("The `price_data` function retrieves the prices of specified items collected 
  in the given country and time period. Each row contains the price of an item,
  with its name displayed in the `item_label` column. The dataset includes only
  the variables specifically collected for the item, such as availability, stocking, 
  and prices in both local currency and USD. All qualitative variables about the key 
  informant responding to the survey can be found in the `full_data` dataset."),

p("Before using this function, it is recommended to call the `get_item_names` 
  function to ensure that the items you are researching are available for the 
  specified country and time period. Incorrectly specifying item names will cause 
  the `price_data` function to fail."),


fluidRow(
  column(12,
         div(style = "color: black;",
             tags$span(icon("exclamation-triangle"), style = "color: black; font-size: 20px;"),
             " Beware! This function might take several minutes to run. In case the function times out, consider selecting a smaller time period."
         )
  )),
br(),

div(class = "param-box green", id = "param1",
    div(class = "title", "country"),
    div(class = "description", "The country for which the function needs to be executed. It must be in ISO-3 code format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        
        "The input ISO-codes and respective countries available in the JMMI are the following:",
        br(),
        tags$ul(
          tags$li(tags$b("'AFG'"), " — Afghanistan"),
          tags$li(tags$b("'BFA'"), " — Burkina Faso"),
          tags$li(tags$b("'BGD'"), " — Bangladesh"),
          tags$li(tags$b("'CAR'"), " — Central African Republic"),
          tags$li(tags$b("'COL'"), " — Colombia"),
          tags$li(tags$b("'DRC'"), " — Democratic Republic of Congo"),
          tags$li(tags$b("'ETH'"), " — Ethiopia"),
          tags$li(tags$b("'HTI'"), " — Haiti"),
          tags$li(tags$b("'IRQ'"), " — Iraq"),
          tags$li(tags$b("'KEN'"), " — Kenya"),
          tags$li(tags$b("'LBY'"), " — Libya"),
          tags$li(tags$b("'NER'"), " — Niger"),
          tags$li(tags$b("'NGA'"), " — Nigeria"),
          tags$li(tags$b("'SOM'"), " — Somalia"),
          tags$li(tags$b("'SDN'"), " — Somalia"),
          tags$li(tags$b("'SSD'"), " — South Sudan"),
          tags$li(tags$b("'SYR'"), " — North-West and North-East Syria"),
          tags$li(tags$b("'UGA'"), " — Uganda"),
          tags$li(tags$b("'UKR'"), " — Ukraine"),
          tags$li(tags$b("'VEN'"), " — Venezuela"),
          tags$li(tags$b("'YEM'"), " — Yemen")
      ))),

div(class = "param-box blue", id = "param2",
    div(class = "title", "start_date"),
    div(class = "description", "The date when we want the dataset to begin. It must be in yyyy-mm-dd format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"), 
        br(), 
        br(),
        
        "Please look at the 'Introduction page', section '3. Data Availability', 
                           column 'Last Date' for a list of available dates for each country.",
        tags$ul(
          tags$li(tags$b("'2016-01-31'"), " — for data about Syria (where data collection efforts began in early 2015)"),
          tags$li(tags$b("'2022-11-01'"), " — for the starting round of data collection in Burkina Faso"),
        ),
        br(),
        br(),
        "Please mind that if data is not available from the inputted start_date, the first available date will be returned.",
        br(),
        br(),
        "Moreover, it is important to note that even if the frequency of the data is reported to be monthly, there might be gaps in specific periods and countries."
    )),
div(class = "param-box violet", id = "param3",
    div(class = "title", "end_date"),
    div(class = "description", "The date when we want the dataset to end. It must be in yyyy-mm-dd format"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        
        "Please look at the 'Introduction page', section '3. Data Availability', 
                           column 'Last Date' for a list of available dates for each country. 
                           Example end dates could be:",
        tags$ul(
          tags$li(tags$b("'2024-02-28'"), " — for data about Syria (where data collection efforts are ongoing)"),
          tags$li(tags$b("'2020-06-30'"), " — for the last round of data collection in Nigeria"),
        ),
        br(),
        "Please mind that if data is not available from the inputted end_date, the last available date will be returned.",
        br(),
        br(),
        
        "Moreover, it is important to note that even if the frequency of the data is reported to be monthly, 
                           there might be gaps in specific periods and countries."
    )),
div(class = "param-box red", id = "param4",
    div(class = "title", "heading_format"),
    div(class = "description", "The format of the column headings of the returned dataset ('names' or 'labels')"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content", 
        br(),
        tags$b("Required class: 'string'"),
        br(), 
        br(),
        
        "Heading format must be equal one of:",
        tags$ul(
          tags$li(tags$b("'names'"), " — it will return the column headings in a 
                  format with no spaces and concise text (e.g., 'price_rice','AFG_employees_number_nt')"),
          tags$li(tags$b("'labels'"), " — it will return the column headings in a format 
                  with spaces and extensive information about the variable 
                  (e.g., 'Price of 1 kg of rice', 'How many employees work in your company/workshop (including yourself)'?)")
        )
    )
),

div(class = "param-box orange", id = "param5",
    div(class = "title", "items"),
    div(class = "description", "The names of the items that we want to filter the dataset for"),
    div(class = "toggle", tags$i(class = "fas fa-chevron-down")),
    div(class = "content",  br(),
        tags$b("Required class: 'list'"),
        br(), 
        br(),
        "A few examples of viable item lists:",
        tags$ul(
          tags$li(tags$b("['rice','soap']"), " — it will return all prices available for rice and soap"),
          tags$li(tags$b("['orange','wheat','tomato']")),
        ),
        br(), 
        "Please beware that the default selection is all items. Consequently, when no item is specified all prices are returned.",
        br(), 
        br(),
        "Moreover, make sure to have run the get_item_names function before running this function as to fully understand the syntax of all the items available in the dataset.",
    )
),

br(),


fluidRow(
  column(width = 6,
         aceEditor("code_editor4", 
                   mode = "python", 
                   theme = "tomorrow_night_bright", 
                   height = "290px",
                   value = "
# Python 3.11
  
import requests
import pandas as pd
   
url = 'https://jmmi-db-2024-108.azure-api.net/impact-jmmi-api-open/price_data'
    
json_body = {
'country': 'AFG',
'start_date': '2022-04-01',
'end_date': '2022-04-27',
'heading_format': 'names',
'items': ['rice','soap'],
}

response = requests.get(url, params=json_body)
df = pd.DataFrame(response.json()['data'])
"),
fluidRow(
  column(2,
         tags$div(
           style = "position: relative;",  # Add a relative positioning container
           actionButton("send_request4", "Send Request", style = "background-color: black; color: white; font-size: 12px; padding: 5px 10px;"),
           tags$div(
             id = "loading-spinner4",
             style = "display: none; position: absolute; left: 200%; top: 50%; transform: translate(10px, -50%);",  # Adjust left and transform values for positioning
             tags$img(src = "https://i.gifer.com/ZZ5H.gif", height = "20px", width = "20px")
           )
         )
  )
)
  ),
column(width = 6,
       DTOutput("table_output4")
)),
br(),
br(),


               )
             )
         )
)
  ),

div(class = "social-icons",
    a(href = "#", class = "email", onclick = "Shiny.setInputValue('open_email', true);",
      img(src = "logo-1.png", class = "overlay"),  # Add your image path here
      HTML('<i class="fas fa-envelope"></i>')
    ),
    a(href = "https://x.com/impact_init?lang=en", target = "_blank", class = "twitter", HTML('<i class="fab fa-twitter"></i>')),
    a(href = "https://www.linkedin.com/company/impact-initiatives", target = "_blank", class = "linkedin", HTML('<i class="fab fa-linkedin"></i>'))
)

)
server <- function(input, output, session) {
  # Ensure the 'requests' module is installed
  
  process_request <- function(editor_input, spinner_id, output_id) {
    observeEvent(input[[paste0('send_request', gsub("code_editor", "", editor_input))]], {
      req(input[[editor_input]])
      
      # Show spinner
      runjs(paste0("$('#", spinner_id, "').show();"))
      
      # Save the Python code to a temporary file
      temp_code_file <- tempfile(fileext = ".py")
      writeLines(input[[editor_input]], temp_code_file)
      
      # Set a timeout for the code execution
      setTimeLimit(elapsed = 15, transient = TRUE)
      
      tryCatch({
        py_run_file(temp_code_file)
        
        # Convert the Python DataFrame to an R DataFrame
        df <- py$df
        
        # Render DataTable
        output[[output_id]] <- renderDT({
          datatable(df, options = list(
            pageLength = 5,
            scrollX = TRUE,
            lengthChange = FALSE,
            searching = FALSE
          ))%>%
            formatStyle(
              columns = names(df),
              fontSize = '8px'
            )
        })
        
        # Hide the loading spinner
        runjs(paste0("$('#", spinner_id, "').hide();"))
        
      }, error = function(e) {
        if (grepl("reached elapsed time limit", e$message)) {
          showNotification("Processing time exceeds limits for testing API requests. Try inputting a smaller time period.", type = "error")
        } else {
          showNotification(paste("An error occurred:", e$message), type = "error")
        }
        runjs(paste0("$('#", spinner_id, "').hide();"))
      })
      
      # Reset the timeout limit
      setTimeLimit(elapsed = Inf, transient = FALSE)
    })
  }
  
  # Process request for the Introduction tab
  observeEvent(input$send_request, {
    req(input$code_editor)
    
    # Show spinner
    runjs("$('#loading-spinner').show();")
    
    # Save the Python code to a temporary file
    temp_code_file <- tempfile(fileext = ".py")
    writeLines(input$code_editor, temp_code_file)
    
    # Set a timeout for the code execution
    setTimeLimit(elapsed = 15, transient = TRUE)
    
    tryCatch({
      py_run_file(temp_code_file)
      
      # Convert the Python DataFrame to an R DataFrame
      df <- py$df
      
      # Render DataTable
      output$table_output <- renderDT({
        datatable(df, options = list(
          pageLength = 7,
          scrollX = TRUE,
          lengthChange = FALSE,
          searching = FALSE
        ))
      })
      
      # Hide the loading spinner
      runjs("$('#loading-spinner').hide();")
      
    }, error = function(e) {
      if (grepl("reached elapsed time limit", e$message)) {
        showNotification("Processing time exceeds limits for testing API requests. Try inputting a smaller time period.", type = "error")
      } else {
        showNotification(paste("An error occurred:", e$message), type = "error")
      }
      runjs("$('#loading-spinner').hide();")
    })
    
    # Reset the timeout limit
    setTimeLimit(elapsed = Inf, transient = FALSE)
  })
  
  # Centralize the processing logic for other tabs
  process_request("code_editor0", "loading-spinner0", "table_output0")
  process_request("code_editor9", "loading-spinner9", "table_output9")
  process_request("code_editor1", "loading-spinner1", "table_output1")
  process_request("code_editor2", "loading-spinner2", "table_output2")
  process_request("code_editor3", "loading-spinner3", "table_output3")
  process_request("code_editor4", "loading-spinner4", "table_output4")
  
  
  # Email sending logic
  observeEvent(input$open_email, {
    recipient <- "impact.geneva.cashandmarkets@impact-initiatives.org"
    subject <- paste0(Sys.Date(), " Enquiry on JMMI API")
    mailto_url <- paste0("mailto:", recipient, "?subject=", URLencode(subject))
    
    # Send a custom message to the client-side JavaScript to open the mailto link
    session$sendCustomMessage(type = 'openMail', mailto_url)
  })
  
  # # Allow reconnection when the dashboard times out
  # session$allowReconnect(TRUE)
  # 
  # observe({
  #   invalidateLater(1000 * 60 * 30, session)
  #   session$onSessionEnded(function() {
  #     stopApp()
  #   })
  # })
}


# Run the application 
shinyApp(ui = ui, server = server)