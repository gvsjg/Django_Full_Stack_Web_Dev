#!/bin/bash
set -e

# Start Celery worker with conda env
exec conda run -n PY_Web_Dev celery -A myproject worker --loglevel=info