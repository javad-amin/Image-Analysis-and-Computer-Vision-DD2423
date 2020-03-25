function pixels = Lv(inpic, shape)
  if (nargin < 2)
    shape = 'same';
  end
  % dxmask = [1 0 -1] / 2;
  % dymask = dxmask';
  % Perform convolution (instead of using filter2 and correlation).
  Lx = conv2(inpic, dxmask, shape);
  Ly = conv2(inpic, dymask, shape);
  pixels = Lx.^2 + Ly.^2;
end
