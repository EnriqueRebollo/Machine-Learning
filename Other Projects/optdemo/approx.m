color1 = [ 0, .5, 0.8 ];
color2 = [ .8, 0.5, 0 ];
color3 = [ .3, .7, 0 ];
color4 = [ .5, 0, .8 ];
mainwidth = 2.5;
approxwidth = 1.5;
approxstyle = ':';
x = 0:.05:10;
plot(x,f(x),'Color',color1,'LineWidth',2)
axis([min(x), max(x), min(0,min(f(x)*1.1)), 1.1*max(f(x))])
grid on
hold on
% plot(x,df(x))
% plot(x,d2f(x))

deg = 2;

% Taylor approx, 1st point
x0=2;
plot(x,taylor(x,x0,deg),approxstyle,'Color',color2,'linewidth',approxwidth)
plot(x0,f(x0),'o','markersize',10,'linewidth',2,'color', color2)

% Taylor approx, 2nd point
x0=5;
plot(x,taylor(x,x0,deg),approxstyle,'Color',color3,'linewidth',approxwidth)
plot(x0,f(x0),'o','markersize',10,'linewidth',2,'color', color3)

% Taylor approx, 3rd point
x0=7;
plot(x,taylor(x,x0,deg),approxstyle,'Color',color4,'linewidth',approxwidth)
plot(x0,f(x0),'o','markersize',10,'linewidth',2,'color', color4)
hold off


function y = taylor(x,x0,deg)
  y = f(x0)*ones(size(x));
  if deg>0
      y = y+df(x0)*(x-x0);
  end
  if deg>1
      y = y+.5*d2f(x0)*(x-x0).^2;
  end
end