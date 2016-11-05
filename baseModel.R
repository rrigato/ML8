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

encodeTrain(train, test)
{
	#one hot encodes all categorical variables,
	#suppresses the intercept term
	encodedCat =  model.matrix(~.-1, train[,2:116] )

	encoded2 = model.matrix(~.-1, test[,2:116] )

	#levels of test not in train
	notInTrain = names(encoded2)[which(!(names(encoded2)  %in% names(encodedCat)) )]
	
	#initializes an n column empty dataframe where n is the number of levels of variables in test
	#that are not found in train
	fillTrain = data.frame(matrix(nrow = nrow(train), ncol = length(notInTrain) ))

	#gives the names of the empty data frame the names of the missing levels in train
	names(fillTrain) = notInTrain
	
	#combines one hot encoded variables with continuous features and 
	#outcome variable
	allVars = as.data.frame(cbind(train[,1], encodedCat,fillTrain, train[,117:ncol(train)]))

	#rename the first variable to id
	names(allVars)[1] = 'id'

	return(allVars)
}

encodeTest = function(train, test)
{
	#one hot encodes all categorical variables,
	#suppresses the intercept term
	encodedCat =  model.matrix(~.-1, train[,2:116] )

	encoded2 = model.matrix(~.-1, test[,2:116] )

	#levels of test not in train
	notInTest = names(encodedCat)[which(!(names(encodedCat)  %in% names(encoded2)) )]

	#initializes an n column empty dataframe where n is the number of levels of variables in test
	#that are not found in train
	fillTest = data.frame(matrix(nrow = nrow(test), ncol = length(notInTest) ))

	#gives the names of the empty data frame the names of the missing levels in train
	names(fillTest) = notInTest
	
	#combines one hot encoded variables with continuous features and 
	#outcome variable
	allVars2 = as.data.frame(cbind(test[,1], encoded2,fillTest, test[,117:ncol(test)]))

	#rename the first variable to id
	names(allVars2)[1] = 'id'



	return(allVars2)

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

train = encodeCategorical(train)
test = encodeCategorical(test)

train = toFactor(train)
test = toFactor(test)

Train = makeTrain(getTrain(train), train)
holdout = makeHoldout(getTrain(train), train)
#everything except the id
tdFit = TDboost(loss ~ .,  n.trees = 10, cv.folds = 5, data = Train[,-c(1)])



crossResult = TDboost.perf(tdFit, method = "cv")
#predict the observations
output = predict.TDboost(tdFit, holdout, 1000)
temp = cbind(output, holdout$id, holdout$loss)
MAE <- sum(abs(temp[,3]- temp[,1])) / length(temp)


test[which(as.character(test$cat89) == "F"), 'cat89'] = 'NA'

#fixing variables that had no levels in train dataset
test[,'cat92'] = as.character(test[,'cat92'])
test[which(as.character(test$cat92) == "E"), 'cat92'] = 'A'
test[which(as.character(test$cat92) == "G"), 'cat92'] = 'A'
test[,'cat96'] = as.character(test[,'cat96'])
test[which(as.character(test$cat96) == "H"), 'cat96'] = 'A'

test[c(67038, 88842), 'cat89'] = 'A'
output1 = predict.TDboost(tdFit, test, 1000)

Result1 













