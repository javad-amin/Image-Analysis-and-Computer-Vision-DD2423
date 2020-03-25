function question11()

scale_factor = 0.5;           % image downscale factor
default_area = [ 80, 110, 570, 300 ]; % image region to train foreground with
areas = [[ 80, 110, 570, 300 ];
         [ 170, 80, 410, 210 ];
         [ 215, 70, 520, 250 ]];
K = 16;                       % number of mixture components
alphas = [14, 25, 19];         % maximum edge cost
sigmas = [14, 25, 20];        % edge cost decay factor
% alphas = [14, 9, ?];         % maximum edge cost
% sigmas = [14, 9, ?];        % edge cost decay factor


for i = 1:length(alphas)
  figure(i)
  % area = areas(i, :);
  I = imread(sprintf('tiger%d.jpg', i));
  I = imresize(I, scale_factor);
  Iback = I;
  area = int16(default_area * scale_factor);
  [segm, prior] = graphcut_segm(I, area, K, alphas(i), sigmas(i));

  Inew = mean_segments(Iback, segm);
  I = overlay_bounds(Iback, segm);
  % imwrite(Inew,'result/graphcut1.png')
  % imwrite(I,'result/graphcut2.png')
  % imwrite(prior,'result/graphcut3.png')
  bigsubplot(1,3,1,1); imshow(Inew);
  bigsubplot(1,3,1,2); imshow(I);
  bigsubplot(1,3,1,3); imshow(prior);
  sgtitle(sprintf('K=%d, \\alpha=%.1f, \\sigma=%.1f, scale=%.1f', ...
                  K, alphas(i), sigmas(i), scale_factor));
end

end
