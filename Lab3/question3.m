function question3()
  seed = 999;    % seed used for random initialization
  sigma = 3.0;   % image preblurring scale

  im = imread('orange.jpg');
  im_not_smoothed = im;
  d = 2 * ceil(sigma * 2) + 1;
  h = fspecial('gaussian', [d d], sigma);
  im = imfilter(im, h);

  %% Image.
  % figure(3);
  % image(im_not_smoothed);
  % title('Image');

  first_K = 7;
  for i = 1:2
    [segmentation, centers, Lconv] = kmeans_segm( ...
           im, first_K + i - 1, 0, seed, 'k-means++');
    figure(i);
    subplot(1, 2, 1);
    im_overlayed = overlay_bounds(im_not_smoothed, segmentation);
    image(im_overlayed);
    axis off;

    subplot(1, 2, 2);
    image(segmentation)
    % Colormap must have values in [0, 1].
    colormap(centers / 255.0);
    % colorbar;
    axis off;
    sgtitle(sprintf('K-means++ (K=%d, \\sigma=%.1f, seed=%d)', ...
                  first_K + i - 1, sigma, seed));
    saveas(gcf, sprintf('report/images/q3-min-k-%d.png', i));
  end
end
