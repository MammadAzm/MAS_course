function nij = nijF(qi, qj, epsilon)
    dist = euclidean_dist(qj-qi);
    nij = (qj-qi)/(sqrt(1 + epsilon*(dist^2)));
end