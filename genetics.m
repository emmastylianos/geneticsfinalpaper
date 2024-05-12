% Read data from Excel file
data = xlsread('test6.xlsx');

% Extract negative control, positive control, and compound data
negative_control = data(:, 1);
positive_control = data(:, 2);
compound_data = data(:, 3:end);

% Calculate means and standard deviations
mean_positive = mean(positive_control);
mean_negative = mean(negative_control);
std_positive = std(positive_control);
std_negative = std(negative_control);

% Calculate Z factor
z_factor = 1 - ((3 * (std_positive + std_negative)) / abs(mean_positive - mean_negative));

% Check if Z factor is greater than 0.5
if z_factor > 0.5
    disp('Assay is sufficiently robust for HTS');
else
    disp('Assay is not sufficiently robust for HTS');
end

% Calculate Z scores for each compound
z_scores = (compound_data - mean_negative) ./ std_negative;

% Plot duplicate Z scores onto a grid
figure;
scatter(z_scores(:,1), z_scores(:,2)); % Assuming duplicate Z scores are in first two columns
xlabel('Z score of duplicate 1');
ylabel('Z score of duplicate 2');
title('Duplicate Z scores plot');

% Plot diagonal line representing identity
hold on;
xlim([-5 5]); % Adjust limits according to your data
ylim([-5 5]); % Adjust limits according to your data
plot([-5 5], [-5 5], 'k--');

% Calculate composite Z scores
composite_z_scores = sqrt(z_scores(:,1).^2 + z_scores(:,2).^2);
