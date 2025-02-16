function y = d2f(x)
  d = .001;
  y = (df(x+d)-df(x))./d;
end
