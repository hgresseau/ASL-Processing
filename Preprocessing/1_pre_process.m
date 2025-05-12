% Code template by Safa Sanami
% Modified by Hendrale Gresseau

clear
close all

addpath(genpath( '/NAS/home/s_sanami/Documents/toolbox/NIfTI_20140122/'))
addpath(genpath( '/NAS/home/s_sanami/Documents/ASLtoobox/spm12'))
data_path='/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/data/';
code_path='/NAS/home/s_sanami/Documents/Scripts/ASLcodes';

% patients 
subjects={'016','017','018','019','020','021','023','024','025','026','030','031'};

for z=1:length(subjects)
  
  % Raw pCASL and BOLD files 
  pcasl_raw=[data_path 'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_acq-pcaslDEe1_run-1_asl.nii.gz'];
  bold_raw=[data_path   'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_acq-pcaslDEe2_run-1_asl.nii.gz'];
  
  % Motion-Corrected (MC) files created after motion correction is applied
  pcasl_mc=[data_path 'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_asl_mc.nii.gz'];
  bold_mc=[data_path   'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_bold_mc.nii.gz'];
  
  % BET files created after applying brain extraction
  pcasl_mc_bet=[data_path 'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_asl_mc_bet.nii'];
  bold_mc_bet=[data_path   'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_bold_mc_bet.nii'];
   
  % Brain Mask path created during brain extraction step
  mask_path=[data_path   'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_bold_mc_brain_mask.nii.gz'];
  %% Motion correction with FSL
  
  cmd=['mcflirt -in  ' pcasl_raw   ' -o ' pcasl_mc ' -mats -plots -report '];
  system(cmd)
       
  cmd=['mcflirt -in  ' bold_raw ' -o ' bold_mc ' -mats -plots -report '];
  system(cmd)
  
  filename = [data_path 'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_asl_mc.nii.gz.par']; 
  
  M = dlmread(filename); % read in the file, skip the header row
  
  % extract the translation and rotation parameters from the matrix
  translation = M(:, 1:3);
  rotation = M(:, 4:6);
  
  % plot the translation parameters
  figure;
  plot(translation(:, 1), 'r');
  hold on;
  plot(translation(:, 2), 'g');
  plot(translation(:, 3), 'b');
  title('Translation Parameters');
  xlabel('Time (volumes)');
  ylabel('Translation (mm)');
  legend('x', 'y', 'z');
  saveas(gcf,[data_path 'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_motion1.png'], 'png')
  % plot the rotation parameters
  figure;
  plot(rotation(:, 1), 'r');
  hold on;
  plot(rotation(:, 2), 'g');
  plot(rotation(:, 3), 'b');
  title('Rotation Parameters');
  xlabel('Time (volumes)');
  ylabel('Rotation (degrees)');
  legend('pitch', 'roll', 'yaw');
  saveas(gcf,[data_path 'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_motion2.png'], 'png')

  % File renaiming
  s1=movefile([data_path 'COVIRM-' subjects{z} '/perf/rsub-' subjects{z} '_acq-pcaslDEe1_run-1_asl.nii'],[data_path 'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_asl_mc.nii']);
  s=movefile([data_path 'COVIRM-' subjects{z} '/perf/rsub-' subjects{z} '_acq-pcaslDEe2_run-1_asl.nii'],[data_path 'COVIRM-' subjects{z} '/perf/sub-' subjects{z} '_bold_mc.nii']);
  % BET
  
  cmd=['bet2 ' bold_mc ' ' [bold_mc(1:end-7)] '_brain  -f 0.17 -m']; 
  system(cmd)
  if isfile(mask_path)
    [brain_mask_nii]=load_untouch_nii(mask_path);
    brain_mask_vol=brain_mask_nii.img;
    [data2]=load_untouch_nii(pcasl_mc);
    A_asl_vol=data2.img;
    
    [data3]=load_untouch_nii(bold_mc);
    A_bold_vol=data3.img;    
    for j=1:size(A_asl_vol,4)
      tmp=A_asl_vol(:,:,:,j);
      tmp( brain_mask_vol<1)=0;
      A_asl_vol(:,:,:,j)=tmp;
    end 
    for j=1:size(A_bold_vol,4)
      tmp=A_bold_vol(:,:,:,j);
      tmp( brain_mask_vol<1)=0;
      A_bold_vol(:,:,:,j)=tmp;
    end
    
    new_data=A_asl_vol(:,:,:,1:end);
    data2.hdr.dime.dim(5)=size(new_data,4);
    data2.img=new_data;
    filename_asl=[pcasl_mc(1:end-7) '_bet.nii' ];
    save_untouch_nii(data2,filename_asl) 
    
    new_data_bold=A_bold_vol(:,:,:,1:end);
    data3.hdr.dime.dim(5)=size(new_data_bold,4);
    data3.img=new_data_bold;
    filename_bold=[bold_mc(1:end-7) '_bet.nii' ];
    save_untouch_nii(data3,filename_bold)       
  end

close all
end
 
