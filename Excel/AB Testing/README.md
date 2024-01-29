# Excel Skilltest: A/B Testing Results from Company A
## About the Data
Company A tests their applicants on their Excel skills and asks them to answer 5 questions. The dataset consists of three tables named 'Data buyers', 'Data visits', and 'Matching'.

### Data buyers

Total Rows: 3874  
Total Columns: 7

![Excel_DataBuyers](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/5a36da00-0a8a-4ad7-98b5-7f3a8e33bf62)

### Data visits
Total Rows: 275  
Total Columns: 4  

![Excel_DataVisits](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/8c255653-ad48-41d0-b888-4ff9e7e53b36)

### Matching
Total Rows: 13  
Total Columns: 2  

![Excel_Matching](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/420de7b0-ffd1-4e05-830d-81a40b12a42f)


## Question 1: Using the information in the matching sheet, match the Domain to each Category for each line.
By using the following formula on cell G7 and then dragging it to the rest of the cells in the Domain column, we get the desired result:  
```Excel
=VLOOKUP(G7; Matching!A:B; 2; FALSE)
```
![Excel_Q1](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/2f317417-7cf4-43b3-8ed1-306a43c0227f)

