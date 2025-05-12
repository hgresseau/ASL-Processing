### Overview  
These codes allow for the preparation of NIfTI files (.nii) from the raw data coming directly from the MRI taken from the online server, such as CAIN. 
Here is an overview of the pipeline to prepare your data for CBF processing. 

# Data Preparation

### In your local machine

1️⃣ Create folders for each participant. In each folder, create a folder called "anat" (short for anatomy), and another folder called "perf" (short for perfusion). 

2️⃣ In the server, locate the patient you need. *Note: To locate the COVIRM participant files, **filter** the Patient ID with "COV".*

3️⃣ Once located, click on one patient to reveal all the data on the lower half of the screen. Select and **download** the following: 
- **MPRAGE_HR**: high resolution T1-weighted image showing brain anatomy.
- **ep2d_DE_pCASL_LOFTmod_XA30 TE10 TE30**: both pCASL and BOLD images showing brain perfusion.
- **ep2d_DE_pCASL_LOFTmod_XA30 M0**: magnetization map used to quantify blood perfusion.
- **MPRAGE 1.5mm**: low resolution T1-weighted image showing brain anatomy.

4️⃣ The folders will be downloaded as a .cab file. **Extract** the file into the appropriate subject folder. 

5️⃣ When you download the folders, their name will appear as a series of numbers. In order to know which file is which, **right click** on one folder, go to **Properties**, look at **Size** and it you will see **# files**. In the folders you downloaded, you will find a large number of images (.dcm), and *one* text file (.info). Go back to the CAIN server and check the column **Images** for the downloaded files. Make sure that the number you see here corresponds to the number - 1 of what is written in # files in your desktop. **You now know which file is which.** 

6️⃣ Rename the file appropriately. 

7️⃣ In your local computer, put MPRAGE 1.5mm and MPRAGE_HR in the "**anat**" folder (short for anatomy) and put the two remaining pCASL data in the "**perf**" folder (short for perfusion). 

8️⃣ Repeat this procedure for all your patients. 

## 

### Transferring the data into your remote machine

9️⃣ Go to your local machine in your terminal and write the following to transfer all the files into the server. Note that this might take a few minutes (5-10 minutes) due to the amount of DICOM (.dcm) files. 

> ***scp -r ~/Documents/Hendrale/* s_sanami@perf-hpc01:~/Documents/covirm_data_processing/Hendrale/data/**

## 

### Conversion to NIfTI (.nii) files in your remote machine

🔟 use the files **dicom2nifti_conversion.sh** and **apply_dcm2nii.sh** to convert the files into the desired format. Write the following commands (one at a time) in the Terminal. 
> **module avail** | provides a list of all the modules available in your directory.

> **module load dcm2niix/1.0.20220720** | loads the module needed to convert .dcm into .nii.
 
> **./dicom2nifti_conversion.sh** | Runs the Bash (.sh) file to convert .dcm to .nii.

## 

### Output 
#### anat folder
Here, you will find the high and low resolution images. .gz indicates that the data is zipped. Also, replace "###" with your participant number ID. 

> **sub-###_acq-MPRAGE0p9_run-1_T1w.nii.gz** | T1-Weighted, High Resolution (T1HR) image

> **sub-###_acq-MPRAGE1p5_run-1_T1w.nii.gz** | T1-Weighted, Low Resolution (T1LR) image

#### perf folder
Here, you will find the **pCASL** file; 
> **sub-###_acq-pcaslDEe1_run-1_asl.nii.gz**

The **BOLD** signal file;
> **sub-###_acq-pcaslDEe2_run-1_asl.nii.gz**

And the **M0** file;

> **sub-###_acq-pcasl_run-1_m0scan.nii.gz**

## 

### Contributors 📝
**Sanami, Safa**. PhD in Physics, Quantitative Physiological Imaging Lab

**Gresseau, Hendrale**. BSc Honours Physics, Concentration: Biophysics.
