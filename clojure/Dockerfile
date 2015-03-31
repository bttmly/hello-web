FROM ubuntu

MAINTAINER Jake Burkhead "jakelauburkhead@gmail.com"

RUN apt-get -qq update && apt-get install -yqq leiningen

ADD . /server
WORKDIR /server

EXPOSE 8080

RUN cd app && lein deps && lein run
