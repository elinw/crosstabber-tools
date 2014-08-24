## Create Data

immigration<-createbasefile("immigration2.csv", "immigration")

immigration<-nativitylabels(immigration)
immigration<-decadeofarrivallabels(immigration)
immigration<-regionlabels(immigration)
immigration<-malefemalelabels(immigration)
immigration<-racerecode(immigration)
immigration<-agerecode(immigration)

variables<-c("immigration$Nativity", "immigration$Age", "immigration$Race", 
             "immigration$Gender", "immigration$Arrival_Decade", "immigration$Region")

immigrationxtabdf<-makeCrosstabbedData(immigration, variables)

oldnames<-colnames(immigrationxtabdf)
newnames<-sub(pattern="immigration.", "", oldnames)
colnames(immigration)<-newnames

saveRDS(immigrationxtabdf, file="immigrationxtab.rds")
