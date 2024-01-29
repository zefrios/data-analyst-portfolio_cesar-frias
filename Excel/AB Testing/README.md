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

### Question 4: Display here a table which shows the conversion rates (conversions/visits) of every version of the A/B Test 3, per week.  
For this, we need to calculate an extra column to have the conversion rate per day for both types of tests and then we can use pivot tables to group and display the data per week.  

![Excel_Q4_1](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/e0272c20-ef2e-4fa0-b67d-eb5fc8fddc04)

![Excel_Q4_2](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/9675f0a3-98f8-4255-93df-514453c7304c)

### Question 5: 
**When we do A/B testing we want to make sure that there is always a reference version. That way we compare the results between the test version and this reference version (control version), and conclude on the best version.  

a) In the whole data set, count the number of test versions we tried out that do not respect the A/B testing rule mentioned above.**  
**b) Display these test versions.**  

To answer this, we must create a helper column in our dataset. Then we can use a set of nested IF(COUNTIF()) to find which tests have a control version. For example this is the formula used in the first row of the helper column:  
```
=IF(COUNTIFS($B$2:$B$3874; $B2; $C$2:$C$3874; "*Control version*") > 0; "Control"; "No Control")
```
![Excel_Q5_1](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/4a5ada51-f2f4-41e6-9c87-e9ee20d771e4)

Once we have our helper column, we can use pivot tables to filter out the tests with no control version. Choosing the table to count values for test versions, the final display looks like this:  

![Excel_Q5_2](https://github.com/zefrios/data-analyst-portfolio_cesar-frias/assets/83305620/d706f41a-be83-4b8a-a1d0-ccd6e36b937f)




