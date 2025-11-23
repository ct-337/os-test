FROM ubuntu:22.04

# Install OS packages you need
# Replace "your-packages-here" with the names of the packages needed by your app
RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    # Add more packages if necessary, e.g., git, nginx, build-essential

# Copy your application
COPY . /app
WORKDIR /app

# (Optional) Install your application's dependencies if necessary (e.g., Python, Node.js)
# Example for Python:
RUN pip install --no-cache-dir -r requirements.txt
# Example for Node.js:
# RUN npm install

# Expose your HTTP port (Render requires port 10000 for web services)
EXPOSE 10000

# Define startup command
# Replace "your-start-command" with the exact command to start your application
# Example for Python (using a common web server like Gunicorn):
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "your_app_module:app"]
# Example for Node.js:
# CMD ["npm", "start"]
# Example for a simple script:
# CMD ["python3", "app.py"]
