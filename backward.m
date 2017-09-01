function img = backward(sinogram, size_x)
% BACKWARD Applies the adjoint of the forward operator
% INPUTS:
%   sinogram:   The detected sinogram. (dimension: nviews * nrays)
%   size_x:     The number of pixels along one edge of the back-projected 
%               image.
% OUTPUTS:
%   img:      The back-projected image after applying the adjoint operator 
%              (dimension: size_x * size_x)
% Examples:
%   img = backward(sinogram, 256);
% See also: forward

img = zeros(size_x,size_x);
[nviews, nrays] = size(sinogram);
t_interval = size_x/nrays;
theta_interval = calc_view_angle_interval(nviews);
pixel_size = calc_pixel_size(size_x);

for view = 1:nviews
    theta = 0+(view-1)*theta_interval;
    for ray = 1:nrays
        t = t_interval*(ray-nrays/2-0.5);
        img = img + CalC_bp(theta,t,sinogram(view,ray),size_x)*pixel_size;
    end
end