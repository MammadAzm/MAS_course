function phi_alpha = phi_alphaF(z, r_a, d_a, h_a, h_b, a, b)
    rho_h = rho_hF(z/r_a, h_a);
    phi = phiF(z-d_a, a, b);
    phi_alpha = (rho_h)*(phi);
end