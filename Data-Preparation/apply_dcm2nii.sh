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
      "id": "29870e44-7a6c-45bd-8afd-b15bd84b7184",
      "cell_type": "code",
      "source": "",
      "metadata": {
        "trusted": true
      },
      "outputs": [],
      "execution_count": null
    },
    {
      "id": "77871568-653f-4ce6-8ffc-43deffe53ae0",
      "cell_type": "code",
      "source": "#!/bin/bash\n\nparticipant_dir=${1}\nparticipant=${2}\n\n# Process anat files\ndcm2niix -z y -f \"sub-${participant}_acq-MPRAGE0p9_run-1_T1w\" -o \"$participant_dir/anat\" \"$participant_dir/anat/MPRAGE_HR\"\n\ndcm2niix -z y -f \"sub-${participant}_acq-MPRAGE1p5_run-1_T1w\" -o \"$participant_dir/anat\" \"$participant_dir/anat/MPRAGE 1.5mm\"\n\n# Process perf files\ndcm2niix -z y -f \"sub-${participant}_acq-pcaslDEe1_run-1_asl\" -o \"$participant_dir/perf\" \"$participant_dir/perf/ep2d_DE_pCASL_LOFTmod_XA30 TE10 TE30\"\n\n# Process M0 scan\ndcm2niix -z y -f \"sub-${participant}_acq-pcasl_run-1_m0scan\" -o \"$participant_dir/perf\" \"$participant_dir/perf/ep2d_DE_pCASL_LOFTmod_XA30 M0\"",
      "metadata": {
        "trusted": true
      },
      "outputs": [],
      "execution_count": null
    }
  ]
}