-module(norm_number_crash).
-export([f/1]).
f(I) when I < 1 bsl 1100 -> I;
f(I) -> g(I).
g(0) -> 0;
g(I) -> g(I div 3).
