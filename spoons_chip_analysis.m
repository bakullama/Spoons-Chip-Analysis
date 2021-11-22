chip_sizes = readmatrix("chip_sizes.csv");

arr_len=size(chip_sizes);
arr_len=arr_len(1);

chip_sizes = sort(chip_sizes);
chip_IDs = zeros(arr_len,1);

for n = 0:arr_len-1
    chip_IDs(n+1) = n;
end

% Calculation of Mean Average
total_length = 0;
for n = 0:arr_len-1
    total_length = total_length + chip_sizes(n+1);
end
mean = total_length/arr_len;

% Calculation of Standard Deviation
sqsum = 0;
for n = 0:arr_len-1
    sqsum = sqsum + (chip_sizes(n+1)^2);
end
variance = sqsum/arr_len;
std_dev = sqrt(variance);

disp("longest chip: " + max(chip_sizes) + "cm");
disp("shortest chip: " + min(chip_sizes) + "cm");
disp("mean avg. length: " + mean + "cm");
disp("variance: " + variance);
disp("standard deviation: pm" + std_dev + "cm");

pd = fitdist(chip_sizes, "Normal");
prob_dist_fitted = pdf(pd, chip_sizes);

lin_reg_grad = chip_sizes/chip_IDs;
lin_reg_line = lin_reg_grad * chip_sizes;

tiledlayout(3, 2);

nexttile;
scatter(chip_IDs, chip_sizes, 'x');
hold on;
plot(chip_sizes, lin_reg_line);
title("Linear Regression of Chip Lengths");
ylabel("Chip length (cm)");
xlabel("Chip ID");
legend('Chip Length','Linear Regression', 'Location', 'northwest');


nexttile;
plot(chip_sizes, prob_dist_fitted);
title("Distribution of chip length");
xlabel("Chip length (cm)")

nexttile;
histfit(chip_sizes);
title("Histogram overlaid on normal distribution of chip length");

nexttile;
qqplot(chip_sizes);
title("Quantile-quantile plot of the sample of chip lengths versus the theoretical quantile of the fitted distribution");

nexttile;
boxplot(chip_sizes, "orientation", "horizontal");
title("Box plot of chip size");
xlabel("Chip length (cm)");
ylabel("Sample");
