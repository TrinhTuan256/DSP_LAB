// Given discrete signals of length N = 5
x = [1, 2, -3, 2, 1];
h = [1, 0, -1, -1, 1];
N = length(x);
n_axis = 0:(N - 1);


// y(n) = sum_{k=0}^{N-1} h(k) * x((n - k) mod N)
y_circ_fold = zeros(1, N);

for n = 0:(N - 1)
    val = 0;
    for k = 0:(N - 1)
        idx = pmodulo(n - k, N) + 1; // 1-based index in Scilab
        val = val + h(k + 1) * x(idx);
    end
    y_circ_fold(n + 1) = val;
end


// Energy Calculation


Ex_inst = x.^2;
Eh_inst = h.^2;
Ey_inst = y_circ_fold.^2;

Ex_total = sum(Ex_inst);
Eh_total = sum(Eh_inst);
Ey_total = sum(Ey_inst);


// Plotting: x(n), y(n), and Energy of Discrete Signals


clf();
subplot(3, 1, 1);
plot2d3(n_axis, x, 2);
plot(n_axis, x, "r*");
xtitle("Periodic Signal x(n) = [1, 2, -3, 2, 1]", "n", "x(n)");
xgrid();

subplot(3, 1, 2);
plot2d3(n_axis, y_circ_fold, 3);
plot(n_axis, y_circ_fold, "g*");
xtitle("Convolution Output y(n) = [4, -4, -3, 0, 3]", "n", "y(n)");
xgrid();

subplot(3, 1, 3);
plot2d3(n_axis, Ex_inst, 5);
plot(n_axis, Ex_inst, "m*");
plot2d3(n_axis, Ey_inst, 6);
plot(n_axis, Ey_inst, "b*");
legend(["x(n) Energy", "", "y(n) Energy", ""]);
xtitle(" Energy signal result", "n", "Energy");
xgrid();
