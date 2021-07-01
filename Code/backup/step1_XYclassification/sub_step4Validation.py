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
data = loadmat('vali_data.mat')
input = 10*torch.from_numpy(data['input'])
output = data['output'].reshape([-1])
out = net(input.float())
value,index = out.max(1)
output_pre = index.data.numpy()
err = numpy.ceil(abs(output-output_pre)/2)
