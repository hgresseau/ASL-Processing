{
  "metadata": {
    "kernelspec": {
      "name": "python",
      "display_name": "Python (Pyodide)",
      "language": "python"
    },
    "language_info": {
      "codemirror_mode": {
        "name": "python",
        "version": 3
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3",
      "version": "3.8"
    }
  },
  "nbformat_minor": 5,
  "nbformat": 4,
  "cells": [
    {
      "id": "ccb77235-6b45-4f20-989d-c34a2a461a56",
      "cell_type": "code",
      "source": "",
      "metadata": {
        "trusted": true
      },
      "outputs": [],
      "execution_count": null
    },
    {
      "id": "7892d80e-9a8c-4d9f-9401-035092fe2d8e",
      "cell_type": "code",
      "source": "#!/bin/bash\n# This script compresses raw data (DICOM) into usable files (NIfTI)\n\n# Define the base path\npath=/NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/\n\n# Navigate to the working directory\ncd $path\n\nparticipants=(\"016\" \"017\" \"018\" \"019\" \"020\" \"021\" \"023\" \"024\" \"025\" \"026\" \"030\" \"031\")\n\n# Loop over each participant (COVIRM-016 to COVIRM-030)\nfor participant in \"${participants[@]}\"\ndo\n    participant_dir=\"data/COVIRM-${participant}\"\n    echo \"Processing participant $participant\"\n\n    # Call apply_dcm2nii.sh with the full participant directory\n    /NAS/home/s_sanami/Documents/covirm_data_processing/Hendrale/apply_dcm2nii.sh ${participant_dir} ${participant}\n\n    # Rename e1 and e2 files to use DEe1 and DEe2 instead of _e1 and _e2\n    mv \"$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl_e1.nii.gz\" \"$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl.nii.gz\"\n    mv \"$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl_e2.nii.gz\" \"$participant_dir/perf/sub-${participant}_acq-pcaslDEe2_run-1_asl.nii.gz\"\n    mv \"$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl_e1.json\" \"$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl.json\" \n    mv \"$participant_dir/perf/sub-${participant}_acq-pcaslDEe1_run-1_asl_e2.json\" \"$participant_dir/perf/sub-${participant}_acq-pcaslDEe2_run-1_asl.json\"\n\n\ndone",
      "metadata": {
        "trusted": true
      },
      "outputs": [],
      "execution_count": null
    }
  ]
}