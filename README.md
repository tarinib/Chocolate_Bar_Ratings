
## README

Author: **TARINI BHATNAGAR**

Date created: November 30th, 2017


## Overview

There is nothing better than the smooth texture and rich taste of a piece of chocolate. Almost everyone is a huge fan of this delicacy made out of Theobroma cacao seeds, roasted and ground. 
However, not all chocolates are same!
This dataset contains expert ratings of over 1,700 individual chocolate bars, along with information on their regional origin, percentage of cocoa, the variety of chocolate bean used and where the beans were grown.

## Data

Data source: [https://www.kaggle.com/rtatman/chocolate-bar-ratings](https://www.kaggle.com/rtatman/chocolate-bar-ratings).
This dataset has been released under [CCO:Public Domain](https://creativecommons.org/publicdomain/zero/1.0/)

However, a kaggle account is required in order to download this dataset. Hence, a copy of the dataset has been provided in the ```data``` directory.	

**Column metadata:**

* Company
* Specific Bean Origin
* REF
* Review Date
* Cocoa Percent
* Company Location
* Rating
* Bean Type
* Broad Bean Origin

**Flavors of Cacao Rating System:**

* 5 : Elite (Transcending beyond the ordinary limits)
* 4 : Premium (Superior flavor development, character and style)
* 3 : Satisfactory(3.0) to praiseworthy(3.75) (well made with special qualities)
* 2 : Disappointing (Passable but contains at least one significant flaw)
* 1 : Unpleasant (mostly unpalatable)	
	
## Objectives

**Exploratory analysis**

Since I have recently learned the limitless possibilities of data anaylsis and visualization in R, I am going to perform an exploratory analysis of this dataset. 

Hypothesis: Best rated chocloates have the highest percentage of Cocoa and come mainly from Central and South America.

Testing this hypothesis will include investigating the following questions: 

* Is there a relationship between Cocoa percentage and Rating of chocolates?
* Which region produces the highest rated chocolates?
* Does Bean type effect Rating of chocolates?
* Where are the beans of highest rated chocolate bars grown?

## Suggested analysis

I will begin by plotting a worldmap visualizing the distribution of origin of beans. According to flavor ratings, a rating of 4 or 5 places the chocolate in 'elite' or 'premium' category. Hence, color coding the above scatter plot might help in identifying the regions producing the highets rated chocolates.

The relationship between Cocoa percentage and Rating of chocolates can be explored through correlation function and fitting a line through the data points. 

Visualizing the types of beans, rating of chocolates using box plots, jitter plots among others with varied aesthetics can narrow down regions producing the best quality chocolates.

I will also look at review date and chocolate ratings to see how ratings have varied over time.

## Acknowledgement

These ratings were compiled by Brady Brelinski, Founding Member of the Manhattan Chocolate Society. The dataset has been taken from kaggle.com.

