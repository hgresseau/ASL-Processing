Insert description here.





**6️⃣ [Running BASIL for Perfusion Estimation](https://github.com/hgresseau/ASL-Processing/blob/69b096b433d934f680490dc41f1ef2ad9eb7b690/CBF-Processing/8_CBF_processing.m)**

- **BASIL** (Bayesian Inference for Arterial Spin Labeling) is used for modeling and estimating perfusion maps.
- There is the line in the main processing script (CBF processing) and it contains basil command. Run it using the subtracted image from the previous step (make sure you put all negative voxels equals to zero in the subtracted image), you will need a params.txt file for basil as well containing the imaging parameters and the number of volumes in the subtracted image (you can use the ones i did for the first participants for COVIRM, use them as an example, change the number of repeats (which is the volumes in subtracted image).
- Full instructions for running BASIL are available in the documentation and code provided.
- The output of BASIL will be the **perfusion-weighted image**.
