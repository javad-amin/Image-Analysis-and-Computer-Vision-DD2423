% Maximizing the figure, just to make it look better
figure('units','normalized','outerposition',[0 0 1 1])

F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
[zeros(128, 48) ones(128, 32) zeros(128, 48)];

showgrey(F);
subplot(1, 6, [1 ,2 ,3]); showgrey(F);
title('F');
subplot(1, 6, [4 ,5 ,6]); showfs(fft2(F));
title('fft2(F)');