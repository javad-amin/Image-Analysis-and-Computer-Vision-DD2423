function question5()
  spatial_bandwidth = 10.0;  % spatial bandwidth
  colour_bandwidth = 0.2;    % colour bandwidth
  num_iterations = 100;      % number of mean-shift iterations
  image_sigma = 1.0;         % image preblurring scale

  %% Small sigmas
  figure(1);
  params = [[2.4 1.6]; [2.5 1.6]; [2.4 1.7]; [2.5 1.7]];
  I = imread('orange.jpg');
  Iback = I;
  d = 2 * ceil(image_sigma * 2) + 1;
  h = fspecial('gaussian', [d d], image_sigma);
  I = imfilter(I, h);

  for i = 1:4
    spatial_bandwidth = params(i, 1);
    colour_bandwidth = params(i, 2);

    segm = mean_shift_segm( ...
            I, spatial_bandwidth, colour_bandwidth, num_iterations);
    Inew = mean_segments(Iback, segm);
    %I = overlay_bounds(Iback, segm);
    bigsubplot(2, 2, ceil(i / 2), mod(i + 1, 2) + 1); imshow(Inew);
    title(sprintf('\\sigma_s=%.1f, \\sigma_c=%.1f', ...
                  spatial_bandwidth, colour_bandwidth));
  end
  saveas(gcf, 'report/images/q5-sigmas-small.pdf');

  %% Larger sigmas
  figure(2);
  params = [[5 5]; [20 5]; [5 20]; [20 20]];
  I = imread('orange.jpg');
  Iback = I;
  d = 2 * ceil(image_sigma * 2) + 1;
  h = fspecial('gaussian', [d d], image_sigma);
  I = imfilter(I, h);

  for i = 1:4
    spatial_bandwidth = params(i, 1);
    colour_bandwidth = params(i, 2);

    segm = mean_shift_segm( ...
            I, spatial_bandwidth, colour_bandwidth, num_iterations);
    Inew = mean_segments(Iback, segm);
    bigsubplot(2, 2, ceil(i / 2), mod(i + 1, 2) + 1); imshow(Inew);
    title(sprintf('\\sigma_s=%.1f, \\sigma_c=%.1f', ...
                  spatial_bandwidth, colour_bandwidth));
  end
  saveas(gcf, 'report/images/q5-sigmas.pdf');

  figure(3);
  params = [[5 50]; [50 5]];
  for i = 1:2
    spatial_bandwidth = params(i, 1);
    colour_bandwidth = params(i, 2);

    segm = mean_shift_segm( ...
            I, spatial_bandwidth, colour_bandwidth, num_iterations);
    Inew = mean_segments(Iback, segm);
    bigsubplot(1, 2, ceil(i / 2), mod(i + 1, 2) + 1); imshow(Inew);
    title(sprintf('\\sigma_s=%.1f, \\sigma_c=%.1f', ...
                  spatial_bandwidth, colour_bandwidth));
  end
  saveas(gcf, 'report/images/q5-sigmas-bounded.pdf');

  % I = imread('tiger1.jpg');
  % I = imresize(I, scale_factor);
  % Iback = I;
  % d = 2*ceil(image_sigma*2) + 1;
  % h = fspecial('gaussian', [d d], image_sigma);
  % I = imfilter(I, h);
  % 
  % figure(1);
  % segm = mean_shift_segm(I, spatial_bandwidth, colour_bandwidth, num_iterations);
  % Inew = mean_segments(Iback, segm);
  % I = overlay_bounds(Iback, segm);
  % % imwrite(Inew,'result/meanshift1.png')
  % % imwrite(I,'result/meanshift2.png')
  % subplot(1,2,1); imshow(Inew);
  % subplot(1,2,2); imshow(I);

  figure(4);
  names = ['orange.jpg'; 'tiger1.jpg'; 'tiger2.jpg'; 'tiger3.jpg'];
  params = [[5 8]; [5 10]; [17 1.5]; [12 1.5]];
  [n_images, ~] = size(names);

  for i = 1:n_images
    I = imread(names(i, :));
    spatial_bandwidth = params(i, 1);
    colour_bandwidth = params(i, 2);
    % I = imresize(I, scale_factor);
    Iback = I;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I = imfilter(I, h);

    segm = mean_shift_segm( ...
            I, spatial_bandwidth, colour_bandwidth, num_iterations);
    Inew = mean_segments(Iback, segm);
    % I = overlay_bounds(Iback, segm);
    subplot(2,2,i); imshow(Inew);
    title(sprintf('\\sigma_s=%.1f, \\sigma_c=%.1f', ...
                  spatial_bandwidth, colour_bandwidth));
  end
  saveas(gcf, 'report/images/q5-settings.pdf');
end
