function set_my_line_styles(style, thickness)
    e = gce();
    e.children.line_style = style;
    e.children.thickness = thickness;
endfunction

// n changed to universal range to fit both signal
n = -1:3;

// signal with padded 0
x1 = [0, 0, 1, 3, -2];
x2 = [0, 1, 2, 3,  0];

y = x1 + x2;

subplot(3, 1, 1);
plot2d3(n, x1)
set_my_line_styles(1, 3);
xgrid();
title("Original x1(n) signal");
xlabel("n");
ylabel("x1(n)");

subplot(3, 1, 2);
plot2d3(n, x2)
set_my_line_styles(1, 3);
xgrid();
title("Original x2(n) signal");
xlabel("n");
ylabel("x2(n)");

subplot(3, 1, 3);
plot2d3(n, y)
set_my_line_styles(1, 3);
xgrid();
title("y(n) signal");
xlabel("n");
ylabel("y(n)");
