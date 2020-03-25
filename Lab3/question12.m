function question12()

scale_factor = 0.5;           % image downscale factor
default_area = [ 80, 110, 570, 300 ]; % image region to train foreground with
K = 16;                       % number of mixture components
Ks = [[2 3]; [2 3]; [2 3]];
alphas = [14, 25, 19];         % maximum edge cost
sigmas = [14, 25, 20];        % edge cost decay factor


for i = 1:length(alphas)
  figure(i)
  % area = areas(i, :);
  for k = 1:2
    K = Ks(i, k);
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
    bigsubplot(2,3,k,1); imshow(Inew);
    bigsubplot(2,3,k,2); imshow(I);
    bigsubplot(2,3,k,3); imshow(prior);
  end
  sgtitle(sprintf('K=%d vs K=%d, \\alpha=%.1f, \\sigma=%.1f, scale=%.1f', ...
                  Ks(i, 1), Ks(i, 2), alphas(i), sigmas(i), scale_factor));
end

end
