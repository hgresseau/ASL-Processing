### Overview  

The codes in this folder are used to perform CBF quantification. 

You will need the following files obtained in the previous step (see [Data-Processing](https://github.com/hgresseau/ASL-Processing/tree/8194ae3b1ac7266898ea987851f34b8212ccb33b/Processing)):
- 

The codes in this folder serve as examples. You must replace the file names with the ones you have, and adjust to your directories/paths.

#### Tools needed 💡
- MATLAB
- NIfTI_tools*

*Note: For students in Dr. Gauthier's lab, ask Dr. Gauthier for more details, including access.

# CBF Quantification

**6️⃣ [Running BASIL for Perfusion Estimation](https://github.com/hgresseau/ASL-Processing/blob/69b096b433d934f680490dc41f1ef2ad9eb7b690/CBF-Processing/8_CBF_processing.m)**

- **BASIL** (Bayesian Inference for Arterial Spin Labeling) is used for modeling and estimating perfusion maps.
- There is the line in the main processing script (CBF processing) and it contains basil command. Run it using the subtracted image from the previous step (make sure you put all negative voxels equals to zero in the subtracted image), you will need a params.txt file for basil as well containing the imaging parameters and the number of volumes in the subtracted image (you can use the ones i did for the first participants for COVIRM, use them as an example, change the number of repeats (which is the volumes in subtracted image).
- Full instructions for running BASIL are available in the documentation and code provided.
- The output of BASIL will be the **perfusion-weighted image**.

**7️⃣ CBF Quantification**
CBF quantification involves a straightforward calculation using the output from BASIL and a calibration image:

**A. Required Inputs**
1. **Perfusion Image**: Generated from BASIL.
2. **M0 Scan** (Calibration Image):
  - The M0 scan is a single-volume calibration scan used for absolute quantification.
  - The only preprocessing step needed is **brain extraction (BET)**.

**B. Applying the CBF Formula**
- Use the provided formula in the shared code to compute the CBF map.
- Inputs: **Perfusion Image + Brain-extracted M0 Scan**
- Save the computed **CBF Map** for further analysis.
