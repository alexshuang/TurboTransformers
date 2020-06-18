import torch
import torch.nn as nn

layers = [nn.Linear(100, 200), nn.ReLU(), nn.Linear(200, 200)]
model = nn.Sequential(*layers).cuda()
x = torch.randn(64, 100, 100).cuda()
y = model(x) # warm up
y = model(x)
