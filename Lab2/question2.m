function question2()
%QUESTION2 Gradient magnitudes.
  margins = 0.01;

  function plotone(img, threshold, row, col)
    bigsubplot(3, 3, row, col, margins, margins);
    showgray((img - threshold) > 0);
    text(50, 15, ...
        sprintf('Threshold %d', threshold), ...
        'color', 'white', ...
        'fontsize', 13, ...
        'fontweight', 'bold');
  end
  function plotthres(img, offset, step)
    if (nargin < 2)
      offset = 5;
    end
    if (nargin < 3)
      step = 5;
    end
    plotone(img, offset, 1, 1);
    plotone(img, 1 * step + offset, 1, 2);
    plotone(img, 2 * step + offset, 1, 3);
    plotone(img, 3 * step + offset, 2, 1);
    plotone(img, 4 * step + offset, 2, 2);
    plotone(img, 5 * step + offset, 2, 3);
    plotone(img, 6 * step + offset, 3, 1);
    plotone(img, 7 * step + offset, 3, 2);
    plotone(img, 8 * step + offset, 3, 3);
  end

  %% Tools.
  tools = few256;
  figure(1);
  bigsubplot(1, 3, 1, 1, margins, margins);
  showgrey(tools);
  title('Original');
  gradmagntools = sqrt(Lv(tools));  % Note sqrt!
  bigsubplot(1, 3, 1, 2, margins, margins);
  showgray(gradmagntools);
  bigsubplot(1, 3, 1, 3, 0.2, margins);
  histogram(gradmagntools, ...
            'Normalization', 'pdf', ...
            'BinMethod', 'integers');
  % Plot non-smoothed.
  figure(2);
  plotthres(gradmagntools);
  % Plot smoothed.
  figure(3);
  plotthres(Lv(discgaussfft(tools, 1.0)), 25, 25);

  %% Godthem.
  godthem = godthem256;
  figure(4);
  bigsubplot(1, 3, 1, 1, margins, margins);
  showgrey(godthem);
  title('Original');
  gradmagngodthem = sqrt(Lv(godthem));  % Note sqrt!
  bigsubplot(1, 3, 1, 2, margins, margins);
  showgray(gradmagngodthem);
  bigsubplot(1, 3, 1, 3, margins, margins);
  histogram(gradmagngodthem, ...
            'Normalization', 'pdf', ...
            'BinMethod', 'integers');
  % Plot non-smoothed.
  figure(5);
  plotthres(gradmagngodthem);
  % Plot smoothed.
  figure(6);
  plotthres(Lv(discgaussfft(godthem, 1.0)), 75, 25);
end
