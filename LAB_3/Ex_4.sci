function set_my_line_styles(style, thickness)
    e = gce();
    e.children.line_style = style;
    e.children.thickness = thickness;
endfunction

function [yn, yorigin] = add(x1n, x1origin, x2n, x2origin)
    if (x1origin < x2origin) then
        x1n = [zeros(1, x2origin - x1origin), x1n];
        x1origin = x2origin;
    elseif (x2origin < x1origin) then
        x2n = [zeros(1, x1origin - x2origin), x2n];
        x2origin = x1origin;
    end
    
    lenx1n = size(x1n, 'c');
    lenx2n = size(x2n, 'c');
    
    if (lenx1n < lenx2n) then
        x1n = [x1n, zeros(1, lenx2n - lenx1n)];
    elseif (lenx2n < lenx1n) then
        x2n = [x2n, zeros(1, lenx1n - lenx2n)];
    end
    
    yn = x1n + x2n;
    yorigin = x1origin;
endfunction

x1n = [0, 1, 3, -2];
x1origin = 1;

x2n = [1, 1, 2, 3];
x2origin = 2;

[yn, yorigin] = add(x1n, x1origin, x2n, x2origin);

clf();
plot2d3((1:size(x1n,"c"))' - x1origin, x1n', 2);
set_my_line_styles(1, 3);
plot2d3((1:size(x2n,"c"))' - x2origin, x2n', 3);
set_my_line_styles(1, 3);
plot2d3((1:size(yn,"c"))' - yorigin, yn', 5);
set_my_line_styles(1, 3);

legend("x1(n)", "x2(n)", "y(n)");
xgrid();
xtitle("Signal Addition", "n", "Amplitude");
