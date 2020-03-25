function edgecurves = extractedge(inpic, scale, threshold, shape)
  if nargin < 4
    shape = 'same';
  end
  if nargin < 3
    threshold = 0;
  end

  lv = Lv(discgaussfft(inpic, scale), shape);
  lvv = Lvvtilde(discgaussfft(inpic, scale), shape);
  lvvv = Lvvvtilde(discgaussfft(inpic, scale), shape);

  % Curves are preserved where mask is non-negative and per default
  % the range of the mask is [0,1] so we need to subtract a small
  % amount in order to get a [-, +] range.
  curves = zerocrosscurves(lvv, (lvvv < 0) - 0.5);
  edgecurves = thresholdcurves(curves, (lv > threshold) - 0.5);
end
