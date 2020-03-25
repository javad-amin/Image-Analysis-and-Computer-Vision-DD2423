function question1()
%QUESTION1 Convolution with difference operators

  margins = 0.01;

  function plot_diffs(row, tools, deltax, deltay, name1, name2)
    dxtools = conv2(tools, deltax, 'valid');
    dytools = conv2(tools, deltay, 'valid');
    bigsubplot(1, 3, row, 2, margins, margins);
    showgrey(dxtools);
    sz = size(dxtools);
    title(sprintf('%s (%d, %d)', name1, sz(1), sz(2)));
    bigsubplot(1, 3, row, 3, margins, margins);
    showgrey(dytools);
    sz = size(dytools);
    title(sprintf('%s (%d, %d)', name2, sz(1), sz(2)));
  end

  tools = few256;

  figure(1); bigsubplot(1, 3, 1, 1, margins, margins); showgrey(tools);
  sz = size(tools);
  title(sprintf('Original (%d, %d)', sz(1), sz(2)));

  % % "The Roberts kernels are in practice too small to reliably
  % %  find edges in the presence of noise."
  % roberts_diag = [-1 0; 0 1];
  % plot_diffs(1, tools, roberts_diag, rot90(roberts_diag, 3), ...
  %            'Roberts \\\\', 'Roberts /');

  % sobel = [-1 -2 -1; 0 0 0; 1 2 1];
  % plot_diffs(2, tools, sobel, sobel', 'Sobel X', 'Sobel Y');

  % two_point_forward_diff = [-1 1];
  % plot_diffs(3, tools, ...
  %            two_point_forward_diff, two_point_forward_diff', ...
  %            'Two-point forward X', 'Two-point forward Y');

  %% Three-point centered difference.
  cent_diff = [-1 0 1];
  plot_diffs(1, tools, cent_diff, cent_diff', 'Central X', 'Central Y');
end
