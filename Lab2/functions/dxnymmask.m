function mask = dxnymmask(n, m, sz, shape)
  if nargin < 4
    shape = 'same';
  end
  if nargin < 3
    sz = 5;
  end
  use_x = false;
  use_y = false;

  if n > 0
    use_x = true;
    if mod(n, 2) == 1
      xmask = dxmask(sz);
      n = n - 1;
    else
      xmask = dxxmask(sz);
      n = n - 2;
    end

    for i = 1:(n / 2)
      xmask = conv2(xmask, dxxmask(sz), shape);
    end
  end

  if m > 0
    use_y = true;
    if mod(m, 2) == 1
      ymask = dymask(sz);
      m = m - 1;
    else
      ymask = dyymask(sz);
      m = m - 2;
    end

    for i = 1:(m / 2)
      ymask = conv2(ymask, dyymask(sz), shape);
    end
  end

  if use_x && use_y
    mask = conv2(xmask, ymask, shape);
  else if use_x
    mask = xmask;
  else
    mask = ymask;
  end
end
