#!/bin/bash
set -e

# Activate conda env
source /opt/conda/etc/profile.d/conda.sh
conda activate PY_Web_Dev

# Start Celery Beat (scheduler)
exec celery -A myproject beat --loglevel=info --scheduler django_celery_beat.schedulers:DatabaseScheduler