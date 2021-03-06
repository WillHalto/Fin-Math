function [mu,sigma] = learnGBMparams(prices)
%compute the paramters of a geometric brownian motion from log returns on
%a single column of daily stock prices
   %assume we want GBM for annualized returns - 252 days
   delta_t = 1/252;
   
   %calculate log returns for each day
   logReturns = zeros(size(prices,1)-1,1);
   for i = 2:size(prices,1)
    logReturns(i-1) = log(prices(i)/prices(i-1));
   end
   
   sample_var = var(logReturns);
   sample_mean = mean(logReturns);
   
   %calculate sigma first, since its needed for mu
   sigma = sqrt(sample_var/delta_t);
   mu = sample_mean/delta_t + .5*sigma*sigma;


end

