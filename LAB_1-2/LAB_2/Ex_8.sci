function set_my_line_styles(style, thickness)
    e = gce();
    e.children.line_style = style;
    e.children.thickness = thickness;
endfunction

// in this one exercise i cant manipulate most of the actual signal in the vector
// so now we just do the range changing

n = -2:2;
x = [1, -2, 3, 6, 0];

n1 = -n;
y1 = x;

n2 = n - 3;
y2 = x;

n3 = -n - 2;
y3 = 2*x;

subplot(2, 2, 1);
plot2d3(n, x)
set_my_line_styles(1, 3);
xgrid();
title("Original x(n) signal");
xlabel("n");
ylabel("x(n)");

subplot(2, 2, 2);
plot2d3(n1, y1)
set_my_line_styles(1, 3);
xgrid();
title("y1(n) signal");
xlabel("n");
ylabel("y1(n)");

subplot(2, 2, 3);
plot2d3(n2, y2)
set_my_line_styles(1, 3);
xgrid();
title("y2(n) signal");
xlabel("n");
ylabel("y2(n)");

subplot(2, 2, 4);
plot2d3(n3, y3)
set_my_line_styles(1, 3);
xgrid();
title("y3(n) signal");
xlabel("n");
ylabel("y3(n)");
