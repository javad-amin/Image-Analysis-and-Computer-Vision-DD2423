function question7()
  margins = 0;
  tools = few256;
  house = godthem256;

  tools_scale = [4, 8, 12];
  tools_threshold = [5, 25, 50];
  house_scale = [3, 6, 9];
  house_threshold = [5,  25, 50];

  figure(1)
  for i = 1:numel(house_scale)
    for j = 1:numel(house_threshold)
      bigsubplot(3, 3, i, j, margins, margins);
      toolscurves = extractedge(tools, tools_scale(i), tools_threshold(j));
      overlaycurves(tools, toolscurves);
      alpha(0.6);
      title(sprintf('Scale=%g, threshold=%d', tools_scale(i), tools_threshold(j)));
    end
  end

  figure(2)
  for i = 1:numel(tools_scale)
    for j = 1:numel(tools_threshold)
      bigsubplot(3, 3, i, j, margins, margins);
      housecurves = extractedge(house, house_scale(i), house_threshold(j));
      overlaycurves(house, housecurves);
      alpha(0.6);
      title(sprintf('Scale=%g, threshold=%d', house_scale(i), house_threshold(j)));
    end
  end
end
