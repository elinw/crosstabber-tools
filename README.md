crosstabber-tools
=================

Some tools for using crosstabber.

If you want to use your own crosstabber instance you will need to copy the cross tabber application and then use it on your Shiny server or on you account at SHinyapps.io or you can just use it locally from inside R.

Most likely you will want to create your own datasets.  This repository contains from tools for this.  Specifically crosstabber is expecting that you have converted your raw data into a reduced data set with a column named Freq and a row for each combination of attributes. 
The easiest way to do this is first to create a cross tab that contains all of the variables that you want to have available using `xtabs`.  Take the results of that and turn it into a dataframe. An easy way to do that is using `as.data.frame`. 

This repository contains some functions that will easily convert your census data into factors with nice, human readable labels and names. You can always add more to that file. Students seem to find it helpful if you use the same cutpoints consistently for something like age, and always using the same utilities will make it easy to do that. 

The repository also includes some examples showing how I made datasets using the utilities. In the future it will be more automated, but this way you have the ability to override however you want to.

In terms of building your data sets, I definitely recommend using data ferret to find micro data.   I also recommend not using too many variables at once unless your students are somewhat advanced.

### The ideas behind this

A lot of the thinking behind this is based on work I did as part of the Integrating Data Analysis project that NSF sponsored and that was jointly run by SSDAN and the American Sociological Association.  The idea if IDA is that sociology students should from their very first courses be doing the work of sociology, much of which is about analyzing data and linking data to theory.  The data should be real data, not mini or articifal datasets.  

The idea is also that doing this should not be about learning software, but learning about society through research. So the software should not get in the way.  The other benefit of this is that faculty don't feel like they are just teaching software or have to worry about a lot of technical problems. The class should be about the content, not about the mechanics, especially in lower level classes.

The application is deliberately designed to be simple. There are not options on "which direction" to calculate percents in for example.  As in most IDA data the number of variables in a data set is kept small. There should be enough so that a student has to think about what variables to use, but not so many that the choices are overwhelming. 

My hope is that because this is open source other people will be able to use it in their classes for their own topics pretty easily.  



