function gradientdescent(w0,ntrials,eta)
w = w0;
w_star = w;
optval = f(w);
fprintf("%5i  w* = %10f,  val = %10f\n",0,w_star,optval)
if nargin<2
    ntrials=100;
end
if nargin<3
    eta = 1;
end
for i=1:ntrials
    G = df(w);
    delta_w = -eta*G;
    w = w + delta_w;
    while w > 10 || w < 0
        G = df(w);
        delta_w = -eta*G;
        w = w + delta_w;
    end
    objval = f(w);
    if objval < optval
        w_star = w;
        optval = objval;
        fprintf("%5i  w* = %10f,  val = %10f\n",i,w_star,optval)
    end
    if abs(G)<1e-3
        fprintf("Converged\n");
        return
    end
end