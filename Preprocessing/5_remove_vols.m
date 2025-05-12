close all;

% Define paths
data_path = '/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/data/';
addpath('/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/NIfTI_tools/')
% notes
% subjects={'016','017','018','019','020','021','023','024','025','026','030','031'};
% note: subject #020: remove volumes 1 and 13
% note: subject #026: remove volume 4
% note: subject #031: remove volumes 1, 2 and 3
subjects = {'031'}; % Add more subjects as needed


for z = 1:length(subjects)
  subj = subjects{z};
  
  % Define file paths
  pcasl_sub = [data_path 'COVIRM-' subj '/perf/sub-' subj '_asl_sub.nii.gz'];
  pcasl_new = [data_path 'COVIRM-' subj '/perf/sub-' subj '_asl_sub_new.nii.gz']; % Output file after removing outliers

  % Load subtracted ASL image
  nii = load_untouch_nii(pcasl_sub);
  sub_im = nii.img; % Extract image data

  % To remove vol 1, 2 and 3, we can keep all the volumes from 4 onwards.
  new_img = sub_im(:,:,:, 4:end);

  % To remove vol 1, we can keep all the volumes from 2 onwards. 
  %new_img = new_img(:,:,:, 2:end);

  % Save the new perfusion-weighted image
  nii.img = new_img;
  nii.hdr.dime.dim(5) = size(new_img, 4); % Update header for correct volume count
  save_untouch_nii(nii, pcasl_new);
  
  fprintf('Processed subject %s. Saved as %s\n', subj, pcasl_new);
end

disp('All selected subjects processed successfully!');




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
