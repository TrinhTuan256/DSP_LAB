function set_my_line_styles(style, thickness)
    e = gce();
    e.children.line_style = style;
    e.children.thickness = thickness;
endfunction

A = 3;
f0 = 50;             // analog frequency
Fs = 300;            // sampling frequency [samples/s]
Ts = 1/Fs;           // sampling period [s]
Delta = 0.1;         // quantization step

T0 = 1/f0;           // analog period
num_periods = 5;

draw_rate = 0.0001;  // for analog

// analog signal: x_a(t)
// five periods = 0.1 s

t = 0:draw_rate:num_periods*T0;

xa = A * sin(2*%pi*f0*t);

// sampled signal: x(n)

n = 0:num_periods*6;
x = A * sin(%pi*n/3)

// quantized signal: x_q(n)
// truncation using int()

xq = Delta * int(x/Delta)

// plotting

scf(0);
clf();

// analog signal
subplot(3,1,1);
temp = plot(t, xa);
temp.thickness = 3; 
xgrid();
xtitle("Analog Signal x_a(t)", "Time (s)", "Amplitude");

// sampled signal
subplot(3,1,2);
plot2d3(n, x, style=color("red"));
set_my_line_styles(1, 3);
xgrid();
xtitle("Discrete-Time Signal x(n)", "n", "Amplitude");

// quantized signal
subplot(3,1,3);
plot2d3(n, xq, style=color("red"));
set_my_line_styles(1, 3);
xgrid();
xtitle("Quantized Signal x_q(n), Delta = 0.1", "n", "Amplitude");
