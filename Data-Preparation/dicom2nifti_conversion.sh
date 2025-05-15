#!/bin/bash

# Code by Hendrale Gresseau, Fall 2024. 
# Verified by Safa Sanami.

# This script compresses raw data (DICOM) into usable files (NIfTI)

# Define the base path
path=/insert/your/base/path/

# Navigate to the working directory
cd $path

participants= #insert participants identification number (ID) 

# Loop over each participant
for participant in "${participants[@]}"
do
    participant_dir="path/to/your/participant/folder"
    echo "Processing participant $participant"

    # Call apply_dcm2nii.sh with the full participant directory
    /path/to/the/conversion/script/apply_dcm2nii.sh ${participant_dir} ${participant}

    # Include the following to rename the _e1 and _e2 files of each participant such that they use _DEe1 and _DEe2 instead (useful for subsequent steps)
    mv "path/to/the/file/_e1.nii.gz" "path/to/the/renamed/file/_DEe1.nii.gz" # The first term represent the current file's name. The second term is the new name you would for it.
    mv "path/to/the/file/_e2.nii.gz" "path/to/the/renamed/file/_DEe2.nii.gz" # The first term represent the current file's name. The second term is the new name you would for it.
    mv "path/to/the/file/_e1.json" "path/to/the/renamed/file/_DEe1.json" # The first term represent the current file's name. The second term is the new name you would for it.
    mv "path/to/the/file/_e2.json" "path/to/the/renamed/file/_DEe2.json" # The first term represent the current file's name. The second term is the new name you would for it.

done
