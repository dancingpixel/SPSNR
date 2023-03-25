clc
clear
close all
warning('off')

K = 500 ; %number of desired sub regions
NMF0 = 300;
NME0 = 300;

imgID = 9 ;
im = imread(['L:\2023\JOURNALS\JNTETI\DATASET\LAPAN_A3_DATASET\' num2str(imgID) '.tif']);

NChannel = size(im,3);
[L,N] = superpixels(im,K,'compactness',1, 'method','slic0', 'NumIterations',10);

im = double(im);
outImg = uint8(zeros(size(im)));
IDX = label2idx(L);

% using Adaptive Stripe Noise Removal
for i = 1:N
	[row,col] = ind2sub(size(L),IDX{i});
    irow = min(row);
    erow = max(row);
    icol = min(col);
    ecol = max(col);
    
    mask = L==i ;
    mask = mask(irow:erow,icol:ecol);
     
    for j = 1 : NChannel
        imc = im(irow:erow,icol:ecol,j);
        imc(mask==0)=NaN;    
        imc = SPSNR3(imc, NMF0, NME0);
        imc = uint8(imc);       
        outImg(irow:erow,icol:ecol,j) = outImg(irow:erow,icol:ecol,j) + imc ;
    end
    
end

im = uint8(im);
outImg = uint8(outImg);

imwrite(outImg,[num2str(imgID) '.tif'])
disp(['PSNR of Input Image : ' num2str(PSNR(rgb2gray(im)))])
disp(['PSNR of Corrected Image : ' num2str(PSNR(rgb2gray(outImg)))])
