%takes in matrices containing the information for price tree and exp payoff
%tree, and generates a plot
function p = binomPriceTreePlot(bPriceTree, bValueTree, N, amFormat)
    %parse coordinates as X = column, Y = price
    hold on;
    
    yr = bPriceTree(1, N+1)-bPriceTree(N+1, N+1);
    for x = 1:N+1
        for j = 1:x
            y = bPriceTree(j,x);
            if(x <= N)
                yu = bPriceTree(j,(x+1));
                yd = bPriceTree(j+1,(x+1));
                plot([x,x+1], [y,yu],'b');
                plot([x,x+1], [y,yd],'b');
            end
            if(amFormat(j,x) == 1)
                scatter(x, y,'filled', 'rd');
            else
                scatter(x, y,'filled', 'bd');
            end
            %label our points with the exp value at that point
            dx = -0.05;
            dy = -.03*yr;
            value = round(bValueTree(j,x),2);
            strV = num2str(value);
            dx = dx - 0.006*(N+1)*(length(strV)-1);
            text(x+dx, y+dy,strV);
        end
    end
    hold off;
    
    
    
    
    