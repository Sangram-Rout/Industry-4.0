# -*- coding: utf-8 -*-
"""
Created on Mon Feb 17 15:12:00 2020

@author: shuhe
"""

import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from scipy.io import loadmat
import numpy

class XY_Net(nn.Module):
    def __init__(self):
        super(XY_Net,self).__init__()
        self.fc1 = nn.Linear(350,150)
        self.fc2 = nn.Linear(150,50)
        self.fc3 = nn.Linear(50,10)
        self.fc4 = nn.Linear(10,3)
        
    def forward(self,X):
        X = torch.sigmoid(self.fc1(X))
        X = torch.sigmoid(self.fc2(X))
        X = torch.sigmoid(self.fc3(X))
        X = self.fc4(X)
        return X
net = XY_Net() 
net.load_state_dict(torch.load('xy_model.pt'))
#validation
data = loadmat('data1.mat')
input = 10*torch.from_numpy(data['input'])
out = net(input.float())
value,index = out.max(1)
out1 = index.data.numpy()



class Dir_Net(nn.Module):
    def __init__(self):
        super(Dir_Net,self).__init__()
        self.fc1 = nn.Linear(350,150)
        self.fc2 = nn.Linear(150,50)
        self.fc3 = nn.Linear(50,15)
        self.fc4 = nn.Linear(15,5)
        self.fc5 = nn.Linear(5,1)
        
    def forward(self,X):
        X = torch.sigmoid(self.fc1(X))
        X = torch.sigmoid(self.fc2(X))
        X = torch.sigmoid(self.fc3(X))
        X = torch.sigmoid(self.fc4(X))
        X = self.fc5(X)
        return X

net = Dir_Net()
net.load_state_dict(torch.load('dir_model.pt'))
out2 = net(input.float())
out2 = out2.data.numpy()
