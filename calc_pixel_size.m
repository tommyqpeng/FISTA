function dx = calc_pixel_size(n)
% CALC_PIXEL_SIZE Calculates the pixel size based on number of pixels
% INPUTS:
%   n - number of pixels along one edge of the n x n image; should be
%       either 256 or 512
% OUTPUTS:
%   dx - the pixel size [m]
% Example:
%   dx = calc_pixel_size(256); % 240E-6
%   dx = calc_pixel_size(512); % 120E-6
% See also: forward, backward

if (n == 512)
    dx = 120E-6;
elseif (n == 256)
    dx = 240E-6;
else
    error('Number of pixels must be either 256 or 512.');
end



