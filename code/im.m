function im(x);
L=length(size(x));
if L==2
    imagesc(x);
    %imshow(x,[0 255])
    colormap gray
    axis image;
    axis off
elseif L==3;
    %imshow(uint8(x),[0 255])
    imagesc(uint8(x));
    axis image;
    axis off
end