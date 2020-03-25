function question5()
  tools = few256;
  % Space-scales.
  scale = [0.0001 1.0 4.0 16.0 64.0];

  figure(1);
  bigsubplot(2, 3, 1, 1);
  showgrey(tools);
  title('Original image');

  for i = 1:numel(scale)
    bigsubplot(2, 3, floor(i / 3) + 1, mod(i, 3) + 1);
    showgrey(Lvvvtilde(discgaussfft(tools, scale(i)), 'same') < 0);
    axis('image');
    axis('ij');
    title(sprintf('Scale = %g', scale(i)));
  end

  figure(2);
  bigsubplot(2, 3, 1, 1);
  showgrey(tools);
  title('Original image');

  for i = 1:numel(scale)
    bigsubplot(2, 3, floor(i / 3) + 1, mod(i, 3) + 1);
    showgrey(discgaussfft(tools, scale(i)));
    axis('image');
    axis('ij');
    title(sprintf('Scale = %g', scale(i)));
  end
end
