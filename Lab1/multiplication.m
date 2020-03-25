% Maximizing the figure, just to make it look better
figure('units','normalized','outerposition',[0 0 1 1])

N = 128;
F = [ zeros(56, N); ones(16, N); zeros(56, N)];
G = F';

Fhat = fft2(F);
Ghat = fft2(G);


subplot (1, 9, [1, 2, 3]); showgrey (F .*G);
title('F . *G');
subplot(1, 9, [4, 5, 6]); showfs(fft2(F .*G));
title('fft2(F .*G)');

% F dot G <==> (1 / N^2) Fhat bigstar Ghat
FGhat = (1/N^2) * conv2(Fhat, Ghat);
subplot (1, 9, [7, 8, 9]); showfs(FGhat(1:N, 1:N));
title ({'conv(fft2(Fhat .* Ghat )' , '(cropped and shifted)'});

x=0;
if x==1
    % Saving image file.
    prompt = 'Do you want to save the image? (Y/N)';
    save = input(prompt,'s');

    if save == 'Y' || save == 'y'
        Image = getframe(gcf);
        imgname = 'images/multiplication.jpg';
        imwrite(Image.cdata, imgname);
        disp('Image file was saved!')
    else
       disp('Image file was not saved!')
    end
end