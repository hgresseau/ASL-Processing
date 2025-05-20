% Code by Safa Sanami
% Modified by Hendrale Gresseau, Winter 2025

clear; clc;

% Define the data path
data_path = '/path/to/data/';

% patients rest
subjects= % insert your participant ID

% Number of volumes to extract
num_volumes = 

for i = 1:length(subjects)
    sub_id = subjects{i};
    
    % Input and output file paths ASL
    input_file = [data_path 'path/to/mc/bet/asl/file/typically/_asl_mc_bet.nii.gz'];
    output_file = [data_path 'path/to/mc/bet/rest/asl/file/typically/_asl_mc_bet_rest.nii.gz'];
    
    % FSL command to extract volumes
    cmd = sprintf('fslroi %s %s 0 %d', input_file, output_file, num_volumes);
    
    % Run the command
    system(cmd);
    
    fprintf('Extracted resting-state volumes for subject %s\n', sub_id);
end

%% Run this command in the Command Window on Matlab: Step_2_extract_resting_volumes
