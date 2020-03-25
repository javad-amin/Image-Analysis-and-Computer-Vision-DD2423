function question1()
  K = 8;               % number of clusters used
  L = 30;              % number of iterations
  seed = 18;           % seed used for random initialization
  scale_factor = 1.0;  % image downscale factor
  image_sigma = 1.0;   % image preblurring scale

  im = imread('orange.jpg');
  im = imresize(im, scale_factor);
  im_not_smoothed = im;
  d = 2 * ceil(image_sigma * 2) + 1;
  h = fspecial('gaussian', [d d], image_sigma);
  im = imfilter(im, h);

  %% Image.
  figure(1);
  image(im_not_smoothed);
  title('Image');

  %% Initial colors from randomly selected points (Forgy method).
  tic
  [segmentation, centers] = kmeans_segm(im, K, L, seed, 'forgy');
  toc

  figure(2);
  image(segmentation)
  % Colormap must have values in [0, 1].
  colormap(centers / 255.0);
  axis off;
  colorbar;
  title(sprintf('Forgy initialization (K=%d, L=%d, seed=%d)', K, L, seed));

  figure(3);
  im_overlayed = overlay_bounds(im_not_smoothed, segmentation);
  image(im_overlayed);
  axis off;
  colorbar('off');
  title(sprintf('Forgy initialization (K=%d, L=%d, seed=%d)', K, L, seed));

  %% K-means++.
  tic
  [segmentation, centers] = kmeans_segm(im, K, L, seed, 'k-means++');
  toc

  figure(4);
  image(segmentation)
  % Colormap must have values in [0, 1].
  colormap(centers / 255.0);
  axis off;
  colorbar;
  title(sprintf('K-means++ (K=%d, L=%d, seed=%d)', K, L, seed));

  figure(5);
  im_overlayed = overlay_bounds(im_not_smoothed, segmentation);
  image(im_overlayed);
  axis off;
  colorbar('off');
  title(sprintf('K-means++ (K=%d, L=%d, seed=%d)', K, L, seed));
end
