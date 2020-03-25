function mask = dxmask(sz)
  if nargin < 1
    sz = 5;
  end
  assert(mod(sz, 2) == 1, 'Size must be odd');
  csz = floor(sz / 2) + 1;
  % Three-point centered-difference formula:
  % f'(x) = (f(x + h) - f(x - h)) / 2h - (second order terms).
  mask = zeros(sz);
  mask(csz, csz - 1) = 0.5;
  mask(csz, csz + 1) = -0.5;
end
