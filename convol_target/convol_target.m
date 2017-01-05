function [II, hII] = convol_target(name, std, ratio)
    close all; clear all;
    xo = readimage(name);
    % see the image
    figure; im(xo)
    figure; imshow(uint8(xo), []); title('Image de départ');
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
    hb = hist(xx(:), 256); hb =b/sum(hb);

    % partie gaussienne
    L=1; R=0.05 ;
    hg = hsGauss(L,R);
    hg = hg/ sum(hg);

    % somme des deux
    H = ratio * hb + (1-ratio) * hg;

    figure;
    H=H/numel(I);
    figure;
    bar([0:1:255],h);xlim([0,255]);
    hold on; plot(H/sum(H)); axis('tight')

    % target intensity image
    [fx,Hx]=HistGrayMatch(H, m, n, idx);

    %figure;im(fx);

    % enhance the image
    II = chm_mult(xo,fx) ;figure;  im(II);title('Image finale');

    hII=hist(II(:),256); hII=hII/sum(hII));title('Histogramme final')
    bar([0:1:255],hII);xlim([0,255]);
end
