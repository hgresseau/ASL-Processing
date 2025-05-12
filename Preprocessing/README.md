### Overview  

The codes in this folder are used to preprocess ASL data. As such, a great understanding of the processing pipeline is needed. Here is a ***great***  source which includes readings, videos and tutorials about the concepts brought up in these codes: https://asl-docs.readthedocs.io/en/latest/analysis_guide.html. 

You will need the following files obtained in the previous step (see [Data-Preparation](https://github.com/hgresseau/ASL-Processing/tree/8194ae3b1ac7266898ea987851f34b8212ccb33b/Data-Preparation)):
- **sub-###_acq-pcaslDEe1_run-1_asl.nii.gz** (pCASL)
- **sub-###_acq-pcaslDEe2_run-1_asl.nii.gz** (BOLD)

The codes in this folder serve as examples. You must replace the file names with the ones you have, and adjust to your directories/paths.

#### Tools needed 💡
- MATLAB
- NIfTI_tools*

*Note: For students in Dr. Gauthier's lab, ask Dr. Gauthier for more details, including access.

# Data Preprocessing

### In terminal

1️⃣ Type the following lines (one by one) in the terminal to open MATLAB: 
> **module load FSL/5.0.9** | loads fslview, useful for visualization in subsequent steps. 

> **module load matlab/R2020a** | loads matlab.

> **matlab** | opens matlab. 

### In MATLAB 🖥

**2️⃣ [Preprocessing the ASL image](https://github.com/hgresseau/ASL-Processing/blob/3d8d82b80c39da1cf7d7a9a6110e4cbe37b07126/Preprocessing/1_pre_process.m)**

Preprocessing involves:
#### A. Motion Correction
- Motion correction compensates for head movements that may have occurred during scanning.
- This process generates two types of motion parameters:
  - Translational movements (shifts in x, y, and z directions)
  - Rotational movements (rotations around x, y, and z axes)

Note that these motion parameters are crucial for quality control (QC).

#### B. Brain Extraction (BET)
- Brain extraction removes non-brain tissues (e.g., skull, scalp) from the ASL image.
- The BET Tool in FSL is commonly used for this step.
- Proper brain extraction ensures accurate subsequent processing.

**3️⃣ [Extracting Resting-State Volumes](https://github.com/hgresseau/ASL-Processing/blob/3d8d82b80c39da1cf7d7a9a6110e4cbe37b07126/Preprocessing/2_extract_resting_volumes.m)**

- The acquired ASL data may contain volumes associated with gas manipulation or external interventions.
- For resting-state CBF analysis, we extract the initial **30 volumes** (or another appropriate number based on the study design; in the example codes, we extract the first 30 volumes).
- **Important Note**: Always extract an **even number** of volumes to maintain TAG/control pairing integrity.
- Save the extracted volumes as a new ASL file for further processing.

**4️⃣ [Surround Subtraction](https://github.com/hgresseau/ASL-Processing/blob/3d8d82b80c39da1cf7d7a9a6110e4cbe37b07126/Preprocessing/3_surround_sub.m)**

ASL imaging involves alternating TAG and Control volumes. To isolate the perfusion signal, surround subtraction is applied:
- TAG and Control images must be subtracted to generate the perfusion-weighted image.
- If the resting-state image contains 30 volumes, the surround-subtracted image will contain 15 volumes.
- This subtraction process removes static tissue contributions, leaving only the perfusion signal.


**5️⃣ [Quality Control (QC) and Visual Inspection](https://github.com/hgresseau/ASL-Processing/blob/3d8d82b80c39da1cf7d7a9a6110e4cbe37b07126/Preprocessing/4_new_method.m)**

After subtraction, the processed ASL image should be examined for artifacts and abnormalities:
- Open the **subtracted image** in FSLView. (type **fslview** in the terminal)
- Press **Ctrl+T** to scroll through the volumes and observe signal variations.
- **Check for the following issues**:
  - **[Negative voxel intensity](https://github.com/hgresseau/ASL-Processing/blob/3d8d82b80c39da1cf7d7a9a6110e4cbe37b07126/Preprocessing/6_negative_to_zero.m)**: The majority of voxels should not appear negative.
  - **Hyperintense voxels**: Identify and remove any unusually bright (artifact) voxels.
  - **Motion-induced artifacts**: Compare with motion correction outputs to identify problematic volumes.
- **Meeting Requirement**: If any abnormalities are observed, discuss them with someone more experienced (grad student or professor) before proceeding further.
- If necessary, **[remove the affected volumes](https://github.com/hgresseau/ASL-Processing/blob/3d8d82b80c39da1cf7d7a9a6110e4cbe37b07126/Preprocessing/5_remove_vols.m)** and save the corrected image.

## 

### Contributors 📝
**Sanami, Safa**. PhD in Physics, Quantitative Physiological Imaging Lab

**Gresseau, Hendrale**. BSc Honours Physics, Concentration: Biophysics.
