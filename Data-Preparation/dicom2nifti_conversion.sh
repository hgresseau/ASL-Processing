#!/bin/bash

# Hendrale Gresseau, Fall/Winter 2024-25 semester 

# This script compresses raw data (DICOM) into usable files (NIfTI)

# Define the base path
path=/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/

# Navigate to the working directory
cd $path

participants=("016" "017" "018" "019" "020" "021" "023" "024" "025" "026" "030" "031")

# Loop over each participant (COVIRM-016 to COVIRM-030)
for participant in "${participants[@]}"
do
    participant_dir="data/COVIRM-${participant}"
    echo "Processing participant $participant"

    # Call apply_dcm2nii.sh with the full participant directory
    /NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/apply_dcm2nii.sh ${participant_dir} ${participant}

    # Rename e1 and e2 files to use DEe1 and DEe2 instead of _e1 and _e2
    mv "$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl_e1.nii.gz" "$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl.nii.gz"
    mv "$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl_e2.nii.gz" "$participant_dir/perf/sub-${participant}_acq-pcaslDEe2_run-1_asl.nii.gz"
    mv "$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl_e1.json" "$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl.json" 
    mv "$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl_e2.json" "$participant_dir/perf/sub-${participant}_acq-pcaslDEe2_run-1_asl.json"


done
