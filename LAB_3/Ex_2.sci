function set_my_line_styles(style, thickness)
    e = gce();
    e.children.line_style = style;
    e.children.thickness = thickness;
endfunction

function [yn, yorigin] = delay(xn, xorigin, k)
    // Assume xn is a row vector and xorigin is a valid array index.
    // Positive k delays; negative k advances.

    yn = xn;
    xlen = size(xn, "c");

    // Calculate the new array index corresponding to n = 0.
    yorigin = xorigin - k;

    if yorigin < 1 then
        // Origin moved before the first array element.
        npad = 1 - yorigin;
        yn = [zeros(1, npad), xn];
        yorigin = 1;

    elseif yorigin > xlen then
        // Origin moved beyond the last array element.
        npad = yorigin - xlen;
        yn = [xn, zeros(1, npad)];
        // yorigin remains unchanged; it now equals the new vector length.
    end
endfunction

function [yn, yorigin] = advance(xn, xorigin, k)
    [yn, yorigin] = delay(xn, xorigin, -k);
endfunction

xn = [1, -2, 3, 6];
xorigin = 3;

[yn, yorigin] = advance(xn, xorigin, 1);

clf();
plot2d3((1:size(xn,"c"))' - xorigin, xn', 2);
set_my_line_styles(1, 3);
plot2d3((1:size(yn,"c"))' - yorigin, yn', 5);
set_my_line_styles(1, 3);

legend("x(n)", "y(n)");
xgrid();
xtitle("Advance", "n", "Amplitude");
