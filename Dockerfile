# Use a Raspberry Pi-compatible base image for Python
FROM python:3.9-slim

# Set working directory in the container
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files into the container
COPY . .

# Set environment variables for Django
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Run database migrations and collect static files
RUN python manage.py migrate --noinput
RUN python manage.py collectstatic --noinput

# Expose the Django port (8000 by default)
EXPOSE 8000

# Command to start the Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
