function mask = dymask(sz)
  if nargin < 1
    sz = 5;
  end
  assert(mod(sz, 2) == 1, 'Size must be odd');
  mask = dxmask(sz)';
end
