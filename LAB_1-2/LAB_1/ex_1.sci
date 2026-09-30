x = 1:4; // create vector x = 1:4

sum_1 = x + [1:1] // create vector sum_1 = (x1 + 1, x2 + 1, x3 + 1, x4 + 1)

y = 5:8; // create vector y = 5:8
mult_y = x .* y // create vector (x1*y1, x2*y2, x3*y3, x4*y4)

x = linspace(0, %pi, 10); // redefined x as vector of 10 value spaced evenly from 0 to pi

sin_x = sin(x) // create vector of sin of x
