function [optionPrice, binPriceTree, binPayoffTree] = buildBinomPriceTree(initPrice, volatility, nPeriods, strike, interest)
    delta = (1/nPeriods);
    upFactor = 1 + volatility*delta;
    downFactor = 1-volatility*delta;
    
    %implement the tree using the upper diagonal of a matrix
    binPriceTree = zeros(nPeriods+1, nPeriods+1);
    binPriceTree(1,1) = initPrice;
    
    for j = 2:nPeriods+1
        binPriceTree(1,j) = binPriceTree(1,j-1)*upFactor;
        for i = 2:j
            binPriceTree(i,j) = binPriceTree(i-1,j-1)*downFactor;
        end
    end
    
    %build the tree for expected option value at each period
    %first calculate some necessary constants
    r = interest *delta;
    p = (exp(r*delta) - downFactor)/(upFactor-downFactor);
    
    binPayoffTree = zeros(nPeriods+1, nPeriods+1);
    
    for i = 1:nPeriods+1
        j = nPeriods+1;
        binPayoffTree(i,j) = max(binPriceTree(i,j)-strike,0);
    end
    
    for j = nPeriods:-1:1
        for i = 1:j
            binPayoffTree(i,j) = computesteppayoff(p, binPayoffTree(i,j+1), binPayoffTree(i+1, j+1), interest,delta);
        end
    end
    
    optionPrice = binPayoffTree(1,1);
    