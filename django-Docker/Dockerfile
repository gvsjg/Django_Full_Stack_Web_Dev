FROM continuumio/miniconda3

# Copy environment file and create env
COPY environment.yml .
RUN conda env create -f environment.yml

# Set the shell to always use the environment
SHELL ["conda", "run", "-n", "PY_Web_Dev", "/bin/bash", "-c"]

# Set working directory
WORKDIR /app

# Copy all project files into the container
COPY . .

# Expose port for Django
EXPOSE 8000

# Copy start-celery.sh script and make it executable
COPY start-celery.sh /app/start-celery.sh
RUN chmod +x /app/start-celery.sh

COPY start-celery-beat.sh /app/start-celery-beat.sh
RUN chmod +x /app/start-celery-beat.sh

# Default command for web service (can be overridden in docker-compose)
# Default command to run Django
CMD ["conda", "run", "-n", "PY_Web_Dev", "python", "manage.py", "runserver", "0.0.0.0:8000"]