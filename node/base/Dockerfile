FROM ubuntu

MAINTAINER Jake Burkhead "jakelauburkhead@gmail.com"

RUN apt-get update -qq && apt-get install -yqq nodejs

ADD . /server
WORKDIR /server

EXPOSE 8080

CMD nodejs app.js
