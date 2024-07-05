function output = formAdjacency(qi, qj, r_a, h_a, epsilon)
    z = sigma_normF(qj-qi, epsilon);
    z = z/r_a;
    output = rho_hF(z, h_a);
end
