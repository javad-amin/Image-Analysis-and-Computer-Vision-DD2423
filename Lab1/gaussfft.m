function result = gaussfft(pic, t)
    [v, u] = size(pic);
    [X, Y] = meshgrid(-v / 2: (v / 2) - 1, -u / 2: (u / 2) - 1);
    gauss = (1 / (2 * pi * t)) * exp(-(X.^2 + Y.^2) / (2 * t));
    %surf(gauss)

    Pichat = fft2(pic);
    Ghat = fft2(gauss);
    result = fftshift(ifft2(Pichat .* Ghat));
    %surf(result);
    %figure;
    %showgray(pic);
end