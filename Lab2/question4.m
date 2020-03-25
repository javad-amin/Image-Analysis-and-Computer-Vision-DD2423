function question4()
  margins = 0.01;

  figure(1);
  house = godthem256;
  % Scale-space scales.
  scale = [0.0001 1.0 4.0 16.0 64.0];

  bigsubplot(2, 3, 1, 1, margins, margins);
  showgrey(house);
  title('Original image');

  for i = 1:numel(scale)
    bigsubplot(2, 3, floor(i / 3) + 1, mod(i, 3) + 1, margins, margins);
    % To draw contour lines at a single height k, specify levels as a
    % two-element row vector [k k]
    % (https://se.mathworks.com/help/matlab/ref/contour.html).
    imagesc(house);
    alpha(.3);
    axis off;
    hold on;
    contour(Lvvtilde(discgaussfft(house, scale(i)), 'same'), ...
            [0 0], 'Color', 'red');
    hold off;
    axis('image');
    axis('ij');
    title(sprintf('Scale = %g', scale(i)));
  end
end
