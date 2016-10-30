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


toFactor = function(train, test)
{

	for (i in 2:117)
	{
		train[,i] = as.factor(train[,i])
		test[,i] = as.factor(test[,i])
	}
	
}

getTrain =  function(train)
{
	set.seed(1234)
	ranTrain = sample(1:nrow(train), floor(nrow(train) * .8) )
	return(ranTrain)
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


TDboost(loss ~ ., data = train)












