clear all;
p=[4 4 2 1 3 1 1]/16;
%p=[2 2 3 3 2 2 1 1]/16;

sum(p)

lp=log2(p);

en=-sum(p.*lp)

