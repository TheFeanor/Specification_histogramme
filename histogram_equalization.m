u = double(imread('im/mandrill.bmp'));
figure();
imshow(u, []);
title('#NoFilter');

h=hist(u(:),256); h=h/numel(u);
figure;
bar([0:1:255],h);xlim([0,255])

u_histeq = double(histeq(uint8(u), 256));

figure();
imshow(u_histeq, []);
title('With histeq routine');

h=hist(u_histeq(:),256); h=h/numel(u_histeq);
figure;
bar([0:1:255],h);xlim([0,255])

idx = order(u);
[m,n]= size(u);
h_unif = ones(1,256)/256;
figure;
bar([0:1:255],h_unif);xlim([0,255])