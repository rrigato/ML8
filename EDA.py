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
		
	def plotCont(self)
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
		for contin in self.train.loc[:,'cont1':'cont14']:
	
	
		
if __name__ == '__main__':
	insuranceObj = severityModel()
	insuranceObj.getUnique()
	print(insuranceObj.categoryUnique)
	insuranceObj.getDescription()