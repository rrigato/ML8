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
		print(self.train.loc[:,'cont1':])
		print(self.test.loc[:,'cont1':])
		
	def plotCont(self)
		'''
			Gives a visual of the continuous variables
		'''
		colors = np.random.rand(N)
		plt.scatter(self.train.loc[:,'cont1'], self.train.loc[:'cont2'], s=self.train.loc[:,'loss'],  alpha=0.5)
		plt.show()
		
if __name__ == '__main__':
	insuranceObj = severityModel()
	insuranceObj.getUnique()
	print(insuranceObj.categoryUnique)
	insuranceObj.getDescription()