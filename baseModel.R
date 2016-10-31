loadTrain = function()
{
	library(data.table)
	
	train = as.data.frame(fread("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\train.csv", sep = ','))	
}

loadTest = function()
{
	library(data.table)
	test = as.data.frame(fread("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\test.csv", sep = ','))
}


toFactor = function(train)
{

	for (i in 2:117)
	{
		train[,i] = as.factor(train[,i])
		#test[,i] = as.factor(test[,i])
	}
	return(train)
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
install.packages("TDboost")
library(TDboost)

train = loadTrain()
test = loadTest()
train = toFactor(train)
test = toFactor(test)

Train = makeTrain(getTrain(train), train)
holdout = makeHoldout(getTrain(train), train)
#everything except the id
tdFit = TDboost(loss ~ .,  n.trees = 1000, cv.folds = 5, data = Train[,-c(1)])


#predict the observations
output = predict.TDboost(tdFit, holdout, 50)
MAE <- sum(abs(temp[,3]- temp[,1])) / length(temp)














