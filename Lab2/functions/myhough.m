function M = myhough(img, n_lines)
% MYHOUGH Hough transform an image and plot hough lines

if nargin < 2
  n_lines = 50;
end

% Edge detection with threshold (scale 2).
edgeimg = Lvvtilde(discgaussfft(img, 2), 'same') > 70;
[height, width] = size(edgeimg);

figure(1)
% Show edge detection result.
subplot(1, 3, 1);
showgrey(edgeimg);
title('Detected edges');

sz = max(width, height);
% A point in the image domain maps to a sin/cos wave in M. Each
% (rho, theta) element in M corresponds to a potential line,
% orthogonal to and passing through the point at (rho, theta). E.g.
%     .                       - –––– -
%     |                           |
% 0---| (theta=0, rho=3)          | (theta=pi/2, rho=2)
%     |                           0
%     .
%
% The magnitude of a specific (rho, theta) element in M tells
% us how many points votes for a specific line, i.e. picking
% the 10 largest values from M will give us the ten strongest
% lines. None of these will be identical to each other as each
% element of M corresponds to a unique line but if sz is large
% and edges are thick, they can all be matches for the same
% edge.
M = zeros(sz);
% theta angle = [0, pi) in sz steps.
thetas = linspace(0, pi, sz + 1);
thetas = thetas(1:end - 1);
% rho = [-rho_max, rho_max] in sz steps where rho_max
% is length of diagonal.
rho_max = norm([width height]);
rhos = linspace(-rho_max, rho_max, sz);
% Function for finding index in rho array that closely matches
% a specific value of rho.
frho_index = @(rho) floor((sz / 2) + (sz / 2) * rho / rho_max) + 1;
% Function for calculating rho given coordinates and theta angle.
frho = @(x, y, i) x * cos(thetas(i)) + y * sin(thetas(i));

% Loop over each pixel finding the ones that match the edge mask.
% TODO vectorize and use logical mask.
for x = 0:width - 1
  for y = 0:height - 1
    if edgeimg(y + 1, x + 1) > 0
      % Loop over theta [0, pi).
      for i = 1:sz
        rho = frho(x, y, i);
        rho_ix = frho_index(rho);
        % Vote for line orthogonal to (rho, theta).
        M(rho_ix, i) = M(rho_ix, i) + 1;
      end
    end
  end
end

% Display result of Hough transform.
subplot(1, 3, 2);
showgrey(M);
title('Result of Hough transform');

% Get the n maximum values of M.
% Note that maxk works on M as a long vector so returned indexes
% need to be converted into (row, col) form.
[vals, ix] = maxk(M(:), n_lines);
cols = floor(ix / sz) + 1;
rows = ix - (cols - 1) * sz;

% Plot image with the strongest lines overlayed.
subplot(1, 3, 3);
showgrey(img)
title(sprintf('%d strongest edges', n_lines));
hold on
for i = 1:n_lines
  rho = rhos(rows(i));
  theta = thetas(cols(i));
  % In order to limit lines to the image boundary, solve for
  % y given x.
  x = 0:2:width;
  y = (rho - x * cos(theta)) / sin(theta);
  % Mask out the found (x,y) pairs that is outside image boundary.
  ymask = y >= 0 & y <= height;
  plot(x(ymask), y(ymask));
end
hold off;

end
