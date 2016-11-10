function [optionPrice, binPriceTree, binPayoffTree, amFormatMatrix] = binomPriceTree(optionType, initPrice, strike, volatility, years, interest, divYield, nPeriods)
    delta = (years/nPeriods);
    upFactor = exp(volatility*sqrt(delta));
    downFactor = exp(-volatility*sqrt(delta));
    
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
    %first figure out what type of option we're dealing with
    put = strcmpi(optionType, 'a put')||strcmpi(optionType, 'e put');
    call = ~put;
    american = strcmpi(optionType, 'a put')||strcmpi(optionType, 'a call');
    european = ~american;
    
    binPayoffTree = zeros(nPeriods+1, nPeriods+1);
    
    for i = 1:nPeriods+1
        j = nPeriods+1;
        if(call)
            binPayoffTree(i,j) = max(binPriceTree(i,j)-strike,0);
        else
            binPayoffTree(i,j) = max(strike - binPriceTree(i,j),0);
        end
    end
    

    amFormatMatrix = zeros(nPeriods+1, nPeriods+1);
    
    
    for j = nPeriods:-1:1
        for i = 1:j
            expPayoff = computesteppayoff(binPayoffTree(i,j+1), binPayoffTree(i+1, j+1), interest,divYield, delta,upFactor,downFactor);
            earlyPayoff = 0;
            if(american)
                if(call)
                    earlyPayoff = binPriceTree(i,j) - strike;
                else
                    earlyPayoff = strike - binPriceTree(i,j);
                end
            end
            binPayoffTree(i,j) = max(expPayoff,earlyPayoff); %earlyPayoff is only >0 if american
            if(binPayoffTree(i,j) == earlyPayoff && american)
                amFormatMatrix(i,j) = 1;
            end
        end
    end
    
    optionPrice = binPayoffTree(1,1);
    