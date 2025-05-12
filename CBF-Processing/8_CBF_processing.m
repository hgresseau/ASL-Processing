clear
close all

% CBF_estimation
% do the subtraction first
% Then perfusion processing
% M0 processing
% Do CBF processing with basil
% Do T1 processing and register WM GM and CSF to the native space
% Do partial volume correction
% T1b is considered 1.65 (for future, estimate this number according to the
% Hct number from blood draw.
% For this study PLD is 1.3s, labeling duration is 1.8s
% estimate ATT map, set --bat option as 1.3 for pcasl, do it according to
% the oxford_asl

addpath(genpath( '/NAS/home/s_sanami/Documents/toolbox/NIfTI_20140122/'))
addpath(genpath( '/NAS/home/s_sanami/Documents/ASLtoobox/spm12'))
addpath(genpath( '/NAS/home/s_sanami/Documents/Scripts/CIRM'))
data_path='/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/data/';
addpath('/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/NIfTI_tools/')
code_path='/NAS/home/s_sanami/Documents/Scripts/ASLcodes';

subjects={'017','018','019','020','021','023','024','025','026','030','031'};

for i=1:length(subjects)
  % here i defined all the paths for inputs and outputs: change them accordingly

  % ASL (Perfusion) File Paths
  pcasl = [data_path 'COVIRM-' subjects{i} '/perf/sub-' subjects{i} '_asl_sub_new.nii.gz']; 
  cbf_path=[data_path   'COVIRM-' subjects{i} '/perf/sub-' subjects{i} '_CBF.nii'];
  mask_path=[data_path   'COVIRM-' subjects{i} '/perf/sub-' subjects{i} '_bold_mc_brain_mask.nii.gz'];

  % Parameter & Diffusion File Paths
  params_path=[data_path   'COVIRM-' subjects{i} '/params.txt'];

  % Output Folder Paths   
  M0_path=[data_path 'COVIRM-' subjects{i} '/perf/sub-' subjects{i} '_acq-pcasl_run-1_m0scan.nii.gz'];
  M0_bet=[data_path 'COVIRM-' subjects{i} '/perf/sub-' subjects{i} '_acq-pcasl_run-1_m0scan_bet.nii.gz'];
  out_path_perf=[data_path 'COVIRM-' subjects{i} '/perf/perfusion_rest']; 
  perfusion_normal=[out_path_perf '/step1/mean_ftiss.nii.gz'];

  data=load_untouch_nii(pcasl);
  data_im=data.img;
  mask=load_untouch_nii(mask_path);
  mask_im=mask.img;
  sub= surround_subtraction(data_im);


  % CBF Estimation method_1 (inputs will be surround suctracted image (pcasl in the code)), mask path and a file cotains parameters). refer to the BASIL linke in the google doc
  % Perfusion with BASIL

  cmd=['basil -i ' pcasl ' -m  ' mask_path ' -o ' out_path_perf  ' -@ ' params_path ];
  system(cmd)

  % M0 bet: after running basil for perfusion quantification, we process M0 image and remove scalp. M0 is a 3D image, so we won't need to do motion correction on it. then use the betted M0, with the output from BASIL to quantify CBF.   
  cmd=['bet2 ' M0_path ' ' [M0_path(1:end-7)] '_bet  -f 0.4 -m'];
  system(cmd)
   
  per_data=load_untouch_nii(perfusion_normal);
  per_data_im=per_data.img;
  M0_bet_data=load_untouch_nii(M0_bet);
  M0_bet_data_im=M0_bet_data.img;
  CBF_im=(6000.*per_data_im)./M0_bet_data_im;

  CBF_im(CBF_im<0)=0;
  CBF_im(isnan(CBF_im))=0;
 
  per_data.img=CBF_im;
  filename=[ data_path 'COVIRM-' subjects{i} '/perf/sub-' subjects{i} '_CBF.nii' ];
  save_untouch_nii(per_data,filename);

end
