function F_new = color_specification_affine(F,F_L,F_L_new,alpha);
%0:255 L values
%F color image
%F_L original gray image (e.g. luminance)
%F_L_new histogram specified gray image (e.g. luminance)
%alpha: in [0,1], where 0 additive model and 1 multiplicative model
%
% Algorithm 3 "Optimal Range-Preserving Enhancement" in 
% Nikolova & Steidl, "Fast Hue and Range Preserving Histogram Specification: 
% Theory and New Algorithms for Color Image Enhancement
% IEEE Trans. Image Process. 23(9), 2014, pp. 4087 - 4100
% see also http://mnikolova.perso.math.cnrs.fr/hs_color_final_tip_14_hal.pdf
%

F_new = F;

%old colors
R = F(:,:,1);
G = F(:,:,2);
B = F(:,:,3);

[m,n] = size(R);

%minima and maxima
mm = min(R,G);
mm = min(mm,B);
M = max(R,G);
M = max(M,B);

%new colors
VR = zeros(size(F_L));
VG = zeros(size(F_L));
VB = zeros(size(F_L));

%Case 1 
VR(F_L == M) = F_L_new(F_L == M);
VG(F_L == M) = F_L_new(F_L == M);
VB(F_L == M) = F_L_new(F_L == M);

VR(F_L == mm) = F_L_new(F_L == mm);
VG(F_L == mm) = F_L_new(F_L == mm);
VB(F_L == mm) = F_L_new(F_L == mm);

%Case 2
a = ones(size(F_L));
a(F_L>0) = (alpha*F_L_new(F_L>0) + (1-alpha)*F_L(F_L>0))./F_L(F_L>0);

GM = a.*(M-F_L) + F_L_new;
IM = (GM>255+1e-13);

Gm = a.*(mm-F_L) + F_L_new;
Im = (Gm<-1e-13);

I = (Gm >= 0 | GM <=255);

%Case 2i
VR(I == 1) = a(I == 1) .*(R(I == 1)  - F_L(I == 1) ) + F_L_new(I == 1) ;
VG(I == 1)  = a(I == 1) .*(G(I == 1)  - F_L(I == 1) ) + F_L_new(I == 1) ;
VB(I == 1)  = a(I == 1) .*(B(I == 1)  - F_L(I == 1) ) + F_L_new(I == 1) ;

%case 2ii
aM = ones(size(F_L));
aM(IM == 1) = (255 - F_L_new(IM == 1))./(M(IM == 1) - F_L(IM == 1));

VR(IM == 1) = aM(IM==1).*(R(IM==1) - F_L(IM==1))  + F_L_new(IM==1);
VG(IM == 1) = aM(IM==1).*(G(IM==1) - F_L(IM==1))  + F_L_new(IM==1);
VB(IM == 1) = aM(IM==1).*(B(IM==1) - F_L(IM==1))  + F_L_new(IM==1);

%case 2iii
am = ones(size(F_L));
am(Im == 1) =  F_L_new(Im == 1)./(F_L(Im == 1)-mm(Im == 1));

VR(Im == 1) = am(Im==1).*(R(Im==1) - F_L(Im==1))  + F_L_new(Im==1);
VG(Im == 1) = am(Im==1).*(G(Im==1) - F_L(Im==1))  + F_L_new(Im==1);
VB(Im == 1) = am(Im==1).*(B(Im==1) - F_L(Im==1))  + F_L_new(Im==1);

%final result
F_new(:,:,1) = VR;
F_new(:,:,2) = VG;
F_new(:,:,3) = VB;



