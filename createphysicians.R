library(data.table)
source('./recodeutilities.R')

physicians<-createbasefile("physicians.csv", "physicians")

physicians<-nativitylabels(physicians)
physicians<-malefemalelabels(physicians)
physicians<-racerecode(physicians)
physicians<-recodeIncomeHigh(physicians)

variables<-c("physicians$Nativity", "physicians$Household_Income", "physicians$Race", 
             "physicians$Gender")

physiciansxtabdf<-makeCrosstabbedData(physicians, variables)

oldnames<-colnames(physiciansxtabdf)
newnames<-sub(pattern="physicians.", "", oldnames)
colnames(physiciansxtabdf)<-newnames
saveRDS(file="./physiciansxtab.rds", physiciansxtabdf)
