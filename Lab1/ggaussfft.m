function outpic = ggaussfft(pic, t)
    [w, h] = size(pic);
    K = guassian_kernel(w, h, t);
    pichat = fft2(pic);
    Khat = fft2(fftshift(K));
    m = pichat .* Khat;
    outpic = ifft2(m);
end