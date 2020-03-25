% Maximizing the figure, just to make it look better
figure('units','normalized','outerposition',[0 0 1 1])

F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

subplot(3, 3, 1);
showgrey(F);
title('F')

subplot(3, 3, 2);
showgrey(G);
title('G')

subplot(3, 3, 3);
showgrey(H);
title('H')

subplot(3, 3, 4);
showgrey(log(1 + abs(Fhat)));
title('log(1 + abs(Fhat))')

subplot(3, 3, 5);
showgrey(log(1 + abs(Ghat)));
title('log(1 + abs(Ghat))')

subplot(3, 3, 6);
showgrey(log(1 + abs(Hhat)));
title('log(1 + abs(Hhat))')

subplot(3, 3, 7);
showgrey(log(1 + abs(fftshift(Fhat))));
title('log(1 + abs(fftshift(Fhat)))')

subplot(3, 3, 8);
showgrey(log(1 + abs(fftshift(Ghat))));
title('log(1 + abs(fftshift(Ghat)))')

subplot(3, 3, 9);
showgrey(log(1 + abs(fftshift(Hhat))));
title('log(1 + abs(fftshift(Hhat)))')

x=0;
if x==1
    % Saving image file.
    prompt = 'Do you want to save the image? (Y/N)';
    save = input(prompt,'s');

    if save == 'Y' || save == 'y'
        Image = getframe(gcf);
        imgname = 'images/linearity.jpg';
        imwrite(Image.cdata, imgname);
        disp('Image file was saved!')
    else
       disp('Image file was not saved!')
    end
end