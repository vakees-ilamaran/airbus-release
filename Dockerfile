FROM python:3.9-slim

MAINTANER Your Name "vakees.ilamaran@gmail.com"

RUN apt-get update -y && \
    apt-get install -y python-pip 

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app 

RUN pip install -r requirements.txt

COPY app.py /app

CMD [ "app.py" ]