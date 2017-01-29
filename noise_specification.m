% Idea: create a noisy histogram (convoluted histogram) then fit this
% histogram with the image
close all; clear all; clc

% read image
name='malta';
xo = readimage(name);
figure(1); im(xo); title('Original picture')
Io=sum(xo,3)/3;
% I gray levels between 0 and 255
I=stretch(Io) ;
% nomalized histogram of I
h=hist(I(:),256); h=h/numel(I);
figure;
bar([0:1:255],h);xlim([0,255])

x=I;
% Creating random noise 
b = 0.5*randn(size(x));
xx = x + b;
%figure; im(xx); title('gauss, sigma = 10');

% hb is the noisy histogram - target hist 1
hb=hist(xx(:),256); hb=hb/numel(xx);
figure;
bar([0:1:255],hb);xlim([0,255]);
title('gauss, sigma = 10');

% target hist 2 - best gaussian approx
L=0.2; R=0.2 ;
H = hsGauss(L,R); 
H = H/sum(H);
figure;
bar([0:1:255],h);xlim([0,255]);
hold on; plot(H); axis('tight')

[m,n]= size(I);
% order the pixel values using minimization code fixedLogs4sortIt
idx = order(I);
% target intensity image
target_hist = 0.9 * hb + 0.1 * H';
figure;
bar([0:1:255],target_hist);xlim([0,255]);

[fx,Hx]=HistGrayMatch(target_hist, m, n, idx); 

% the new image in gray
%figure;im(fx); 


% enhance the image 
x_out = chm_mult(xo,fx) ;figure;  im(x_out)

