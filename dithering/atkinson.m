function [im2] = atkinson(im)

[row, col, ~] = size(im);

im2 = zeros(row, col, 3);

w = 1/8;

for k =1:3
    for y=1:col-2
        for x = 2:row-2
            pix1 = im(x,y,k);
            if pix1 < 128
                pix2 = 0;
            else
                pix2=255;
            end
            im2(x, y, k) = pix2;
            quant_error = pix1 - pix2;
            im2(x+1,y,k) = im(x+1,y,k) + w*quant_error;
            im2(x+2,y,k) = im(x+2,y,k) + w*quant_error;
            im2(x-1,y+1,k) = im(x-1,y+1,k) + w*quant_error;
            im2(x,y+1,k) = im(x,y+1,k) + w*quant_error;
            im2(x+1,y+1,k) = im(x+1,y+1,k) + w*quant_error;
            im2(x,y+2,k) = im(x,y+2,k) + w*quant_error;
        end
    end
end

% {
%   w1=1/8;
%   for (y=0; y<h; y++){
%     for (x=0; x<w; x++){
%       oldpixel = getPixel(x,y);
%       if (oldpixel<128) newpixel = 0; else newpixel=255;
%       setPixel(x,y, newpixel);
%       quant_error = oldpixel - newpixel;
%       setPixel(x+1,y, getPixel(x+1,y) + w1 * quant_error);
%       setPixel(x+2,y, getPixel(x+2,y) + w1 * quant_error);
%       setPixel(x-1,y+1, getPixel(x-1,y+1) + w1 * quant_error);
%       setPixel(x,y+1, getPixel(x,y+1) + w1 * quant_error);
%       setPixel(x+1,y+1, getPixel(x+1,y+1) + w1 * quant_error);
%       setPixel(x,y+2, getPixel(x,y+2) + w1 * quant_error);
%     }
%   }
%  }


end

