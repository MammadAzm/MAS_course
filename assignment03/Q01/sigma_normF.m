function sigma_norm = sigma_normF(z, epsilon)
    sigma_norm = (epsilon^(-1))*(sqrt(1 + epsilon*(euclidean_dist(z))^2) - 1);
end