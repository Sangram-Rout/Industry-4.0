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
data = loadmat('data.mat')
input = 10*torch.from_numpy(data['train_input'])
output = torch.from_numpy(data['train_output'])
output = output[:,0].reshape([-1,1])*10        

criterion = nn.MSELoss()
optimizer = optim.SGD(net.parameters(), lr=0.05, momentum=0.9)

l = numpy.zeros(5000)
for epoch in range(5000):  # loop over the dataset multiple times
    running_loss = 0.0
    # zero the parameter gradients
    optimizer.zero_grad()

    # forward + backward + optimize
    o = net(input.float())
    loss = criterion(o, output.float())
    loss.backward()
    optimizer.step()
    # print statistics
    running_loss += loss.item()
    print(running_loss)
    l[epoch] = running_loss

print('Finished Training')
torch.save(net.state_dict(), 'dir_model.pt')

#validation
data = loadmat('data.mat')
input = 10*torch.from_numpy(data['test_input'])
output = data['test_output'].reshape([-1])
out = net(input.float())
