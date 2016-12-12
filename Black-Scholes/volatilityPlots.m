
%got this data from yahoo finance 
%format is [strike, price, implied volatility]
calls = [2250,36.75,.1095;
         2275,23.15,.1019;
         2300,12.69,.0969];
     
puts = [2100,5.00,.1645;
        2150,7.95,.1454;
        2200,14.45,.1269];
    
delta_t = 29/252;

S = 2259.53;
%K = 2250;
r = .005;

hold on;
plotvec = zeros(6,2);
for i = 1:3
    K = calls(i,1);
    K2 = puts(i,1);
    p = calls(i,2);
    p2 = puts(i,2);
    fun = @(sigma) BlackScholes(sigma,delta_t,K,r,S)-p;
    fun2 = @(sigma2) BlackScholes_Put(sigma2,delta_t,K2,r,S)-p2;
    sigma = fzero(fun,.1);
    sigma2 = fzero(fun2,.1);
    plotvec(i+3,:) = [K,sigma];
    plotvec(i,:) = [K2,sigma2];
    plot(K,sigma,'b*') %blue is for call implied volatilities
    plot(K2,sigma2,'r*') %red is for put implied volatilities
end

plot(plotvec(:,1),plotvec(:,2))
