function sinogram = forward(img, nviews, nrays)
% FORWARD Computes the sinogram of a user-supplied image
% The measured data for an X-ray CT system is often called a sinogram. The
% reason for the name can be seen by viewing the sinogram as an image.
% INPUTS:
%   img:    The digital object to be detected (dimension: size_x * size_x)
%   nviews: Number of view angles in the sinogram 
%   nrays:  For each view, the number of rays detected. The distance
%           between neighboring rays is the ratio of the number of pixels
%           along one dimension and the number of rays.
% OUTPUTS:
%   sinogram: The detected sinogram (dimension: nviews * nrays)
% Examples:
%   sinogram = forward(img, 270, 256);
% See also: backward

if (size(img,1) ~= size(img,2))
    error('The input image must be square.');
end

size_x = size(img,1);
sinogram = zeros(nviews,nrays);
t_interval = size_x/nrays;
theta_interval = calc_view_angle_interval(nviews);
pixel_size = calc_pixel_size(size_x);

for ind=1:nviews
    for j=1:nrays
        theta = 0+(ind-1)*theta_interval;
        t = t_interval*(j-nrays/2-0.5);
        temp = CalC_integral(theta,t,img);
        sinogram(ind,j)=temp*pixel_size;
    end
end
