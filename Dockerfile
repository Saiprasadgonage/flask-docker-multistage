# ---------- STAGE 1: Build ----------
FROM python:3.10-slim AS build

# Set working directory
WORKDIR /app

# Install build tools
RUN apt-get update && apt-get install -y --no-install-recommends gcc

# Copy requirements and install
COPY app/requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Copy source code
COPY app .

# ---------- STAGE 2: Runtime ----------
FROM python:3.10-slim

WORKDIR /app

# Copy installed dependencies from build stage
COPY --from=build /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH

# Copy application code
COPY app .

# Expose port
EXPOSE 5000

# Run with Gunicorn for production
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
