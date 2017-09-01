function dtheta = calc_view_angle_interval(nviews)
% CALC_VIEW_ANGLE_INTERVAL Calculates angle between consecutive views
% INPUTS:
%   nviews - the number of views
% OUTPUTS:
%   the angle between consecutive views [rad]
% Examples:
%   dtheta = calc_view_angle_interval(540);
% See also:

% For 540 views, the angle between consecutive views is 5/12 deg.
dtheta = pi/180*5/12*540/nviews;


