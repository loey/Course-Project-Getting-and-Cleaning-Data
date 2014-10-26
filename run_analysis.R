# # # # # # # # # # # # # # # # # # # # # # # # # 
# Testsæt
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

test_subject_test<-read.table("test/subject_test.txt")
test_X_test<-read.table("test/X_test.txt")
test_X_test<-as.data.frame(sapply(test_X_test, as.numeric))
test_Y_test<-read.table("test/Y_test.txt")
subject_test<-read.table("test/subject_test.txt")


# # # # # # # # # # # # # # # # # # # # # # # # # 
# Træningssæt
train_subject_train<-read.table("train/subject_train.txt")
train_X_test<-read.table("train/X_train.txt")
train_X_test<-as.data.frame(sapply(train_X_test, as.numeric))
train_Y_test<-read.table("train/Y_train.txt")
subject_train<-read.table("train/subject_train.txt")


# # # # # # # # # # # # # # # # # # # # # # # # # 
# Nu sammenbindes data
test<-cbind(test_Y_test, test_X_test, subject_test)
train<-cbind(train_Y_test, train_X_test, subject_train)
data<- rbind(test,train)


# # # # # # # # # # # # # # # # # # # # # # # # # 
# Nu indsættes variabelnavne til train_X_test
features <- data.frame(lapply(features, as.character), stringsAsFactors=FALSE)
features_for_use <- features[,2]
for (i in 1:561)
{
  colnames(data)[i+1] <- features_for_use[i]
}
colnames(data)[1]<-"activities"
colnames(data)[563]<-"subject"


# # # # # # # # # # # # # # # # # # # # # # # # # 
# Nu ekstraheres de data som skal bruges
data_for_use<-cbind(data[,1:7], data[,42:47], data[,82:87], data[,122:127], 
data[,166:167], data[,202:203], data[,215:216], data[,228:229],
data[,241:242], data[,254:255], data[,267:272], data[,346:351], data[,425:430],
data[,504:505], data[,517:518], data[,530:531], data[,543:544], data[,563])
colnames(data_for_use)[64]<-"subject"


# # # # # # # # # # # # # # # # # # # # # # # # # 
# Nu skabes tidy-dataset med gennemsnit af hver aktivitet og label
for (i in 1:30)
{
  assign(paste0("subject_", i), subset(data_for_use, subject==i))
}
subject_list<-list(subject_1=subject_1, subject_2=subject_2, subject_3=subject_3, 
                   subject_4=subject_4, subject_5=subject_5, subject_6=subject_6,
                   subject_7=subject_7, subject_8=subject_2, subject_9=subject_9, 
                   subject_10=subject_10, subject_11=subject_11, subject_12=subject_12,
                   subject_13=subject_13, subject_14=subject_14, subject_15=subject_15, 
                   subject_16=subject_16, subject_17=subject_17, subject_18=subject_18,
                   subject_19=subject_19, subject_20=subject_20, subject_21=subject_21, 
                   subject_22=subject_22, subject_23=subject_23, subject_24=subject_24,
                   subject_25=subject_25, subject_26=subject_26, subject_27=subject_27, 
                   subject_28=subject_28, subject_29=subject_29, subject_30=subject_30)
samlet_subject_means<-data.frame(colMeans(subject_list[[1]]))

for (i in 1:30)
{
  assign('navn', cbind(colMeans(subject_list[[i]])))
  colnames(navn)<-paste0("means_subject_", i)
  samlet_subject_means<-cbind(samlet_subject_means, navn)
  assign(paste0("means_subject_", i), navn)
}


# # # # # # # # # # # # # # # # # # # # # # # # # 
# Nu gentages for activities
for (i in 1:6)
{
  assign(paste0("activity_", i), subset(data_for_use, activities==i))
}
activity_list<-list(activity_1=activity_1, activity_2=activity_2,
                    activity_3=activity_3, activity_4=activity_4,
                    activity_5=activity_5, activity_6=activity_6)

samlet_activity_means<-data.frame(colMeans(activity_list[[1]]))

for (i in 1:6)
{
  assign('navn', cbind(colMeans(activity_list[[i]])))
  #colnames(navn)<-paste0("means_activity_", i)
 
  if (i==1)
  {
    colnames(navn)<-"means_activity_Walking"
  } 
  else if (i==2) 
  {
    colnames(navn)<-"means_activity_Walking_Upstairs"
  }
  else if (i==3) 
  {
    colnames(navn)<-"means_activity_Walking_Downstairs"
  }
  else if (i==4) 
  {
    colnames(navn)<-"means_activity_Sitting"
  }
  else if (i==5) 
  {
    colnames(navn)<-"means_activity_Standing"
  }
  else if (i==6) 
  {
    colnames(navn)<-"means_activity_Laying"
  }
  
  samlet_activity_means<-cbind(samlet_activity_means, navn)
  assign(paste0("means_activity_", i), navn)
}

# # # # # # # # # # # # # # # # # # # # # # # # # 
# Nu sammenlægges til tidy data set
tidyA<-samlet_activity_means[,2:7]
tidyB<-samlet_subject_means[,2:31]
tidyC<-cbind(tidyA, tidyB)
tidy_data_set<-tidyC[2:63,]
tidy_data_set<-t(tidy_data_set)
