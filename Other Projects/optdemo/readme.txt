approx      plots an objective function, calculates the Taylor
            polynomial of order deg (you can set it to 0, 1, 2)
            and plots it around three points (you can set them
            to any value between 0 and 10)

directsearch(x0, niter, eta)
            search with random steps in [-eta, eta] for niter
            iterations starting from point x0

gradientdescent(x0, niter, eta)
            search with gradient descent steps with learning rate eta
            for at most niter iterations starting from point x0 and
            stopping when |gradient| < 10e-3

f(w)        zeroth-order oracle (returns value of f at w)

df(w)       first-order oracle (returns value of f' at w)

d2f(w)      second-order oracle (returns value of f'' at w)