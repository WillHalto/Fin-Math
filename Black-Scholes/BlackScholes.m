function price = BlackScholes(sigma, delta_t, K,r,S) %black scholes european call price
    
    [d1,d2] = calculateDs(delta_t, sigma, K,r,S);
    price = -(normcdf(d2))*K*exp(-r*delta_t)+(normcdf(d1))*S;

end