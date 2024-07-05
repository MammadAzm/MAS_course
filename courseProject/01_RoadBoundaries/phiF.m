function phi = phiF(z,a,b)
    c = (a - b) / sqrt(4 * a * b);
    sig1 = sigma_1F(z+c);
    phi = 0.5*( (a+b)*sig1 + (a-b) );
end