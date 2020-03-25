office = office256;

add = gaussnoise(office, 16);
sap = sapnoise(office, 0.1, 255);

spr = 2; spc = 3;

sigma = 3; wsize = 3; cutoff = 0.07;
%Figure 1
figure;
subplot(spr,spc,1)
showgrey(office);
title('Original');

subplot(spr,spc,2)
showgrey(add);
title('Gaussnoise');

subplot(spr,spc,3)
showgrey(sap);
title('Sapnoise');

subplot(spr,spc,5)
showgrey(gaussfft(add, sigma));
title('Smoothing with gaussfft');

subplot(spr,spc,6)
showgrey(gaussfft(sap, sigma));

%Figure 2
figure;
subplot(spr,spc,1)
showgrey(office);
title('Original');

subplot(spr,spc,2)
showgrey(add);
title('Gaussnoise');

subplot(spr,spc,3)
showgrey(sap);
title('Sapnoise');

subplot(spr,spc,5)
showgrey(medfilt(add, wsize));
title('Smoothing with median filtering');

subplot(spr,spc,6)
showgrey(medfilt(sap, wsize));

%Figure 3
figure;
subplot(spr,spc,1)
showgrey(office);
title('Original');

subplot(spr,spc,2)
showgrey(add);
title('Gaussnoise');

subplot(spr,spc,3)
showgrey(sap);
title('Sapnoise');

subplot(spr,spc,5)
showgrey(ideal(add, cutoff));
title('Smoothing with ideal filtering');

subplot(spr,spc,6)
showgrey(ideal(sap, cutoff));