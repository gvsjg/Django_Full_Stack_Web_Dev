#!/bin/bash
set -e

# Activate conda env
source /opt/conda/etc/profile.d/conda.sh
conda activate PY_Web_Dev

# Start Celery worker
exec celery -A myproject worker --loglevel=info