% Code template by Safa Sanami
% Modified by Hendrale Gresseau

clear
close all

% CBF_estimation

addpath(genpath( '/path/to/NIfTI/toolbox/NIfTI_20140122/'))
addpath(genpath( '/path/to/ASL/toolbox/spm12'))
addpath(genpath( '/path/to/Scripts/CIRM'))
data_path='/path/to/data/';
code_path='/path/to/Scripts/ASLcodes';

subjects= % Add subject IDs

for i=1:length(subjects)

  % ASL (Perfusion) File Paths
  pcasl = [data_path 'path/to/new/sub/asl/file/typically/_asl_sub_new.nii.gz']; 
  cbf_path=[data_path   'path/to/CBF/file/typically/_CBF.nii'];
  mask_path=[data_path   'path/to/mc/bold/brain/mask/typically/_bold_mc_brain_mask.nii.gz'];

  % Parameter & Diffusion File Paths
  params_path=[data_path   'path/to/params.txt/file'];

  % Output Folder Paths   
  M0_path=[data_path 'path/to/M0/raw/file/typically/_acq-pcasl_run-1_m0scan.nii.gz'];
  M0_bet=[data_path 'path/to/brain/extracted/M0/file/typically/_acq-pcasl_run-1_m0scan_bet.nii.gz'];
  out_path_perf=[data_path 'path/to/rest/perfusion/output']; 
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
  filename=[ data_path 'path/to/CBF/file/typically/_CBF.nii' ];
  save_untouch_nii(per_data,filename);

end
