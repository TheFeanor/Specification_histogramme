function w = affine_transfer(u,v)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

N = size(u,1);
mean_u = zeros(1,3);
std_u = zeros(N,1,3);

w = zeros(length(v),3);

for i =1:3
    
    % calcul de la moyenne de u
    means = mean(u(:,:,i));
    mean_u(1,i) = mean(means);
    
    % calcul de la variance de u
    stds = std(u(:,:,i));
    std_u(:,1,i) = stds(:);
    
    for k=1:N
        v_norm = (v(:,k,i) - mean(v(:,k,i)))/std(v(:,k,i));
        w(:,k,i) = std_u(k,1,i) * v_norm + means(k);
    end
end

end

