FROM ubuntu

MAINTAINER Jake Burkhead "jakelauburkhead@gmail.com"

RUN apt-get update -qq && apt-get install -yqq nodejs npm

ADD . /server
WORKDIR /server

RUN npm install

EXPOSE 8080

CMD nodejs app.js
