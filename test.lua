print(torch.Tensor(5,3))

cutorch.setDevice(0)
local dest = src:clone()

print(dest)