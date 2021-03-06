%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Occupancy Grid Mapping
%
% Chapter 9.1, 9.2, Table 9.1, 9.2 (p.286-288)
% Probabilistic Robotics, Thrun et al.
%
% Assumptions:
%   - Conditional independence of grid cells
%
% Devon Morris BYU
% 20 Oct 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear, clc;

% === Load the Data =======================================================
load('state_meas_data.mat')


% === Set up the grid =====================================================
dx = 1;
dy = 1;

x_len = 100;
y_len = 100;
x = (0:dx:x_len-dx/2) + dx/2;
y = (0:dy:y_len-dy/2) + dy/2;

Grid = zeros(length(x),length(y));
nt = length(X);


for t = 1:nt
    xt = X(:,t);
    zt = z(:,:,t);
    for i = 1:length(x)
    xi = x(i);
        for j = 1:length(y)
            % inverse sensor model
            yi = y(j);
            mi = [xi yi];
            l = inverse_range_sensor(mi, xt, zt, thk);
            Grid(i,j) = Grid(i,j) + l;
        end
    end
end
probs = 1 - 1./(1+ exp(Grid));
b = bar3(probs);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
