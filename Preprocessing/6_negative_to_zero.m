% Code by Hendrale Gresseau, Winter 2025
% Approved by Safa Sanami

close all;

% Define paths
data_path = '/path/to/data/';
addpath('/path/to/NIfTI/toolbox/NIfTI_tools/')


% Define participants
% subjects= % insert participant IDs
% file name: '_asl_sub.nii.gz'
% file name: '_asl_sub_new.nii.gz'

% Loop through each participant
for z = 1:length(subjects)
  subj = subjects{z};

  % Define file paths
  pcasl_sub = [data_path 'path/to/new/asl/sub/file/typically/_asl_sub_new.nii.gz'];
  pcasl_zeroed = [data_path 'path/to/zeroed/asl/sub/file/typically/_asl_sub_new.nii.gz']; % Output file

  % Load ASL image
  nii = load_untouch_nii(pcasl_sub);
  sub_im = nii.img; % Extract image data
  
  % Ensure all negative voxels are set to zero
  sub_im(sub_im < 0) = 0;

  % Save the new subtracted image after processing
  nii.img = sub_im;
  nii.hdr.dime.dim(5) = size(sub_im, 4); % Update the header for correct volume count
  save_untouch_nii(nii, pcasl_zeroed);

  fprintf('Processed subject %s, saved as %s\n', subj, pcasl_zeroed);
end

disp('All subjects processed successfully!');




% Surround subtraction function
function [ D_ASL_vol ] = surround_subtraction( ASL_vol )
  ASL_T = ASL_vol(:,:,:,1:2:end); % TAG
  ASL_C = ASL_vol(:,:,:,2:2:end); % Control
  t = size(ASL_C, 4);
  vol_t(:,:,:,1) = ASL_C(:,:,:,1) - ASL_T(:,:,:,1);
  c = 2;
  for i = 1:t-1
      vol_t(:,:,:,c) = (ASL_C(:,:,:,i) + ASL_C(:,:,:,i+1)) / 2 - ASL_T(:,:,:,i);
      c = c + 1;
  end
  D_ASL_vol = vol_t(:,:,:,1:end);
end
