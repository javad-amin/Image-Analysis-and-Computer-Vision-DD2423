function [linepar acc] = houghedgeline( ...
        pic, scale, gradmagnthreshold, nrho, ntheta, nlines, ...
        use_magnitude, verbose)
%HOUGHEDGELINE
  margins = 0.01;

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
    ntheta = 180;
  end
  if nargin < 4
    [height width] = size(pic);
    nrho = ceil(norm([height width]));
  end
  if nargin < 3
    gradmagnthreshold = 70;
  end
  if nargin < 2
    scale = 2;
  end

  [height, width] = size(pic);

  % Edge detection with threshold and scale.
  curves = extractedge(pic, scale, gradmagnthreshold, 'same');

  % Show edge detection result.
  bigsubplot(1, 3, 1, 1, margins, margins);
  overlaycurves(pic, curves)
  title('Detected edges');
  alpha(0.5);

  magnitude = sqrt(Lv(pic, 'same'));

  [linepar acc] = houghline( ...
         curves, magnitude, nrho, ntheta, gradmagnthreshold, nlines, ...
         use_magnitude, verbose);

  % Display result of Hough transform.
  bigsubplot(1, 3, 1, 2, margins, margins);
  showgrey(acc);
  axis square;
  title('Result of Hough transform');

  % Plot image with the strongest lines overlayed.
  bigsubplot(1, 3, 1, 3, margins, margins);
  showgrey(pic)
  title(sprintf('%d strongest edges', nlines));
  hold on
  for i = 1:nlines
    rho = linepar(i, 1);
    theta = linepar(i, 2);
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
