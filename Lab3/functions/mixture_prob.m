function [prob, w] = mixture_prob(image, K, L, mask)
% Let I be a set of pixels and V be a set of K Gaussian components in
% 3D (R,G,B).

[height, width, depth] = size(image);
N = width * height;
Ivec = im2double(reshape(image, N, 3));
maskvec = reshape(logical(mask), N, 1);

% Store all pixels for which mask=1 in a Nx3 matrix
Imaskvec = Ivec(maskvec, :);

% Initialize the K components using masked pixels.
[Nmask, ~] = size(Imaskvec);
[segm, mu] = kmeans_segm(Imaskvec, K, L, 789);

%% Initialize weights
% "The parameter wk would then define how many pixels you have of
% each colour type".
w = zeros(K, 1);
for k = 1:K
  w(k) = sum(segm == k) / Nmask;
end

Sigmas = cell(K, 1);
Sigmas(:) = {eye(3)};

% Iterate L times
G = zeros(Nmask, K);
for iter = 1:L
  % Expectation: Compute probabilities P_ik using masked pixels
  for k = 1:K
    G(:, k) = gkci(k, mu, Sigmas, Imaskvec);
  end
  P_ik = w' .* G(:, :) ./ sum(w' .* G(:, :), 2);

  % Maximization: Update weights, means and covariances using masked pixels
  w = (1 / Nmask) * sum(P_ik)';
  for k = 1:K
    mu(k, :) = P_ik(:, k)' * Imaskvec / sum(P_ik(:, k));
    diff = Imaskvec(:, :) - mu(k, :);
    Sigmas{k} = diff' * (P_ik(:, k) .* diff) / sum(P_ik(:, k));
  end
  fprintf('Loop done. \n');
end

%  Compute probabilities p(c_i) in Eq.(3) for all pixels I.
P_ci = zeros(height * width, K);
for k = 1:K
  P_ci(:, k) = gkci(k, mu, Sigmas, Ivec);
end
% Note that the function returns an image of probabilities (prob), but
% not the weights, means and covariances of the components.
prob = reshape(P_ci * w, height, width, 1);


function ret = gkci(k, mu, Sigmas, ci)
  diff = ci - mu(k, :);
  x = -0.5 * sum((diff * inv(Sigmas{k})) .* diff, 2);
  ret = 1 / sqrt((2 * pi)^3 * det(Sigmas{k})) * exp(x);
end

end
