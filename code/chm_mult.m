function [x,er] = chm_mult(y,Ir,L,C,ran);
% Mila Nikolova, Sep 14, 2014, nikolova@cmla.ens-cachan.fr
%
% y input color image 
% Ir target intensity image
% C=0  gray image = 1/3 (R + G + B)
% C=1  gray iamge = 0.299 R + 0.587 G + 0.114 B
% ran =1 - display output range ; default ran=0
% x - output color image, luminance component with histogram H
% multiplicative color assignement + corrections
% er.Ix=reshape(I,m,n); Intensity of x
% er.I=reshape(Ir,m,n); Gray image with histogram H
% er.C1=100*C1/mn;      % pixels with gamut after 1st step
% er.Htrue=HS(:);       % true matched histogram
% er.HS=erHS;           % number of pixels fail target histogram
% er.C2=C2;             % number negative pixels ( 0 in theory) 
% 
%[x,er] = chm_mult(y,H,C,idx,ran);

if nargin<3; L=255; C=0; ran=0; end
if nargin <5; ran=0; end
to=1e-12;
R=y(:,:,1); G=y(:,:,2); B=y(:,:,3);  [m,n]=size(R); mn=numel(R);
% ------------------------------------------------
if nargin<4; C=0;ran=0;  end
if C==0; I=sum(y,3)/3; 
elseif C==1; C=[0.299 0.587 0.114];
         I=C(1)*y(:,:,1)+C(2)*y(:,:,2)+C(3)*y(:,:,3);
end
% -----------------------------------------------------
M=max(y,[],3);  M=M(:);   R=R(:);     G=G(:);     B=B(:);         
% -----------------------------------------------------
S=find(I(:)>0);
al=zeros(mn,1);al(S)=Ir(S)./I(S);
r=R.*al;   g=G.*al;   b=B.*al;
% --------------------------------------------
S=find(I==0);
r(S)=Ir(S); g(S)=Ir(S);  b(S)=Ir(S);
% --------------------------------------------
S=find(al.*M > L+to);  C1=length(S);

if C1>0 ;disp(['   % pixels > ',int2str(L),' : ', num2str(100*C1/mn), '  => correction']);end
% --------------------------------------------
al(S)=(L-Ir(S))./(M(S)-I(S));

r(S)=al(S).*(R(S)-I(S))+Ir(S);
g(S)=al(S).*(G(S)-I(S))+Ir(S);
b(S)=al(S).*(B(S)-I(S))+Ir(S);
%---------------------------------------------
%lr=sum(r>L+to); lg=sum(g>L+to); lb=sum(b>L+to); 
C2=sum(r<-to)+sum(g<-to)+sum(b<-to); 
%disp(['   after correction => # pixels < 0 : ', int2str(C2),'   # pixels > ',sL,' : ',int2str(lr+lg+lb)])
if ran==1
mir=num2str(min(r),4);mar=num2str(max(r),4);
mig=num2str(min(g),4);mag=num2str(max(g),4);
mib=num2str(min(b),4);mab=num2str(max(b),4);
disp(['   =>  R in [',mir,' ',mar,']  G in [',mig,' ',mag,']  B in [',mib,' ',mab,']']);
end
x = cat(3, reshape(r,m,n), reshape(g,m,n), reshape(b,m,n));

er.Ixo=reshape(I,m,n);
er.Ix=reshape(Ir,m,n);
er.C1=100*C1/mn;
er.C2=C2; 
er.al=reshape(al,m,n);
er.C=C;

% Algorithm 4 "Multiplicative Color Enhancement" in 
% Nikolova & Steidl, "Fast Hue and Range Preserving Histogram Specification: 
% Theory and New Algorithms for Color Image Enhancement
% IEEE Trans. Image Process. 23(9), 2014, pp. 4087 - 4100
% see also http://mnikolova.perso.math.cnrs.fr/hs_color_final_tip_14_hal.pdf
