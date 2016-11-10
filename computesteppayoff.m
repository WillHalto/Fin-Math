%gets the expected payoff value for a single step in a binomial tree
%pricing model given the next possible prices
function stepPayoff = computesteppayoff(upPayoff, downPayoff, interest, divYield, delta, u, d)

    p = (exp((interest-divYield)*delta) - d)/(u-d);
    stepPayoff = exp(-interest*delta) * (p*upPayoff + (1-p)*downPayoff);  