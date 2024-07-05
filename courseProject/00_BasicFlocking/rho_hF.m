function rho_h = rho_hF(z, h)
    if z>0 && z<h
        rho_h = 1;
    elseif z>h && z<1
        rho_h = 0.5*(1 + cos(pi*(z-h)/(1-h)));
    else
        rho_h = 0;
    end
end