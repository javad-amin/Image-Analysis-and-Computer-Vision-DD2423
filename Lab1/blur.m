img1 = kloss256;
img2 = hand256;
img3 = godthem256;

spr = 3; spc = 6;

subplot(spr,spc,1)
showgrey(img1);
subplot(spr,spc,2)
showgrey(img2);
title('Original Images');
subplot(spr,spc,3)
showgrey(img3);

subplot(spr,spc,4)
showgrey(gaussfft(img1, 1.0));
subplot(spr,spc,5)
showgrey(gaussfft(img2, 1.0));
title('Gaussian convolution (t=1.0)');
subplot(spr,spc,6)
showgrey(gaussfft(img3, 1.0));

subplot(spr,spc,7)
showgrey(gaussfft(img1, 4.0));
subplot(spr,spc,8)
showgrey(gaussfft(img2, 4.0));
title('Gaussian convolution (t=4.0)');
subplot(spr,spc,9)
showgrey(gaussfft(img3, 4.0));

subplot(spr,spc,10)
showgrey(gaussfft(img1, 16.0));
subplot(spr,spc,11)
showgrey(gaussfft(img2, 16.0));
title('Gaussian convolution (t=16.0)');
subplot(spr,spc,12)
showgrey(gaussfft(img3, 16.0));


subplot(spr,spc,13)
showgrey(gaussfft(img1, 64.0));
subplot(spr,spc,14)
showgrey(gaussfft(img2, 64.0));
title('Gaussian convolution (t=64.0)');
subplot(spr,spc,15)
showgrey(gaussfft(img3, 64.0));


subplot(spr,spc,16)
showgrey(gaussfft(img1, 256.0));
subplot(spr,spc,17)
showgrey(gaussfft(img2, 256.0));
title('Gaussian convolution (t=256.0)');
subplot(spr,spc,18)
showgrey(gaussfft(img3, 256.0));