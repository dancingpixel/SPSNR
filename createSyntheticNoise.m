clc
clear
close all
warning('off')

imgID = 10 ;
im = imread(['L:\2023\JOURNALS\JNTETI\DATASET\LAPAN_A2_DATASET\' num2str(imgID) '.tif']);
im0 = im ;
% Create vertical noise
MFNoise = rand(size(im(:,:,1)));
id = randperm(size(MFNoise,2));
id = id(1 : round(length(id)/8));
for i = 1 : length(id)
    MFNoise(:,id(i)) = zeros(size(MFNoise(:,id(i)))) ;
end
MFNoise = MFNoise - movmedian(MFNoise, 20, 2);
MFNoiseV = movmean(MFNoise, 20, 1);

% Create horizontal noise
MFNoise = rand(size(im(:,:,1)));
id = randperm(size(MFNoise,1));
id = id(1 : round(length(id)/8));
for i = 1 : length(id)
    MFNoise(id(i),:) = zeros(size(MFNoise(id(i),:))) ;
end
MFNoise = MFNoise - movmedian(MFNoise, 20, 1);
MFNoiseH = movmean(MFNoise, 20, 2);

% Vertical + horizontal Noise
MFNoise = MFNoiseV + MFNoiseH ;

% Adding noise to image
im = double(im);
for i = 1 : size(im,3)
    im(:,:,i) = im(:,:,i) + 128*MFNoise ;
end
im = uint8(im);

for i = 1 : size(im0,3)
    im(:,:,i) = imhistmatch(im(:,:,i),im0(:,:,i));
end

% exporting image
imwrite(im,[num2str(imgID) '.tif']);
