function grad = gradK(u, lambda)

grad = zeros(size(lambda));

L = u(1); R = u(2);

grad(1) = -L;
grad(2) = L-1;
grad(3) = -R;
grad(4) = R-1;
grad(5) = R+L-1.5;
grad(6) = 0.2-R-L;

end

