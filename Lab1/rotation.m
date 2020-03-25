% Maximizing the figure, just to make it look better
figure('units','normalized','outerposition',[0 0 1 1])

F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
[zeros(128, 48) ones(128, 32) zeros(128, 48)];

figure;
subplot(3, 9, [1, 2, 3]); showgrey(F); title('F');
subplot(3, 9, [4, 5, 6]); showfs(fft2(F)); title('fft2(F)');

G = rot(F, 30); Ghat = fft2(G); Hhat = rot(fftshift(Ghat) , -30);
subplot(3, 9, [10, 11, 12]); showgrey(G); title ( 'G [30deg]');
subplot(3, 9, [13, 14, 15]); showfs(Ghat); title ( 'fft2(G) [30 deg]');
subplot(3, 9, [16, 17, 18]); showgrey(log(1 + abs(Hhat)));
title('log(1 + abs(Hhat) [30deg]');

G = rot (F, 45); Ghat = fft2(G); Hhat = rot ( fftshift (Ghat) , -45);
subplot(3, 9, [19, 20, 21]); showgrey(G); title ( 'G [45deg] ');
subplot(3, 9, [22, 23, 24]); showfs(Ghat); title ( ' fft2 (G) [45 deg] ');
subplot(3, 9, [25, 26, 27]); showgrey(log(1 + abs(Hhat)));
title('log(1 + abs(HHat) [45deg]');