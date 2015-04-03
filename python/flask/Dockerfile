FROM ubuntu

MAINTAINER Jake Burkhead "jakelauburkhead@gmail.com"

ADD . /server
WORKDIR /server

RUN apt-get update -qq && apt-get install -yqq python python-pip

# setup virtualenv
RUN pip install virtualenv && virtualenv env && sh env/bin/activate
RUN pip install -r requirements.txt

EXPOSE 8080

CMD python app.py
