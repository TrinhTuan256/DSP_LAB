// Generate a synthetic 64x64 grayscale test image
// Combining smooth gradient and geometric intensity patterns
N = 64;
[X, Y] = meshgrid(1:N, 1:N);
img_base = 80 + 35*sin(X/6) + 35*cos(Y/6);
// Confine dynamic range to simulate low-contrast lighting
img_original = uint8(max(0, min(255, round(img_base))));
img_d = double(img_original);

// -----------------------------------------------------------------------------
// Manipulation 1: Histogram Calculation and Display
// -----------------------------------------------------------------------------
L = 256;
hist_counts = zeros(1, L);
for r = 1:N
    for c = 1:N
        intensity = img_original(r, c);
        hist_counts(intensity + 1) = hist_counts(intensity + 1) + 1;
    end
end
pdf = hist_counts / (N * N);

// -----------------------------------------------------------------------------
// Manipulation 2: Histogram Equalization (Contrast Enhancement)
// -----------------------------------------------------------------------------
// Cumulative Distribution Function (CDF)
cdf = cumsum(pdf);
// Transformation mapping table s_k = round((L - 1) * CDF(k))
map_s = round((L - 1) * cdf);

img_equalized = zeros(N, N);
for r = 1:N
    for c = 1:N
        img_equalized(r, c) = map_s(img_original(r, c) + 1);
    end
end
img_equalized_uint8 = uint8(img_equalized);

// -----------------------------------------------------------------------------
// Manipulation 3: Image Blurring (Spatial 2D Low-Pass Filtering)
// -----------------------------------------------------------------------------
// 5x5 Normalized Averaging Kernel
kernel_size = 5;
kernel = ones(kernel_size, kernel_size) / (kernel_size * kernel_size);
img_blurred = conv2(img_d, kernel, "same");
img_blurred_uint8 = uint8(max(0, min(255, round(img_blurred))));

// -----------------------------------------------------------------------------
// Manipulation 4: Digital Image Watermarking
// -----------------------------------------------------------------------------
// Create binary logo/watermark pattern (cross/checkerboard pattern)
watermark_binary = zeros(N, N);
watermark_binary(24:40, 28:36) = 1; // Vertical bar
watermark_binary(28:36, 20:44) = 1; // Horizontal bar

// (A) Spatial Additive / Alpha Blending:
alpha = 0.20; // 20% watermark strength
img_watermarked_d = (1 - alpha) * img_d + alpha * (watermark_binary * 255);
img_watermarked = uint8(max(0, min(255, round(img_watermarked_d))));

// Watermark Extraction (Blind / Semi-blind recovery):
extracted_mark = double((img_watermarked_d - (1 - alpha) * img_d) / (alpha * 255) > 0.5);
recovery_rate = sum(extracted_mark == watermark_binary) / (N * N) * 100;

// (B) Spatial LSB Watermarking:
// Embed binary watermark into the least significant bit (bit 0)
img_lsb_watermarked = bitor(bitand(img_original, uint8(254)), uint8(watermark_binary));
// Extract LSB
extracted_lsb = bitand(img_lsb_watermarked, uint8(1));
lsb_recovery = sum(double(extracted_lsb) == watermark_binary) / (N * N) * 100;

disp("Image Processing Manipulations Executed Successfully!");
mprintf("Original Image Intensity Range: [%d, %d]\n", min(img_original), max(img_original));
mprintf("Equalized Image Intensity Range: [%d, %d]\n", min(img_equalized_uint8), max(img_equalized_uint8));
mprintf("Alpha Watermark Recovery Rate: %.2f%%\n", recovery_rate);
mprintf("LSB Watermark Recovery Rate: %.2f%%\n", lsb_recovery);
