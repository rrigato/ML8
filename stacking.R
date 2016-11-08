loadTrain = function()
{
	library(data.table)
	
	train = as.data.frame(fread("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\cleanTrain.csv", sep = ','))	
	
	return(train)
}

loadTest = function()
{
	library(data.table)
	test = as.data.frame(fread("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\cleanTest.csv", sep = ','))
	return(test)
}


getTrain =  function(train)
{
	set.seed(1234)
	ranTrain = sample(1:nrow(train), floor(nrow(train) * .6) )
	return(ranTrain)
}


makeTrain = function(ranTrain, train)
{
	Train = train[ranTrain,]
	return(Train)
}

makeHoldout = function(ranTrain, train)
{
	#gets the observations that are not in the train dataset for the 
	#test dataset
	holdout = train[which(!((1:nrow(train)) %in% ranTrain) ),]
	return(holdout)
}




##############################################################
#Main entry point for the script
#
#
#
##############################################################


train = loadTrain()

Train = makeTrain(getTrain(train), train)
holdout = makeHoldout(getTrain(train), train)






library(h2oEnsemble)
h2o.init()

train = as.h2o( Train)
#train = h2o.importFile("newtrain.csv")
#test = h2o.importFile("newtest.csv")

test = as.h2o(holdout)
trainID = train$id
testID = test$id

trainY = train$loss
testY = test$loss

train = train[1:nrow(train), colnames(train)[2:ncol(train)]]

test = train[1:nrow(train), colnames(train)[2:ncol(train)]]



learner <- c("h2o.glm.wrapper", "h2o.randomForest.wrapper", 
             "h2o.gbm.wrapper", "h2o.deeplearning.wrapper")
metalearner <- "h2o.deeplearning.wrapper"

family = "gaussian"
x = colnames(train)[2:(ncol(train)- 1)]
y = "loss"

search_criteria <- list(strategy = "RandomDiscrete", 
                        max_runtime_secs = 120)
nfolds <- 5
system.time(fit <- h2o.ensemble(x = x,
                                y = y,
                                training_frame = train ,
                                family = family,
                                learner = learner,
                                metalearner = metalearner,
                                cvControl = list(V = 5, shuffle = TRUE)))

result = predict(fit, newdata = test)

result2 = matrix(nrow=nrow(test), ncol = 2)
result2 = as.data.frame(result2)
names(result2) = c("UNIQUE_ID", "Estimated_Ult_Avg_Severity")

result2$UNIQUE_ID = as.vector(test$UNIQUE_ID)
result2$Estimated_Ult_Avg_Severity = as.vector(result$pred)


