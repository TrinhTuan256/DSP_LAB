function set_my_line_styles(style, thickness)
    e = gce();
    e.children.line_style = style;
    e.children.thickness = thickness;
endfunction

function [yn, yorigin] = convolution(xn, xorigin, hn, horigin)
    // Assume xn and hn are nonempty row vectors.
    // xorigin and horigin are valid array indices for n = 0.

    xlen = size(xn, "c");
    hlen = size(hn, "c");

    // Time-index support of each input signal.
    nminx = 1 - xorigin;
    nmaxx = xlen - xorigin;

    nminh = 1 - horigin;
    nmaxh = hlen - horigin;

    // Time-index support of the convolution.
    kmin = nminx + nminh;
    kmax = nmaxx + nmaxh;

    // Output contains xlen + hlen - 1 samples.
    yn = zeros(1, xlen + hlen - 1);

    // Array index corresponding to output time k = 0.
    yorigin = xorigin + horigin - 1;

    // Calculate y[k] = sum_n x[n] * h[k-n].
    for k = kmin:kmax
        acc = 0;

        for i = 1:xlen
            n = i - xorigin;
            m = k - n;

            // Convert the time index m to an array index in hn.
            j = m + horigin;

            if j >= 1 & j <= hlen then
                acc = acc + xn(i) * hn(j);
            end
        end

        // Store samples in chronological order.
        output_index = k - kmin + 1;
        yn(output_index) = acc;
    end
endfunction

xn = [1, 2, 3];
xorigin = 2;

hn = [4, 5];
horigin = 1;

[yn, yorigin] = convolution(xn, xorigin, hn, horigin);

clf();
plot2d3((1:size(xn,"c"))' - xorigin, xn', 2);
set_my_line_styles(1, 3);
plot2d3((1:size(hn,"c"))' - horigin, hn', 3);
set_my_line_styles(1, 3);
plot2d3((1:size(yn,"c"))' - yorigin, yn', 5);
set_my_line_styles(1, 3);

legend("x(n)", "h(n)", "y(n)");
xgrid();
xtitle("Linear Convolution", "n", "Amplitude");
