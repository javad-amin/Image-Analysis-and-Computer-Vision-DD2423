function K = gaussian_kernel(w, h, t)
  w = w / 2; h = h / 2;
  [X, Y] = meshgrid(-w:w-1, -h:h-1);
  K = 1 / (2 * pi * t) * exp(-(X.^2 + Y.^2) ./ (2 * t));
end
