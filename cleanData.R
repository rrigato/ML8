loadTrain = function()
{
	library(data.table)
	
	train = as.data.frame(fread("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\train.csv", sep = ','))	
	return(train)
}

loadTest = function()
{
	library(data.table)
	test = as.data.frame(fread("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\test.csv", sep = ','))

	return(test)
}

############################################################
#Does not include variable cat117, because it has really high cardinality
#(over 300 levels)
#
#
##############################################################
encodeTrain = function(train, test)
{
	#one hot encodes all categorical variables,
	#suppresses the intercept term
	encodedCat =  model.matrix(~.-1, train[,2:116] )

	encoded2 = model.matrix(~.-1, test[,2:116] )

	#cast as data frames
	encodedCat = as.data.frame(encodedCat)
	encoded2 = as.data.frame(encoded2)


	#levels of test not in train
	notInTrain = names(encoded2)[which(!(names(encoded2)  %in% names(encodedCat)) )]
	
	#initializes an n column empty dataframe where n is the number of levels of variables in test
	#that are not found in train
	fillTrain = data.frame(matrix(nrow = nrow(train), ncol = length(notInTrain) ))

	#gives the names of the empty data frame the names of the missing levels in train
	names(fillTrain) = notInTrain
	
	#combines one hot encoded variables with continuous features and 
	#outcome variable
	allVars = as.data.frame(cbind(train[,1], encodedCat,fillTrain, train[,118:ncol(train)]))

	#rename the first variable to id
	names(allVars)[1] = 'id'

	return(allVars)
}



############################################################
#Does not include variable cat117, because it has really high cardinality
#(over 300 levels)
#
#
##############################################################
encodeTest = function(train, test)
{
	#one hot encodes all categorical variables,
	#suppresses the intercept term
	encodedCat =  model.matrix(~.-1, train[,2:116] )

	encoded2 = model.matrix(~.-1, test[,2:116] )


	#cast as dataframes
	encodedCat = as.data.frame(encodedCat)
	encoded2 = as.data.frame(encoded2)

	#levels of test not in train
	notInTest = names(encodedCat)[which(!(names(encodedCat)  %in% names(encoded2)) )]

	#initializes an n column empty dataframe where n is the number of levels of variables in test
	#that are not found in train
	fillTest = data.frame(matrix(nrow = nrow(test), ncol = length(notInTest) ))

	#gives the names of the empty data frame the names of the missing levels in train
	names(fillTest) = notInTest
	
	#combines one hot encoded variables with continuous features and 
	#outcome variable
	allVars2 = as.data.frame(cbind(test[,1], encoded2,fillTest, test[,118:ncol(test)]))

	#rename the first variable to id
	names(allVars2)[1] = 'id'



	return(allVars2)

}

writeCleanData = function(train,test)
{
	print("Writing train and test to a csv")
	write.csv(train, row.names = FALSE,
		 "C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\cleanTrain.csv")
 	write.csv(test, row.names = FALSE, 
		"C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\cleanTest.csv")

}


train = loadTrain()
test = loadTest()

train = encodeTrain(train, test)
test = encodeTest(loadTrain(), test)

writeCleanData(train,test)


