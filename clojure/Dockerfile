FROM ubuntu

MAINTAINER Jake Burkhead "jakelauburkhead@gmail.com"

RUN apt-get -qq update && apt-get install -yqq leiningen

ADD . /server
WORKDIR /server

EXPOSE 8080

WORKDIR /server/app

CMD lein deps && lein run
