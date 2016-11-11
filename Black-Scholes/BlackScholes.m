function price = BlackScholes(delta_t, sigma, K,r,S)
    
    [d1,d2] = calculateDs(delta_t, sigma, K,r,S);
    price = normcdf(d1)*S-normcdf(d2)*K*exp(-r*delta_t);

end