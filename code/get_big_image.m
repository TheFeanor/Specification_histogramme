function [ big_image ] = get_big_image( image )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(image);
big_image = zeros(3*m, 3*n);
big_image(1:m,1:n) = fliplr(flipud(image));
big_image(1:m,n+1:2*n) = flipud(image);
big_image(1:m,2*n+1:end) = fliplr(flipud(image));
big_image(m+1:2*m,1:n) = fliplr(image);
big_image(m+1:2*m,n+1:2*n) = image;
big_image(m+1:2*m,2*n+1:end) = fliplr(image);
big_image(2*m+1:end,1:n) = fliplr(flipud(image));
big_image(2*m+1:end,n+1:2*n) = flipud(image);
big_image(2*m+1:end,2*n+1:end) = fliplr(flipud(image));

end

