# Base image
FROM python:3.12-slim

# Install system essentials
RUN apt update && \
    apt install --no-install-recommends -y build-essential gcc && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /

# Copy dependency specifications first
COPY requirements.txt requirements.txt
COPY pyproject.toml pyproject.toml

# Install Python dependencies
RUN pip install -r requirements.txt --no-cache-dir

# Install the project itself (without re-installing deps)
RUN pip install . --no-deps --no-cache-dir

# Copy application code and data
COPY src/ src/
COPY data/ data/


ENTRYPOINT ["python", "-u", "src/vae/train.py"]

