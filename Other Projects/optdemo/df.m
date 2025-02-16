function y = df(x)
  d = .001;
  y = (f(x+d)-f(x))./d;
end
