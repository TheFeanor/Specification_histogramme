close all; clear all;

name = 'bungalow';
xo = readimage(name);

% see the image
figure; im(xo)
%figure; imshow(uint8(xo), []);

% color-to-gray 
Io=sum(xo,3)/3; im(Io); 

% stretch on [0,255]
I=stretch(Io) ;

% nomalized histogram of I
h=hist(I(:),256); h=h/numel(I);
figure;
bar([0:1:255],h);xlim([0,255])

% order the pixel values using minimization code fixedLogs4sortIt
idx = order(I);

% target histogram 
L=1; R=0.05 ;
H = hsGauss(L,R); 
figure; plot(H); axis('tight')

[m,n]= size(I);

% target intensity image
[fx,Hx]=HistGrayMatch(H, m, n, idx); 

figure;im(fx); 

% THE LARGE PIXEL PROBLEM COMES FROM 
% ORDER, CHOICE OF THE HISTOGRAM AND HistGrayMatch

% enhance the image 
x = chm_mult(xo,fx) ;figure;  im(x)

h=hist(x(:),256); h=h/numel(x);
figure;
bar([0:1:255],h);xlim([0,255])

% FOR SOME IMAGES WITH LARGE PIXELS RESULTS ARE BAD

%% 
clear; close all
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

b = 5*randn(size(x));
xx = x + b;

h=hist(x(:),256); h=h/numel(x);
figure;
bar([0:1:255],h);xlim([0,255])

h=hist(xx(:),256); h=h/numel(xx);
figure;
bar([0:1:255],h);xlim([0,255])

figure; im(xx);