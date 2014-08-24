## This is a set of utility functions for handling recoding of census data.
## Creating the immigration files

library(data.table)

## We're going to put everything in the same folder as this file.
## Code from http://r.789695.n4.nabble.com/set-working-directory-to-current-source-directory-td4640210.html
this.dir <- dirname(parent.frame(2)$ofile) 
setwd(this.dir) 

##dataframe is a dataframe that contains the RAC1P variable and the HISP variable
## This function pulls all self-identified Hispanics or Latinos into a separate group
## regardless of what self-identified race category they are in.
racerecode<-function(dataframe)
{
        ## Pull out Hispanics into a separate code.
        dataframe$racerecode<-ifelse(dataframe$HISP > 1, 10, dataframe$RAC1P)
        racelabels<-c("White", "Black", "Asian", "American Indian + Alaskan Native ", "Other", "Multiple", "Latino")
        racecuts<-c(0,1,2,4,6,8,9,10)
        dataframe$Race<-cut(dataframe$racerecode, breaks=racecuts, labels=racelabels)
        return(dataframe)
}

## This function will divide raw ages into a smaller number  of age groups.
## This is for the census variable Age.
agerecode<-function(dataframe)
{
        agebreaks<-c(0, 4, 14, 24, 34, 44, 54, 64, 200)
        agelabels=c("Under 4", "5-14", "15-24", "25-34", "35-44", "45-54", "55-64", "65+")
        dataframe$Age<-cut(dataframe$AGEP, breaks=agebreaks, ordered_result=TRUE, labels=agelabels)
 
        return(dataframe)
}

## This function assigns yes no labels to a dichtomous variable and makes the variable a factor. 
## Yes is assigned to the lowest value in a dataframe.
yesnolabels<-function(dataframe, variable)
{
        yesnolabels<-c("Yes", "No")
        dataframe[[variable]]<-factor(dataframe[[variable]], labels=yesnolabels)        
        return(dataframe)        
}

## This takes the census variable SEX, applies labels and converts to a factor called Gender.
malefemalelabels<-function(dataframe)
{
        genderlabels<-c("Male","Female")
        dataframe$Gender<-factor(dataframe$SEX, label=genderlabels)
        return(dataframe)
}

## This takes the census variable NATIVITY, applies labels and converts to a factor called Gender.
nativitylabels<-function(dataframe)
{
        nativitylabels<-c("Native Born","Foreign Born")
        dataframe$Nativity<-factor(dataframe$NATIVITY, label=nativitylabels)
        return(dataframe)
}

## This takes the census variable REGION, applies labels and 
## converts to a factor called Region.

regionlabels<-function(dataframe)
{
        regionlabels<-c("Northeast", "Midwest", "South", "West")
        dataframe$Region<-factor(dataframe$REGION, label=regionlabels)
        return(dataframe)
}

## This takes the census variable DECADE, applies labels and 
## converts to a factor called Arrival_Decade.

decadeofarrivallabels<-function(dataframe)
{
        decadelabels<-c("Native Born","Before 1950", "1950 to 1959", "1960 to 1969", "1970 to 1979",
                       "1980-1989", "1990-1999", "2000 or later")
        dataframe$Arrival_Decade<-factor(dataframe$DECADE, label=decadelabels)
        return(dataframe)
}

## Recode income in a way appropriate for high income subsets
recodeIncomeHigh<-function(dataframe)
{
        ## Only use data for people with incomes
        dataframe$HINCP<-ifelse(dataframe$HINCP < 1, NA, dataframe$HINCP)
        incomecuts<-c(0, 100000, 150000, 200000, 250000, 300000, 350000, 400000, 450000, 3000000)
        incomelabels<-c("Under $100,000", "$100,000-$149,999", "$150,000-$199,999", "$200,000-$249,99", 
                        "$250,000 - $299,999", "$300,000-$349,999", "$350,000-$399,999", 
                        "$400,000-$449,999", "$450,000 or more")
        dataframe$Household_Income<-cut(dataframe$HINCP, labels=incomelabels,
                                           breaks=incomecuts, ordered_result=TRUE)
        return(dataframe)
}

## Rename the original census variables
## Give the name of the dataframe and the array of new names 
## (must match the order and number of old names)
renameVariables<-function(dataframe, newnames)
{
        oldnames<-colnames(dataframe)
        colnames(dataframe)<-newames
        return(dataframe)
}



## Create the dataframe
createbasefile<-function(csvFile, dataframeName)
{
        dataframeName<-fread(csvFile, header=TRUE)
        filename<-paste0(dataframeName, ".rds")
        saveRDS(dataframeName, file=filename)
        return(dataframeName)
}

## This will make the compact data set to be used in the application.
## the variable list should be the variables you want in the final data set.
makeCrosstabbedData<-function(dataframe, variableList)
{
        formulaList<-as.formula(paste0("~", paste(variableList, collapse="+")))
        xtabname<-xtabs(formula=  formulaList, 
              drop.unused.levels = TRUE,
              data=dataframe)
        xtabname<-as.data.frame(xtabname)
        return(xtabname)
}
