ARG PYTHON_VERSION=3.12.6
FROM python:${PYTHON_VERSION}-alpine

RUN apk update

RUN apk upgrade

RUN apk add alpine-sdk python3-dev libressl-dev musl-dev libffi-dev gcc libressl-dev curl

RUN addgroup -S python3 && adduser -S python3 -G python3

USER python3

ENV PATH="/home/python3/.local/bin:$PATH"

RUN python3 -m pip install --upgrade pip

COPY requirements.txt .

RUN pip3 install --user -r requirements.txt

USER root

RUN apk del alpine-sdk python3-dev libressl-dev musl-dev libffi-dev gcc libressl-dev curl

USER python3
