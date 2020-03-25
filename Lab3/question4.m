function question4()
  K = 8;                % number of clusters used
  seed = 999;           % seed used for random initialization
  sigma = 3.0;    % image preblurring scale

  names = ['orange.jpg'; 'tiger1.jpg'; 'tiger2.jpg'; 'tiger3.jpg'];
  [n_images, ~] = size(names);

  figure(2);
  for i = 1:n_images
    im = imread(names(i, :));
    im_not_smoothed = im;
    d = 2 * ceil(sigma * 2) + 1;
    h = fspecial('gaussian', [d d], sigma);
    im = imfilter(im, h);
    subplot(2, 2, i);
    [segmentation, centers, Lconv] = kmeans_segm(im, K, 0, seed, 'k-means++');
    im_overlayed = overlay_bounds(im_not_smoothed, segmentation);
    image(im_overlayed);
    axis off;
    title(sprintf('K-means++ (K=%d, seed=%d, \\sigma=%.1f)', K, seed, sigma));
  end
  x = [0.55 0.61];
  y = [0.8 0.775];
  annotation('arrow', x, y, 'Color', 'blue', 'LineWidth', 3.0);
  x = [0.35 0.335];
  y = [0.45 0.385];
  annotation('arrow', x, y, 'Color', 'white', 'LineWidth', 3.0);
  x = [0.87 0.825];
  y = [0.25 0.285];
  annotation('arrow', x, y, 'Color', 'blue', 'LineWidth', 3.0);
  saveas(gcf, 'report/images/q4-orange-vs-tigers.pdf');


  %%

  K = 12;               % number of clusters used
  seed = 999;           % seed used for random initialization
  sigma = 1.5;    % image preblurring scale

  names = ['orange.jpg'; 'tiger1.jpg'; 'tiger2.jpg'; 'tiger3.jpg'];
  [n_images, ~] = size(names);

  figure(3);
  for i = 1:n_images
    im = imread(names(i, :));
    im_not_smoothed = im;
    d = 2 * ceil(sigma * 2) + 1;
    h = fspecial('gaussian', [d d], sigma);
    im = imfilter(im, h);
    subplot(2, 2, i);
    [segmentation, centers, Lconv] = kmeans_segm(im, K, 0, seed, 'k-means++');
    im_overlayed = overlay_bounds(im_not_smoothed, segmentation);
    image(im_overlayed);
    axis off;
    title(sprintf('K-means++ (K=%d, seed=%d, \\sigma=%.1f)', K, seed, sigma));
  end
  saveas(gcf, 'report/images/q4-tigers.pdf');
end
