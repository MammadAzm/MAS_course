function phat = projectAgent_p(qi, pi, obs_center, Rk)
    mu = Rk/euclidean_dist(qi-obs_center);
    a_k = (qi-obs_center)/euclidean_dist(qi-obs_center);
    P = eye(2) - a_k*transpose(a_k);
    phat = mu*P*pi;
end
