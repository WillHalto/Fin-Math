function [d1,d2] = calculateDs(delta_t, sigma, K,r,S)
    d1 = 1/(sigma*sqrt(delta_t))*(log(S/K)+(r+sigma*sigma/2)*delta_t);
    
    d2 = d1 - sigma*sqrt(delta_t);
end