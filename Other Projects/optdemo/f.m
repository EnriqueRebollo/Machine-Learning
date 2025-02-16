function y = f(x)
  xpol = 3*(x-5).^2+.4*(x-5).^3;
  y = log(xpol+1./(1+exp(-2*x))+1.5);
end
