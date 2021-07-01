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
        X = torch.relu(self.fc1(X))
        X = torch.relu(self.fc2(X))
        X = torch.relu(self.fc3(X))
        X = self.fc4(X)
        return X

net = XY_Net() 
data = loadmat('data.mat')
input = 10*torch.from_numpy(data['train_input'])
output = torch.from_numpy(data['train_output'])
output = output[:,0].reshape([-1])      
criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(net.parameters(), lr=0.01, momentum=0.9)

l = numpy.zeros(1000)
for epoch in range(1000):  # loop over the dataset multiple times
    running_loss = 0.0
    # zero the parameter gradients
    optimizer.zero_grad()

    # forward + backward + optimize
    o = net(input.float())
    loss = criterion(o, output.long())
    loss.backward()
    optimizer.step()
    # print statistics
    running_loss += loss.item()
    print(running_loss)
    l[epoch] = running_loss

print('Finished Training')
torch.save(net.state_dict(), 'XY_model.pt')

#validation
data = loadmat('data.mat')
input = 10*torch.from_numpy(data['test_input'])
output = data['test_output'].reshape([-1])
out = net(input.float())
value,index = out.max(1)
output_pre = index.data.numpy()
err = numpy.ceil(abs(output-output_pre)/2)


