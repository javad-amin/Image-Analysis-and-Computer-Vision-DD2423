function question7()
colour_bandwidth = 20.0; % color bandwidth
radius = 3;              % maximum neighbourhood distance
ncuts_thresh = 0.2;      % cutting threshold
min_area = 200;          % minimum area of segment
max_depth = 8;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

names = ['orange.jpg'; 'tiger1.jpg'; 'tiger2.jpg'; 'tiger3.jpg'];
[n_images, ~] = size(names);


%% Optimal parameters plot.
params = [[10 20 0.2 200 8 2.0]; ...
          [5 20 0.2 50 10 2.0]; ...
          [6 15 0.5 30 8 1.0]; ...
          [4 20 0.2 20 12 1.0]];
params = [[20 20 0.2 200 8 2.0]; ...
          [10 20 0.2 50 10 2.0]; ...
          [12 15 0.5 30 8 1.0]; ...
          [8 20 0.2 20 12 1.0]];

for i = 1:n_images
  figure(7 + i - 1);
  tmp_radius = params(i, 1);
  tmp_colour_bandwidth = params(i, 2);
  tmp_ncuts_thresh = params(i, 3);
  tmp_min_area = params(i, 4);
  tmp_max_depth = params(i, 5);
  tmp_image_sigma = params(i, 6);
  filename = names(i, :);
  [I, Inew] = ncut(filename, scale_factor, tmp_image_sigma, ...
                   tmp_colour_bandwidth, tmp_radius, tmp_ncuts_thresh, ...
                   tmp_min_area, tmp_max_depth);
  subplot(1, 2, 1); imshow(Inew);
  subplot(1, 2, 2); imshow(I);
  sgtitle(sprintf( ...
        'r=%d, \\sigma_C=%.1f, Ncut<%.1f, area>%d, depth<%d, scale=%.1f', ...
        tmp_radius, tmp_colour_bandwidth, tmp_ncuts_thresh, ...
        tmp_min_area, tmp_max_depth, tmp_image_sigma));
end
return


filename = names(4, :);
%% q7-area
figure(6);
min_areas = [100 200 400 600];

for i = 1:length(min_areas)
  tmp_min_area = min_areas(i);
  [I, Inew] = ncut(filename, scale_factor, image_sigma, ...
                   colour_bandwidth, radius, ncuts_thresh, tmp_min_area, ...
                   max_depth);
  subplot(2,2,i); imshow(Inew);
  title(sprintf('area>%d', tmp_min_area));
end
sgtitle(sprintf( ...
        '\\sigma_C=%.1f, ncut<%.1f, r=%d, depth<%d, scale=%.1f', ...
        colour_bandwidth, ncuts_thresh, radius, max_depth, image_sigma));

%% q7-scale
figure(5);
image_sigmas = [1 2 3 5];

for i = 1:length(image_sigmas)
  tmp_image_sigma = image_sigmas(i);
  [I, Inew] = ncut(filename, scale_factor, tmp_image_sigma, ...
                   colour_bandwidth, radius, ncuts_thresh, min_area, ...
                   max_depth);
  subplot(2,2,i); imshow(Inew);
  title(sprintf('scale=%.1f', tmp_image_sigma));
end
sgtitle(sprintf( ...
        '\\sigma_C=%.1f, ncut<%.1f, r=%d, area>%d, depth<%d', ...
        colour_bandwidth, ncuts_thresh, radius, min_area, max_depth));

%% q7-depth
figure(4);
max_depths = [4 6 8 10];

for i = 1:length(max_depths)
  tmp_max_depth = max_depths(i);
  [I, Inew] = ncut(filename, scale_factor, image_sigma, ...
                   colour_bandwidth, radius, ncuts_thresh, min_area, ...
                   tmp_max_depth);

  subplot(2,2,i); imshow(Inew);
  title(sprintf('depth<%d', tmp_max_depth));
end
sgtitle(sprintf( ...
        '\\sigma_C=%.1f, ncut<%.1f, r=%d, area>%d, scale=%.1f', ...
        colour_bandwidth, ncuts_thresh, radius, min_area, image_sigma));

