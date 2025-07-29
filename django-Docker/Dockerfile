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

# Default command to run Django
CMD ["conda", "run", "-n", "PY_Web_Dev", "python", "manage.py", "runserver", "0.0.0.0:8000"]