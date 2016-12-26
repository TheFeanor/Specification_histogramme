close all; clear all; clc

name='book';

xo = readimage(name);
figure; im(xo)
Io=sum(xo,3)/3;
I=stretch(Io) ;
%b = 5*randn(size(I));
%I = I + b;
% nomalized histogram of I
h=hist(I(:),256); h=h/numel(I);
figure;
bar([0:1:255],h);xlim([0,255])

L=1; R=0.01; 
idx = order(I);

H = hsGauss(L,R); 
[m,n]= size(I);
figure; plot(H); axis('tight')

[fx,Hx]=HistGrayMatch(H, m, n, idx); 
figure;im(fx);  % ARTIFACTS IN THE SKY !!!
x = chm_mult(xo,fx) ;figure;  im(x)

h=hist(x(:),256); h=h/numel(x);
figure;
bar([0:1:255],h);xlim([0,255])

%% gaussienne : sigma = 3

b = 3*randn(size(x));
xx = x + b;
figure; im(xx); title('gauss, sigma = 3');

h=hist(xx(:),256); h=h/numel(xx);
figure;
bar([0:1:255],h);xlim([0,255]);
title('gauss, sigma = 3');