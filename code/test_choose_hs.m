close all; clear all;

% read image
name='birds';
x0 = readimage(name);
figure(1); im(x0); title('Original picture')
I0=sum(x0,3)/3;
% I gray levels between 0 and 255
u=stretch(I0) ;
% nomalized histogram of I
h=hist(u(:),256); h=h/numel(u);
figure;
bar([0:1:255],h);xlim([0,255])

%% modified image with large pixel problem
% sorting pixels
idx = order(u);

% fit an histogram adapted to the original picture
H = choose_hs(u);

figure;
bar([0:1:255],h);xlim([0,255]);hold on; plot(H/sum(H)); axis('tight')
[m,n]= size(u);

[g_u,Hx]=HistGrayMatch(H, m, n, idx); 
figure;im(g_u);  % ARTIFACTS IN THE SKY !!!
x = chm_mult(x0,g_u) ;figure;  im(x)

%% TMR

radius = 3;
N = 4;
%sigma_list = [0.5, 0.8, 0.9, 1, 1.1, 1.5];
sigma_list = 1;
tm_u = u;
tm_g_u = g_u;
output = zeros(size(u));
for sigma=sigma_list
    for k = 1:N
        tm_u = tmr_fonction( u, tm_u, radius, sigma );
        tm_g_u = tmr_fonction( u, tm_g_u, radius, 1 );
        output = u + tm_g_u - tm_u;
    end

    str = sprintf('with sigma = %f', sigma);
    figure; imshow(uint8(output));title( ['With sigma= ' num2str( sigma )]);
end

x = chm_mult(x0,output) ;figure;  im(x)
