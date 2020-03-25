function outpic = gaussfft(pic, t)
  [w, h] = size(pic);
  K = gaussian_kernel(w, h, t);
  Khat = fft2(K);
  pichat = fft2(pic);
  m = pichat .* Khat;
  outpic = fftshift(ifft2(m));
end
