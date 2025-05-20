#!/bin/bash

# Code by Hendrale Gresseau, Fall 2024.
# Verified by Safa Sanami.

participant_dir=${1}
participant=${2}

# Process anatomy (anat) files

# -z y: Compresses the output NIfTI file into .nii.gz. y means yes.
# -f: output filename:
  # ANAT: high resolution t1w dcm files, typically '_acq-MPRAGE0p9_run-1_T1w'
  #       low resolution t1w dcm files, typically '_acq-MPRAGE1p5_run-1_T1w'
  # PERF: pCASL/BOLD dcm files, typically '_acq-pcaslDEe1_run-1_asl'
  #       M0 scan dcm files, typically '_acq-pcasl_run-1_m0scan (M0)'
# -o: directory to save the output file.

dcm2niix -z y -f "filnename format (high res t1w)" -o "output directory" "path to dcm files, typically 'MPRAGE_HR'"

dcm2niix -z y -f "filnename format (low res t1w)" -o "output directory" "path to dcm files, typically 'MPRAGE 1.5mm'"

# Process perfusion (perf) files
dcm2niix -z y -f "filename format (pCASL/BOLD)" -o "output directory" "path to dcm files, typically '_LOFTmod_XA30 TE10 TE30'"

# Process M0 scan
dcm2niix -z y -f "filename format (M0)" -o "output directory" "path to dcm files, typically '_LOFTmod_XA30 M0'"
