% Add necessary paths for NIfTI and SPM toolboxes
addpath(genpath('/NAS/home/s_sanami/Documents/toolbox/NIfTI_20140122/'))
addpath(genpath('/NAS/home/s_sanami/Documents/ASLtoobox/spm12'))
addpath(genpath('/NAS/home/s_sanami/Documents/Scripts/CIRM'))
% Add necessary paths for NIfTI and SPM toolboxes
addpath(genpath('/NAS/home/s_sanami/Documents/toolbox/NIfTI_20140122/'))
addpath(genpath('/NAS/home/s_sanami/Documents/ASLtoobox/spm12'))
addpath(genpath('/NAS/home/s_sanami/Documents/Scripts/CIRM'))

% Define paths
data_path = '/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/data/';

% Define subjects and rests
subjects = {'016','017','018','019','020','021','023','024','025','026','030','031'}; % Add more subjects as needed

% Initialize cell arrays to store results
results = struct();
outlier_summary = {};  % Initialize a cell array to store subject ID and volume indices

% Loop through each subject
for i = 1:length(subjects)
  subject_id = subjects{i};
  
  % Load Rest image
  rest_path = [data_path 'COVIRM-' subject_id '/perf/sub-' subject_id '_asl_sub.nii.gz'];
  rest = load_untouch_nii(rest_path);    
  rest_im = double(rest.img); % Convert to double for calculations
  
  % Calculate number of volumes
  num_volumes_rest = size(rest_im, 4);
  
  % Calculate mean images for each image type
  mean_rest = mean(rest_im, 4);
  
  % Calculate voxel-wise standard deviation images
  sd_rest_img = std(rest_im, 0, 4);
  
  % Initialize arrays to store outlier percentages for each volume
  outlier_percentage_rest = zeros(1, num_volumes_rest);
  
  % Store volume indices with more than 1% outliers
  volumes_with_high_outliers = struct('rest', []);
  
  % Calculate outlier percentages for Rest
  for v = 1:num_volumes_rest
    % Calculate outliers for Rest
    outliers_rest = abs(rest_im(:, :, :, v) - mean_rest) > 2 * sd_rest_img;
    num_outliers_rest = sum(outliers_rest(:));
    total_voxels_rest = numel(rest_im(:, :, :, v));
    outlier_percentage_rest(v) = (num_outliers_rest / total_voxels_rest) * 100;
    
    % Check if outlier percentage is greater than 1%
    if outlier_percentage_rest(v) > 1.5
      volumes_with_high_outliers.rest = [volumes_with_high_outliers.rest, v];
    end
  end
    
  % Store results for the current subject
  results(i).subject_id = subject_id;
  results(i).num_volumes_rest = num_volumes_rest;
  results(i).outlier_percentages_rest = outlier_percentage_rest;
  
  % Add to outlier summary if there are any volumes with more than 1% outliers
  if ~isempty(volumes_with_high_outliers.rest)
    outlier_summary = [outlier_summary; {subject_id, 'rest', volumes_with_high_outliers.rest}];
  end
    
  % Print results for each subject
  fprintf('Subject %s:\n', subject_id);
  fprintf('Rest Outlier Percentages: %s\n', num2str(outlier_percentage_rest));
  fprintf('Number of Volumes (Rest): %d, %d, %d\n\n', num_volumes_rest);
end

% Save the results to a .mat file
save('subject_outlier_analysis.mat', 'results', 'outlier_summary');

% Print outlier summary
fprintf('Outlier Summary:\n');
for j = 1:size(outlier_summary, 1)
    fprintf('Subject ID: %s, Image Type: %s, Volumes with >1%% Outliers: %s\n', ...
        outlier_summary{j, 1}, outlier_summary{j, 2}, num2str(outlier_summary{j, 3}));
end
