% Code by Safa Sanami
% Modified by Hendrale Gresseau, Winter 2025

clear
close all

addpath(genpath('/path/to/NIfTI_20140122/toolbox/'))
addpath(genpath('/path/to/spm12/ASL/toolbox/files'))
data_path='/path/to/your/data/';
code_path='/path/to/Scripts/ASLcodes';

% patients 
subjects= % insert participant ID

for z=1:length(subjects)
  
  % Raw pCASL and BOLD files 
  pcasl_raw=[data_path 'path/to/raw/pcasl/data/typically/_acq-pcaslDEe1_run-1_asl.nii.gz'];
  bold_raw=[data_path 'path/to/raw/bold/data/typically/_acq-pcaslDEe2_run-1_asl.nii.gz'];
  
  % Motion-Corrected (MC) files created after motion correction is applied
  pcasl_mc=[data_path 'path/to/motion/corrected/pcasl/typically/_asl_mc.nii.gz'];
  bold_mc=[data_path 'path/to/motion/corrected/bold/typically/_bold_mc.nii.gz'];

  % BET files created after applying brain extraction
  pcasl_mc_bet=[data_path 'path/to/brain/extracted/mc/pcasl/typically/_asl_mc_bet.nii'];
  bold_mc_bet=[data_path 'path/to/brain/extracted/mc/bold/typically/_bold_mc_bet.nii'];
   
  % Brain Mask path created during brain extraction step
  mask_path=[data_path 'path/to/mc/bold/brain/mask/typically/_bold_mc_brain_mask.nii.gz'];

  %% Motion correction with FSL
  
  cmd=['mcflirt -in  ' pcasl_raw   ' -o ' pcasl_mc ' -mats -plots -report '];
  system(cmd)
       
  cmd=['mcflirt -in  ' bold_raw ' -o ' bold_mc ' -mats -plots -report '];
  system(cmd)
  
  filename = [data_path 'path/to/mc/asl/.par/file/typically/_asl_mc.nii.gz.par'];
  
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
  saveas(gcf,[data_path '/path/to/output/translational/motion/.png/image'], 'png')
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
  saveas(gcf,[data_path '/path/to/output/rotational/motion/.png/image'], 'png')
  % File renaiming
  s1=movefile([data_path 'path/to/pcasl/file/typically/_acq-pcaslDEe1_run-1_asl.nii'],[data_path 'path/to/mc/asl/file/typically/_asl_mc.nii']);
  s=movefile([data_path 'path/to/bold/file/typically/_acq-pcaslDEe2_run-1_asl.nii'],[data_path 'path/to/mc/bold/file/typically/_bold_mc.nii']);
  
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
 
