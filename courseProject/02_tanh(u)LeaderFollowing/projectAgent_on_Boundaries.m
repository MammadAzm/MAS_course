function qhat = projectAgent_on_Boundaries(qi, boundary)
    qhat = [qi(1); boundary(2)];
end