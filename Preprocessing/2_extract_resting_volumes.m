% Code template by Safa Sanami
% Modified by Hendrale Gresseau

clear; clc;

% Define the data path
data_path = '/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/data/';

% patients rest
subjects={'016','017','018','019','020','021','023','024','025','026','030','031'};

% Number of volumes to extract
num_volumes = 30; % First 30 volumes

for i = 1:length(subjects)
    sub_id = subjects{i};
    
    % Input and output file paths ASL
    input_file = [data_path 'COVIRM-' sub_id '/perf/sub-' sub_id '_asl_mc_bet.nii.gz'];
    output_file = [data_path 'COVIRM-' sub_id '/perf/sub-' sub_id '_asl_mc_bet_rest.nii.gz'];
    
    % FSL command to extract volumes
    cmd = sprintf('fslroi %s %s 0 %d', input_file, output_file, num_volumes);
    
    % Run the command
    system(cmd);
    
    fprintf('Extracted resting-state volumes for subject %s\n', sub_id);
end

%% Run this command in the Command Window on Matlab: Step_2_extract_resting_volumes
