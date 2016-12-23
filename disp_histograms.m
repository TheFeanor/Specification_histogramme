function [h_r, h_g, h_b] = disp_histograms(img, name)
    img_r = img(:, :, 1);
    img_g = img(:, :, 2);
    img_b = img(:, :, 3);

    h_r = hist(img_r(:),256); h_r = h_r/numel(img);
    h_g = hist(img_g(:),256); h_g = h_g/numel(img);
    h_b = hist(img_b(:),256); h_b = h_b/numel(img);
    
    figure();
    subplot(3,1,1);
    bar([0:1:255],h_r);xlim([0,255]);
    title([name ' - Rouge']);
    subplot(3,1,2);
    bar([0:1:255],h_g);xlim([0,255]);
    title([name ' - Vert']);
    subplot(3,1,3);
    bar([0:1:255],h_b);xlim([0,255]);
    title([name ' - Bleu']);
    
end

