function pixels = Lvvvtilde(inpic, shape)
  if (nargin < 2)
      shape = 'same';
  end

  Lx = conv2(inpic, dxmask(), shape);
  Ly = conv2(inpic, dymask(), shape);
  Lxxx = conv2(inpic, dxnymmask(3, 0), shape);
  Lxxy = conv2(inpic, dxnymmask(2, 1), shape);
  Lxyy = conv2(inpic, dxnymmask(1, 2), shape);
  Lyyy = conv2(inpic, dxnymmask(0, 3), shape);

  pixels = Lx.^3 .* Lxxx + ...
           3 * Lx.^2 .* Ly .* Lxxy + ...
           3 * Lx .* Ly.^2 .* Lxyy + ...
           Ly.^3 .* Lyyy;
end
