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