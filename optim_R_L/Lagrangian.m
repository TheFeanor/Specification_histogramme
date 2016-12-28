function Lag = Lagrangian(target, L, R, lambda)

g = zeros(size(lambda), 'gpuarray');
g(1) = -L;
g(2) = L-1;
g(3) = -R;
g(4) = R-1;
g(5) = R+L-1; % on ne veut pas du cas histogramme constant
g(6) = 0.2-R-L;
h= hsGauss(L, R);
h = h/sum(h);
target = target/sum(target);
Lag = 0.5*norm(target-h)^2 + lambda * g';

end

