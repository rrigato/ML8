import pandas as pd
import numpy as np

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
if __name__ == '__main__':
	insuranceObj = severityModel()
	insuranceObj.getUnique()
	print(insuranceObj.categoryUnique)
	