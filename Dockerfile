FROM ubuntu:latest

# Set non-interactive frontend for apt to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    python3-venv

# Install FastAPI and Uvicorn
RUN python3 -m venv /venv \
    && /venv/bin/pip install --upgrade pip \
    && /venv/bin/pip install "fastapi[standard]" uvicorn

ENV PATH="/venv/bin:$PATH"

# Copy your FastAPI app into the container
COPY app.py .

# Expose the port FastAPI runs on
EXPOSE 8000

# Start FastAPI using uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]


