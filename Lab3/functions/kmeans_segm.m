function [segmentation, centers, Lconv] = ...
         kmeans_segm(image, K, L, seed, method)
  err_limit = double(max(image, [], 'all') - min(image, [], 'all'))^2 / 256^2;
  % If L = 0, then run until converged (MSE < 1).
  % If Lconv > 0 then converged at Lconv = L.
  if nargin < 5
    method = 'k-means++';
  end
  if L == 0
    L = 100;
    until_converged = true;
  else
    until_converged = false;
  end
  if seed >= 0
    rng(seed);
  end

  Lconv = 0;
  % Check if image is already flattened.
  if ndims(image) == 2
    [height, channels] = size(image);
    width = 1;
    Ivec = image;
  else
    [height, width, channels] = size(image);
    Ivec = reshape(double(image), height * width, channels);
  end

  Avec = zeros([height * width, 1], "uint8");
  if strcmpi(method, 'forgy')
    % 'Using random points for initialization'
    % randi produces random integers [1,256] so subtract one for [0,255).
    Z = randi(height * width, K, 1);
    % Initialize centers from existing values instead of randomly
    % making them up to prevent unassigned clusters in the first round.
    centers = Ivec(Z, :);
  elseif strcmpi(method, 'k-means++')
    % 'Using K-means++ for initialization'
    % K-means++
    Z = randi(height * width, 1);
    centers = zeros(K, channels);
    centers(1, :) = Ivec(Z, :);

    for i = 2:K
      % Why does this work without sorting? Because if
      % D.^2 is a vector of squared distances, e.g.
      % [4 36 9 1 4 0 0 16 4 36] then the cumulative sum (normalized) is
      % [0.0364 0.3636 0.4455 0.4545 0.4909 0.4909 0.4909 0.6364 0.6727 1].
      % With a uniform random number generator [0,1), it is much more
      % likely to pick numbers that hit the gap between the first two values
      % than the gap between 0 and the first number. A number falling
      % between the two first numbers corresponds to index 2, which
      % corresponds to an index in Ivec that is far from the centers
      % picked so far.
      [D, ~] = pdist2(centers(1:i - 1, :), Ivec, 'euclidean', 'Smallest', 1);
      D = cumsum(D.^2);
      if D(end) == 0
        ME = MException('k_means_segm:badInitialization', ...
                        'All initial centers equal')
        throw(ME)
      end
      ix = find(rand < D/D(end), 1);
      centers(i, :) = Ivec(ix, :);
    end
  else
    ME = MException('k_means_segm:noSuchMethod', ...
                    'Method %s not recognized', method);
    throw(ME)
  end

  for l = 1:L
    [p, Avec] = pdist2(centers, Ivec, 'euclidean', 'Smallest', 1);
    mu = zeros([K, 3]);
    for k = 1:K
      avec_k = (Avec == k);
      if any(avec_k)
        mu(k, :) = mean(Ivec(avec_k, :));
      else
        mu(k, :) = centers(k, :);
      end
    end
    err = immse(centers, mu);
    centers = mu;
    if until_converged && err < err_limit
      Lconv = l;
      break;
    end
  end

  segmentation = reshape(Avec, height, width, 1);
end
