function set_my_line_styles(style, thickness)
    e = gce();
    e.children.line_style = style;
    e.children.thickness = thickness;
endfunction

function [yn, yorigin] = fold(xn, xorigin)
    yn = flipdim(xn, 2);
    yorigin = size(xn, 'c') - xorigin + 1;
endfunction

xn = [1, -2, 3, 6];
xorigin = 3;

[yn, yorigin] = fold(xn, xorigin);

clf();
plot2d3((1:size(xn,"c"))' - xorigin, xn', 2);
set_my_line_styles(1, 3);
plot2d3((1:size(yn,"c"))' - yorigin, yn', 5);
set_my_line_styles(1, 3);

legend("x(n)", "y(n)");
xgrid();
xtitle("Folding", "n", "Amplitude");
