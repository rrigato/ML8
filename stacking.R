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
h2o.init(nthread = -1)

train = as.h2o( Train)
train = h2o.importFile("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\cleanTrain.csv")
test = h2o.importFile("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\cleanTest.csv")

test = as.h2o(holdout)
trainID = train$id
testID = test$id

trainY = train$loss
testY = test$loss

train = train[1:nrow(train), colnames(train)[2:ncol(train)]]

test = test[1:nrow(test), colnames(test)[2:ncol(test)]]



learner <- c("h2o.glm.wrapper", "h2o.randomForest.wrapper", 
             "h2o.gbm.wrapper", "h2o.deeplearning.wrapper")


#adding custom learning functions
h2o.glm.1 <- function(..., alpha = 0.0) h2o.glm.wrapper(..., alpha = alpha)
h2o.glm.2 <- function(..., alpha = 0.5) h2o.glm.wrapper(..., alpha = alpha)
h2o.glm.3 <- function(..., alpha = 1.0) h2o.glm.wrapper(..., alpha = alpha)
h2o.randomForest.1 <- function(..., ntrees = 200, nbins = 50, seed = 1) h2o.randomForest.wrapper(..., ntrees = ntrees, nbins = nbins, seed = seed)
h2o.randomForest.2 <- function(..., ntrees = 200, sample_rate = 0.75, seed = 1) h2o.randomForest.wrapper(..., ntrees = ntrees, sample_rate = sample_rate, seed = seed)
h2o.randomForest.3 <- function(..., ntrees = 200, sample_rate = 0.85, seed = 1) h2o.randomForest.wrapper(..., ntrees = ntrees, sample_rate = sample_rate, seed = seed)
h2o.randomForest.4 <- function(..., ntrees = 200, nbins = 50, balance_classes = TRUE, seed = 1) h2o.randomForest.wrapper(..., ntrees = ntrees, nbins = nbins, balance_classes = balance_classes, seed = seed)
h2o.gbm.1 <- function(..., ntrees = 100, seed = 1) h2o.gbm.wrapper(..., ntrees = ntrees, seed = seed)
h2o.gbm.2 <- function(..., ntrees = 100, nbins = 50, seed = 1) h2o.gbm.wrapper(..., ntrees = ntrees, nbins = nbins, seed = seed)
h2o.gbm.3 <- function(..., ntrees = 100, max_depth = 10, seed = 1) h2o.gbm.wrapper(..., ntrees = ntrees, max_depth = max_depth, seed = seed)
h2o.gbm.4 <- function(..., ntrees = 100, col_sample_rate = 0.8, seed = 1) h2o.gbm.wrapper(..., ntrees = ntrees, col_sample_rate = col_sample_rate, seed = seed)
h2o.gbm.5 <- function(..., ntrees = 100, col_sample_rate = 0.7, seed = 1) h2o.gbm.wrapper(..., ntrees = ntrees, col_sample_rate = col_sample_rate, seed = seed)
h2o.gbm.6 <- function(..., ntrees = 100, col_sample_rate = 0.6, seed = 1) h2o.gbm.wrapper(..., ntrees = ntrees, col_sample_rate = col_sample_rate, seed = seed)
h2o.gbm.7 <- function(..., ntrees = 100, balance_classes = TRUE, seed = 1) h2o.gbm.wrapper(..., ntrees = ntrees, balance_classes = balance_classes, seed = seed)
h2o.gbm.8 <- function(..., ntrees = 100, max_depth = 3, seed = 1) h2o.gbm.wrapper(..., ntrees = ntrees, max_depth = max_depth, seed = seed)
h2o.gbm.9 <- function(..., ntrees = 1000, max_depth = 35,
learn_rate = .01,  seed = 1) h2o.gbm.wrapper(..., ntrees = ntrees, max_depth = max_depth,
learn_rate = learn_rate, seed = seed)
h2o.deeplearning.1 <- function(..., hidden = c(500,500), activation = "Rectifier", epochs = 50, seed = 1)  h2o.deeplearning.wrapper(..., hidden = hidden, activation = activation, seed = seed)
h2o.deeplearning.2 <- function(..., hidden = c(200,200,200), activation = "Tanh", epochs = 50, seed = 1)  h2o.deeplearning.wrapper(..., hidden = hidden, activation = activation, seed = seed)
h2o.deeplearning.3 <- function(..., hidden = c(500,500), activation = "RectifierWithDropout", epochs = 50, seed = 1)  h2o.deeplearning.wrapper(..., hidden = hidden, activation = activation, seed = seed)
h2o.deeplearning.4 <- function(..., hidden = c(500,500), activation = "Rectifier", epochs = 50, balance_classes = TRUE, seed = 1)  h2o.deeplearning.wrapper(..., hidden = hidden, activation = activation, balance_classes = balance_classes, seed = seed)
h2o.deeplearning.5 <- function(..., hidden = c(100,100,100), activation = "Rectifier", epochs = 50, seed = 1)  h2o.deeplearning.wrapper(..., hidden = hidden, activation = activation, seed = seed)
h2o.deeplearning.6 <- function(..., hidden = c(50,50), activation = "Rectifier", epochs = 50, seed = 1)  h2o.deeplearning.wrapper(..., hidden = hidden, activation = activation, seed = seed)
h2o.deeplearning.7 <- function(..., hidden = c(100,100), activation = "Rectifier", epochs = 50, seed = 1)  h2o.deeplearning.wrapper(..., hidden = hidden, activation = activation, seed = seed)






learner <- c("h2o.glm.wrapper",
             "h2o.randomForest.1", "h2o.randomForest.2",
             "h2o.gbm.1", "h2o.gbm.6", "h2o.gbm.8", "h2o.gbm.9",
             "h2o.deeplearning.1", "h2o.deeplearning.6", "h2o.deeplearning.7")

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
                                cvControl = list(V = 3, shuffle = TRUE)))

result = predict(fit, newdata = test)

result2 = matrix(nrow=nrow(test), ncol = 2)
result2 = as.data.frame(result2)
names(result2) = c("ID", "loss")

result2$ID = as.vector(testID)
result2$loss = as.vector(result$pred)

write.csv(result2, "C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\result2.csv", row.names = FALSE)



test = h2o.importFile("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\cleanTest.csv")


result = predict(fit, newdata = test)

result2 = matrix(nrow=nrow(test), ncol = 2)
result2 = as.data.frame(result2)
names(result2) = c("ID", "loss")

test = loadTest()
result2$ID = as.vector(test$ID)
result2$loss = as.vector(result$pred)

result2 = cbind(result2, test$id)
write.csv(result2, "C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\testPred1.csv", row.names = FALSE)

library(data.table)
testRes = as.data.frame(fread("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\testPred1.csv", sep = ','))



holdoutPred = as.data.frame(fread("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\holdoutPred.csv"))






names(testRes) = c("loss","id")
write.csv(testRes, "C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\result1.csv", row.names = FALSE)

