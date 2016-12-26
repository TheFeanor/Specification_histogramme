%%
clear; close all
name='malta';

xo = readimage(name);
figure; im(xo)
Io=sum(xo,3)/3;
I=stretch(Io) ;
% nomalized histogram of I
h=hist(I(:),256); h=h/numel(I);
%figure;
%bar([0:1:255],h);xlim([0,255])

L=1; R=0.2; 
idx = order(I);

H = hsGauss(L,R); 
[m,n]= size(I);
figure; bar([0:1:255],h);xlim([0,255])
hold on; plot(H/sum(H)); axis('tight')

[fx,Hx]=HistGrayMatch(H, m, n, idx); 
figure;im(fx);  
x = chm_mult(xo,fx) ;figure;  im(x)

figure;
plot(cumsum(h));
hold on;
plot(cumsum(H/sum(H)), 'g');

%% Chercher L et R tq gaussienne la plus proche de cumsum
R = [0.005, 0.01, 0.05, 0.1, 0.2, 0.5, 0.8, 1];
L = [0.005, 0.01, 0.05, 0.1, 0.2, 0.5, 0.8, 1];

dist = 1e20;
H_min = zeros(1,256);
R_min = 0;
L_min = 0;

for i=1:length(R)
    for j=1:length(L)
        H = hsGauss(L(j), R(j));
        if norm(cumsum(H/sum(H)) - cumsum(h)) < dist
            dist = norm(cumsum(H/sum(H)) - cumsum(h));
            H_min = H;
            R_min = R(i);
            L_min = L(j);
        end
    end
end

%%
[fx,Hx]=HistGrayMatch(H_min, m, n, idx); 
figure;im(fx);  
x = chm_mult(xo,fx) ;figure;  im(x)

figure;
plot(cumsum(h));
hold on;
plot(cumsum(H/sum(H)), 'g');