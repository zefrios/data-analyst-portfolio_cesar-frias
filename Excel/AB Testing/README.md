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


### Question 1: Using the information in the matching sheet, match the Domain to each Category for each line.
By using a VLOOKUP formula as follows, we can get the desired result:  
```Excel
=VLOOKUP(G7; Matching!A:B; 2; FALSE)
```
![Excel_Q1](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/2f317417-7cf4-43b3-8ed1-306a43c0227f)

### Question 2: 
**a) In the AB test 2, find the average basket of the Control version.**  

Once we filter our data so we only see the table with the asked criteria (AB test2 and Control), we proceed to SUM() the elements in the Number of Checkouts column and the Revenue column. Then we divide the results to obtain Avg. Basket:  

![Excel_Q2](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/33d3a866-a0f7-4a67-b4d5-3eabcf8adc97)

**b) Still in this same AB test 2, and for the control version, display the average basket for each category.**  
By using the a SUMIF() formula we can obtain the Average Basket given a specific Category. For example to obtain the Average Basket for SHOES, we used:
```Excel
=SUMIF('Q1'!G1716:G3723; B8; 'Q1'!E1716) / SUMIF('Q1'!G1716:G3723; B8; 'Q1'!D1716)
```
This is the final result:  

![Excel_Q2b](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/83cb7443-9ae0-4dfd-a59d-c4e5e5de81f7)

### Question 3: Compare the conversion rates (conversions/visits) on the different versions of AB test 3. Did a version perform better than the other?  
To answer this, filtering the *Data visits* table to only display AB Test 3 and sorting it by date revealed that there are two versions for this test: *Control* and *Improved*.  

![Excel_Q3_1](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/300fd739-6a9d-43dd-aeb3-265f72c26f5f)

By using pivot tables, we can arrange *Control version* and *Improved* cells as columns, which allows us to easily calculate the Total Visits and the Total Number of Checkouts per test version and thus, calculate the conversion rates for both the *Improved* test and the *Control* test:  

![image](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/21e9dcab-631c-43d4-ab55-a8956aeeea4a)

![Excel_Q3_3](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/28602173-621d-44f5-8926-6fb1cab87614)

**So to answer Q3, there is a slight practical difference between the versions in the test, but not significative enough to make a business decision. Further testing would be recommended.**

