import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

class severityModel:
	def __init__(self):
		'''
			Initializes the object
		'''
		self.loadData()
		
	def loadData(self):
		'''
			Loads the data into memory
		'''
		self.train = pd.read_csv("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\train.csv")
		self.test = pd.read_csv("C:\\Users\\Punkiehome1\\Downloads\\allstateKaggle\\test.csv")
		print(self.train.head())
		print(self.train.shape)
		print(self.test.head())
		print(self.train.shape)
		
	def getUnique(self):
		'''
			Gets a list of distinct values
		'''
		self.categoryUnique = [None] * 115
		i = 0
		'''
			Iterating over each categorical variable to 
			see how many unique values are in each
			Stores the result in self.categoryUnique
		'''
		for cols in self.train.ix[:,2:117]:
			self.categoryUnique[i] = len(np.unique(self.train.loc[:,cols]))
			i += 1
			
	def getDescription(self):
		'''
			Gets the description of all the continuous variables
		'''
		print(self.train.loc[:,'cont1':].describe())
		print(self.test.loc[:,'cont1':].describe())
		
	def plotCont(self):
		'''
			Gives a visual of the continuous variables
		'''
		colors = np.random.rand(N)
		plt.scatter(np.array(self.train.loc[:,'cont1']).reshape(len(train), 1), np.array(self.train.loc[:'cont2']).reshape(len(train), 1), s=self.train.loc[:,'loss'],  alpha=0.5)
		plt.show()
		
	def getRatios(self):
		'''
			does some automatic feature creation for ratios of the continuous variables
		'''
		'''
			Subsets the entire train dataset into only continuous features and then further subsets
			based on whether a continuous feature has a minimum greater than zero
			The reason for this is because I will be creating ratios, and we cannot divide by zero
		'''
		self.train.loc[:,'cont1':'cont14'].loc[:,self.train.loc[:,'cont1':'cont14'].min() >0].head() 
		
		'''
			Variables that have a minimum of 0 in the test dataset
		'''
		zeroMinVariables = ['cont9', 'cont10']
		
		'''
			The new columns to be added to the dataframe
		'''
		newCols = pd.DataFrame(columns = ['ratio1','ratio2','ratio3','ratio5','ratio6', 'ratio7', 'ratio8', 'ratio11', 'ratio12', 'ratio13', 'ratio14'])
		
		'''
			adding the new columns which will show up as Nans to the train dataframe
		'''
		self.train = pd.concat([self.train, newCols], axis = 1)
		
		'''
			List of column names that will be iterated over to create new ratios
		'''
		colNames = ['ratio1','ratio2','ratio3','ratio5','ratio6', 'ratio7', 'ratio8', 'ratio11', 'ratio12', 'ratio13', 'ratio14']
		contNames = ['cont1','cont2','cont3','cont5','cont6', 'cont7', 'cont8', 'cont11', 'cont12', 'cont13', 'cont14'] 
		
		start = 1
		colCounter = start
		
		while colCounter <= len(colNames) - 1:
			self.train.loc[:,colNames[colCounter]] = self.train.loc[:,contNames[colCounter]]
			
			colCounter = colCounter + 1
		#for contin in pd.concat([self.train.loc[:,'cont1':'cont8'], self.train.loc[:,'cont11':'cont14']], axis = 1):
			
	
	
		
if __name__ == '__main__':
	insuranceObj = severityModel()
	insuranceObj.getUnique()
	print(insuranceObj.categoryUnique)
	insuranceObj.getDescription()
	insuranceObj.getRatios()