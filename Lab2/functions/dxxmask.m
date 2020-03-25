function mask = dxxmask(sz)
  if nargin < 1
    sz = 5;
  end
  assert(mod(sz, 2) == 1, 'Size must be odd');
  csz = floor(sz / 2) + 1;
  % Three-point centered-difference formula for 2nd derivative:
  % f''(x) = (f(x - h) - 2 f(x) + f(x + h)) / h^2 -
  %          (higher order terms).
  mask = zeros(sz);
  mask(csz, csz - 1) = 1;
  mask(csz, csz) = -2;
  mask(csz, csz + 1) = 1;
end
