n = -5:5;
zero_check = bool2s(n >= 0);
msignal = n.*zero_check;
plot2d3(n, msignal)
