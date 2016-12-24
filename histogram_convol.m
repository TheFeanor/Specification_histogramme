close all; clear all; clc

name='Malta';

xo = readimage(name);
figure; im(xo)
Io=sum(xo,3)/3;
I=stretch(Io) ;
% nomalized histogram of I
h=hist(I(:),256); h=h/numel(I);
figure;
bar([0:1:255],h);xlim([0,255])

L=0.2; R=0.2; 
idx = order(I);

H = hsGauss(L,R); 
[m,n]= size(I);

[fx,Hx]=HistGrayMatch(H, m, n, idx); 
figure;im(fx);  % ARTIFACTS IN THE SKY !!!
x = chm_mult(xo,fx) ;figure;  im(x)

h=hist(x(:),256); h=h/numel(x);
figure;
bar([0:1:255],h);xlim([0,255])

%% gaussienne : sigma = 1
b = 1*randn(size(x));
xx = x + b;
figure; im(xx); title('gauss, sigma = 1');

h=hist(xx(:),256); h=h/numel(xx);
figure;
bar([0:1:255],h);xlim([0,255]);
title('gauss, sigma = 1');

%% gaussienne : sigma = 3

b = 3*randn(size(x));
xx = x + b;
figure; im(xx); title('gauss, sigma = 3');

h=hist(xx(:),256); h=h/numel(xx);
figure;
bar([0:1:255],h);xlim([0,255]);
title('gauss, sigma = 3');

%% gaussienne : sigma = 5

b = 5*randn(size(x));
xx = x + b;
figure; im(xx); title('gauss, sigma = 5');

h=hist(xx(:),256); h=h/numel(xx);
figure;
bar([0:1:255],h);xlim([0,255]);
title('gauss, sigma = 5');

%% gaussienne : sigma = 10

b = 10*randn(size(x));
xx = x + b;
figure; im(xx); title('gauss, sigma = 10');

h=hist(xx(:),256); h=h/numel(xx);
figure;
bar([0:1:255],h);xlim([0,255]);
title('gauss, sigma = 10');

%% porte : sigma : 1

b = -1 + (2*1)*rand(size(x));
xx = x + b;
figure; im(xx); title('porte, sigma = 1');

figure; im(rgb2gray(uint8(xx)));

h=hist(xx(:),256); h=h/numel(xx);
figure;
bar([0:1:255],h);xlim([0,255]);
title('porte, sigma = 1');

%% porte : sigma : 3

b = -3 + (2*3)*rand(size(x));
xx = x + b;
figure; im(xx); title('porte, sigma = 3');

h=hist(xx(:),256); h=h/numel(xx);
figure;
bar([0:1:255],h);xlim([0,255]);
title('porte, sigma = 3');

%% porte : sigma = 5

b = -5 + (2*5)*rand(size(x));
xx = x + b;
figure; im(xx); title('porte, sigma = 5');

h=hist(xx(:),256); h=h/numel(xx);
figure;
bar([0:1:255],h);xlim([0,255]);
title('porte, sigma = 5');

%% gaussienne : sigma = 10

b = -10 + (2*10)*rand(size(x));
xx = x + b;
figure; im(xx); title('porte, sigma = 10');

h=hist(xx(:),256); h=h/numel(xx);
figure;
bar([0:1:255],h);xlim([0,255]);
title('porte, sigma = 10');