# Use an official Python runtime as a parent image
FROM python:3.9

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y ffmpeg

# Install Rust (if necessary)
# Uncomment these lines if Rust is required for tiktoken
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# ENV PATH="/root/.cargo/bin:${PATH}"

# Install Python dependencies and Whisper
RUN pip install --upgrade pip && \
    pip install openai-whisper

# Optionally, install setuptools-rust (if required)
RUN pip install setuptools-rust

# Copy your application code to the container
# ADD . /app

# Set the working directory
# WORKDIR /app

# Define the command to run your application
# CMD ["python", "your_script.py"]
