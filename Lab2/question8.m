function question8()
  testimage1 = triangle128;
  testimage2 = houghtest256;
  tools = few256;
  house = godthem256;
  phone = phonecalc256;

  % figure(1)
  % smalltest1 = binsubsample(testimage1);
  % [height width] = size(smalltest1);
  % nrho = ceil(norm([height, width]));
  % houghedgeline(smalltest1, 1, 5, nrho, 180, 8);

  figure(2)
  [height width] = size(testimage2);
  nrho = ceil(norm([height, width]));
  houghedgeline(testimage2, 1, 5, nrho, 180, 10);

  figure(3)
  [height width] = size(tools);
  nrho = ceil(norm([height, width]));
  houghedgeline(tools, 4, 15, nrho, 180, 30);

  figure(4)
  [height width] = size(phone);
  nrho = ceil(norm([height, width]));
  houghedgeline(phone, 16, 3, nrho, 180, 30);

  figure(5)
  [height width] = size(house);
  nrho = ceil(norm([height, width]));
  houghedgeline(house, 4, 15, nrho, 180, 30);

%% Plot correspondence between accumulator matrix and edges.
  figure(6)
  pic = houghtest256;
  margins = 0.01;
  nlines = 5;
  [height width] = size(pic);
  nrho = ceil(norm([height, width]));
  % Edge detection with threshold and scale.
  curves = extractedge(pic, 1, 5, 'same');

  magnitude = sqrt(Lv(pic, 'same'));
  [linepar acc rhos thetas] = houghline( ...
         curves, magnitude, nrho, 180, 5, nlines);

  % Display result of Hough transform.
  bigsubplot(1, 2, 1, 1, margins, margins);
  showgrey(acc);
  hold on;
  % Extract local maxima from the accumulator
  [pos, value] = locmax8(acc);
  [dummy, indexvector] = sort(value, 'descend');
  rhoidxacc = pos(indexvector(1:nlines), 1)
  thetaidxacc = pos(indexvector(1:nlines), 2)
  plot(thetaidxacc, rhoidxacc, 'o', 'Color', 'red');
  for i = 1:nlines
    text(thetaidxacc(i) + 5, rhoidxacc(i), num2str(i), 'Color', 'red');
  end
  hold off;
  axis square;
  title('Result of Hough transform');

  % Plot image with the strongest lines overlayed.
  bigsubplot(1, 2, 1, 2, margins, margins);
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

  % Plot image with (rho, theta) vectors + orthogonal vectors overlayed.
  for i = 1:nlines
    theta = thetas(thetaidxacc(i))
    rho = rhos(rhoidxacc(i))
    [x y] = pol2cart(theta, rho);
    plot([0 x], [0, y], ':', 'Color', 'red');
    text(x, y, num2str(i), 'Color', 'red');

    x = -40:2:160;
    y = (rho - x * cos(theta)) / sin(theta);
    ymask = y >= -50 & y <= 300;
    % Mask out the found (x,y) pairs that is outside image boundary.
    plot(x(ymask), y(ymask), ':');
  end

  hold off;
end
