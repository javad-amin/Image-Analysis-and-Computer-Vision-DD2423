function pixels = Lvvtilde(inpic, shape)
  if (nargin < 2)
      shape = 'same';
  end

  Lx = conv2(inpic, dxmask(), shape);
  Ly = conv2(inpic, dymask(), shape);
  Lxx = conv2(inpic, dxxmask(), shape);
  Lyy = conv2(inpic, dyymask(), shape);
  Lxy = conv2(inpic, dxnymmask(1, 1), shape);

  pixels = Lx.^2 .* Lxx + ...
           2 * Lx .* Ly .* Lxy + ...
           Ly.^2 .* Lyy;
end
