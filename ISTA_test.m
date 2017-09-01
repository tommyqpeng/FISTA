% clear all;
% close all;

load('bme593_project_data.mat');

sinogram540views = sinogram(:,1:2:end);
sinogram270views = sinogram(1:2:end,1:2:end);
sinogram90views = sinogram(1:6:end,1:2:end);

input = sinogram540views;
x = zeros(size(imgref));
max_it = 5;
L = 8;

output = tp_ISTABACK(input, 5);

% thresh = 0.02;
% for i = 1:max_it
%     in_fid = forward(x, size(input,1), size(input, 2)) - input;
%     fidelity = backward(in_fid, 256);
%     x = tp_soft(x - (2/L)*fidelity, (thresh));
%     thresh = thresh + i*0.002;
% end