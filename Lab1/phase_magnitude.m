% Maximizing the figure, just to make it look better
figure('units','normalized','outerposition',[0 0 1 1])

phonecalc = phonecalc128;
few = few128;
nallo = nallo128;

a = 10^(-10);

subplot(3,3,1)
showgrey(phonecalc);
title('Original Image');
subplot(3,3,2)
showgrey(pow2image(phonecalc, a));
title('pow2image');
subplot(3,3,3)
showgrey(randphaseimage(phonecalc));
title('randphaseimage');

subplot(3,3,4)
showgrey(few);
subplot(3,3,5)
showgrey(pow2image(few, a));
subplot(3,3,6)
showgrey(randphaseimage(few));

subplot(3,3,7)
showgrey(nallo);
subplot(3,3,8)
showgrey(pow2image(nallo, a));
subplot(3,3,9)
showgrey(randphaseimage(nallo));