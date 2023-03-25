function mpsnr = PSNR(imR)
imR = double(imR);
Signal = max(imR(:));
Noise = (std(imR(:)));
mpsnr = 10*log(Signal/Noise) ;
mpsnr = double(mpsnr);