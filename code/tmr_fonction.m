function [ output ] = tmr_fonction( u, g_u, r, sigma )
%calculate the TMR of an image
[m,n] = size(u);
patch_size = 2*r + 1;
C = patch_size^2;
big_u = get_big_image(u);
big_g_u = get_big_image(g_u);

output = zeros(m,n);

for i = m+1:2*m
    for j = n+1:2*n
        patch_g_u = big_g_u(i-r:i+r,j-r:j+r);
        patch_u = big_u(i-r:i+r,j-r:j+r);
        exponential = exp(-abs(patch_u-big_u(i,j)).^2/(sigma^2));
        output(i-m,j-n) = 1/C*dot(patch_g_u(:),exponential(:));
    end
end










end

