function phi_beta = phi_betaF(z, r_a, d_b, h_b, a, b)
    rho_h = rho_hF(z/d_b, h_b);
    phi_beta = (rho_h)*(sigma_1F(z-d_b) - 1);
end