FROM ubuntu:22.04

# Install Chrome and dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable

# Install a web server to expose browser control
RUN apt-get install -y python3 python3-pip
RUN pip3 install selenium flask

WORKDIR /app
COPY . /app

EXPOSE 10000

CMD ["python3", "server.py"]
