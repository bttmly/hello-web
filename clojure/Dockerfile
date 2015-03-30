FROM ubuntu

MAINTAINER Jake Burkhead "jakelauburkhead@gmail.com"

RUN apt-get -qq update && apt-get install -yqq leiningen

ADD . /server
WORKDIR /server

EXPOSE 8080

RUN lein new app
RUN cp project.clj ./app &&cp core.clj ./app/src/app

RUN cd app && lein deps && lein run
