img = imnoise(imread("picture.jpg"),'salt & pepper',0.1);
filterSize = 5; % odd
tic;
newImg1 = effMedian(img, filterSize);
toc;
subplot(1,2,1);
imshow(img);
title("Original Image");
subplot(1,2,2);
imshow(newImg1);
title("Filtered Image");