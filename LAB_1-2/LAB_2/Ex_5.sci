function set_my_line_styles(style, thickness)
    e = gce();
    e.children.line_style = style;
    e.children.thickness = thickness;
endfunction

n = -1:1;
x = [1, 3, -2];
x_folded = flipdim(x, 2);

xo = 1/2*(x - x_folded);
xe = 1/2*(x + x_folded);

subplot(3, 1, 1);
plot2d3(n, x)
set_my_line_styles(1, 3);
xgrid();
title("Original x(n) signal");
xlabel("n");
ylabel("x(n)");

subplot(3, 1, 2);
plot2d3(n, xo)
set_my_line_styles(1, 3);
xgrid();
title("Odd signal component x_o(n) signal");
xlabel("n");
ylabel("x_o(n)");

subplot(3, 1, 3);
plot2d3(n, xe)
set_my_line_styles(1, 3);
xgrid();
title("Even signal component x_e(n) signal");
xlabel("n");
ylabel("x_e(n)");
