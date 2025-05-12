% Code by Hendrale Gresseau
% Approved by Safa Sanami

% Define the directory where the file will be saved
data_path = '/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/data/';

% Define the content for the file (excluding repeats)
params = {
    '--casl'
    '--t1=1.4'
    '--t1b=1.65'
    '--tau=1.8'
    '--bat=1.3'
    '--pld=1.3'
};

% List of subjects with their corresponding repeats
subjects_repeats = {
    '016', 14;
    '017', 14;
    '018', 14;
    '019', 14;
    '020', 12;
    '021', 14;
    '023', 14;
    '024', 14;
    '025', 14;
    '026', 13;
    '030', 14;
    '031', 11
};

% Loop through each subject and generate the params.txt file
for z = 1:size(subjects_repeats, 1)
  subj = subjects_repeats{z, 1};  % Subject ID
  repeats = subjects_repeats{z, 2};  % Number of repeats

  % Create the final params list, including the dynamic repeats value
  params_with_repeats = [params; {['--repeats=', num2str(repeats)]}];

  % Define the file path to save the params.txt
  file_path = fullfile(data_path, ['COVIRM-', subj], 'params.txt');
  
  % Open the file for writing
  fileID = fopen(file_path, 'w');
  
  % Write each line to the file
  for i = 1:length(params_with_repeats)
      fprintf(fileID, '%s\n', params_with_repeats{i});
  end
  
  % Close the file
  fclose(fileID);
  
  fprintf('Params file created for subject %s: %s\n', subj, file_path);
end

disp('All params files created successfully!');

