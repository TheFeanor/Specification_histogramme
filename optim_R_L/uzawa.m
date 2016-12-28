function [u, lambda] = uzawa(target, u0, lambda0, N, n)

u = zeros(N+1, 2);
u(1,:) = u0;
lambda = lambda0;
grad = gradK(u0, lambda0);
%rho = 5e-3 * ones(N);
rho = 5e-3*ones(1,N) ./ (1:N);

for k =1:N
    lambda = (lambda + rho(k) * grad) .* (lambda + rho(k)*grad > 0);
    grad = gradK(u(k,:), lambda);
    u(k+1, :) = minLagrangian(target, u(k,:), lambda, rho, n);
end

figure; plot(1:N+1, u(:,1)');
hold on; plot(1:N+1, u(:,2)', 'g');