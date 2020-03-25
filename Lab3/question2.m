function question2()
  function [segmentation, centers, Lconv] = ...
           kmeans_pp(im, K, L, seed, sigma, scale_factor)
    % If L = 0, then run until converged (MSE < 1).
    if nargin < 6
      scale_factor = 1.0;
    end
    if nargin < 5
      sigma = 1.0;
    end
    if scale_factor ~= 1.0
      "Scaling!"
      im = imresize(im, scale_factor);
    end
    if sigma > 0
      d = 2 * ceil(sigma * 2) + 1;
      h = fspecial('gaussian', [d d], sigma);
      im = imfilter(im, h);
    end
    [segmentation, centers, Lconv] = kmeans_segm(im, K, L, seed, 'k-means++');
  end

  function plot_kmeans(im, K, L, seed, sigma, scale_factor)
    [segmentation, centers, Lconv] = kmeans_pp( ...
            im, K, L, seed, sigma, scale_factor)
    if Lconv > 0
      fprintf(sprintf('Converged at L=%d\n', Lconv));
      convstr = '*';
    else
      Lconv = L;
      convstr = '';
    end
    image(segmentation);
    colormap(gca, centers / 255.0);
    axis off; colorbar;
    title(sprintf('K-means++ (K=%d, L=%d%s, seed=%d, \\sigma=%.1f, scale=%.2f)', ...
                  K, Lconv, convstr, seed, sigma, scale_factor));
  end

  function convergence_per_seed()
    K = 8;
    sigma = 1.0;
    names = ['tiger1.jpg'; 'tiger2.jpg'; 'tiger3.jpg'; 'orange.jpg'];
    seeds = 1:100;
    n_seeds = length(seeds);
    [n_images, ~] = size(names);
    conv = zeros(n_seeds, n_images);
    for i = 1:n_images
      fprintf('Processing "%s"...\n', names(i, :));
      im = imread(names(i, :));
      for j = 1:n_seeds
        fprintf('%d ', j);
        [~, ~, Lconv] = kmeans_pp(im, K, 0, seeds(j), sigma);
        conv(j, i) = Lconv;
      end
      fprintf('\n ');
    end
    figure(100);
    plot(seeds, conv(:, 1));
    hold on;
    for i = 2:n_images
      plot(seeds, conv(:, i));
    end
    hold off;
    legend(names);
    xlabel('seed');
    ylabel('iterations');
    title(sprintf(strcat( ...
            'Number of iterations for convergence per seed\n', ...
            '(K=%d, \\sigma=%.1f)'), K, sigma));
    saveas(gcf, 'report/images/q2-convergence-per-seed.pdf');
  end

  function convergence_per_K()
    Ks = 2:32;
    sigma = 1.0;
    names = ['tiger1.jpg'; 'tiger2.jpg'; 'tiger3.jpg'; 'orange.jpg'];
    n_iters = 25;  % Change this to 100 for plot but takes a looong time.
    n_Ks = length(Ks);
    [n_images, ~] = size(names);
    conv = zeros(n_iters * n_images, n_Ks);

    % Set random seed based on current time and do not reinitialize below
    % (use seed = -1).
    rng('shuffle');
    for s = 1:n_Ks
      for i = 1:n_images
        fprintf('Processing "%s" (K=%d/%d)...\n', names(i, :), Ks(s), Ks(end));
        im = imread(names(i, :));
        for j = 1:n_iters
          fprintf('%d ', j);
          [~, ~, Lconv] = kmeans_pp(im, Ks(s), 0, -1, sigma);
          conv(j + (i - 1) * n_iters, s) = Lconv;
        end
        fprintf('\n');
      end

    end
    figure(101);
    boxplot(conv, Ks, 'PlotStyle', 'compact');
    xlabel('K');
    ylabel('iterations');
    title(sprintf(strcat( ...
            'Number of iterations for convergence per K\n', ...
            '(\\sigma=%.1f, iterations per K=%d*%d images=%d)'), ...
            sigma, n_iters, n_images, n_iters * n_images));
    saveas(gcf, 'report/images/q2-convergence-per-K.pdf');
  end

  function convergence_per_sigma()
    K = 8;
    n_sigmas = 31;
    sigma_max = 5;
    sigmas = linspace(0, sigma_max, n_sigmas);
    names = ['tiger1.jpg'; 'tiger2.jpg'; 'tiger3.jpg'; 'orange.jpg'];
    n_iters = 25;  % Change this to 100 for plot but takes a looong time.
    [n_images, ~] = size(names);
    conv = zeros(n_iters * n_images, n_sigmas);

    % Set random seed based on current time and do not reinitialize below
    % (use seed = -1).
    rng('shuffle');
    for s = 1:n_sigmas
      for i = 1:n_images
        fprintf('Processing "%s" (s=%d/%d)...\n', names(i, :), s, n_sigmas);
        im = imread(names(i, :));
        for j = 1:n_iters
          fprintf('%d ', j);
          [~, ~, Lconv] = kmeans_pp(im, K, 0, -1, sigmas(s));
          conv(j + (i - 1) * n_iters, s) = Lconv;
        end
        fprintf('\n');
      end

    end
    figure(102);
    boxplot(conv, sigmas, 'PlotStyle', 'compact');
    xlabel('\sigma');
    ylabel('iterations');
    title(sprintf(strcat( ...
            'Number of iterations for convergence per \\sigma\n', ...
            '(K=%d, iterations per \\sigma=%d*%d images=%d)'), ...
            K, n_iters, n_images, n_iters * n_images));
    saveas(gcf, 'report/images/q2-convergence-per-sigma.pdf');
  end

  % convergence_per_sigma();
  % return
  convergence_per_K();
  return
  convergence_per_seed();
  return

  K = 8;               % number of clusters used
  L = 5;               % number of iterations
  seed = 25;           % seed used for random initialization
  scale_factor = 1.0;  % image downscale factor
  image_sigma = 1.0;   % image preblurring scale

  im1 = imread('tiger1.jpg');
  im2 = imread('tiger2.jpg');
  im3 = imread('tiger3.jpg');

  %% Image.
  % figure(1);
  % subplot(1, 3, 1); image(im1); title('Tiger1');
  % subplot(1, 3, 2); image(im2); title('Tiger2');
  % subplot(1, 3, 3); image(im3); title('Tiger3');

  % figure(2);
  % subplot(3, 3, 1); plot_kmeans(im1, 4, L, seed, image_sigma, scale_factor);
  % subplot(3, 3, 2); plot_kmeans(im1, 8, L, seed, image_sigma, scale_factor);
  % subplot(3, 3, 3); plot_kmeans(im1, 16, L, seed, image_sigma, scale_factor);
  % subplot(3, 3, 4); plot_kmeans(im1, K, L, seed, 1.0, scale_factor);
  % subplot(3, 3, 5); plot_kmeans(im1, K, L, seed, 2.0, scale_factor);
  % subplot(3, 3, 6); plot_kmeans(im1, K, L, seed, 3.0, scale_factor);
  % subplot(3, 3, 7); plot_kmeans(im1, K, L, seed, image_sigma, 0.8);
  % subplot(3, 3, 8); plot_kmeans(im1, K, L, seed, image_sigma, 0.6);
  % subplot(3, 3, 9); plot_kmeans(im1, K, L, seed, image_sigma, 0.4);

  % figure(3);
  % subplot(3, 3, 1); plot_kmeans(im2, 4, L, seed, image_sigma, scale_factor);
  % subplot(3, 3, 2); plot_kmeans(im2, 8, L, seed, image_sigma, scale_factor);
  % subplot(3, 3, 3); plot_kmeans(im2, 16, L, seed, image_sigma, scale_factor);
  % subplot(3, 3, 4); plot_kmeans(im2, K, L, seed, 1.0, scale_factor);
  % subplot(3, 3, 5); plot_kmeans(im2, K, L, seed, 2.0, 0.8);
  % subplot(3, 3, 6); plot_kmeans(im2, K, L, seed, 3.0, 0.6);
  % subplot(3, 3, 7); plot_kmeans(im2, K, L, seed, image_sigma, 0.8);
  % subplot(3, 3, 8); plot_kmeans(im2, K, L, seed, image_sigma, 0.6);
  % subplot(3, 3, 9); plot_kmeans(im2, K, L, seed, image_sigma, 0.4);

  % figure(4);
  % subplot(3, 3, 1); plot_kmeans(im1, K, 1, 79, image_sigma, scale_factor);
  % subplot(3, 3, 2); plot_kmeans(im1, K, 3, 79, image_sigma, scale_factor);
  % subplot(3, 3, 3); plot_kmeans(im1, K, 100, 79, image_sigma, scale_factor);
  % subplot(3, 3, 4); plot_kmeans(im2, K, 1, 79, image_sigma, scale_factor);
  % subplot(3, 3, 5); plot_kmeans(im2, K, 3, 79, image_sigma, scale_factor);
  % subplot(3, 3, 6); plot_kmeans(im2, K, 100, 79, image_sigma, scale_factor);
  % subplot(3, 3, 7); plot_kmeans(im3, 8, 1, 79, image_sigma, scale_factor);
  % subplot(3, 3, 8); plot_kmeans(im3, 8, 3, 79, image_sigma, scale_factor);
  % subplot(3, 3, 9); plot_kmeans(im3, 8, 100, 79, image_sigma, scale_factor);

  figure(5);
  subplot(3, 3, 1); plot_kmeans(im1, 6, 100, 19, image_sigma, scale_factor);
  subplot(3, 3, 2); plot_kmeans(im1, 6, 100, 44, image_sigma, scale_factor);
  subplot(3, 3, 3); plot_kmeans(im1, 6, 100, 25, image_sigma, scale_factor);
  subplot(3, 3, 4); plot_kmeans(im2, 6, 100, 19, image_sigma, scale_factor);
  subplot(3, 3, 5); plot_kmeans(im2, 6, 100, 44, image_sigma, scale_factor);
  subplot(3, 3, 6); plot_kmeans(im2, 6, 100, 25, image_sigma, scale_factor);
  subplot(3, 3, 7); plot_kmeans(im3, 6, 100, 19, image_sigma, scale_factor);
  subplot(3, 3, 8); plot_kmeans(im3, 6, 100, 44, image_sigma, scale_factor);
  subplot(3, 3, 9); plot_kmeans(im3, 6, 100, 25, image_sigma, scale_factor);

  figure(6);
  subplot(3, 3, 1); plot_kmeans(im1, 6, 100, 19, 0.01, 3);
  subplot(3, 3, 2); plot_kmeans(im1, 6, 100, 44, 0.01, 3);
  subplot(3, 3, 3); plot_kmeans(im1, 6, 100, 25, 0.01, 3);
  subplot(3, 3, 4); plot_kmeans(im2, 6, 100, 19, 0.01, 3);
  subplot(3, 3, 5); plot_kmeans(im2, 6, 100, 44, 0.01, 3);
  subplot(3, 3, 6); plot_kmeans(im2, 6, 100, 25, 0.01, 3);
  subplot(3, 3, 7); plot_kmeans(im3, 6, 100, 19, 0.01, 3);
  subplot(3, 3, 8); plot_kmeans(im3, 6, 100, 44, 0.01, 3);
  subplot(3, 3, 9); plot_kmeans(im3, 6, 100, 25, 0.01, 3);
  return


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
