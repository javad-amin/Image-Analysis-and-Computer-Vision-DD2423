function fftwave(u, v, sz)

if (nargin < 2)
    error('Requires at least two input arguments.')
end
if (nargin == 2)
    sz = 128;
end

% Maximizing the figure, just to make it look better
figure('units','normalized','outerposition',[0 0 1 1])

Fhat = zeros(sz);
Fhat(u, v) = 1;

F = ifft2(Fhat);
Fabsmax = max(abs(F(:)));

subplot(3, 2, 1);
showgrey(Fhat);
title(sprintf('Fhat: (u, v) = (%d, %d)', u, v))

% Fixing the indexing as matlab is 1-indexed
if (u <= sz/2)
    uc = u - 1;
else
    uc = u - 1 - sz;
end
if (v <= sz/2)
    vc = v - 1;
else
    vc = v - 1 - sz;
end

wavelength = sz / sqrt(uc^2 + vc^2);
% amplitude = sqrt( (real(F(u,v)))^2 + (imag(F(u,v)))^2 );
amplitude = abs(F(u,v));

subplot(3, 2, 2);
showgrey(fftshift(Fhat));
title(sprintf('centered Fhat: (uc, vc) = (%d, %d)', uc, vc))

subplot(3, 2, 3);
showgrey(real(F), 64, -Fabsmax, Fabsmax);
title('real(F)')

subplot(3, 2, 4);
showgrey(imag(F), 64, -Fabsmax, Fabsmax);
title('imag(F)')

subplot(3, 2, 5);
showgrey(abs(F), 64, -Fabsmax, Fabsmax);
title(sprintf('abs(F) (amplitude %f)', amplitude))

subplot(3, 2, 6);
showgrey(angle(F), 64, -pi, pi);
title(sprintf('angle(F) (wavelength %f)', wavelength))

x=0;
if x==1
    % Saving image file.
    prompt = 'Do you want to save the image? (Y/N)';
    save = input(prompt,'s');

    if save == 'Y' || save == 'y'
        Image = getframe(gcf);
        imgname = sprintf('images/fftwave(%d, %d).jpg', u, v);
        imwrite(Image.cdata, imgname);
        disp('Image file was saved!')
    else
       disp('Image file was not saved!')
    end
end

%Plotting the sine wave
if x==2
    surf(real(F));
    title(sprintf('Real part of F(p, q) = (%d, %d)', u, v));
end
if x==3
        
    plot(1:sz, F(1,:))
    hold on
    plot(1:sz, F(:,1))
    axis square;
    legend("First row (with p=5)", "First column (with q=9)")
    title("Corresponding wave forms")
end
    