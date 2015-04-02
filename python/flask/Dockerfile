FROM ubuntu

MAINTAINER Jake Burkhead "jakelauburkhead@gmail.com"

RUN apt-get update -qq && apt-get install -yqq python python-pip
RUN pip install flask

ADD . /server
WORKDIR /server

EXPOSE 8080

CMD python app.py
