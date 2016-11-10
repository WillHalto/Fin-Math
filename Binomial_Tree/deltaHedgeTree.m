%assumes and long only stock
function [deltaTree, payoffTree] = deltaHedgeTree(stocktree, optiontree, N,interest) %two N+1 by N+1 matrices where N is # of time periods
    deltaTree = zeros(N+1,N+1);
    payoffTree = zeros(N+1,N+1);
    
    for j = 1:N
        for i = 1:j
            deltaTree(i,j) = (optiontree(i,j+1) - optiontree(i+1,j+1))/(stocktree(i,j+1) - stocktree(i+1,j+1));
        end
    end
    
    for i = 1:(N+1)
        deltaTree(i,N+1) = 0;
    end
    
    
    %now calculate payoff tree assuming long only stock
    
    payoffTree(1,1) = -stocktree(1,1)*deltaTree(1,1);
    for j = 1:N
        for i = 1:j
            payoffTree(i,j+1) = payoffTree(i,j)*exp(interest/N);
            payoffTree(i+1,j+1) = payoffTree(i,j)*exp(interest/N);
%             if(i < N+1 && i > 1) %use the empty cells in the matrix to hold alternate payoffs
%                 row = N+1-(j-i-1);
%                 col = N+1-(j-2);
%                 payoffTree(row,col) = payoffTree(i-1,j-1)*exp(interest/N);
%             end            
        end
    end
    
    
    
    
    