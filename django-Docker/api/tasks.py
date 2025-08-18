from celery import shared_task
import time

'''@shared_task
def test_add(x, y):
    time.sleep(5)
    return x + y'''

@shared_task
def debug_task():
    print("✅ debug_task ran")
    return "ok"
