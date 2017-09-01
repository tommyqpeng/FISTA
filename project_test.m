close all;

load('bme593_project_data.mat');

%three different types of sinograms for different number of views, all with
%256 rays
sinogram540views = sinogram(:,1:2:end);
sinogram270views = sinogram(1:2:end,1:2:end);
sinogram90views = sinogram(1:6:end,1:2:end);

input = sinogram90views; %%change the input here for different cases of views

lambda = 0.00001;
L = 0.005;
b = input;
x = zeros(size(imgref));
y = x;
t = 1;
max_it = 100;

rmse_mat = zeros(1, max_it);
f_mat = zeros(1, max_it);

for i = 1:max_it
    temp_x = x;
    temp_t = t;

    [L, x, f] = tp_findL(y, b, L, lambda);
    
    t = (1+(1+4*t^2)^0.5)/2;
    y = temp_x + ((temp_t - 1)/(t))*(x-temp_x);
       
    rmse_mat(i) = sqrt(sum(sum((imgref-x)).^2)/numel(imgref));
    f_mat(i) = f;
    
    figure();
    caxis([-10 400]);
    imagesc(x);
    drawnow;
    
    filename = sprintf('%s_%d.png','image90views',i);
    saveas(gcf, filename);
    
    if (i == 20|| i == 40|| i == 60|| i == 80|| i == 100)
        filename_save = sprintf('%s_%d.mat', 'variables90views', i);
        save(filename_save, 'x', 'L', 'i', 'rmse_mat', 'f_mat', 't', 'y');
    end

    disp(i);
end


