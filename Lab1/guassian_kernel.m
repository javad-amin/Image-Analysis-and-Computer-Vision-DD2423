function K = guassian_kernel(width, height, t)
  function r = g(x, y, t)
    r = 1 / (2 * pi * t) * exp(-(x.^2 + y.^2) ./ (2 * t));
  end

  hw_min = -width / 2;
  hw_max = width / 2;
  if (hw_max - hw_min) >= width
    hw_max = hw_max - 1;
  end
  hh_min = -height / 2;
  hh_max = height / 2;
  if (hh_max - hh_min) >= height
    hh_max = hh_max - 1;
  end
  [X, Y] = meshgrid(hw_min:hw_max, hh_min:hh_max);
  K = g(X, Y, t);
  %surf(X, Y, K);
end