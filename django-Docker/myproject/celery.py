import os
from celery import Celery
from celery.schedules import crontab
from celery import shared_task
from .celery import app

# Set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myproject.settings')

app = Celery('myproject')

# Load config from Django settings, using the namespace 'CELERY'
# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
app.config_from_object('django.conf:settings', namespace='CELERY')

# Auto-discover tasks from all registered apps
# Load task modules from all registered Django app configs.
app.autodiscover_tasks()

@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')

@shared_task
def beat_task():
    print("Celery Beat task executed!")

app.conf.beat_schedule = {
    'beat-task-every-1-minute': {
        'task': 'myproject.celery.beat_task',
        'schedule': crontab(minute='*/1'),
    },
}