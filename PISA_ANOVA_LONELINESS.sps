* Encoding: UTF-8.
**After merging the 2012 and 2018 PISA dataset
    
* Encoding: UTF-8.
* Create the "sex_2_way" variable based on the "sex" variable.
RECODE sex (1 = 1) (2 = 2) (ELSE = SYSMIS) INTO sex_2_way.

* Define value labels for the new "sex_2_way" variable.
VALUE LABELS sex_2_way
  1 'Female'
  2 'Male'.

* Execute the commands.
EXECUTE.

* Recode "Outsider_Lonely" to create a new variable "Outsider_Lonely_New".
RECODE Outsider_Lonely (1 = 1) (2 = 2) (3 = 3) (4 = 4) (ELSE = SYSMIS) INTO Outsider_Lonely_New.

* Repeat similar recoding for the other loneliness items.
RECODE Friends_Lonely (1 = 1) (2 = 2) (3 = 3) (4 = 4) (ELSE = SYSMIS) INTO Friends_Lonely_New.
RECODE Belong_Lonely (1 = 1) (2 = 2) (3 = 3) (4 = 4) (ELSE = SYSMIS) INTO Belong_Lonely_New.
RECODE Awkward_Lonely (1 = 1) (2 = 2) (3 = 3) (4 = 4) (ELSE = SYSMIS) INTO Awkward_Lonely_New.
RECODE Liked_Lonely (1 = 1) (2 = 2) (3 = 3) (4 = 4) (ELSE = SYSMIS) INTO Liked_Lonely_New.
RECODE Lonely_Lonely (1 = 1) (2 = 2) (3 = 3) (4 = 4) (ELSE = SYSMIS) INTO Lonely_Lonely_New.

* Execute the commands.
EXECUTE.

* Reverse-code "Outsider_Lonely_New" to create a new variable "Outsider_Lonely_Rev".
RECODE Outsider_Lonely_New (1 = 4) (2 = 3) (3 = 2) (4 = 1) INTO Outsider_Lonely_Rev.

* Reverse-code "Awkward_Lonely_New" to create a new variable "Awkward_Lonely_Rev".
RECODE Awkward_Lonely_New (1 = 4) (2 = 3) (3 = 2) (4 = 1) INTO Awkward_Lonely_Rev.

* Reverse-code "Lonely_Lonely_New" to create a new variable "Lonely_Lonely_Rev".
RECODE Lonely_Lonely_New (1 = 4) (2 = 3) (3 = 2) (4 = 1) INTO Lonely_Lonely_Rev.

* Execute the commands.
EXECUTE.

* Add value labels to "Outsider_Lonely_New" and "Outsider_Lonely_Rev".
VALUE LABELS Outsider_Lonely_New Outsider_Lonely_Rev
  1 'Strongly Agree'
  2 'Agree'
  3 'Disagree'
  4 'Strongly Disagree'.

* Add value labels to "Awkward_Lonely_New" and "Awkward_Lonely_Rev".
VALUE LABELS Awkward_Lonely_New Awkward_Lonely_Rev
  1 'Strongly Agree'
  2 'Agree'
  3 'Disagree'
  4 'Strongly Disagree'.

* Add value labels to "Lonely_Lonely_New" and "Lonely_Lonely_Rev".
VALUE LABELS Lonely_Lonely_New Lonely_Lonely_Rev
  1 'Strongly Agree'
  2 'Agree'
  3 'Disagree'
  4 'Strongly Disagree'.

* Execute the commands.
EXECUTE.

* Add value labels to "Belong_Lonely_New".
VALUE LABELS Belong_Lonely_New
  1 'Strongly Agree'
  2 'Agree'
  3 'Disagree'
  4 'Strongly Disagree'.

* Add value labels to "Liked_Lonely_New".
VALUE LABELS Liked_Lonely_New
  1 'Strongly Agree'
  2 'Agree'
  3 'Disagree'
  4 'Strongly Disagree'.

* Add value labels to "Friends_Lonely_New".
VALUE LABELS Friends_Lonely_New
  1 'Strongly Agree'
  2 'Agree'
  3 'Disagree'
  4 'Strongly Disagree'.

* Execute the commands.
EXECUTE.

COMPUTE Loneliness_Score = MEAN(Friends_Lonely_New, Belong_Lonely_New, Liked_Lonely_New, Outsider_Lonely_Rev, Awkward_Lonely_Rev, Lonely_Lonely_Rev).
EXECUTE.

**Use select cases to only look at the trends within the Scandinavian countries. (NOT MISSING(COUNTRY)) & ((COUNTRY = 208) | (COUNTRY = 246) | (COUNTRY = 352) | (COUNTRY = 578) | (COUNTRY = 752))

**Statistical Tests for School Loneliness between 2012 and 2018

DATASET ACTIVATE DataSet1.
UNIANOVA Loneliness_Score BY Year COUNTRY
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=Year COUNTRY(TUKEY) 
  /PLOT=PROFILE(Year*COUNTRY COUNTRY*Year) TYPE=LINE ERRORBAR=NO MEANREFERENCE=NO YAXIS=AUTO
  /PRINT ETASQ DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=Year COUNTRY Year*COUNTRY.

UNIANOVA Loneliness_Score BY Year Sex
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=Year(TUKEY) 
  /PLOT=PROFILE(Year*Sex Sex*Year) TYPE=LINE ERRORBAR=NO MEANREFERENCE=NO YAXIS=AUTO
  /PRINT ETASQ DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=Year Sex Year*Sex.
