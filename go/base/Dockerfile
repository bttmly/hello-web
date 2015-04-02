FROM ubuntu

MAINTAINER Jake Burkhead "jakelauburkhead@gmail.com"

RUN apt-get update -qq && apt-get install -yqq golang

ADD . /server
WORKDIR /server

RUN go build

EXPOSE 8080

CMD ./server
