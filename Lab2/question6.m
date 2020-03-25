function question6()
  tools = few256;
  % Space-scales.
  scale = [0.0001 1.0 4.0 16.0 64.0];

  %% Combination Lvv = 0 and Lvvv < 0:
  figure(1);
  bigsubplot(2, 3, 1, 1);
  showgrey(tools);
  title('Original image');

  for i = 1:numel(scale)
    bigsubplot(2, 3, floor(i / 3) + 1, mod(i, 3) + 1);
    lvv = Lvvtilde(discgaussfft(tools, scale(i)), 'same');
    lvvv = Lvvvtilde(discgaussfft(tools, scale(i)), 'same');
    % It is difficult to find a good zero-crossing threshold for
    % lvv > a & lvv < b so we will use contours instead, like in Q4.
    % Since we only want to include the information where lvvv < 0, we will
    % white the other areas out by setting them to NaN,
    % cf. https://se.mathworks.com/help/matlab/ref/contour.html
    % ("Contours Over Discontinuous Surface").
    lvv(lvvv >= 0) = NaN;
    showgrey(tools);
    hold on;
    contour(lvv, [0 0], 'Color', 'red');
    hold off;
    axis('image');
    axis('ij');
    title(sprintf('Scale = %g', scale(i)));
  end

  %% Using only Lvv = 0:
  figure(2);
  bigsubplot(2, 3, 1, 1);
  showgrey(tools);
  title('Original image');

  for i = 1:numel(scale)
    bigsubplot(2, 3, floor(i / 3) + 1, mod(i, 3) + 1);
    showgrey(tools);
    hold on;
    contour(Lvvtilde(discgaussfft(tools, scale(i)), 'same'), ...
            [0 0], 'Color', 'red');
    hold off;
    axis('image');
    axis('ij');
    title(sprintf('Scale = %g', scale(i)));
  end
end
