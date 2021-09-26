function [resultImg] = effMedian(inputImg, fSize)
%EFFMEDIAN Summary of this function goes here
%   Detailed explanation goes here
%   inpuImg: input image
%   fSize: filter size x*x

fSize = [fSize, fSize];
[ih, iw, ic] = size(inputImg);     % height, width and channel of inputImg                    
ch = round((fSize(1)-1)/2);
cw = round((fSize(2)-1)/2);

% padding inputImg
tempImg = zeros([ih+ch*2, iw+cw*2, ic]);
tempImg(1+ch:ih+ch, 1+cw:iw+cw, :) = inputImg;
resultImg = zeros([ih, iw, ic]);

% step1
t = ceil(fSize(1)*fSize(2)/2);

for c = 1:ic
    for h = 1+ch:ih+ch  % Step 9
        w = 1+cw;
        H = zeros([1,256]); % histogram
        filterBlock = tempImg(h-ch:h+ch, w-cw:w+cw, c);
        tempBlock = filterBlock(:);
        for tmpi = 1:fSize(1)*fSize(2)
            H(tempBlock(tmpi)+1) = H(tempBlock(tmpi)+1)+1;% +1：亮度0对应位置1 
        end
        m = median(tempBlock);
        n_m = length(find(tempBlock <= m));
        resultImg(h-ch,w-1,c) = m;
        for w = 2+cw:iw+cw  % Step 8
            moveOut = tempImg(h-ch:h+ch,w-1-cw,c);
            moveIn = tempImg(h-ch:h+ch,w+cw,c);
            tempBlock = moveOut(:);
            for tmpi = 1:fSize(1)  % Step 3
                H(tempBlock(tmpi)+1) = H(tempBlock(tmpi)+1)-1;   
            end
            n_m = n_m - length(find(tempBlock <= m)); % Step 3
            tempBlock = moveIn(:);
            for tmpi = 1:fSize(1)  % Step 4
                H(tempBlock(tmpi)+1) = H(tempBlock(tmpi)+1)+1;   
            end
            n_m = n_m + length(find(tempBlock <= m));  % Step 4
            jmpFlag = n_m - t;                         % Step 5
            if (jmpFlag < 0)                           % Step 6
                while(n_m < t)
                    m = m + 1;
                    n_m = n_m + H(m+1);
                end
            elseif (jmpFlag > 0)                       % Step 7
                while(n_m > t)
                    n_m = n_m - H(m+1);
                    m = m - 1;
                end
            end
            resultImg(h-cw,w-cw,c) = m;
        end
    end
end

resultImg = uint8(resultImg);

end

