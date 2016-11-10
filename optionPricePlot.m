function optionPricePlot(optionType, initPrice, strike, volatility, years, interest, divYield, nPeriodStart, nPeriodStop)
    
    hold on;
    even = mod(nPeriodStart,2);
    p1 = binomPriceTree(optionType, initPrice,strike,volatility, years, interest, divYield, nPeriodStart);
    p2 = 0;
    for n = nPeriodStart:nPeriodStop
        if(n < nPeriodStop)
            if(mod(n,2) == even) %p1 is current node price, p2 will be used to store next
                p2 = binomPriceTree(optionType, initPrice,strike,volatility, years, interest, divYield, n+1);
            else %we are at a node where p2 is the current price, use p1 to store the next price
                p1 = binomPriceTree(optionType, initPrice,strike,volatility, years, interest, divYield, n+1);
            end
        end
        p = (p1+p2)/2;
        %uncomment this line to not take pairwise price averages. Comment
        %everything above.
        pp = binomPriceTree(optionType, initPrice,strike,volatility, years, interest, divYield, n);
        scatter(n,pp,'r*');
        scatter(n,p,'b*');
    end
    hold off;