#!/bin/bash

# Code by Hendrale Gresseau, Fall 2024.
# Verified by Safa Sanami.

participant_dir=${1}
participant=${2}

# Process anatomy (anat) files
# -z y: Compresses the output NIfTI file into .nii.gz. y means yes.
# -f: output filename:
  # ANAT: _acq-MPRAGE0p9_run-1_T1w (High Resolution T1-Weighted Image)
  #       _acq-MPRAGE1p5_run-1_T1w (Low Resolution T1-Weighted Image)
  # PERF: _acq-pcaslDEe1_run-1_asl (pCASL/BOLD)
  #       _acq-pcasl_run-1_m0scan (M0)
# -o: directory to save the output file.
dcm2niix -z y -f "sub-${participant}_acq-MPRAGE0p9_run-1_T1w" -o "$participant_dir/anat" "$participant_dir/anat/MPRAGE_HR"

dcm2niix -z y -f "sub-${participant}_acq-MPRAGE1p5_run-1_T1w" -o "$participant_dir/anat" "$participant_dir/anat/MPRAGE 1.5mm"

# Process perfusion (perf) files
dcm2niix -z y -f "sub-${participant}_acq-pcaslDEe1_run-1_asl" -o "$participant_dir/perf" "$participant_dir/perf/ep2d_DE_pCASL_LOFTmod_XA30 TE10 TE30"

# Process M0 scan
dcm2niix -z y -f "sub-${participant}_acq-pcasl_run-1_m0scan" -o "$participant_dir/perf" "$participant_dir/perf/ep2d_DE_pCASL_LOFTmod_XA30 M0"
