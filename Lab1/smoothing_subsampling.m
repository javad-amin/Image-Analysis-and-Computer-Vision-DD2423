img = phonecalc256; 
smoothimg = img;
N=5;

figure;
for i=1:N
    if i>1 % generate subsampled versions
        img = rawsubsample(img);
        smoothimg = gaussfft(smoothimg, 1);
        smoothimg = rawsubsample(smoothimg);
    end
    subplot(2, N, i)
    showgrey(img)
    title('rawsubsample');
    subplot(2, N, i+N)
    showgrey(smoothimg)
    title('Guassian filter and rawsubsample');
end

img = phonecalc256; 
smoothimg = img;
N=5;

figure;
for i=1:N
    if i>1 % generate subsampled versions
        img = rawsubsample(img);
        smoothimg = ideal(smoothimg, 0.2);
        smoothimg = rawsubsample(smoothimg);
    end
    subplot(2, N, i)
    showgrey(img)
    title('rawsubsample');
    subplot(2, N, i+N)
    showgrey(smoothimg)
    title('ideal filter and rawsubsample');
end


img = phonecalc256; 
smoothimg = img;
N=5;

figure;
for i=1:N
    if i>1 % generate subsampled versions
        img = rawsubsample(img);
        smoothimg = gaussfft(smoothimg, 1);
        smoothimg = rawsubsample(smoothimg);
    end
    subplot(2, N, i)
    showgrey(log(1+abs(fftshift(fft2(img)))))
    title('rawsubsample');
    subplot(2, N, i+N)
    showgrey(log(1+abs(fftshift(fft2(smoothimg)))))
    title('Guassian filter and rawsubsample');
end

img = phonecalc256; 
smoothimg = img;
N=5;

figure;
for i=1:N
    if i>1 % generate subsampled versions
        img = rawsubsample(img);
        smoothimg = ideal(smoothimg, 0.2);
        smoothimg = rawsubsample(smoothimg);
    end
    subplot(2, N, i)
    showgrey(log(1+abs(fftshift(fft2(img)))))
    title('rawsubsample');
    subplot(2, N, i+N)
    showgrey(log(1+abs(fftshift(fft2(smoothimg)))))
    title('ideal filter and rawsubsample');
end