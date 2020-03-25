function [linepar acc rhos thetas] = houghline( ...
        curves, magnitude, nrho, ntheta, threshold, nlines, ...
        use_magnitude, verbose)
% HOUGHLINE Hough transform an image and plot hough lines

if nargin < 8
  verbose = false;
end
if nargin < 7
  use_magnitude = false;
end
if nargin < 6
  nlines = 50;
end
if nargin < 5
  threshold = 70;
end
if nargin < 4
  ntheta = 180;
end
if nargin < 3
  nrho = 256;
end

% A point in the image domain maps to a sin/cos wave in acc. Each
% (rho, theta) element in acc corresponds to a potential line,
% orthogonal to and passing through the point at (rho, theta). E.g.
%     .                       - –––– -
%     |                           |
% 0---| (theta=0, rho=3)          | (theta=pi/2, rho=2)
%     |                           0
%     .
%
% The magnitude of a specific (rho, theta) element in acc tells
% us how many points votes for a specific line, i.e. picking
% the 10 largest values from acc will give us the ten strongest
% lines. None of these will be identical to each other as each
% element of acc corresponds to a unique line but if sz is large
% and edges are thick, they can all be matches for the same
% edge.
acc = zeros(nrho, ntheta);
% theta angle = [0, pi) in ntheta steps.
thetas = linspace(0, pi, ntheta + 1);
thetas = thetas(1:end - 1);

% Since we have curves as input and not an image, we need to
% go through the all the curves to find the pair (x,y) with
% maximum distance from origin.
rho_max = 0;
% Loop over all the input curves (cf. pixelplotcurves)
insize = size(curves, 2);
trypointer = 1;
while trypointer <= insize
  polylength = curves(2, trypointer);
  for polyidx = 1 : polylength
    x = curves(2, trypointer + polyidx);
    y = curves(1, trypointer + polyidx);
    rho_max = max(ceil(norm([x y])), rho_max);
  end
  trypointer = trypointer + polylength + 1;
end
if verbose > 0
  fprintf(sprintf('Maximum distance from origo to point on curve: %f\n', ...
                  rho_max));
end
% rho = [-rho_max, rho_max] in nrho steps where rho_max is
% the maximum distance found above.
rhos = linspace(-rho_max, rho_max, nrho);
% Function for finding index in rho array that closely matches
% a specific value of rho.
frho_index = @(rho) floor((nrho / 2) + (nrho / 2) * rho / rho_max) + 1;
% Function for calculating rho given coordinates and theta angle.
frho = @(x, y, i) x * cos(thetas(i)) + y * sin(thetas(i));

% Loop over all the input curves (cf. pixelplotcurves)
insize = size(curves, 2);
trypointer = 1;
numcurves = 0;

while trypointer <= insize
  polylength = curves(2, trypointer);
  numcurves = numcurves + 1;

  % For each point on each curve
  for polyidx = 1 : polylength
    x = curves(2, trypointer + polyidx);
    y = curves(1, trypointer + polyidx);

    % Check if valid point with respect to threshold
    mag = magnitude(round(x), round(y));
    if use_magnitude
        magdelta = log(1 + mag);
    elseif verbose == false
        magdelta = 1;
    end

    if mag > threshold
      % Loop over a set of theta values
      for i = 1 : ntheta
        rho = frho(y, x, i);
        rho_ix = frho_index(rho);
        % Vote for line orthogonal to (rho, theta).
        acc(rho_ix, i) = acc(rho_ix, i) + magdelta;
      end
    end
  end
  trypointer = trypointer + polylength + 1;
end

% Extract local maxima from the accumulator
[pos, value] = locmax8(acc);
[dummy, indexvector] = sort(value);
nmaxima = size(value, 1);

% Compute a line for each one of the strongest responses in the accumulator
linepar = zeros(nlines, 2);
for idx = 1:nlines
  rhoidxacc = pos(indexvector(nmaxima - idx + 1), 1);
  thetaidxacc = pos(indexvector(nmaxima - idx + 1), 2);

  rho = rhos(rhoidxacc);
  theta = thetas(thetaidxacc);
  linepar(idx, :) = [rho theta];
end

% Initial implemenation:
%
% % Loop over each pixel finding the ones that match the edge mask.
% % TODO vectorize and use logical mask.
% for x = 0:width - 1
%   for y = 0:height - 1
%     if curves(y + 1, x + 1) > 0
%       % Loop over theta [0, pi).
%       for i = 1:ntheta
%         rho = frho(x, y, i);
%         rho_ix = frho_index(rho);
%         % Vote for line orthogonal to (rho, theta).
%         acc(rho_ix, i) = acc(rho_ix, i) + 1;
%       end
%     end
%   end
% end

% % Get the n maximum values of acc.
% % Note that maxk works on acc represented as a single-dimensional
% % vector so returned indexes need to be converted back into
% % (row, col) form.
% [vals, ix] = maxk(acc(:), nlines);
% cols = floor(ix / ntheta) + 1;
% rows = ix - (cols - 1) * nrho;
% 
% % Get nlines strongest lines represented as pairs (rho, theta).
% linepar = zeros(nlines, 2);
% for i = 1:nlines
%   rho = rhos(rows(i));
%   theta = thetas(cols(i));
%   linepar(i, :) = [rho theta];
% end

end
