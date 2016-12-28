function u = minLagrangian(target, u0, lambda0, rho, n)
u = u0;
lambda=  lambda0;
eps = 1e-6;
grad = zeros(size(u0));

for k=1:n
    grad(1) = (Lagrangian(target, u(1)+eps, u(2), lambda) - Lagrangian(target, u(1), u(2), lambda))/eps;
    grad(2) = (Lagrangian(target, u(1), u(2)+eps, lambda) - Lagrangian(target, u(1), u(2), lambda))/eps;
    u(1) = proj(u(1) - rho(k)*grad(1));
    u(2) = proj(u(2) - rho(k)*grad(2));
end

end

