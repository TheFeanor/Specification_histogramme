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
figure; plot(H); axis('tight')
[m,n]= size(I);

[fx,Hx]=HistGrayMatch(H, m, n, idx); 
figure;im(fx);  % ARTIFACTS IN THE SKY !!!
x = chm_mult(xo,fx) ;figure;  im(x)

%% 2 levels pyramid

m2 = m/2; n2 = n/2;
I11 = I(1:m2, 1:n2); I12 = I(1:m2, n2+1:end);
I21 = I(m2+1:end, 1:n2); I22 = I(m2+1:end, n2+1:end);

h=hist(I11(:),256); h=h/numel(I11);
figure; bar([0:1:255],h);xlim([0,255]);title('I11');
L = 0.2;R = 0.1; H = hsGauss(L,R);
figure; plot(H); axis('tight') 

h=hist(I12(:),256); h=h/numel(I12);
figure;bar([0:1:255],h);xlim([0,255]);title('I12');
L = 0.2;R = 0.8; H = hsGauss(L,R);
figure; plot(H); axis('tight') 

h=hist(I21(:),256); h=h/numel(I21);
figure;bar([0:1:255],h);xlim([0,255]);title('I21');
L = 0.3;R = 0.7; H = hsGauss(L,R);
figure; plot(H); axis('tight') 

h=hist(I22(:),256); h=h/numel(I22);
figure;bar([0:1:255],h);xlim([0,255]);title('I22');
L = 0.2;R = 0.2; H = hsGauss(L,R);
figure; plot(H); axis('tight') 

%%

idx11 = order(I11); idx12 = order(I12);
idx21 = order(I21); idx22 = order(I22);

[fx11,Hx11]=HistGrayMatch(H, m2, n2, idx11); 
%figure;im(fx11);
x11 = chm_mult(xo(1:m2, 1:n2,:),fx11) ;figure;  im(x11)

[fx12,Hx12]=HistGrayMatch(H, m2, n2, idx12); 
%figure;im(fx12);
x12 = chm_mult(xo(1:m2, n2+1:end, :), fx12) ;figure;  im(x12)

[fx21,Hx21]=HistGrayMatch(H, m2, n2, idx21); 
%figure;im(fx21);
x21 = chm_mult(xo(m2+1:end, 1:n2, :),fx21) ;figure;  im(x21)

[fx22,Hx22]=HistGrayMatch(H, m2, n2, idx22); 
%figure;im(fx22);
x22 = chm_mult(xo(m2+1:end, n2+1:end, :),fx22) ;figure;  im(x22)

%% add noise
xx11 = x11 + 5*randn(size(x11)); xx12 = x12 + randn(size(x12)); 
xx21 = x21 + randn(size(x21)); xx22 = x22 + randn(size(x22)); 

figure; im(xx11);

%% blur
xx11 = imgaussfilt(x11, 2); xx12 = imgaussfilt(x12); 
xx21 = imgaussfilt(x21); xx22 = imgaussfilt(x22);

figure; im(xx11);

%% reconstruction

out = zeros(m,n,3);

out(1:m2, 1:n2,:) = 0.5*(x(1:m2, 1:n2,:) + x11);
out(1:m2, n2+1:end,:) = 0.5*(x(1:m2, n2+1:end,:) + x12);
out(m2+1:end, 1:n2,:) = 0.5*(x(m2+1:end, 1:n2,:) + x21);
out(m2+1:end, n2+1:end,:) = 0.5*(x(m2+1:end, n2+1:end,:) + x22);

figure; im(out);
