import os
from celery import Celery

# Set the default Django settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myproject.settings')

app = Celery('myproject')

# Load config from Django settings, using the namespace 'CELERY'
app.config_from_object('django.conf:settings', namespace='CELERY')

# Auto-discover tasks from all registered apps
app.autodiscover_tasks()

@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')