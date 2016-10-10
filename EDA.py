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
			
if __name__ == '__main__':
	insuranceObj = severityModel()
	