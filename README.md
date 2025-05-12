### Overview  
This repository contains documentation and scripts (Matlab, Linux (Shell)) to perform cerebral blood flow (CBF) processing on arterial spin labelling (ASL) MRI data. 

# CBF Processing

### What is ASL?🤔
Arterial spin labelling (ASL) is a non-invasive MRI technique widely used in neurodegenerative research (including Alzheimer's) to quantify blood flow (also referred to as perfusion). [1,2,3] It measures the amount of blood volume (mL) that flows through 100 grams of tissue per unit time (measured in minutes). [4,5] This technique makes use of the intrinsic magnetic spin property of hydrogen nuclei found in the water molecules within the blood. [6,7] An ASL acquisition begins by sending rapid short radiofrequency (RF) pulses in the water molecules in the arteries in the neck [Image 1] to alter their spin orientation by a predefined “flip angle” called the alpha or the excitation angle. This process hence “labels” the blood-water, allowing it to act as an endogenous tracer that will travel to the brain to replace non-labeled blood-water. 

<img src="https://github.com/user-attachments/assets/d4e2f536-143b-4d6e-bc78-11b520a9133a" alt="Alt Text" width="1000" height="350">
Image 1 The T1-weighted high resolution images from participant COVIRM-016 of this study were used to visualize the process through which blood-water from the arteries in the neck is labeled by an RF pulse (A), travels upwards in the head (B), where it is imaged for analysis (C). [8]
 <br>
As blood-water travels upward, two images are taken subsequent of one another: one with labeling (called the TAG image), and one without labeling (called the Control image). The time between each image is referred to as the time of repetition (TR) or repetition time, which is a predefined interval during which a three-dimensional brain image (volume) is acquired, where a unit cube is defined as a voxel (3D). For reference, a pixel is the 2-dimensional counterpart of a voxel. 

Additionally, the time between the labelling of the blood-water, and the measurement of the MRI signal is referred to as the time of echo (TE), or echo time. Since different tissues allow the labeled blood-water to relax at different rates, acquiring images at two distinct echo times (TE1 and TE2) allows for enhanced contrast between tissues. 

After acquisition, the TAG image is subtracted from the Control image to remove signal contributions from static tissue (such as the skull and scalp), isolating the small contributions from the labeled blood-water (which is only around 0.5% to 1.5%) that has reached the imaging region. (9) This subtraction yields a perfusion-weighted image, which can be further processed to directly quantify cerebral blood flow (CBF) [see Image 2]. 

<img src="https://github.com/user-attachments/assets/b2094886-e3b5-4514-9dc5-c28b8e4577ef" alt="Alt Text" width="1000" height="300">
Image 2 The Control and TAG images of participant COVIRM-016 of this study were used to visualize the subtracting of the TAG image from the Control image. This results in a perfusion-weighted image, which is an indirect measure of cerebral blood flow (CBF).
 <br> 

➡️ A ***very good*** introductory source worth taking the time to go through (readings, videos, tutorials): https://asl-docs.readthedocs.io/en/latest/analysis_guide.html. 

### What is CBF, and why it's important?🧐
Cerebral blood flow (CBF) is a measure of blood volume (mL) delivery to 100 grams of tissue per unit time (minutes) used to quantify perfusion. [4,5] ASL imaging reveals that CBF often serves as an early physiological biomarker for various neurodegenerative diseases such as Alzheimer's, and potentially COVID-19. [1,2,3] In fact, existing literature supports the use of ASL as an effective method for quantifying changes in CBF, with reduced perfusion recognized as a defining characteristic of early-stage AD. As such, CBF may serve as a potential early physiological biomarker to qualify and quantify changes in cognition, and in brain structure and function that were seemingly induced by the disease. 

Generating a CBF map may help with:

   ✅ Identifying regions of interest (ROIs) with changes in perfusion. 
   
   ✅ Quantifying changes in brain structure at certain ROIs.
   
   ✅ Indicating the presence of a disease/vius/infection (neurodegenerative or even COVID-19).
   

## Pipeline Overview: [num]-Step [insert here] 👩‍💻
1. 
- Goal: 
2. 
- Goal: 


### What's Needed?💡
- Terminal* (BASH [Unix Shell])
- FSL* (fslview or fsleyes) (install here: https://fsl.fmrib.ox.ac.uk/fsl/oldwiki/) 
- MATLAB*

*Note: For students in Dr. Gauthier's lab, ask Dr. Gauthier for more details, including access. 

#### References:
1. Roher, A. E., Debbins, J. P., Malek-Ahmadi, M., Chen, K., Pipe, J. G., Maze, S., ... & Beach, T. G. (2012). Cerebral blood flow in Alzheimer’s disease. Vascular health and risk management, 599-611.
2. Goldsmith, H. S. (2022). Alzheimer’s disease: a decreased cerebral blood flow to critical intraneuronal elements is the cause. Journal of Alzheimer’s Disease, 85(4), 1419-1422.
3. Ciacciarelli, A., Sette, G., Giubilei, F., & Orzi, F. (2020). Chronic cerebral hypoperfusion: An undefined, relevant entity. Journal of clinical neuroscience, 73, 8-12.
4. Sen, S., Newman‐Norlund, R., Riccardi, N., Rorden, C., Newman‐Norlund, S., Sayers, S., ... & Logue, M. (2023). Cerebral blood flow in patients recovered from mild COVID‐19. Journal of Neuroimaging, 33(5), 764-772.
5. Kim, W. S., Ji, X., Roudaia, E., Chen, J. J., Gilboa, A., Sekuler, A., ... & MacIntosh, B. J. (2023). MRI assessment of cerebral blood flow in nonhospitalized adults who self‐isolated due to COVID‐19. Journal of Magnetic Resonance Imaging, 58(2), 593-602.
6. Felix Lugauer and Jens Wetzl. (2018). Medical Imaging Systems: An Introductory Guide. Chapter 6: Magnetic Resonance Imaging. URL: https://www.ncbi.nlm.nih.gov/books/NBK546152/
7. Chappel, M., Okell, T., Jenkinson, M. Short introduction to MRI Physics for Neuroimaging. URL: https://www.fmrib.ox.ac.uk/primers/appendices/mri_physics.pdf
8. Ferré, J. C., Bannier, E., Raoult, H., Mineur, G., Carsin-Nicol, B., & Gauvrit, J. Y. (2013). Arterial spin labeling (ASL) perfusion: techniques and clinical use. Diagnostic and interventional imaging, 94(12), 1211-1223.
9. Petcharunpaisan, S., Ramalho, J., & Castillo, M. (2010). Arterial spin labeling in neuroimaging. World journal of radiology, 2(10), 384.
