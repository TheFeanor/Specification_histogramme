cd ../code;
addpath('../convol_target/');
name = 'Malta';
std = 8; % écart-type du bruit
% ratio*hb + (1-ratio) * hg
%hb :hist bruit, hg : hist gaussien
ratio = 0.90; 

%[I, h] = convol_target(name, std, ratio);

%close all; clear all;
    xo = readimage('Malta');
    % see the image
    figure; im(xo);title('Image de départ');
    % color-to-gray
    Io=sum(xo,3)/3; im(Io);

    % stretch on [0,255]
    I=stretch(Io) ;

    % nomalized histogram of I
    h=hist(I(:),256); h=h/sum(h);
    % figure;
    % bar([0:1:255],h);xlim([0,255]);

    % order the pixel values using minimization code fixedLogs4sortIt
    idx = order(I);
    [m,n]= size(I);

    % target histogram
    % partie 'bruit'
    xx = I + std * randn(m,n);
    hb = hist(xx(:), 256); hb =hb/sum(hb);

    % partie gaussienne
    L=1; R=0.2 ;
    hg = hsGauss(L,R);
    hg = hg'/ sum(hg);

    % somme des deux
    H = ratio * hb + (1-ratio) * hg;

%     figure;
%     H=H/numel(I);
%     figure;
%     bar([0:1:255],H);xlim([0,255]); axis('tight')

    % target intensity image
    [fx,~]=HistGrayMatch(H, m, n, idx);

    %figure;im(fx);

    % enhance the image
    II = chm_mult(xo,fx) ;figure;  im(II);title(sprintf('Image finale, ratio: %1.1d, std: %2.0d', ratio, std));
    
    figure;
    hII=hist(II(:),256); hII=hII/sum(hII);title('Histogramme final')
    bar([0:1:255],hII);xlim([0,255]);

    %% ajouter des pixels aux zones pauvres
    
    