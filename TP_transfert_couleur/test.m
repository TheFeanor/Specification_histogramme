clear all; clc; close all;

%% Intro

imrgb  = imread('im/parrot.bmp');
[nrow,ncol,nchan]=size(imrgb);               
imshow(imrgb); %display the color image

%% Intro 2

u = double(imread('im/flower1.bmp'));  % use imread with Matlab
v = double(imread('im/flower2.bmp'));
[nr,nc,nch] = size(u);
figure(1);
im_u = uint8(u);
im_v = uint8(v);
imshow(im_u,[]);
figure(2)% imshow(u,[]) with Matlab
imshow(im_v,[]);


%% Separable affine transfer

w = affine_transfer(u,v);
w = min(max(w,0),255);
im_w = uint8(w);
imshow(im_w,[]);

%% Separable specification
w = specification_channels(u,v);
w = min(max(w,0),255);help            
im_w = uint8(w);
imshow(im_w,[]);

%% Affine transfer in a color space with decorrelated channels - part 1

O = [1/sqrt(3), 1/sqrt(3), 1/sqrt(3) ; 1/sqrt(2) -1/sqrt(2) 0; 1/sqrt(6) 1/sqrt(6) -2/sqrt(6)];
u_opp = reshape(reshape(u,nr*nc,3)*O',nr,nc,3);      % Matlab : replace 'matrix'  by 'reshape'
v_opp = reshape(reshape(v,nr*nc,3)*O',nr,nc,3);
%w_opp = affine_transfer(u_opp,v_opp);
w_opp = specification_channels(u_opp,v_opp);
w_opp = reshape(reshape(w_opp,nr*nc,3)*inv(O)',nr,nc,3);
w_opp = min(max(w_opp,0),255);
im_w_opp = uint8(w_opp);
imshow(im_w_opp, []);                                     % Matlab  : imshow

%% part 2 

LMS = [0.3811 0.5783 0.0402 ; 0.1967 0.7244 0.0782 ; 0.0241 0.1288 0.8444];
u_lms = log10(0.1+reshape(reshape(u,nr*nc,3)*LMS',nr,nc,3));
v_lms = log10(0.1+reshape(reshape(v,nr*nc,3)*LMS',nr,nc,3));
u_lab = reshape(reshape(u_lms,nr*nc,3)*O',nr,nc,3);
v_lab = reshape(reshape(v_lms,nr*nc,3)*O',nr,nc,3);
w_lab = affine_transfer(u_lab,v_lab);
%w_lab = specification_channels(u_lab,v_lab);
w_lms = reshape(reshape(w_lab,nr*nc,3)*inv(O)',nr,nc,3);
w_lms = reshape(reshape(exp(w_lms*log(10))-0.1,nr*nc,3)*inv(LMS)',nr,nc,3);
w_lms = min(max(w_lms,0),255);
im_w_lms = uint8(w_lms);
imshow(im_w_lms, []);

%% Sliced optimal transport
X = rand(20,3);
Y = rand(20,3);
Z = transport3D(X,Y,5000,0.01);

scatter3(X(:,1),X(:,2),X(:,3),'+');  % points of X are represented as +
hold on;
scatter3(Y(:,1),Y(:,2),Y(:,3),'x');  % points of Y are represented as x
hold on;
scatter3(Z(:,1),Z(:,2),Z(:,3),'o');  % points of Y are represented as o 

%% use for color transfer

u = u(1:4:nr,1:4:nc,:);
v = v(1:4:nr,1:4:nc,:);
[nr,nc,nch] = size(u);

X = reshape(u,nr*nc,3);
Y = reshape(v,nr*nc,3);

Z = transport3D(X,Y,1000,0.01);
w = reshape(Z,nr,nc,3);
w = min(max(w,0),255);
im_w = uint8(w);
imshow(im_w, []);

%% Midway

mid = (X + Y)/2;
X_mid = transport3D(X,mid, 5000, 0.01);
Y_mid = transport3D(Y,mid, 5000, 0.01);

figure(1)
w = reshape(X_mid,nr,nc,3);
w = min(max(w,0),255);
im_w = uint8(w);
imshow(im_w, []);

figure(2)
w = reshape(Y_mid,nr,nc,3);
w = min(max(w,0),255);
im_w = uint8(w);
imshow(im_w, []);

%% Regularisation

K = ones(5,5); K = K/sum(K);
for i=1:3
  wreg(:,:,i) = conv2(w(:,:,i), K, 'same');
end

wreg = min(max(wreg,0),255);
im_wreg = uint8(wreg);
imshow(im_wreg, []);

f = 2;
sigma = 0.5;

 b=crossed_filter(u,v,f,sigma);