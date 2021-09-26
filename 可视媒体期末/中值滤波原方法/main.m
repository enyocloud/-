% imgOrg = rgb2gray(imread("peppers.png"));
imgOrg = imread("picture.jpg");
imgOrg = imnoise(imgOrg, 'salt & pepper'); % Adding salt-pepper noise
subplot(1,3,1);
imshow(imgOrg);
title("Originall img");

% median filter
imgMedian = medianfilter(imgOrg, 3); % Generally, the size of a filter is an odd num
subplot(1,3,2);
imshow(imgMedian);
title("Median filter img");

% Using Matlab API
subplot(1,3,3);
[~, ~, c] = size(imgOrg);
newImg = zeros(size(imgOrg));
for i = 1:c
    newImg(:,:,i) = medfilt2(imgOrg(:,:,i));
end
newImg = uint8(newImg);
imshow(newImg);
title("Medfilt img by API");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function imgMedian = medianfilter(img,filterSize)
% img: image
% filterSize: if=5, it means 5*5

% Generate new blank image
[h, w, c] = size(img);
padSize = (filterSize-1)/2;
imgMedianT = zeros([h+2*padSize, w+2*padSize, c]);
imgMedianT(1+padSize:padSize+h, 1+padSize:padSize+w, :) = img;
imgMedian = zeros([h, w, c]);

for k = 1:c
    for i = 1:h
        for j = 1:w
            block = imgMedianT(i:i-1+filterSize, j:j-1+filterSize, k);
            imgMedian(i, j, k) = median(block, 'all');
        end
    end
end

imgMedian = uint8(imgMedian);

end