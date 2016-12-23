clear all; clc; close all;

%% loading the images images
u = double(imread('im/flower1.bmp'));  % use imread with Matlab
v = double(imread('im/flower2.bmp'));
[nr, nc, nch] = size(u);
figure();
im_u = uint8(u);
im_v = uint8(v);
imshow(im_u, []);
figure();
imshow(im_v, []);

[hr_u, hg_u, hb_u] = disp_histograms(u, 'u initial');
[hr_v, hg_v, hb_v] = disp_histograms(v, 'v initial');

%% Sliced optimal transport for colour transfer - sort

u2 = u(1:2:nr,1:2:nc,:);
v2 = v(1:2:nr,1:2:nc,:);

[nr2, nc2, ~] = size(u2);

X = reshape(u2, nr2*nc2, 3);
Y = reshape(v2, nr2*nc2, 3);

Z = transport3D(X,Y,1000,0.01, 'def');
w = reshape(Z,nr2,nc2,3);
w = min(max(w,0),255);
im_w = uint8(w);

figure();
imshow(im_w, []);
title('Sliced optimal transport - fonction sort');

[hr_sort, hg_sort, hb_sort] = disp_histograms(w, 'SOT - sort');

%% Sliced optimal transport for colour transfer - order

u2 = u(1:2:nr,1:2:nc,:);
v2 = v(1:2:nr,1:2:nc,:);

[nr2, nc2, ~] = size(u2);

X = reshape(u2, nr2*nc2, 3);
Y = reshape(v2, nr2*nc2, 3);

Z = transport3D(X,Y,1000,0.01, 'ord');
w = reshape(Z,nr2,nc2,3);
w = min(max(w,0),255);
im_w = uint8(w);

figure();
imshow(im_w, []);
title('Sliced optimal transport - order');

[hr_order, hg_order, hb_order] = disp_histograms(w, 'SOT - order');

%% Comparaison d'histogrammes

dotr_sort = dot(hr_sort-mean(hr_sort), hr_u-mean(hr_u))/(norm(hr_sort-mean(hr_sort)) * norm(hr_u-mean(hr_u)));
dotg_sort = dot(hg_sort-mean(hg_sort), hg_u-mean(hg_u))/(norm(hg_sort-mean(hg_sort)) * norm(hg_u-mean(hg_u)));
dotb_sort = dot(hb_sort-mean(hb_sort), hb_u-mean(hb_u))/(norm(hb_sort-mean(hb_sort)) * norm(hb_u-mean(hb_u)));

dotr_order = dot(hr_order-mean(hr_order), hr_u-mean(hr_u))/(norm(hr_order-mean(hr_order)) * norm(hr_u-mean(hr_u)));
dotg_order = dot(hg_order-mean(hg_order), hg_u-mean(hg_u))/(norm(hg_order-mean(hg_order)) * norm(hg_u-mean(hg_u)));
dotb_order = dot(hb_order-mean(hb_order), hb_u-mean(hb_u))/(norm(hb_order-mean(hb_order)) * norm(hb_u-mean(hb_u)));

disp(['Fonction sort {rouge: ', num2str(dotr_sort) ,', bleu: ', num2str(dotb_sort),', vert: ', num2str(dotg_sort),'}']); 
disp(['Fonction order {rouge: ', num2str(dotr_order) ,', bleu: ', num2str(dotb_order),', vert: ', num2str(dotg_order),'}']); 

%% Midway - sort

mid = (X + Y)/2;
X_mid = transport3D(X,mid, 1000, 0.01, 'def');
Y_mid = transport3D(Y,mid, 1000, 0.01, 'def');

w = reshape(X_mid,nr2,nc2,3);
w = min(max(w,0),255);
im_w = uint8(w);

figure();
imshow(im_w, []);
title('Midway 2 images - sort');

[hr_sort, hg_sort, hb_sort] = disp_histograms(w, 'Midway - sort');

%% Midway - order

mid = (X + Y)/2;
X_mid = transport3D(X,mid, 1000, 0.01, 'ord');
Y_mid = transport3D(Y,mid, 1000, 0.01, 'ord');

w = reshape(X_mid,nr2,nc2,3);
w = min(max(w,0),255);
im_w = uint8(w);

figure();
imshow(im_w, []);
title('Midway 2 images - order');

[hr_order, hg_order, hb_order] = disp_histograms(w, 'Midway - order');

%% Comparaison d'histogrammes

hr_target = (hr_u + hr_v)/2;
hg_target = (hg_u + hg_v)/2;
hb_target = (hb_u + hb_v)/2;

dotr_sort = dot(hr_sort-mean(hr_sort), hr_target-mean(hr_target))/(norm(hr_sort-mean(hr_sort)) * norm(hr_target-mean(hr_target)));
dotg_sort = dot(hg_sort-mean(hg_sort), hg_target-mean(hg_target))/(norm(hg_sort-mean(hg_sort)) * norm(hg_target-mean(hg_target)));
dotb_sort = dot(hb_sort-mean(hb_sort), hb_target-mean(hb_target))/(norm(hb_sort-mean(hb_sort)) * norm(hb_target-mean(hb_target)));

dotr_order = dot(hr_order-mean(hr_order), hr_target-mean(hr_target))/(norm(hr_order-mean(hr_order)) * norm(hr_target-mean(hr_target)));
dotg_order = dot(hg_order-mean(hg_order), hg_target-mean(hg_target))/(norm(hg_order-mean(hg_order)) * norm(hg_target-mean(hg_target)));
dotb_order = dot(hb_order-mean(hb_order), hb_target-mean(hb_target))/(norm(hb_order-mean(hb_order)) * norm(hb_target-mean(hb_target)));

disp(['Fonction sort {rouge: ', num2str(dotr_sort) ,', bleu: ', num2str(dotb_sort),', vert: ', num2str(dotg_sort),'}']); 
disp(['Fonction order {rouge: ', num2str(dotr_order) ,', bleu: ', num2str(dotb_order),', vert: ', num2str(dotg_order),'}']); 
