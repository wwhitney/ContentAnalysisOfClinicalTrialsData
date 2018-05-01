% Content Analysis oF Clinical Trials Data
% Wanda Narun Shirley Monika

# Clinical Trials Data
  - ClinicalTrials.org as a part of NIH ask PI to inform if they intent to share Participant Individual Data(PID)
  - ClinicalTrials.org has information how PID information will be shared
  - Data has been analyzed on records registered between January 2016 and August 2017
  - New and more information has been added since
  - Purpose of this project is to examine the changes if any
  - Source of our data is ClinicalTrials.gov (AACT) database containing all the ClinicalTrials.gov records
 # Connect and query database
  - Import libraries `sqlalchemy`  and `panda`
  - Create an engine to the database
  
    `engine = create_engine('postgresql+psycopg2://aact:aact@aact-db.ctti-clinicaltrials.org:5432/aact')`
  - Query Engine and save the information as dataframe (df)
  
    `df = pd.read_sql_query("SELECT * FROM studies WHERE plan_to_share_ipd != 'Null'", engine)`
  - Save information as csv file
  
    `df.to_csv('intent.csv',sep=',')`
    
  # Open file and capture columns of interest
   - Import necessary libraries `os` `from dateutil.parser import parse` `import matplotlib.pyplot as plt`
   - Prompt user to provide input file path and change to that dir
   
    `default_path = input('Please enter the path to your file: ')`
    `os.chdir(default_path)`
   - Select two columns of interest
   
    `datePlan = intent[['first_received_date', 'plan_to_share_ipd']]  

  # Parse and clean data
   - Parse Date columns
   
   `datePlan['first_received_date'] = datePlan['first_received_date'].apply(parse, yearfirst =True)`
   - Extract date to month and year only
   
   `datePlan['month_year'] = datePlan['first_received_date'].dt.to_period('M')`
   - Count the occurance of each value
   
    `datePlan['first_received_date'].value_counts()`
    `datePlan['plan_to_share_ipd'].value_counts()`
    `datePlan['month_year'].value_counts()`
   - Create a new dataframe based on count of plan_to_share_ipd for each month
   
    `datePlanGroupByCount =  datePlan.groupby(['month_year', 'plan_to_share_ipd'])['first_received_date'].count().reset_index(name="count")`
   - Seprate each unique value of 'plan_to_share_ipd' into separate columns to plot
   
    `datePlanGroupByCountPivot = datePlanGroupByCount.pivot('month_year', 'plan_to_share_ipd', 'count').fillna(0)`

   - Change the order of columns, such that the order is "yes", "no", "undecided"
   
    `cols = datePlanGroupByCountPivot.columns.tolist()`
    `cols = cols[-1:] + cols[:-1]`
    `datePlanGroupByCountPivot = datePlanGroupByCountPivot[cols]`
    
  #  Plot Frequency of three potential choices as a function of year
   - Plot and label the data 
   
    `ax =  datePlanGroupByCountPivot.plot(title = "Willingness to Share Individual Participant Data")`
    `ax.set_xlabel("The record first received in clinicaltrials.gov (month)")`
    `ax.set_ylabel("Frequency")`
    `ax.legend(title='')`
    `plt.show()`
    
  # Willingness to Share Individual Participant Data Plot
   -  ![alt text](https://github.com/mbihan/biof309_spring2018_project1/tree/master/ContentAnalysisOfClinicalTrialsData/SharePIDByYear.png)
   
  # References and Thanks
   - http://www.icmje.org/recommendations/browse/publishing-and-editorial-issues/clinical-trial-registration.html#two 
   - https://jamanetwork.com/journals/jama/fullarticle/2670243 https://aact.ctti-clinicaltrials.org/
   - Prof. Martin Skarzynski
   
