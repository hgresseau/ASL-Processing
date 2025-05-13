% Code by Safa Sanami
% Modified by Hendrale Gresseau, Winter 2025

close all;

% Define paths
data_path = '/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/data/';
% addpath('/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/NIfTI_tools/')

subjects = {'016','017','018','019','020','021','023','024','025','026','030','031'}; % Add more subjects as needed

for z = 1:length(subjects)
  subj = subjects{z};
  
  % Define file paths
  pcasl_rest = [data_path 'COVIRM-' subj '/perf/sub-' subj '_asl_mc_bet_rest.nii.gz'];
  pcasl_sub = [data_path 'COVIRM-' subj '/perf/sub-' subj '_asl_sub.nii.gz']; % Output file
  
  % Load ASL image
  nii = load_untouch_nii(pcasl_rest);
  ASL_vol = nii.img; % Extract image data
  
  % Load data and remove the first time point
  ASL_vol = ASL_vol(:,:,:,3:end);
  
  
  % Apply surround subtraction
  D_ASL_vol = surround_subtraction(ASL_vol);
  
  % Save the new perfusion-weighted image
  nii.img = D_ASL_vol;
  nii.hdr.dime.dim(5) = size(D_ASL_vol, 4); % Update the header for correct volume count
  save_untouch_nii(nii, pcasl_sub);
  
  fprintf('Surround subtraction complete for subject %s. Saved as %s\n', subj, pcasl_sub);

end

disp('All subjects processed successfully!');



function [ D_ASL_vol ] = surround_subtraction( ASL_vol )

  ASL_T=ASL_vol(:,:,:,1:2:end); % TAG
  ASL_C=ASL_vol(:,:,:,2:2:end); % Control
  t=size(ASL_C,4);
  vol_t(:,:,:,1)=ASL_C(:,:,:,1)-ASL_T(:,:,:,1);
  c=2;
  for i=1:1:t-1
  
     vol_t(:,:,:,c)=(ASL_C(:,:,:,i)+ASL_C(:,:,:,i+1))./2-ASL_T(:,:,:,i);
      c=c+1;
  end
  
  D_ASL_vol=(vol_t(:,:,:,1:end));

end
