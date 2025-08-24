#!/bin/bash
set -e

# Activate conda env
source /opt/conda/etc/profile.d/conda.sh
conda activate PY_Web_Dev

# Run Celery Beat (with persistent scheduler file inside /app)
exec celery -A myproject beat --loglevel=info --scheduler django_celery_beat.schedulers:DatabaseScheduler