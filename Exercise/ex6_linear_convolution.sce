// ==============================================================================
// Given discrete signals:
// x(n) with origin at index 1 (n = 0)
x = [1, 2, -3, 2, 1];
nx = 0:4;

// h(n) with origin at index 1 (n = 0)
h = [1, 0, -1];
nh = 0:2;

// Output time index range:
n_start = min(nx) + min(nh); // 0 + 0 = 0
n_end = max(nx) + max(nh);     // 4 + 2 = 6
ny = n_start:n_end;
Ly = length(ny);

// -----------------------------------------------------------------------------
// Method 1: Folding and Shifting
// y(n) = sum_{k} x(k) * h(n - k)
// -----------------------------------------------------------------------------
y_fold = zeros(1, Ly);

for i = 1:Ly
    n_val = ny(i);
    sum_val = 0;
    for k_idx = 1:length(x)
        k = nx(k_idx);
        h_idx = find(nh == (n_val - k));
        if ~isempty(h_idx) then
            sum_val = sum_val + x(k_idx) * h(h_idx);
        end
    end
    y_fold(i) = sum_val;
end

// -----------------------------------------------------------------------------
// Method 2: Matrix Method (Toeplitz Convolution Matrix)
// y = H * x
// -----------------------------------------------------------------------------
Lx = length(x);
Lh = length(h);
H = zeros(Ly, Lx);

for col = 1:Lx
    H(col : col + Lh - 1, col) = h(:);
end

y_matrix = (H * x(:))';

// Verification using Scilab built-in convol()
y_builtin = convol(h, x);
disp("3. Scilab built-in convol() verification:");
disp(y_builtin);

// -----------------------------------------------------------------------------
// Energy Calculation
// -----------------------------------------------------------------------------
// Instantaneous energy: |s(n)|^2
Ex_inst = x.^2;
Eh_inst = h.^2;
Ey_inst = y_fold.^2;

// Total energy:
Ex_total = sum(Ex_inst);
Eh_total = sum(Eh_inst);
Ey_total = sum(Ey_inst);

// -----------------------------------------------------------------------------
// Plotting: x(n), y(n), and Energy of Discrete Signals
// -----------------------------------------------------------------------------

clf();
subplot(3, 1, 1);
plot2d3(nx, x, 2);
plot(nx, x, "r*");
xtitle("Input Signal x(n) = [1, 2, -3, 2, 1]", "n", "x(n)");
xgrid();

subplot(3, 1, 2);
plot2d3(ny, y_fold, 3);
plot(ny, y_fold, "g*");
xtitle("Linear Convolution Output y(n) = [1, 2, -4, 0, 4, -2, -1]", "n", "y(n)");
xgrid();

subplot(3, 1, 3);
plot2d3(nx, Ex_inst, 5);
plot(nx, Ex_inst, "m*");
plot2d3(ny, Ey_inst, 6);
plot(ny, Ey_inst, "b*");
legend(["x(n) Energy", "", "y(n) Energy", ""]);
xtitle("Energy", "n", "Energy");
xgrid();
