# For more information, please refer to https://aka.ms/vscode-docker-python
FROM ubuntu

USER root
RUN apt-get update
RUN apt-get install -y virtualenv
RUN apt-get install -y apache2 apache2-utils 
# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Create Virtualenv
ENV VIRTUAL_ENV=/venv
RUN virtualenv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
COPY requirements.txt .
RUN pip install -r requirements.txt

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
WORKDIR /app
COPY code /app

RUN useradd -ms /bin/bash zahur && usermod -aG sudo zahur
# USER zahur

CMD apachectl -D FOREGROUND
