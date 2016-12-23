function b=crossed_filter(u,u0,f,sigma)
    % the goal is to regularize u0 following the regularity of u 
    [nrow,ncol]=size(u);
        
    for i=1:nrow
        for j=1:ncol
         % Extract a neighborhood of (i,j) 
         iMin = max(i-f,1);
         iMax = min(i+f,nrow);
         jMin = max(j-f,1);
         jMax = min(j+f,ncol);
         v = u(iMin:iMax,jMin:jMax,:);
         v0 = u0(iMin:iMax,jMin:jMax,:);
         % Compute gaussian weights 
         for k = iMin:IMax
             for l = jMin:jMax
                 w(k,l) = exp(-norm(u(i,j) - u(k,l))^2/sigma);
             end
         end
         c = sum(sum(w, 1));
         % Compute the filtered image at (i,j) 
        b(i,j) = 1/c * dot(v0(:), w(:));
        end
    end
end