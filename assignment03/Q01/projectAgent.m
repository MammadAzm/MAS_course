function qhat = projectAgent(qi, obs_center, Rk)
    muu = Rk/(euclidean_dist(qi-obs_center));
%     qhat = muu*qi + (eye(2) - muu)*obs_center;
    qhat = muu*qi + (1 - muu)*obs_center;
end