% Code by Hendrale Gresseau
% Approved by Safa Sanami

% Define paths
data_path = '/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/data/';
addpath('/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/NIfTI_tools/')

% List of subjects (you can expand this with all participants)
%subjects = {'001', '002', '006', '007', '008', '016', '017', '018', '019', '020', '021', '023', '024', '025', '026', '030', '031'};
subjects={'021'};

% Loop through each subject
for i = 1:length(subjects)
    % Define the CBF path for the current subject
    cbf_path = [data_path 'COVIRM-' subjects{i} '/perf/sub-' subjects{i} '_CBF.nii'];
    
    % Load the CBF image (NIfTI format)
    cbf_nii = load_untouch_nii(cbf_path);

    % Get the image data (CBF values)
    cbf_data = double(cbf_nii.img);   % Convert CBF data to double for better handling

    % Check for Inf values and replace them with NaN
    cbf_data(cbf_data == Inf) = NaN;  % Replace Inf values with NaN (or a large number if you prefer)

    % Apply the threshold of 45 (Cap any value greater than 45 to 45)
    cbf_data(cbf_data > 45) = 45;

    % Check for NaN values and print a warning if any are present
    if any(isnan(cbf_data(:)))
        warning(['NaN values found in subject ' subjects{i} ' CBF data']);
    end
    
    % Print the min and max CBF values for each subject to check the range
    min_cbf = min(cbf_data(:), [], 'omitnan'); % 'omitnan' ignores NaN values when calculating the min/max
    max_cbf = max(cbf_data(:), [], 'omitnan'); % Same for max value
    fprintf('Subject %s: Min CBF = %.2f, Max CBF = %.2f\n', subjects{i}, min_cbf, max_cbf);
    
    % Get the size of the CBF data (3D volume)
    [~, ~, num_slices] = size(cbf_data);

    % Find the middle slice index
    %middle_slice_index = round(num_slices / 2);  % Round to get the nearest integer
    middle_slice_index =10;
    
    % Visualize the CBF data
    figure;

    % Extract the middle slice
    cbf_slice = cbf_data(:,:,middle_slice_index);  % Extract the middle 2D slice

    % Display the slice with color map
    imagesc(cbf_slice);   % Display the slice as an image
    axis equal;           % Equal scaling of the axes
    
    % Set color limits (to ensure all images use the same range)
    caxis([min(cbf_data(:)), max(cbf_data(:))]); % This will set the color scale to the overall min/max range

    colormap('jet');      % Apply the jet color map (you can also use 'hot', 'cool', etc.)
    colorbar;             % Show colorbar to indicate CBF value range

    % Add title and axis labels
    title(['CBF Map for Subject ', subjects{i}, ', Slice ' num2str(middle_slice_index)]);
    xlabel('X-axis');
    ylabel('Y-axis');

    % Pause to view each image before moving to the next one
    pause;  % This will allow you to view the image and press any key to proceed to the next subject
end
