function Z=transport3D(X, Y, N, e, type)  % X, Y and Z are  n x 3 matrices 
  Z = X;  
  for k=1:N

    % orthogonal basis, uniform distribution on the sphere
    u = randn(3,3);
    q = qr(u);

    % projection
    for j=1:3
      Zt = Z*q(:,j);
      Yt = Y*q(:,j);
      
      if type == 'ord'
          len = length(Yt);
          Yt2 = reshape(Yt, [sqrt(len), sqrt(len)]);
          Zt2 = reshape(Zt, [sqrt(len), sqrt(len)]);
          sY = order(Yt2);
          sZ = order(Zt2);
      else
          [sY,sZ] = transport1D(Yt, Zt);
      end
      
      Z(sZ, :) = Z(sZ, :) + e * (Yt(sY) - Zt(sZ))*q(:,j)';
    end
  end
end