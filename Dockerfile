FROM python:3.9-slim

LABEL maintainer="vakees.ilamaran@gmail.com"
ARG PORT_DATA="8081"
ENV PORT="${PORT_DATA}"
RUN pip install --upgrade pip

RUN adduser manager --home /home/manager
USER manager
WORKDIR /home/manager
COPY --chown=manager:manager requirements.txt requirements.txt 
COPY --chown=manager:manager templates/* templates/
RUN pip install --user -r requirements.txt
ENV PATH="/home/manager/.local/bin:${PATH}"

COPY --chown=manager:manager app.py .

CMD ["python3", "app.py" ]
 