%% q7-ncut
figure(3);
ncuts_threshs = [0.05 0.1 0.2 0.5];

for i = 1:length(ncuts_threshs)
  tmp_ncuts_thresh = ncuts_threshs(i);
  [I, Inew] = ncut(filename, scale_factor, image_sigma, ...
                   colour_bandwidth, radius, tmp_ncuts_thresh, min_area, ...
                   max_depth);
  subplot(2,2,i); imshow(Inew);
  title(sprintf('ncut<%.2f', tmp_ncuts_thresh));
end
sgtitle(sprintf( ...
        '\\sigma_C=%.1f, r=%d, area>%d, depth<%d, scale=%.1f', ...
        colour_bandwidth, radius, min_area, max_depth, image_sigma));

%% q7-radius
figure(2);
radii = [1 3 6 10];
for i = 1:length(radii)
  tmp_radius = radii(i);
  [I, Inew] = ncut(filename, scale_factor, image_sigma, ...
                   colour_bandwidth, tmp_radius, ncuts_thresh, min_area, ...
                   max_depth);
  subplot(2,2,i); imshow(Inew);
  title(sprintf('r=%d', tmp_radius));
end
sgtitle(sprintf( ...
        '\\sigma_C=%.1f, Ncut<%.1f, area>%d, depth<%d, scale=%.1f', ...
        colour_bandwidth, ncuts_thresh, min_area, max_depth, image_sigma));

%% q7-sigma-c
figure(1);
colour_bandwidths = [10 20 30 40];
for i = 1:length(radii)
  tmp_colour_bandwidth = colour_bandwidths(i);
  [I, Inew] = ncut(filename, scale_factor, image_sigma, ...
                   tmp_colour_bandwidth, radius, ncuts_thresh, min_area, ...
                   max_depth);
  subplot(2,2,i); imshow(Inew);
  title(sprintf('\\sigma_c=%.1f', tmp_colour_bandwidth));
end
sgtitle(sprintf( ...
        'r=%d, Ncut<%.1f, area>%d, depth<%d, scale=%.1f', ...
        radius, ncuts_thresh, min_area, max_depth, image_sigma));
return



I = imread('tiger2.jpg');
I = imread('orange.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imshow(I);
title(sprintf(strcat( ...
      '\\sigma_c=%.1f, r=%d, cutting threshold=%.1f,\n', ...
      'min area=%d, max depth=%d, image sigma=%.1f'), ...
      colour_bandwidth, radius, ncuts_thresh, min_area, max_depth, ...
      image_sigma));
% imwrite(Inew,'result/normcuts1.png')
% imwrite(I,'result/normcuts2.png')

function [I, Inew] = ncut(filename, scale_factor, image_sigma, ...
                          colour_bandwidth, radius, ncuts_thresh, ...
                          min_area, max_depth)
  I = imread(filename);
  I = imresize(I, scale_factor);
  Iback = I;
  d = 2*ceil(image_sigma*2) + 1;
  h = fspecial('gaussian', [d d], image_sigma);
  I = imfilter(I, h);
  segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, ...
                        min_area, max_depth);
  Inew = mean_segments(Iback, segm);
  I = overlay_bounds(Iback, segm);
end

function mask = overlay_bounds_jonas(im, segm)
  [h,w] = size(segm);
  imcut = segm(2:h-1,2:w-1);
  diff = [ ones(1,w) ; ones(h-2,1), ((imcut==segm(3:h,2:w-1)) & (imcut==segm(2:h-1,3:w)) & (imcut==segm(1:h-2,2:w-1)) & (imcut==segm(2:h-1,1:w-2))), ones(h-2,1); ones(1,w) ];
  mask = diff < 0.5;
  % mask = repmat(uint8(diff), [1,1,3]) > 0.5;
  % imout = (im .* mask);
  % imout(:,:,1) = imout(:,:,1) + (1 - mask(:,:,1))*100;
end

end
